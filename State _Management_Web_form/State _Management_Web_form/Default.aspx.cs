using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace State__Management_Web_form
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIncrement_Click(object sender, EventArgs e)
        {
            int counter = ViewState["count"] == null ? 0 : (int)ViewState["count"];
            counter++;
            ViewState["count"] = counter;
            lblCounter.Text = counter.ToString();
        }

        // HiddenField Example
        protected void btnHidden_Click(object sender, EventArgs e)
        {
            lblHidden.Text = "HiddenField Value: " + hfValue.Value;
        }

        // QueryString Example
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx?Muhammad=sabir");
        }

        protected void btnGetCookie_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["UserCookie"] != null)
                lblCookie.Text = "Cookie Value: " + Request.Cookies["UserCookie"].Value;

            else
                lblCookie.Text = "No cookie found!";
        }

        protected void btnSetCookie_Click(object sender, EventArgs e)
        {
            Response.Cookies["UserCookie"].Value = txtCookie.Text;
            Response.Cookies["UserCookie"].Expires = DateTime.Now.AddMinutes(1);

        }
    }
}