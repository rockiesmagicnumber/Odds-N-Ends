# Battle.net on Linux (Lutris + Proton): troubleshooting notes

Getting the Blizzard Battle.net launcher working under Lutris on Linux Mint 22
(Ubuntu 24.04 base), AMD GPU. Worked through 2026-10-20 / 21.

**Final working setup:** the original Lutris entry, runner **Proton -
Experimental** (Steam's), with `winbind` installed and `winetricks tahoma
corefonts vcrun2019 win10` applied to the prefix.

## Symptoms, in the order they appeared

| Symptom | Cause | Fix |
|---|---|---|
| Login works, then launcher stalls: "Battle.net Update Agent went to sleep" (`BLZBNTBNA00000005`) | Agent rejected the launcher's signature (`Failed Caller authorization due to signature for 'Battle.net.exe'`, client log `response=401`) because the Wine build could not decode Authenticode signature data (`Unsupported decoder for lpszStructType 1.3.6.1.4.1.311.2.1.4`) | Use a newer Wine. Distro `wine-9.0` and `wine-ge-8-26` both failed; `proton-cachyos-11` and Proton Experimental passed |
| `err:ntlm: no NTLM support, expect problems` | `ntlm_auth` missing | `sudo apt install winbind` |
| Launcher window freezes at an empty login screen; main `Battle.net.exe` process vanishes, helpers linger; log shows `err:virtual:virtual_setup_exception stack overflow ...` | Missing fonts (reproduced on Proton-CachyOS and Proton Experimental, on old and fresh prefixes) | `winetricks tahoma corefonts` |
| Install button says "Your OS is unsupported" | Prefix reported Windows 7 | `winetricks win10` |

## Commands

Run winetricks against the prefix using the same Wine as Lutris is using:

```bash
WINEPREFIX=/path/to/prefix \
WINE="/path/to/Steam/steamapps/common/Proton - Experimental/files/bin/wine" \
winetricks tahoma corefonts win10
```

In Lutris: Configure -> Runner options -> Wine version -> `Proton - Experimental`.

## Debugging notes worth keeping

- **`fixme:` lines are not failures.** Wine prints them for any unimplemented
  call. Search the log for `err:` instead.
- **Read the app's own logs, not just Wine's.** The real clue was in the Agent
  log (`<prefix>/drive_c/ProgramData/Battle.net/Agent/Agent.*/Logs/Agent-*.log`)
  and the client log (`<prefix>/drive_c/users/<user>/AppData/Local/Battle.net/Logs/`).
- **Capturing Wine output from Lutris.** Lutris silences Wine's debug output
  unless the entry sets `WINEDEBUG` and `show_debug: ''`. If Lutris is already
  open, `lutris -d lutris:rungame/<slug>` hands the launch to that instance and
  your pipe gets nothing; fully quit Lutris first, then launch from a terminal:
  `lutris -d lutris:rungame/<slug> 2>&1 | tee log.txt`.
- **Find the slug** with `sqlite3 -readonly ~/.local/share/lutris/pga.db "select id, slug, name from games;"`.
  The `slug:` field inside a game's `.yml` is not the same thing.
- **Don't run Proton-style runners via the bare `bin/wine`.** Their vkd3d DLL
  paths aren't set up, so Qt apps fail with
  `Library libvkd3d-1.dll ... not found`. Launch through Lutris.
- **Cleaning up between attempts** while other things share the prefix: kill
  by name (`pkill -f 'Battle.net|Agent.exe'`) rather than `wineserver -k`.
  If an `Agent.exe` keeps respawning, quit Lutris and then run
  `WINEPREFIX=... <runner>/bin/wineserver -k`.

## Dead ends (don't repeat)

- Deleting the Agent / `ProgramData/Blizzard Entertainment` folders. The Agent
  wasn't stale; it was rejecting the signature.
- Forcing builtin D3D via DLL overrides (`d3d9/d3d10core/d3d11/dxgi=b`). On
  Proton runners this breaks with missing `libvkd3d-*.dll`.
- Disabling `uiautomationcore` (`=d`). `libcef.dll` imports it, so the
  launcher fails to load at all.
- `WINE_SIMULATE_WRITECOPY=1`, and a fresh prefix. Neither made a difference;
  fonts did.
- Turning DXVK on/off. Proton runners ship their own, and the toggle didn't
  change what loaded.

## Caveats

This was a one-machine investigation. The stack overflow reproduced on two
different Wine builds and two prefixes until Tahoma was installed, which is why
I attribute the fix to fonts, but I did not isolate it from `corefonts` (it was
installed in the same run on the clean prefix; on the original prefix `corefonts`
was already present and adding only `tahoma` fixed it).
