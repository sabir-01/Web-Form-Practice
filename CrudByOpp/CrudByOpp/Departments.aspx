<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Departments.aspx.cs" Inherits="CrudByOpp.Departments" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manage Departments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container mt-5">
        <h2>Manage Departments</h2>
        
        <!-- Input Field -->
        <div class="mb-3">
            <label for="txtDepartment" class="form-label">Department Name</label>
            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <!-- Hidden Field for Editing -->
        <asp:HiddenField ID="hdnDepartmentId" runat="server" />

        <!-- Buttons -->
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
<asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-primary" OnClick="btnBack_Click" />
        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" Visible="false" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" Visible="false" />

        <hr />

        <!-- Grid -->
        <asp:GridView ID="gvDepartments" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered mt-3"
            OnRowCommand="gvDepartments_RowCommand">
            <Columns>
                <asp:BoundField DataField="DepartmentId" HeaderText="ID" />
                <asp:BoundField DataField="DepartmentName" HeaderText="Department Name" />
                <asp:ButtonField CommandName="EditDept" Text="Edit" ButtonType="Button" ControlStyle-CssClass="btn btn-sm btn-warning" />
                <asp:ButtonField CommandName="DeleteDept" Text="Delete" ButtonType="Button" ControlStyle-CssClass="btn btn-sm btn-danger" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
