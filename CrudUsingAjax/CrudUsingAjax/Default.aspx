<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CrudUsingAjax.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>AJAX Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <div class="container mt-5" style="max-width:400px;">
            <div class="card p-4 shadow">
                <h4 class="text-center">Login</h4>

                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" id="email" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" id="password" class="form-control" required />
                </div>

                <div id="message" class="mb-3 text-danger"></div>

                <button type="button" id="loginBtn" class="btn btn-primary w-100">Login</button>
            </div>
        </div>
    </form>

    <script>
        $(document).ready(function () {
            $("#loginBtn").click(function () {
                var email = $("#email").val();
                var password = $("#password").val();

                $.ajax({
                    type: "POST",
                    url: "Default.aspx/LoginUser", // must match your page name
                    data: JSON.stringify({ email: email, password: password }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d === "success") {
                            window.location.href = "Dashboard.aspx";
                        } else {
                            $("#message").text(response.d);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("AJAX Error:", error);
                      
                    }
                });
            });
        });
    </script>
</body>
</html>