using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;

namespace CrudByOpp
{
    public partial class ManageEmployees : System.Web.UI.Page
    {
        static string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEmployees();
            }
        }

        private void BindEmployees(string searchKeyword = "")
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Employees";
                SqlCommand cmd = new SqlCommand();

                if (!string.IsNullOrEmpty(searchKeyword))
                {
                    query += " WHERE FullName LIKE @search OR Department LIKE @search OR Email LIKE @search OR Phone LIKE @search OR Role LIKE @search";
                    cmd.Parameters.AddWithValue("@search", "%" + searchKeyword + "%");
                }

                cmd.CommandText = query;
                cmd.Connection = con;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Add base64 image column
                dt.Columns.Add("ImageBase64", typeof(string));
                foreach (DataRow row in dt.Rows)
                {
                    if (row["ImageData"] != DBNull.Value)
                    {
                        byte[] imageBytes = (byte[])row["ImageData"];
                        if (imageBytes != null && imageBytes.Length > 0)
                        {
                            row["ImageBase64"] = "data:image/png;base64," + Convert.ToBase64String(imageBytes);
                        }
                        else
                        {
                            row["ImageBase64"] = "";
                        }
                    }
                    else
                    {
                        row["ImageBase64"] = "";
                    }
                }

                gvEmployees.DataSource = dt;
                gvEmployees.DataBind();
            }
        }

        // Search functionality
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string searchKeyword = txtSearch.Text.Trim();
            BindEmployees(searchKeyword);
        }

        // Clear search functionality
        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            BindEmployees();
        }

        // DTO for WebMethods
        public class EmployeeDto
        {
            public int EmployeeId { get; set; }
            public string FullName { get; set; }
            public string Department { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
            public string Role { get; set; }
            public string ImageBase64 { get; set; }
        }

        [WebMethod]
        public static string SaveEmployee(EmployeeDto emp)
        {
            try
            {
                // Null check
                if (emp == null) return "Error: Employee data is null";

                // Validation
                if (string.IsNullOrWhiteSpace(emp.FullName)) return "Full Name is required!";
                if (string.IsNullOrWhiteSpace(emp.Department)) return "Department is required!";
                if (string.IsNullOrWhiteSpace(emp.Email)) return "Email is required!";
                if (string.IsNullOrWhiteSpace(emp.Phone)) return "Phone is required!";
                if (string.IsNullOrWhiteSpace(emp.Role)) return "Role is required!";

                if (string.IsNullOrEmpty(connStr)) return "Error: Database connection string not found";

                byte[] imageBytes = null;
                if (!string.IsNullOrEmpty(emp.ImageBase64))
                {
                    try
                    {
                        if (emp.ImageBase64.StartsWith("data:image"))
                        {
                            int commaIndex = emp.ImageBase64.IndexOf(',');
                            if (commaIndex >= 0)
                            {
                                string base64Data = emp.ImageBase64.Substring(commaIndex + 1);
                                imageBytes = Convert.FromBase64String(base64Data);
                            }
                        }
                    }
                    catch
                    {
                        imageBytes = null; // if conversion fails
                    }
                }

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd;

                    if (emp.EmployeeId == 0) // INSERT
                    {
                        cmd = new SqlCommand(@"
                            INSERT INTO Employees 
                            (FullName, Department, Email, Phone, Role, ImageData) 
                            VALUES (@FullName, @Department, @Email, @Phone, @Role, @ImageData)", con);
                    }
                    else // UPDATE
                    {
                        cmd = new SqlCommand(@"
                            UPDATE Employees 
                            SET FullName=@FullName, Department=@Department, Email=@Email, Phone=@Phone, Role=@Role, ImageData=@ImageData 
                            WHERE EmployeeId=@EmployeeId", con);

                        cmd.Parameters.AddWithValue("@EmployeeId", emp.EmployeeId);
                    }

                    cmd.Parameters.AddWithValue("@FullName", emp.FullName ?? "");
                    cmd.Parameters.AddWithValue("@Department", emp.Department ?? "");
                    cmd.Parameters.AddWithValue("@Email", emp.Email ?? "");
                    cmd.Parameters.AddWithValue("@Phone", emp.Phone ?? "");
                    cmd.Parameters.AddWithValue("@Role", emp.Role ?? "");

                    // Image param
                    SqlParameter imageParam = new SqlParameter("@ImageData", SqlDbType.VarBinary);
                    imageParam.Value = (imageBytes != null && imageBytes.Length > 0) ? (object)imageBytes : DBNull.Value;
                    cmd.Parameters.Add(imageParam);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    return rows > 0 ? "Employee saved successfully!" : "Save failed!";
                }
            }
            catch (SqlException sqlEx)
            {
                return "Database Error: " + sqlEx.Message;
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message + " | StackTrace: " + ex.StackTrace;
            }
        }

        [WebMethod]
        public static object GetEmployee(int employeeId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(@"
                        SELECT EmployeeId, FullName, Department, Email, Phone, Role, ImageData 
                        FROM Employees 
                        WHERE EmployeeId=@EmployeeId", con);

                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);
                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        string base64 = "";
                        if (dr["ImageData"] != DBNull.Value)
                        {
                            byte[] imageBytes = (byte[])dr["ImageData"];
                            if (imageBytes != null && imageBytes.Length > 0)
                            {
                                base64 = "data:image/png;base64," + Convert.ToBase64String(imageBytes);
                            }
                        }

                        return new
                        {
                            EmployeeId = dr["EmployeeId"].ToString(),
                            FullName = dr["FullName"].ToString(),
                            Department = dr["Department"].ToString(),
                            Email = dr["Email"].ToString(),
                            Phone = dr["Phone"].ToString(),
                            Role = dr["Role"].ToString(),
                            ImageBase64 = base64
                        };
                    }

                    return null;
                }
            }
            catch (Exception ex)
            {
                return new { Error = "Error: " + ex.Message };
            }
        }

        [WebMethod]
        public static string DeleteEmployee(int employeeId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Employees WHERE EmployeeId=@EmployeeId", con);
                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    return rows > 0 ? "Employee deleted successfully!" : "Employee not found!";
                }
            }
            catch (Exception ex)
            {
                    return "Error: " + ex.Message;
            }
        }
    }
}
