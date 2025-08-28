using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrudByOpp
{
    public partial class _Default : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

       protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT UserId, FullName, Role FROM Users WHERE Email=@Email AND Password=@Password";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        // Save session
                        Session["UserId"] = dr["UserId"].ToString();
                        Session["FullName"] = dr["FullName"].ToString();
                        Session["Role"] = dr["Role"].ToString();

                        string role = dr["Role"].ToString();

                        // redirect according to role
                        if (role == "Admin")
                        {
                            Response.Redirect("AdminDashboard.aspx");
                        }
                        else if (role == "HR")
                        {
                            Response.Redirect("HRDashboard.aspx");
                        }
                        else if (role == "Finance")
                        {
                            Response.Redirect("FinanceDashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("UserDashboard.aspx");
                        }
                    }
                    else
                    {
                        pnlMessage.CssClass = "alert alert-danger";
                        pnlMessage.Visible = true;
                        lblMessage.Text = "Invalid email or password.";
                    }
                }
                catch (SqlException ex)
                {
                    pnlMessage.CssClass = "alert alert-danger";
                    pnlMessage.Visible = true;
                    lblMessage.Text = "Database Error: " + ex.Message;
                }
            }
        }
    }
}

