using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;

namespace  CrudUsingAjax
{
    public partial class Dashboard : System.Web.UI.Page
    {
        public class Employee
        {
            public int EmployeeId { get; set; }
            public string Name { get; set; }
            public string Department { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
        }
        [WebMethod]
        public static List<Employee> GetEmployees()
        {
            var list = new List<Employee>();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT EmployeeId, Name, Department, Email, Phone FROM Employees", conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    list.Add(new Employee
                    {
                        EmployeeId = (int)dr["EmployeeId"],
                        Name = dr["Name"].ToString(),
                        Department = dr["Department"].ToString(),
                        Email = dr["Email"].ToString(),
                        Phone = dr["Phone"].ToString()
                    });
                }
            }
            return list;
        }

        [WebMethod]
        public static Employee GetEmployeeById(int id)
        {
            Employee emp = null;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT EmployeeId, Name, Department, Email, Phone FROM Employees WHERE EmployeeId=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    emp = new Employee
                    {
                        EmployeeId = (int)dr["EmployeeId"],
                        Name = dr["Name"].ToString(),
                        Department = dr["Department"].ToString(),
                        Email = dr["Email"].ToString(),
                        Phone = dr["Phone"].ToString()
                    };
                }
            }
            return emp;
        }



        [WebMethod]
        public static void SaveEmployee(Employee emp)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString))
            {
                SqlCommand cmd;

                if (emp.EmployeeId == 0)
                {
                    // Insert
                    cmd = new SqlCommand("INSERT INTO Employees (Name, Department, Email, Phone) VALUES (@Name, @Department, @Email, @Phone)", conn);
                }
                else
                {
                    // Update
                    cmd = new SqlCommand("UPDATE Employees SET Name=@Name, Department=@Department, Email=@Email, Phone=@Phone WHERE EmployeeId=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", emp.EmployeeId);
                }

                cmd.Parameters.AddWithValue("@Name", emp.Name);
                cmd.Parameters.AddWithValue("@Department", emp.Department);
                cmd.Parameters.AddWithValue("@Email", emp.Email);
                cmd.Parameters.AddWithValue("@Phone", emp.Phone);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }


        [WebMethod]
        public static void DeleteEmployee(int id)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Employees WHERE EmployeeId=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
