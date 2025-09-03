using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebformProject
{
    public partial class ManageOrders : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadOrders();
             

        }

        private void LoadOrders()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT OrderId, UserId, TotalAmount, CreatedAt FROM Orders ORDER BY CreatedAt DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                GridViewOrders.DataSource = cmd.ExecuteReader();
                GridViewOrders.DataBind();
            }
        }

        protected void GridViewOrders_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int orderId = Convert.ToInt32(GridViewOrders.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Orders WHERE OrderId=@OrderId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadOrders(); // refresh grid
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");

        }
    }
}