using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI.WebControls;
using Image = System.Web.UI.WebControls.Image;
using Label = System.Web.UI.WebControls.Label;

namespace WebformProject
{
    public partial class Product : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        void ResetControls()
        {
            txtId.Text = txtName.Text = txtPrice.Text = "";
            ddlCategory.ClearSelection();
            Getimage.Visible = false;
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

            if (fuImage.HasFile)
            {
                if (extension.ToLower() == ".jpg" || extension.ToLower() == ".png" || extension.ToLower() == ".jpeg")
                {
                    if (size <= 1000000)
                    {
                        fuImage.SaveAs(filepath + filename);
                        string path2 = "Images/" + filename;

                        string query = "INSERT INTO Products (Name, Price, Category, ImagePath) VALUES (@Name, @Price, @Category, @Image)";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                        cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedItem.Value);
                        cmd.Parameters.AddWithValue("@Image", path2);

                        con.Open();
                        int a = cmd.ExecuteNonQuery();
                        if (a > 0)
                        {
                          
                            Response.Write("<script>alert('Product Inserted Successfully!')</script>");
                            BindGridView();
                            ResetControls();
                        }
                        else
                        {
                            Response.Write("<script>alert('Insertion Failed!')</script>");
                        }
                        con.Close();
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
                    Label1.ForeColor = Color.Red;
                }

            }
            else
            {
                Label1.Text = "Please upload an image.";
                Label1.ForeColor = Color.Red;
                Label1.Visible = true;
            }
        }

        void BindGridView()
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT * FROM Products";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable data = new DataTable();
            sda.Fill(data);
            GridView1.DataSource = data;
            GridView1.DataBind();
        }

      

        protected void btnUpdate_Click(object sender, EventArgs e)
        { 
            SqlConnection con = new SqlConnection(cs);
            string filepath = Server.MapPath("Images/");
            string filename = Path.GetFileName(fuImage.FileName);
            string extension = Path.GetExtension(filename);
            string updatepath = "Images/";
            HttpPostedFile postedFile = fuImage.PostedFile;
            int size = postedFile.ContentLength;

            if (fuImage.HasFile == true)
            {
                if (extension.ToLower() == ".jpg" || extension.ToLower() == ".png" || extension.ToLower() == ".jpeg")
                {
                    if (size <= 1000000) // 1 MB
                    {
                        updatepath = updatepath + filename;
                        fuImage.SaveAs(Server.MapPath(updatepath));

                        string query = "UPDATE Products SET Name=@Name, Price=@Price, Category=@Category, ImagePath=@Image WHERE ProductId=@Id";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@Id", txtId.Text);
                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                        cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedItem.ToString());
                        cmd.Parameters.AddWithValue("@Image", updatepath);

                        con.Open();
                        int a = cmd.ExecuteNonQuery();
                        if (a > 0)
                        {
                            Response.Write("<script>alert('Product Updated Successfully!')</script>");
                            BindGridView();
                            ResetControls();
                            Label1.Visible = false;
                        }
                        else
                        {
                            Response.Write("<script>alert('Update Failed!')</script>");
                        }
                        con.Close();
                    }
                    else
                    {
                        Label1.Text = "File size must be less than 1 MB!";
                        Label1.Visible = true;
                        Label1.ForeColor = Color.Red;
                    }
                }
                else
                {
                    Label1.Text = "Only JPG, JPEG, PNG formats supported!";
                    Label1.Visible = true;
                    Label1.ForeColor = Color.Red;
                }
            }
            else
            {
                // Keep old image
                updatepath = Getimage.ImageUrl.ToString();

                string query = "UPDATE Products SET Name=@Name, Price=@Price, Category=@Category, ImagePath=@Image WHERE ProductId=@Id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", txtId.Text);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedItem.ToString());
                cmd.Parameters.AddWithValue("@Image", updatepath);

                con.Open();
                int a = cmd.ExecuteNonQuery();
                if (a > 0)
                {
                    Response.Write("<script>alert('Product Updated Successfully!')</script>");
                    BindGridView();
                    ResetControls();
                    Label1.Visible = false;
                    Getimage.Visible = false;

                    // Optional: delete old file from server
                    string deletepath = Server.MapPath(Getimage.ImageUrl.ToString());
                    if (File.Exists(deletepath))
                    {
                        File.Delete(deletepath);
                    }
                }
                else
                {
                    Response.Write("<script>alert('Update Failed!')</script>");
                }
                con.Close();
            }
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "DELETE FROM Products WHERE ProductId=@Id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Id", txtId.Text);

            con.Open();
            int a = cmd.ExecuteNonQuery();
            if (a > 0)
            {
                Response.Write("<script>alert('Product Deleted Successfully!')</script>");
                BindGridView();
                ResetControls();
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
                Response.Write("<script> alert('Deleation  Failed !!') </script>");
            }
            con.Close();
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = GridView1.SelectedRow;

            Label labelid = (Label)row.FindControl("lblProductId");
            Label labelName = (Label)row.FindControl("lblName");
            Label labelprice = (Label)row.FindControl("lblPrice");
            Label labelCategory = (Label)row.FindControl("lblCategory");

            Image img = (Image)row.FindControl("lblImage");

            txtId.Text = labelid.Text;
            txtName.Text = labelName.Text;
            txtPrice.Text = labelprice.Text;
            ddlCategory.SelectedValue = labelCategory.Text; // ✅ better than .Text
            Getimage.ImageUrl = img.ImageUrl;
            Getimage.Visible = true;
        }


    }
}
