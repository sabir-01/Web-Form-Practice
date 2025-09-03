<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebformProject._Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #0d6efd, #6f42c1);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .form-control {
            border-radius: 0.5rem;
            padding: 0.75rem;
        }
        .btn-custom {
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 10px;
        }
        h3 {
            font-weight: 700;
            color: #0d6efd;
        }
        a {
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="w-100" style="max-width: 420px;">
        <div class="card p-4">
            <div class="card-body">
                <h3 class="text-center mb-4">🔐 𝐋𝐨𝐠𝐢𝐧 𝐅𝐨𝐫𝐦</h3>

                <!-- Email -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        CssClass="text-danger small" ErrorMessage="Email is required"></asp:RequiredFieldValidator>
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                        CssClass="text-danger small" ErrorMessage="Password is required"></asp:RequiredFieldValidator>
                </div>

                <!-- Remember Me -->
                <div class="mb-3 form-check">
                    <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label fw-semibold">Remember me</label>
                </div>

                <!-- Login Button -->
                <div class="d-grid">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-lg btn-custom" OnClick="btnLogin_Click" />
                </div>

                <!-- Error Message -->
                <asp:Label ID="lblError" runat="server" CssClass="text-danger d-block mt-3 fw-semibold"></asp:Label>

                <!-- Register Redirect -->
                <p class="text-center mt-3 mb-0">
                    Not registered yet? 
                    <a href="Signup.aspx" class="fw-semibold text-primary">Register here</a>
                </p>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
