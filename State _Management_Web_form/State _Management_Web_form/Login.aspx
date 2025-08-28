<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="State__Management_Web_form.Login" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <title>Login</title>
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
    <form id="form1" runat="server" class="card p-4 shadow-lg rounded-4" style="width: 350px;">
        <h3 class="text-center text-primary mb-3">Login</h3>
        <asp:TextBox ID="txtUser" runat="server" CssClass="form-control mb-3" 
            placeholder="Enter Username"></asp:TextBox>
        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary w-100" 
            Text="Login" OnClick="btnLogin_Click" />
        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger d-block mt-2"></asp:Label>
    </form>
</body>
