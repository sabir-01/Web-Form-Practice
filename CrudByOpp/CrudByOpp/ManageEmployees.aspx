<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageEmployees.aspx.cs" Inherits="CrudByOpp.ManageEmployees" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manage Employees</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <form id="form1" runat="server" class="container mt-4">

        <h2 class="mb-3">Employee Management</h2>

        <button type="button" class="btn btn-primary mb-3" 
                data-bs-toggle="modal" data-bs-target="#employeeModal" onclick="clearForm()">
            Add Employee
        </button>
      
        <div class="row mb-3">
            <div class="col-md-6">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                    placeholder="Search by name, department, or email..."
                    OnTextChanged="txtSearch_TextChanged" AutoPostBack="true">
                </asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnClearSearch" runat="server" Text="Clear" 
                    CssClass="btn btn-secondary" OnClick="btnClearSearch_Click" />
            </div>
        </div>

        <asp:GridView ID="gvEmployees" runat="server"
            CssClass="table table-bordered table-striped"
            AutoGenerateColumns="False" DataKeyNames="EmployeeId">

            <Columns>
                <asp:BoundField DataField="EmployeeId" HeaderText="ID" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" />
                <asp:BoundField DataField="Role" HeaderText="Role" />

                <asp:TemplateField HeaderText="Photo">
                    <ItemTemplate>
                        <%# !string.IsNullOrEmpty(Eval("ImageBase64").ToString())
                            ? "<img src='" + Eval("ImageBase64") + "' style='width:80px;height:80px;object-fit:cover;border:1px solid #ddd;' />"
                            : "<div style='width:80px;height:80px;background:#f3f4f6;border:1px solid #ddd;display:flex;align-items:center;justify-content:center;color:#999;font-size:12px;'>No Photo</div>"
                        %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <button type="button" class="btn btn-sm btn-warning"
                            onclick="editEmployee('<%# Eval("EmployeeId") %>')">Edit</button>
                        <button type="button" class="btn btn-sm btn-danger"
                            onclick="deleteEmployee('<%# Eval("EmployeeId") %>')">Delete</button>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div class="modal fade" id="employeeModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title">Employee</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <input type="hidden" id="hdnEmployeeId" />

                        <div class="mb-3">
                            <label>Full Name</label>
                            <input type="text" id="txtFullName" class="form-control" />
                        </div>

                        <div class="mb-3">
                            <label>Department</label>
                            <input type="text" id="txtDepartment" class="form-control" />
                        </div>

                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" id="txtEmail" class="form-control" />
                        </div>

                        <div class="mb-3">
                            <label>Phone</label>
                            <input type="text" id="txtPhone" class="form-control" />
                        </div>

                        <div class="mb-3">
                            <label>Role</label>
                            <select id="ddlRole" class="form-control">
                                <option value="Staff">Staff</option>
                                <option value="Manager">Manager</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Photo</label>
                            <div class="mb-2">
                                <img id="imgPreview" style="width: 80px; height: 80px; border: 1px solid #ddd; display: none;" />
                            </div>
                            <input type="file" id="fileImage" class="form-control" accept="image/*" onchange="previewImage(this)" />
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="saveEmployee()">Save</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="clearForm()">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $("#imgPreview").attr("src", e.target.result).show();
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function clearForm() {
            $("#hdnEmployeeId").val("");
            $("#txtFullName").val("");
            $("#txtDepartment").val("");
            $("#txtEmail").val("");
            $("#txtPhone").val("");
            $("#ddlRole").val("Staff");
            $("#fileImage").val("");
            $("#imgPreview").attr("src", "").hide();
        }

        function editEmployee(id) {
            $.ajax({
                type: "POST",
                url: "ManageEmployees.aspx/GetEmployee",
                data: JSON.stringify({ employeeId: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    var emp = res.d;
                    $("#hdnEmployeeId").val(emp.EmployeeId);
                    $("#txtFullName").val(emp.FullName);
                    $("#txtDepartment").val(emp.Department);
                    $("#txtEmail").val(emp.Email);
                    $("#txtPhone").val(emp.Phone);
                    $("#ddlRole").val(emp.Role);

                    if (emp.ImageBase64 && emp.ImageBase64 !== "") {
                        $("#imgPreview").attr("src", emp.ImageBase64).show();
                    } else {
                        $("#imgPreview").attr("src", "").hide();
                    }

                    $("#employeeModal").modal("show");
                },
                error: function (xhr, status, error) {
                    console.error("Error fetching employee:", error);
                    alert("Error loading employee data!");
                }
            });
        }

        function saveEmployee() {
            var fullName = $("#txtFullName").val().trim();
            var email = $("#txtEmail").val().trim();
            var department = $("#txtDepartment").val().trim();
            var phone = $("#txtPhone").val().trim();
            var role = $("#ddlRole").val();

            if (!fullName) { alert("Full Name is required!"); return; }
            if (!email) { alert("Email is required!"); return; }
            if (!department) { alert("Department is required!"); return; }
            if (!phone) { alert("Phone is required!"); return; }

            var employeeId = $("#hdnEmployeeId").val();
            var imageBase64 = $("#imgPreview").attr("src") || "";

            var emp = {
                EmployeeId: employeeId ? parseInt(employeeId) : 0,
                FullName: fullName,
                Department: department,
                Email: email,
                Phone: phone,
                Role: role,
                ImageBase64: imageBase64
            };

            $.ajax({
                type: "POST",
                url: "ManageEmployees.aspx/SaveEmployee",
                data: JSON.stringify({ emp: emp }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    alert(res.d);
                    if (res.d && res.d.includes("successfully")) {
                        $("#employeeModal").modal("hide");
                        clearForm();
                        location.reload();
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error saving employee: " + error);
                }
            });
        }

        function deleteEmployee(id) {
            if (confirm("Are you sure you want to delete this employee?")) {
                $.ajax({
                    type: "POST",
                    url: "ManageEmployees.aspx/DeleteEmployee",
                    data: JSON.stringify({ employeeId: parseInt(id) }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (res) {
                        alert(res.d);
                        if (res.d.includes("successfully")) {
                            location.reload();
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("Error deleting employee!");
                    }
                });
            }
        }
    </script>
</body>
</html>
