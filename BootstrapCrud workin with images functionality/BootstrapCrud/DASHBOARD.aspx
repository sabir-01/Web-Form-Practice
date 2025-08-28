<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DASHBOARD.aspx.cs" Inherits="BootstrapCrud.DASHBOARD" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <title>Employee CRUD Application</title>
    <style>
        .form-container {
            width: 400px;
            margin: 50px auto;
            border: 2px solid #000;
            padding: 20px;
            border-radius: 5px;
            background: #fff;
        }

            .form-container h3 {
                text-align: center;
                margin-bottom: 20px;
            }

        .auto-style1 {
            width: 86px;
        }

        .auto-style2 {
            width: 273px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h3>EMPLOYEE CRUD APPLICATION</h3>
            <table>
                <tr>
                    <td class="auto-style1">ID</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtId" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtId" ErrorMessage="Id Requirred" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">NAME</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" ErrorMessage="Name Required" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">AGE</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtAge" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAge" ErrorMessage="age required" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">GENDER</td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                            <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlGender" ErrorMessage="select gender" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">DESIGNATION</td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlDesignation" runat="server" CssClass="form-control">
                            <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                            <asp:ListItem Text="Manager" Value="Manager"></asp:ListItem>
                            <asp:ListItem Text="Developer" Value="Developer"></asp:ListItem>
                            <asp:ListItem Text="Designer" Value="Designer"></asp:ListItem>
                            <asp:ListItem Text="Tester" Value="Tester"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlDesignation" ErrorMessage="select designation " ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">SALARY</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtSalary" ErrorMessage="Enter salary" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">IMAGE</td>
                    <td class="auto-style2">
                        <br />
                        <asp:Image ID="Getimage" Height="50" width="50" visible="false"  runat="server" />
                        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                        <br />
                        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-top: 15px;">
                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" />
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" Width="62px" OnClick="btnDelete_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-top: 15px;">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="Larger" ForeColor="Red" Height="85px" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:GridView ID="GridView1" runat="server" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" HorizontalAlign="Center" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:TemplateField HeaderText="ID">
                    <ItemTemplate>
                        <asp:Label ID="LabelID" runat="server" Text='<%# Eval("EmployeeId") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="NAME">
                    <ItemTemplate>
                        <asp:Label ID="LabelNAME" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="AGE">
                    <ItemTemplate>
                        <asp:Label ID="LabelAGE" runat="server" Text='<%#Eval("Age") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GENDER">

                    <ItemTemplate>
                        <asp:Label ID="Labelgender" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="DESIGNATION ">
                    <ItemTemplate>
                        <asp:Label ID="LabelDESIGNATION" runat="server" Text='<%# Eval("Designation") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="SALARY">
                    <ItemTemplate>
                        <asp:Label ID="LabelSALARY" runat="server" Text='<%# Eval("Salary") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="IMAGE">
                    <ItemTemplate>
                        <asp:Image ID="LabelIMAGage"  Height="50" Width="50" ImageUrl='<%# Eval("Image_path") %>'  runat="server"  />
                        
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
