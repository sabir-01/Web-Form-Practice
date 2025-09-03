<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageProducts.aspx.cs" Inherits="WebformProject.Product" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            min-height: 100vh;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: 600;
        }
        .btn {
            border-radius: 0.5rem;
        }
        .table th {
            background-color: #0d6efd;
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="container my-5">
        
        <div class="text-center mb-5">
            <h2 class="fw-bold text-primary">🛒 Product Management</h2>
            <p class="text-muted">Add, update, and manage your products easily</p>
        </div>

        <asp:TextBox ID="txtId" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>

        <div class="card p-4 mb-4">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="txtName" class="form-label">Product Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter product name"></asp:TextBox>
                    <asp:RegularExpressionValidator 
                        ID="revName" runat="server" ControlToValidate="txtName"
                        ValidationExpression="^[a-zA-Z\s]+$"
                        ErrorMessage="Only letters are allowed in product name."
                        CssClass="text-danger small">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <label for="txtPrice" class="form-label">Price</label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="Enter price"></asp:TextBox>
                    <asp:RangeValidator 
                        ID="rvPrice" runat="server" ControlToValidate="txtPrice" 
                        MinimumValue="0" MaximumValue="999999999" Type="Double" 
                        ErrorMessage="Price cannot be less than 0" CssClass="text-danger small">
                    </asp:RangeValidator>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <label for="ddlCategory" class="form-label">Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem Value="Electronics">Electronics</asp:ListItem>
                        <asp:ListItem Value="Clothing">Clothing</asp:ListItem>
                        <asp:ListItem Value="Books">Books</asp:ListItem>
                        <asp:ListItem Value="Accessories">Accessories</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Product Image</label>
                    <div class="d-flex align-items-center gap-3">
                        <asp:Image ID="Getimage" Height="60" Width="60" Visible="false" CssClass="rounded border shadow-sm" runat="server" />
                        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                    </div>
                    <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
                </div>
            </div>

            <div class="text-center">
                <asp:Button ID="btnSave" runat="server" Text="💾 Save" CssClass="btn btn-success px-4 me-2" OnClick="btnSave_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="✏️ Update" CssClass="btn btn-warning px-4 me-2" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnDelete" runat="server" Text="🗑 Delete" CssClass="btn btn-danger px-4" OnClick="btnDelete_Click" />
            </div>
        </div>

        <div class="card">
            <div class="card-header bg-primary text-white fw-bold">
                Product List
            </div>
            <div class="card-body p-0">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-striped table-bordered mb-0 text-center align-middle"
                    DataKeyNames="ProductId" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="true" SelectText="➡ Select" />

                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="lblProductId" runat="server" Text='<%# Eval("ProductId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate>
                                <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("Category") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <asp:Image ID="lblImage" runat="server" ImageUrl='<%# Eval("ImagePath") %>'
                                    Width="80" Height="80" CssClass="rounded shadow-sm border" />
                            </ItemTemplate>
                        </asp:TemplateField>      
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </form>
</body>
</html>
