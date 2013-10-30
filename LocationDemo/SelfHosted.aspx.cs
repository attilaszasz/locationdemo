using LocationProvider;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LocationDemo
{
    public partial class SelfHosted : System.Web.UI.Page
    {
        protected string LocationLiteral { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ILocationSupplier supplier = new GeoIpLocationSupplier(HttpContext.Current.Server.MapPath("bin\\Db\\GeoLite2-City.mmdb"));
            LocationLiteral = supplier.GetLocationJson(Request.UserHostAddress);
        }
    }
}