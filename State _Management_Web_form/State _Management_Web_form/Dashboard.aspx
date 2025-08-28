<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="State__Management_Web_form.Dashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <title>Dashboard</title>
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container mt-5">
        <div class="card shadow-lg p-4 rounded-4">
            <h2 class="text-center text-success mb-4">Dashboard</h2>
            <div class="alert alert-info">
                <asp:Label ID="lblWelcome" runat="server" CssClass="fw-bold"></asp:Label>
            </div>
            <div class="alert alert-secondary">
                <asp:Label ID="lblApp" runat="server" CssClass="fw-bold"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>