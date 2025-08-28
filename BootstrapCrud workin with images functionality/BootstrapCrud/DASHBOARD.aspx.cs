using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Drawing;
using System.Data;
using System.Web.UI.WebControls;
using Image = System.Web.UI.WebControls.Image;

namespace BootstrapCrud
{

    public partial class DASHBOARD : System.Web.UI.Page
    {
    string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }
        void resetcontol()
        {
            txtId.Text = txtName.Text = txtSalary.Text = txtAge.Text = "";
            ddlDesignation.ClearSelection();
            ddlGender.ClearSelection();
            Label1.Visible = false;
            Getimage.Visible = false;
            GridView1.SelectedIndex = -1;

        
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
          SqlConnection con = new SqlConnection(cs);
            string filepath = Server.MapPath("Images/");
            string filename = Path.GetFileName(fuImage.FileName);
            string extension = Path.GetExtension(filename);
            HttpPostedFile postedFile = fuImage.PostedFile;
            int size = postedFile.ContentLength;

            if (fuImage.HasFile == true)
            {
                if(extension.ToLower() == ".jpg" || extension.ToLower() == ".png" || extension.ToLower() == ".jpeg")
                {
                    if (size <= 1000000)
                    {
                        string query2 = "select * from Employees where EmployeeId = @id";
                        SqlCommand cmd2 = new SqlCommand(query2, con);
                        cmd2.Parameters.AddWithValue("@id", txtId.Text);
                        con.Open();
                        SqlDataReader dr = cmd2.ExecuteReader();
                        if (dr.HasRows == true)
                        {
                            Response.Write("<script> alert('ID already Exist !!') </script>");

                        }
                        else {
                            con.Close();


                            fuImage.SaveAs(filepath + filename);
                            string path2 = "Images/" + filename;
                            string query = "insert into Employees values(@id,@Name,@age,@gender,@Designation,@salary,@image)";
                            SqlCommand cmd = new SqlCommand(query, con);
                            cmd.Parameters.AddWithValue("@id", txtId.Text);
                            cmd.Parameters.AddWithValue("@name", txtName.Text);
                            cmd.Parameters.AddWithValue("@age", txtAge.Text);
                            cmd.Parameters.AddWithValue("@gender", ddlGender.SelectedItem.Value);
                            cmd.Parameters.AddWithValue("@Designation", ddlDesignation.SelectedItem.Value);
                            cmd.Parameters.AddWithValue("@salary", txtSalary.Text);
                            cmd.Parameters.AddWithValue("@image", path2);
                            con.Open();
                            int a = cmd.ExecuteNonQuery();
                            if (a > 0)
                            {
                                Response.Write("<script> alert('Insertion sucessfully !!') </script>");
                                BindGridView();
                                resetcontol();
                                Label1.Visible = false;
                            }
                            else
                            {
                                Response.Write("<script> alert('Insertion Failed !!') </script>");
                            }
                            con.Close();
                         }
                    }
                    else
                    {
                        Label1.Text = "Length should be Less then 5 MB !! ";
                        Label1.Visible = true;
                        Label1.ForeColor = Color.Red;
                    }
                }
                else
                {
                    Label1.Text = "Format Not supported !! ";
                    Label1.Visible = true;
                    Label1.ForeColor = Color.Red;
                }
            }
            else
            {
                Label1.Text = "plz upload image ";
                Label1.Visible = true;
                Label1.ForeColor =Color.Red;
            }
            
        }    
        protected void btnClear_Click1(object sender, EventArgs e)
        {
            resetcontol();
        }
        void BindGridView()
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "select * from Employees";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable data = new DataTable();
            sda.Fill(data);
            GridView1.DataSource = data;
            GridView1.DataBind();

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = GridView1.SelectedRow;
            Label labelid = (Label)row.FindControl("LabelID");
            Label labelName = (Label)row.FindControl("LabelNAME");
            Label labelAge = (Label)row.FindControl("LabelAGE");
            Label labelgender = (Label)row.FindControl("Labelgender");
            Label labeldesignation = (Label)row.FindControl("LabelDESIGNATION");
            Label labelsalary = (Label)row.FindControl("LabelSALARY");
            Image img = (Image)row.FindControl("LabelIMAGage");

            txtId.Text = labelid.Text;
            txtName.Text = labelName.Text;
            txtAge.Text = labelAge.Text;
            ddlGender.Text = labelgender.Text;
            ddlDesignation.Text = labeldesignation.Text;
            txtSalary.Text = labelsalary.Text;
            Getimage.ImageUrl = img.ImageUrl;
            Getimage.Visible = true;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            SqlConnection con = new SqlConnection(cs);
            string filepath = Server.MapPath("Images/");
            string filename = Path.GetFileName(fuImage.FileName);
            string extension = Path.GetExtension(filename);
            HttpPostedFile postedFile = fuImage.PostedFile;
            int size = postedFile.ContentLength;
            string updatepath = "images/";

            if (fuImage.HasFile == true)
            {
                if (extension.ToLower() == ".jpg" || extension.ToLower() == ".png" || extension.ToLower() == ".jpeg")
                {
                    if (size <= 1000000)
                    {
                        updatepath = updatepath + filename;
                        fuImage.SaveAs(Server.MapPath(updatepath));
                        string query = "update Employees set Name = @nmae, Age = @age,Gender = @gender, Designation = @desi, Salary = @salary, Image_path = @img where EmployeeId = @id";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@id", txtId.Text);
                        cmd.Parameters.AddWithValue("@nmae", txtName.Text);
                        cmd.Parameters.AddWithValue("@age", txtAge.Text);
                        cmd.Parameters.AddWithValue("@gender", ddlGender.SelectedItem.ToString());
                        cmd.Parameters.AddWithValue("@desi", ddlDesignation.SelectedItem.ToString());
                        cmd.Parameters.AddWithValue("@salary", txtSalary.Text);
                        cmd.Parameters.AddWithValue("@img", updatepath);
                        con.Open();
                        int a = cmd.ExecuteNonQuery();
                        if (a > 0)
                        {
                            Response.Write("<script> alert('Updated sucessfully !!') </script>");
                            BindGridView();
                            resetcontol();
                            Label1.Visible = false;
                            Getimage.Visible = false;
                        }
                        else
                        {
                            Response.Write("<script> alert('Updated  Failed !!') </script>");
                        }
                        con.Close();
                    }
                    else
                    {
                        Label1.Text = "Length should be Less then 5 MB !! ";
                        Label1.Visible = true;
                        Label1.ForeColor = Color.Red;
                    }
                }
                else
                {
                    Label1.Text = "Format Not supported !! ";
                    Label1.Visible = true;
                    Label1.ForeColor = Color.Red;
                }
            }
            else
            {
                updatepath = Getimage.ImageUrl.ToString();
                fuImage.SaveAs(Server.MapPath(updatepath));
                string query = "update Employees set Name = @nmae, Age = @age,Gender = @gender, Designation = @desi, Salary = @salary, Image_path = @img where EmployeeId = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", txtId.Text);
                cmd.Parameters.AddWithValue("@nmae", txtName.Text);
                cmd.Parameters.AddWithValue("@age", txtAge.Text);
                cmd.Parameters.AddWithValue("@gender", ddlGender.SelectedItem.ToString());
                cmd.Parameters.AddWithValue("@desi", ddlDesignation.SelectedItem.ToString());
                cmd.Parameters.AddWithValue("@salary", txtSalary.Text);
                cmd.Parameters.AddWithValue("@img", updatepath);
                con.Open();
                int a = cmd.ExecuteNonQuery();
                if (a > 0)
                {
                    Response.Write("<script> alert('Updated sucessfully !!') </script>");
                    BindGridView();
                    resetcontol();
                    Label1.Visible = false;
                    Getimage.Visible = false;
                    string deletepath = Server.MapPath(Getimage.ImageUrl.ToString());
                    if (File.Exists(deletepath) == true)
                    {
                        File.Delete(deletepath);
                    }
                }
                else
                {
                    Response.Write("<script> alert('Updated  Failed !!') </script>");
                }
                con.Close();
            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "delete from  Employees  where EmployeeId = @id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@id", txtId.Text);       
            con.Open();
            int a = cmd.ExecuteNonQuery();
            if (a > 0)
            {
                Response.Write("<script> alert('Deleted sucessfully !!') </script>");
                BindGridView();
                resetcontol();
                Label1.Visible = false;
                Getimage.Visible = false;
                string deletepath = Server.MapPath(Getimage.ImageUrl.ToString());
                if(File.Exists(deletepath) == true)
                {
                    File.Delete(deletepath);
                }
            }
            else
            {
                Response.Write("<script> alert('Deleation  Failed !!') </script>");
            }
            con.Close();
        }
    }
}