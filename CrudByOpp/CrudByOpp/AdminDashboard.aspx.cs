using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrudByOpp
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private static readonly string connStr =
                   ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Default.aspx"); // force login
                }
                BindUsers();
            }
        }
        [WebMethod]
        public static string DeleteUser(int userId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM Users WHERE UserId=@UserId";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    con.Close();

                    if (rows > 0)
                        return "User deleted successfully!";
                    else
                        return "User not found.";
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
        private void BindUsers(string search = "")
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT UserId, FullName, Email, Role, CreatedAt FROM Users";

                if (!string.IsNullOrEmpty(search))
                {
                    query += " WHERE FullName LIKE @search OR Email LIKE @search OR Role LIKE @search";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(search))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        // Handle logout
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }

        // Handle search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //BindUsers(txtSearch.Text.Trim());
        }

        // Handle row edit
        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            BindUsers();
        }

        // Handle row cancel edit
        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            BindUsers();
        }

        // Handle row update
        [WebMethod]
        public static string UpdateUser(int userId, string fullName, string email, string role)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "UPDATE Users SET FullName=@FullName, Email=@Email, Role=@Role WHERE UserId=@UserId";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    con.Close();

                    return rows > 0 ? "User updated successfully!" : "User not found.";
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }




    }


}

