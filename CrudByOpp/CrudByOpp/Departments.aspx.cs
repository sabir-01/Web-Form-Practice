using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CrudByOpp
{
    public partial class Departments : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadDepartments();
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }

        private void LoadDepartments()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Departments", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvDepartments.DataSource = dt;
                gvDepartments.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "INSERT INTO Departments (DepartmentName) VALUES (@DepartmentName)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@DepartmentName", txtDepartment.Text.Trim());
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            txtDepartment.Text = "";
            LoadDepartments();
        }

        protected void gvDepartments_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvDepartments.Rows[index];
            string id = row.Cells[0].Text;

            if (e.CommandName == "EditDept")
            {
                hdnDepartmentId.Value = id;
                txtDepartment.Text = row.Cells[1].Text;
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                btnCancel.Visible = true;
            }
            else if (e.CommandName == "DeleteDept")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM Departments WHERE DepartmentId=@Id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                LoadDepartments();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "UPDATE Departments SET DepartmentName=@DepartmentName WHERE DepartmentId=@Id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@DepartmentName", txtDepartment.Text.Trim());
                cmd.Parameters.AddWithValue("@Id", hdnDepartmentId.Value);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            ResetForm();
            LoadDepartments();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        private void ResetForm()
        {
            txtDepartment.Text = "";
            hdnDepartmentId.Value = "";
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
        }
    }
}