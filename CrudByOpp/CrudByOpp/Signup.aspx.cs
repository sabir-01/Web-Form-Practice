using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;


namespace CrudByOpp
{
    public partial class Signup : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
          
        }
        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim(); // simple (not hashed, as you requested)
            string role = ddlRole.SelectedValue;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Users (FullName, Email, Password, Role) " +
                               "VALUES (@FullName, @Email, @Password, @Role)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Role", role);

                try
                {
                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        lblMessage.Text = "Account created successfully! You can now login.";
                        pnlMessage.CssClass = "alert alert-success";
                        pnlMessage.Visible = true;

                        // clear form
                        txtFullName.Text = "";
                        txtEmail.Text = "";
                        txtPassword.Text = "";
                        ddlRole.SelectedIndex = 0;
                    }
                    else
                    {
                        lblMessage.Text = "Something went wrong. Please try again.";
                        pnlMessage.CssClass = "alert alert-danger";
                        pnlMessage.Visible = true;
                    }
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    pnlMessage.CssClass = "alert alert-danger";
                    pnlMessage.Visible = true;
                }
            }
        }
    }




}