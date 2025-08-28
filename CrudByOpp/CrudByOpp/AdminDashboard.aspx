<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="CrudByOpp.AdminDashboard" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Employee Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f8f9fa;
        }

        .dashboard-container {
            margin: 30px auto;
            max-width: 1300px;
        }

        .card {
            border-radius: 15px;
        }

        .table th {
            background-color: #667eea;
            color: white;
        }

        .logout-btn {
            float: right;
        }

        .nav-pills .nav-link.active {
            background-color: #667eea;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-tachometer-alt"></i>Admin Dashboard</h2>
                <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger logout-btn" Text="Logout" OnClick="btnLogout_Click" />
            </div>

            <!-- Dashboard Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card text-center shadow p-3">
                        <i class="fas fa-users fa-2x text-primary"></i>
                        <h5 class="mt-2">Total Employees</h5>
                        <asp:Label ID="lblTotalEmployees" runat="server" CssClass="fw-bold fs-4 text-dark"></asp:Label>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow p-3">
                        <i class="fas fa-building fa-2x text-success"></i>
                        <h5 class="mt-2">Departments</h5>
                        <asp:Label ID="lblDepartments" runat="server" CssClass="fw-bold fs-4 text-dark"></asp:Label>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow p-3">
                        <i class="fas fa-user-shield fa-2x text-warning"></i>
                        <h5 class="mt-2">Admins</h5>
                        <asp:Label ID="lblAdmins" runat="server" CssClass="fw-bold fs-4 text-dark"></asp:Label>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center shadow p-3">
                        <i class="fas fa-user-tie fa-2x text-danger"></i>
                        <h5 class="mt-2">HR Staff</h5>
                        <asp:Label ID="lblHR" runat="server" CssClass="fw-bold fs-4 text-dark"></asp:Label>
                    </div>
                </div>
            </div>

            <!-- Navigation Tabs -->
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="users-tab" data-bs-toggle="pill" data-bs-target="#users" type="button" role="tab">
                        <i class="fas fa-users"></i>Manage Users
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <a href="ManageEmployees.aspx" class="nav-link" role="tab">
                        <i class="fas fa-id-card"></i>Manage Employees
                    </a>

                </li>
                <li class="nav-item" role="presentation">
                    <a href="Departments.aspx" class="nav-link" role="tab">
                        <i class="fas fa-building"></i>Departments
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reports-tab" data-bs-toggle="pill" data-bs-target="#reports" type="button" role="tab">
                        <i class="fas fa-chart-line"></i>Reports
                    </button>
                </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content" id="pills-tabContent">
                <!-- Users -->
                <div class="tab-pane fade show active" id="users" role="tabpanel">
                    <div class="d-flex justify-content-between mb-3">
                        <h4><i class="fas fa-users"></i>Users List</h4>
                        <%--                        <asp:Button ID="btnAddUser" runat="server" CssClass="btn btn-primary" Text="Add NUsers List</h4>--%>
                        <%--                        <asp:Button ID="btnAddUser" runat="server" CssClass="btn btn-primary" Text="Add New User" OnClick="btnAddUser_Click" />--%>
                    </div>
                    <asp:GridView ID="gvUsers" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" DataKeyNames="UserId">
                        <Columns>
                            <asp:BoundField DataField="UserId" HeaderText="ID" />
                            <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Role" HeaderText="Role" />
                            <asp:BoundField DataField="CreatedAt" HeaderText="Created At" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <button type="button" class="btn btn-sm btn-danger" onclick="deleteUser(<%# Eval("UserId") %>)">
                                        Delete
                                    </button>
                                    <button type="button" class="btn btn-sm btn-warning"
                                        onclick="editRow(<%# Eval("UserId") %>, this)">
                                        Edit
                                    </button>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>



                </div>

                <!-- Departments -->
                <div class="tab-pane fade" id="departments" role="tabpanel">
                    <div class="d-flex justify-content-between mb-3">
                        <h4><i class="fas fa-building"></i>Departments</h4>
                        <asp:Button ID="btnAddDept" runat="server" CssClass="btn btn-info" Text="Add Department" />
                    </div>
                    <asp:GridView ID="gvDepartments" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="DeptId" HeaderText="ID" />
                            <asp:BoundField DataField="DeptName" HeaderText="Department Name" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnEditDept" runat="server" Text="Edit" CssClass="btn btn-sm btn-warning" CommandName="EditDept" CommandArgument='<%# Eval("DeptId") %>' />
                                    <asp:Button ID="btnDeleteDept" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" CommandName="DeleteDept" CommandArgument='<%# Eval("DeptId") %>' OnClientClick="return confirm('Are you sure you want to delete this department?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- Reports -->
                <div class="tab-pane fade" id="reports" role="tabpanel">
                    <h4><i class="fas fa-chart-line"></i>Reports</h4>
                    <p>Here you can download system reports (Employees, Attendance, Payroll, etc.)</p>
                    <asp:Button ID="btnEmployeeReport" runat="server" Text="Download Employees Report" CssClass="btn btn-outline-primary mb-2" />
                    <asp:Button ID="btnAttendanceReport" runat="server" Text="Download Attendance Report" CssClass="btn btn-outline-success mb-2" />
                    <asp:Button ID="btnPayrollReport" runat="server" Text="Download Payroll Report" CssClass="btn btn-outline-danger" />
                </div>
            </div>
        </div>
    </form>
    <!-- Update User Modal -->
    <div class="modal fade" id="updateUserModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title">Update User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="updateUserId" />

                    <div class="form-group mb-2">
                        <label>Full Name</label>
                        <input type="text" id="updateFullName" class="form-control" />
                    </div>

                    <div class="form-group mb-2">
                        <label>Email</label>
                        <input type="email" id="updateEmail" class="form-control" />
                    </div>

                    <div class="form-group mb-2">
                        <label>Role</label>
                        <select id="updateRole" class="form-control">
                            <option value="Admin">Admin</option>
                            <option value="HR">HR</option>
                            <option value="Finance">Finance</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-warning" onclick="updateUser()">Save Changes</button>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <!-- AJAX Script -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function deleteUser(userId) {
            if (confirm("Are you sure you want to delete this user?")) {
                $.ajax({
                    type: "POST",
                    url: "AdminDashboard.aspx/DeleteUser",
                    data: JSON.stringify({ userId: userId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert(response.d);
                        location.reload(); // reload grid
                    },
                    error: function (xhr, status, error) {
                        alert("Error: " + error);
                    }
                });
            }
        }



        function editRow(userId, btn) {
            let row = $(btn).closest("tr");

            let fullName = row.find("td:eq(1)").text();
            let email = row.find("td:eq(2)").text();
            let role = row.find("td:eq(3)").text().trim();

            // Dropdown options
            let roleOptions = `
        <select id="ddlRole_${userId}" class="form-control">
            <option value="Admin" ${role === "Admin" ? "selected" : ""}>Admin</option>
            <option value="HR" ${role === "HR" ? "selected" : ""}>HR</option>
            <option value="Finance" ${role === "Finance" ? "selected" : ""}>Finance</option>
            <option value="User" ${role === "User" ? "selected" : ""}>User</option>
        </select>
    `;

            // Replace text with inputs
            row.find("td:eq(1)").html('<input type="text" id="txtFullName_' + userId + '" class="form-control" value="' + fullName + '" />');
            row.find("td:eq(2)").html('<input type="email" id="txtEmail_' + userId + '" class="form-control" value="' + email + '" />');
            row.find("td:eq(3)").html(roleOptions);

            // Change button text to Save
            $(btn).text("Save")
                .removeClass("btn-warning")
                .addClass("btn-success")
                .attr("onclick", "saveRow(" + userId + ", this)");
        }

        function saveRow(userId, btn) {
            let fullName = $("#txtFullName_" + userId).val();
            let email = $("#txtEmail_" + userId).val();
            let role = $("#ddlRole_" + userId).val(); // <-- get selected role

            $.ajax({
                type: "POST",
                url: "AdminDashboard.aspx/UpdateUser",
                data: JSON.stringify({ userId: userId, fullName: fullName, email: email, role: role }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    alert(response.d);

                    let row = $(btn).closest("tr");

                    // Replace inputs with updated values
                    row.find("td:eq(1)").text(fullName);
                    row.find("td:eq(2)").text(email);
                    row.find("td:eq(3)").text(role);

                    // Reset button back to Edit
                    $(btn).text("Edit")
                        .removeClass("btn-success")
                        .addClass("btn-warning")
                        .attr("onclick", "editRow(" + userId + ", this)");
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });
        }

    </script>


</body>
</html>
