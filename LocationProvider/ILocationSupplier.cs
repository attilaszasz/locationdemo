using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LocationProvider
{
    public interface ILocationSupplier
    {
        string GetLocationJson(string IPAddress);
    }
}
