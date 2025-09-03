<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="WebformProject.Signup" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Signup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #6f42c1, #0d6efd);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .form-control {
            border-radius: 0.5rem;
        }
        .btn-custom {
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 10px;
        }
        h2 {
            font-weight: 700;
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="w-100">
        <div class="container" style="max-width: 500px;">
            <div class="card p-4">
                <h2 class="text-center mb-4">Create Account</h2>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" required="true"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter your email" required="true"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password" required="true"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Role</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select Role --" Value="" />
                        <asp:ListItem Text="User" Value="User" />
                        <asp:ListItem Text="Admin" Value="Admin" />
                    </asp:DropDownList>
                </div>

                <asp:Button ID="btnSignup" runat="server" CssClass="btn btn-success w-100 btn-custom" Text="Sign Up" OnClick="btnSignup_Click" />

                <p class="text-center mt-3 mb-0">
                    Already have an account? 
                    <a href="Default.aspx" class="fw-semibold text-decoration-none text-primary">Login here</a>
                </p>
            </div>
        </div>
    </form>
</body>
</html>
