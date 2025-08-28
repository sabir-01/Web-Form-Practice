using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace CrudUsingAjax
{
    public partial class Default : System.Web.UI.Page
    {
        [WebMethod]
        public static string LoginUser(string email, string password)
        {
            try
            {
                // Get connection string from Web.config
                string connStr = ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT COUNT(*) FROM Users WHERE Email=@Email AND Password=@Password";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    conn.Close();

                    if (count > 0)
                        return "success";
                    else
                        return "Invalid email or password";
                }
            }
            catch (Exception ex)
            {
                // You can log the error here
                return "Error: " + ex.Message;
            }
        }
    }
}
