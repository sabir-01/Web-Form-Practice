<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="WebformProject.DashBoard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid p-0">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <a class="navbar-brand ms-3" href="#">🛒 E-Shop Admin</a>
                <div class="ms-auto me-3">
                    <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger btn-sm" Text="Logout" OnClick="btnLogout_Click" />
                </div>
            </nav>

            <!-- Dashboard Content -->
            <div class="row mt-4">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 bg-light p-3 border-end">
                    <h5>Menu</h5>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="ManageProducts.aspx"><i class="bi bi-box"></i> Manage Products</a></li>
                        <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-people"></i> Manage Users</a></li>
                        <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-cart-check"></i> Orders</a></li>
                    </ul>
                </div>

                <!-- Main Area -->
                <div class="col-md-9 col-lg-10 p-4">
                    <h3>Welcome, <asp:Label ID="lblAdminName" runat="server" Text=""></asp:Label> 👋</h3>
                    <hr />

                    <div class="row g-3">
                        <!-- Card: Products -->
                        <div class="col-md-4">
                            <div class="card shadow-lg border-0 rounded-3">
                                <div class="card-body text-center">
                                    <i class="bi bi-box-seam display-4 text-primary"></i>
                                    <h5 class="card-title mt-2">Products</h5>
                                    <p class="card-text">Add, edit, or remove products.</p>
                                    <a href="ManageProducts.aspx" class="btn btn-outline-primary">Go</a>
                                </div>
                            </div>
                        </div>

                        <!-- Card: Users -->
                        <div class="col-md-4">
                            <div class="card shadow-lg border-0 rounded-3">
                                <div class="card-body text-center">
                                    <i class="bi bi-people-fill display-4 text-success"></i>
                                    <h5 class="card-title mt-2">Users</h5>
                                    <p class="card-text">View and manage registered users.</p>
                                    <a href="ManageUsers.aspx" class="btn btn-outline-success">Go</a>
                                </div>
                            </div>
                        </div>

                        <!-- Card: Orders -->
                        <div class="col-md-4">
                            <div class="card shadow-lg border-0 rounded-3">
                                <div class="card-body text-center">
                                    <i class="bi bi-cart-check-fill display-4 text-warning"></i>
                                    <h5 class="card-title mt-2">Orders</h5>
                                    <p class="card-text">Track customer orders.</p>
                                    <a href="ManageOrders.aspx" class="btn btn-outline-warning">Go</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>