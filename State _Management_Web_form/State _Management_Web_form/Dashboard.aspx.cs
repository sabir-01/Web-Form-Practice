using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace State__Management_Web_form
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
                lblWelcome.Text = "Welcome, " + Session["username"].ToString();
            else
                Response.Redirect("Login.aspx");

            lblApp.Text = "Total Users Logged In (Application State): " + Application["userCount"];
        }
    }
}