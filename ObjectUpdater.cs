namespace Andrew.OddsNEnds
{
	public class GeneralFunctions
	{
	    public T UpdateObject<T>(T target, T source, bool overWriteWithNull)
        {
            Type t = typeof(T);

            var properties = t.GetProperties().Where(prop => prop.CanRead && prop.CanWrite);

            foreach (var prop in properties)
            {
                var value = prop.GetValue(source, null);
                var existingValue = prop.GetValue(target, null);

                if ((value != null || overWriteWithNull) && value is IComparable && !value.Equals(existingValue))
                {
		    // I picked IList because I can directly apply indexing to IList, but not to ICollection or IEnumerable
                    if (value is IList iLvalue)
                    {
                        IList exILvalue = (IList)existingValue;
			    
                        // Initial use case assumed any IList objects would have an equal number of entries
			// This assumption is stupid.
			// TODO: Add "Insert/Delete" functionality
                        for (int i = 0; i < iLvalue.Count; i++)
                        {
                            var v = iLvalue[i];
                            var e = exILvalue[i];

                            Type typeArgument = v.GetType();
                            MethodInfo method = typeof(ReportBuilder).GetMethod(nameof(ReportBuilder.UpdateObject));
                            MethodInfo generic = method.MakeGenericMethod(typeArgument);
                            generic.Invoke(this, new[] { e, v });
                        }
                    }
                    prop.SetValue(target, value, null);
                }
            }
            return target;
        }			
	}
}
