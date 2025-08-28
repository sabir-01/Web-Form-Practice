<%@ Page Title="Home Page" Language="C#"  AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="State__Management_Web_form._Default" %>
<!DOCTYPE html>
<html>
<head runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <title>State Management Demo</title>
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container mt-5">
        <div class="card shadow-lg p-4 rounded-4">
            <h2 class="text-center text-primary mb-4">ASP.NET State Management Demo</h2>

            <!-- ViewState Example -->
            <div class="mb-3">
                <label class="form-label fw-bold">ViewState Counter:</label>
                <asp:Label ID="lblCounter" runat="server" CssClass="badge bg-info fs-6"></asp:Label><br />
                <asp:Button ID="btnIncrement" runat="server" CssClass="btn btn-primary mt-2" 
                    Text="Increment Counter" OnClick="btnIncrement_Click" />
            </div>
            <hr />

            <!-- HiddenField Example -->
            <div class="mb-3">
                <asp:Button ID="btnHidden" runat="server" CssClass="btn btn-secondary"
                    Text="Show HiddenField" OnClick="btnHidden_Click" />
                <asp:Label ID="lblHidden" runat="server" CssClass="ms-2 text-success fw-bold"></asp:Label>
                <asp:HiddenField ID="hfValue" runat="server" Value="HelloHidden" />
            </div>
            <hr />

            <!-- QueryString Example -->
            <div class="mb-3">
                <asp:Button ID="btnQuery" runat="server" CssClass="btn btn-warning"
                    Text="Go to Login (QueryString)" OnClick="btnQuery_Click" />
            </div>
            <hr />

            <!-- Cookies Example -->
            <div class="mb-3">
                <label class="form-label fw-bold">Set Cookie:</label>
                <asp:TextBox ID="txtCookie" runat="server" CssClass="form-control mb-2" placeholder="Enter Cookie Value"></asp:TextBox>
                <asp:Button ID="btnSetCookie" runat="server" CssClass="btn btn-success me-2" 
                    Text="Set Cookie" OnClick="btnSetCookie_Click" />
                <asp:Button ID="btnGetCookie" runat="server" CssClass="btn btn-outline-success" 
                    Text="Get Cookie" OnClick="btnGetCookie_Click" />
                <div class="mt-2">
                    <asp:Label ID="lblCookie" runat="server" CssClass="text-dark fw-bold"></asp:Label>
                </div>
            </div>
        </div>
    </form>
</body>
</html>