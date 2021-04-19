const Constants = {
    headerBackgroundColor: "#652128",
    css: ".customMeter{height:20px;position:relative;background:#555;border-radius:25px;padding:10px;box-shadow:inset 0 -1px 1px rgba(255,255,255,.3)}.customMeter>span{display:block;height:100%; border-top-right-radius:8px;border-bottom-right-radius:8px;border-top-left-radius:20px; border-bottom-left-radius:20px;box-shadow:inset 0 2px 9px rgba(255,255,255,.3),inset 0 -2px 6px rgba(0,0,0,.4);position:relative;overflow:hidden;padding-bottom:20px;bottom:30px;left:-10px}span.potential{bottom:10px;}"
};
const SectionLayouts = {
    Batting: {
        FriendlyName: "Batting",
        Fields: [{
                Name: "Contact",
                ColName: "Con",
                Order: 1,
            }, {
                Name: "Gap Power",
                ColName: "Gap",
                Order: 2,
            }, {
                Name: "Home Run Power",
                ColName: "Pow",
                Order: 3,
            }, {
                Name: "Eye/Discipline",
                ColName: "Eye",
                Order: 4,
            }, {
                Name: "Avoid K's",
                ColName: "K's",
                Order: 5,
            }
        ]
    },
    Fielding: {
        FriendlyName: "Defensive Ratings",
        Fields: [{
                Name: "Catcher Ability",
                Order: 1,
            }, {
                Name: "Catcher Arm",
                Order: 2,
            }, {
                Name: "Infield Range",
                Order: 3,
            }, {
                Name: "Infield Error",
                Order: 4,
            }, {
                Name: "Infield Arm",
                Order: 5,
            }, {
                Name: "Turn DP",
                Order: 6,
            }, {
                Name: "Outfield Range",
                Order: 7,
            }, {
                Name: "Outfield Error",
                Order: 8,
            }, {
                Name: "Outfield Arm",
                Order: 9,
            }
        ]
    },
    Position: {
        FriendlyName: "Position Ratings",
        Fields: [{
                Name: "Pitcher",
                ColName: "Pitcher",
                Order: 1,
            }, {
                Name: "Catcher",
                ColName: "Catcher",
                Order: 2,
            }, {
                Name: "First Base",
                ColName: "First",
                Order: 3,
            }, {
                Name: "Second Base",
                ColName: "Second",
                Order: 4,
            }, {
                Name: "Third Base",
                ColName: "Third",
                Order: 5,
            }, {
                Name: "Shortstop",
                ColName: "Shortstop",
                Order: 6,
            }, {
                Name: "Left Field",
                ColName: "Left Field",
                Order: 7,
            }, {
                Name: "Center Field",
                ColName: "Center Field",
                Order: 8,
            }, {
                Name: "Right Field",
                ColName: "Right Field",
                Order: 9,
            }
        ]
    },
    RunBunt: {
        FriendlyName: "Other Offensive Ratings",
        Fields: [{
                Name: "Running Speed",
                ColName: "Speed",
                Order: 1,
            }, {
                Name: "Stealing Bases",
                ColName: "Stealing",
                Order: 2,
            }, {
                Name: "Baserunning",
                ColName: "Running",
                Order: 3,
            }, {
                Name: "Sacrifice Bunt",
                ColName: "Sac Bunt",
                Order: 4,
            }, {
                Name: "Bunt for Hit",
                ColName: "Bunt for Hit",
                Order: 5,
            }
        ]
    },
    Pitching: {
        FriendlyName: "Pitching",
        Fields: [{
                Name: "Stuff",
                ColName: "Stuff",
                Order: 1,
            }, {
                Name: "Movement",
                ColName: "Movement",
                Order: 2,
            }, {
                Name: "Control",
                ColName: "Control",
                Order: 3,
            }
        ]
    },
    PitchRatings: {
        FriendlyName: "Pitches",
        Fields: [{
                Name: "Fastball",
                ColName: "Fastball",
                Order: 1,
            }, {
                Name: "Sinker",
                ColName: "Sinker",
                Order: 2,
            }, {
                Name: "Cutter",
                ColName: "Cutter",
                Order: 3,
            }, {
                Name: "Curveball",
                ColName: "Curveball",
                Order: 4,
            }, {
                Name: "Slider",
                ColName: "Slider",
                Order: 5,
            }, {
                Name: "Changeup",
                ColName: "Changeup",
                Order: 6,
            }, {
                Name: "Splitter",
                ColName: "Splitter",
                Order: 7,
            }, {
                Name: "Forkball",
                ColName: "Forkball",
                Order: 8,
            }, {
                Name: "Circle Change",
                ColName: "Circle Change",
                Order: 9,
            }, {
                Name: "Screwball",
                ColName: "Screwball",
                Order: 10,
            }, {
                Name: "Knuckle Curve",
                ColName: "Knuckle Curve",
                Order: 11,
            }, {
                Name: "Knuckleball",
                ColName: "Knuckleball",
                Order: 12,
            }
        ]
    },
    OtherPitching: {
        FriendlyName: "Other Pitching Ratings",
        Fields: [{
                Name: "Velocity",
                ColName: "Velocity",
                Order: 1,
            }, {
                Name: "Groundball %",
                ColName: "GB %",
                Order: 2,
            }, {
                Name: "Arm Slot",
                ColName: "Arm Slot",
                Order: 3,
            }, {
                Name: "Stamina",
                ColName: "Stamina",
                Order: 3,
            }, {
                Name: "Hold Runners",
                ColName: "Hold",
                Order: 3,
            }
        ]
    }
};
const RatingColors = [{
        rating: 20,
        color: "#A50000"
    }, {
        rating: 25,
        color: "#CB0000"
    }, {
        rating: 30,
        color: "#FD0000"
    }, {
        rating: 35,
        color: "#FD6B00"
    }, {
        rating: 40,
        color: "#FDBC00"
    }, {
        rating: 45,
        color: "#EBDF09"
    }, {
        rating: 50,
        color: "#BCD600"
    }, {
        rating: 55,
        color: "#57D100"
    }, {
        rating: 60,
        color: "#56D121"
    }, {
        rating: 65,
        color: "#75D186"
    }, {
        rating: 70,
        color: "#00C3C5"
    }, {
        rating: 75,
        color: "#00C4E6"
    }, {
        rating: 80,
        color: "#0097FD"
    }, {
        rating: 85,
        color: "#0097FD"
    }, {
        rating: 90,
        color: "#0097FD"
    }, ]
function getDataTableObject(thisTable) {
    var myObject = [];
    var trArray = $(thisTable).find("tr");
    var header = trArray[0];
    var headerData = $(header).find("th");
    for (var k = 0; k < trArray.length; k++) {
        var thisTr = trArray[k];
        var thisRow = {};
        var rowData = $(thisTr).find("td");
        if (rowData.length > 0) {
            for (var i = 0; i < rowData.length; i++) {
                try {
                    thisRow[cleanString((headerData[i] ? headerData[i].textContent : "Rating"))] = rowData[i].textContent;
                } catch (e) {
                    console.error(e);
                    console.log(rowData);
                }
            }
            myObject.push(thisRow);
        }
    }
    return myObject;
}
function cleanString(str) {
    return str.replace(" ", "").replace("/", "");
}
function createSection(dataTable) {
    var html = "";
    var entity = dataTable.id;
    var sectionLayout = SectionLayouts[entity].Fields.sort((a, b) => (a.Order > b.Order) ? 1 : -1);
    html += '<div id="' + entity + '">';
    html += '<div class="row"><span style="style="width:100%;background-color:' + Constants.headerBackgroundColor + ';">' + SectionLayouts[entity].FriendlyName + '</span></div>';
    if (entity === "Fielding") {}
    else if (entity === "Batting" || entity === "Pitching") {
        for (var i = 0; i < sectionLayout.length; i++) {
            var rating = sectionLayout[i];
            var currentData = dataTable.data.find(x => x[entity] === "Current");
            var potentialData = dataTable.data.find(x => x[entity] === "Potential");
            if (currentData && potentialData) {
                html += createRatingRows(rating.Name, currentData[rating.ColName], potentialData[rating.ColName]);
            }
        }
    } else if (entity === "PitchRatings") {
        for (var i = 0; i < sectionLayout.length; i++) {
            var rating = sectionLayout[i];
            var data = dataTable.data.find(x => x[entity] === rating.ColName);
            if (data) {
                html += createRatingRows(rating.Name, data.Cur, data.Pot);
            }
        }
    } else if (entity === "Position") {
        for (var i = 0; i < sectionLayout.length; i++) {
            var rating = sectionLayout[i];
            var data = dataTable.data.find(x => x[entity] === rating.ColName);
            if (data) {
                html += createRatingRows(rating.Name, data.Rating);
            }
        }
    }
    html += '</div>';
    return html;
}

function createRatingRows(ratingName, cur, pot) {
    var html = "";
    var hasPot = (typeof pot !== "undefined");
    html += '<div class="row"><span">' + ratingName + '</span></div>';
    html += '<div class="row">';
    html += '<div class="customMeter">';
    if (hasPot) {
        html += '<span class="potential" style="width:' + (100 / 14) * Math.round(((pot >= 80 ? 80 : pot) - 10) / 5) + '%; background-color:' + RatingColors.find(x => x.rating == pot).color + '"></span>';
    }
    // I hate this line. The way the "bottom" properties are set, if I don't have the "potential" rating, the "current" bumps up a row, so I need to set that class to "potential". Annoying.
    html += '<span class="' + (!hasPot ? 'potential' : 'current') + '" style="width:' + (100 / 14) * Math.round(((cur >= 80 ? 80 : cur) - 10) / 5) + '%; background-color:' + RatingColors.find(x => x.rating == cur).color + '">';
    html += '<div style="background-color:black; opacity: 0.5; width:60px;">';
    html += '<div style="margin-left:10px;font-weight: bold;font-color:white;">' + cur + (hasPot ? ' / ' + pot : "") + '</div>';
    html += '</div>';
    html += '</span>';
    html += '</div>';
    html += '</div>';
    return html;
}
function injectCss(css) {
    const style = document.createElement('style');
    style.textContent = css;
    document.head.append(style);
}

function runMe() {
    $("#player-page-osa-ratings").append('<div id="myPlayerVisualizer" style="width:50%;"></div>');
    //var myObjectArray = [];
    var tableSelector = "table.statsplustable-zebra";
    for (var j = 0; j < $(tableSelector).length; j++) {
        var thisTable = $(tableSelector)[j];
        var myObject = getDataTableObject(thisTable);
        var section = createSection({
                data: myObject,
                id: cleanString(Object.keys(myObject[0])[0])
            });
        $(section).appendTo("#myPlayerVisualizer");
        //$(tableSelector)[j].replaceWith(section);
        // myObjectArray.push({
        // data: myObject,
        // id: cleanString(Object.keys(myObject[0])[0])
        // });
    }
    //$(createSection()).appendTo("#myPlayerVisualizer");
    //getDataTableObject().forEach(x => {
    //$(createSection(x)).appendTo("#myPlayerVisualizer");
    //});
};

injectCss(Constants.css);

setTimeout(() => {
    runMe();
}, 100)
