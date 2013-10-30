using MaxMind.GeoIP2;
using MaxMind.GeoIP2.Exceptions;
using MaxMind.GeoIP2.Responses;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;

namespace LocationProvider
{
    public class GeoIpLocationSupplier : ILocationSupplier, IDisposable
    {
        private DatabaseReader _reader;
        private Stopwatch sw = new Stopwatch();

        public GeoIpLocationSupplier(string Db)
        {
            sw.Start();
            _reader = new DatabaseReader(Db);
        }

        public string GetLocationJson(string IPAddress)
        {
            OmniResponse omni;
            try
            {
                omni = _reader.Omni(IPAddress);
                sw.Stop();
            }
            catch (GeoIP2AddressNotFoundException)
            {
                return @"{""Success"": ""0"",""Exception"": ""AddressNotFound"",""Location"": """"}";
            }
            catch (MaxMind.Db.InvalidDatabaseException)
            {
                return @"{""Success"": ""0"",""Exception"": ""InvalidDatabase"",""Location"": """"}";
            }
            var response = new
            {
                Success = 1,
                Exception = string.Empty,
                Location = omni,
                TimeSpent = sw.Elapsed.Seconds > 0 ? string.Format("{0}.{1} s", sw.Elapsed.Seconds, sw.Elapsed.TotalMilliseconds) : string.Format("{0} ms", sw.Elapsed.TotalMilliseconds)
            };

            return JsonConvert.SerializeObject(response);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_reader != null)
                {
                    _reader.Dispose();
                    _reader = null;
                }
            }

        }
    }
}
