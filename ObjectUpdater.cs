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
                    if (value is IList iLvalue)
                    {
                        IList exILvalue = (IList)existingValue;

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