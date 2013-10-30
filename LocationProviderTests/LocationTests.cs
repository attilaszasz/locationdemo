using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LocationProvider;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace LocationProviderTests
{
    [TestClass]
    public class LocationTests
    {
        [TestMethod]
        public void GetLocation()
        {
            //arrange
            ILocationSupplier supplier = new GeoIpLocationSupplier("Db\\GeoLite2-City.mmdb");
            //act
            string response = supplier.GetLocationJson("86.120.44.89");  //our external Ip my change
            dynamic Location = JObject.Parse(response);
            //assert

            Assert.AreEqual(Location.Location.Country.Name.ToString(), "Romania");
        }
    }
}
