using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace State__Management_Web_form
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Initialize Application State
            Application["userCount"] = 0;
        }

        void Session_Start(object sender, EventArgs e)
        {
            Application["userCount"] = (int)Application["userCount"] + 1;
        }

        void Session_End(object sender, EventArgs e)
        {
            Application["userCount"] = (int)Application["userCount"] - 1;
        }
    }
}

