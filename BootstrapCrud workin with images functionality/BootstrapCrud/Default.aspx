<%@ Page Title="Home Page" Language="C#"  AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BootstrapCrud._Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

</head>
<body class="d-flex align-items-center justify-content-center vh-100 bg-light">
    <form id="form1" runat="server" class="w-100" style="max-width:400px;">
        <div class="card shadow-lg border-0 rounded-3">
            <div class="card-body p-4">
                <h3 class="text-center mb-4">🔐 Login</h3>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                        CssClass="text-danger small" ErrorMessage="Email is required"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                        CssClass="text-danger small" ErrorMessage="Password is required"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 form-check">
                    <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label">Remember me</label>
                </div>
                <div class="d-grid">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-lg" OnClick="btnLogin_Click" />
                </div>
                <asp:Label ID="lblError" runat="server" CssClass="text-danger d-block mt-3"></asp:Label>
            </div>
        </div>
    </form>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>