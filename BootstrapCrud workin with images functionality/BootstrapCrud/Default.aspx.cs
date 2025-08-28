using System;
using System.Configuration;
using System.Data.SqlClient;

namespace BootstrapCrud
{
    public partial class _Default : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string querry = "select * from Users where Email = @UserEmail and Password = @userpass";
            SqlCommand cmd = new SqlCommand(querry, con);
            cmd.Parameters.AddWithValue("@UserEmail", txtEmail.Text);
            cmd.Parameters.AddWithValue("@userpass", txtPassword.Text);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                Session["user"] = txtEmail.Text;
                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Login sucessfully || ') </script>");
                Response.Redirect("DASHBOARD.aspx");
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Login Failed || ') </script>");
            }

            con.Close();

        }
    }
}