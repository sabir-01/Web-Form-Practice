<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="WebformProject.ManageUsers" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #0d6efd, #6f42c1);
            min-height: 100vh;
            padding: 30px;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        h2 {
            font-weight: 700;
            color: #0d6efd;
        }

        .btn-action {
            border-radius: 0.5rem;
            padding: 4px 12px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-0">👥 Manage Users</h2>
                <asp:Button ID="btnLogout" runat="server" Text="🚪 Logout" CssClass="btn btn-danger btn-sm"
                    OnClick="btnLogout_Click" />
            </div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-striped text-center align-middle"
                        AutoGenerateColumns="False" DataKeyNames="UserId"
                        OnRowEditing="GridView1_RowEditing"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit"
                        OnRowUpdating="GridView1_RowUpdating"
                        OnRowDeleting="GridView1_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="UserId" HeaderText="ID" ReadOnly="true" />
                            <asp:BoundField DataField="Username" HeaderText="Username" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />

                            <asp:TemplateField HeaderText="Password">
                                <ItemTemplate>
                                    <span>•••••••</span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtPasswordEdit" runat="server"
                                            Text='<%# Bind("Password") %>'
                                            TextMode="Password"
                                            CssClass="form-control form-control-sm text-center" />
                                        <button type="button" class="btn btn-outline-secondary btn-sm toggle-password">
                                            👁️
                                        </button>
                                    </div>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Role">
                                <ItemTemplate>
                                    <%# Eval("Role") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlRoleEdit" runat="server" CssClass="form-select form-select-sm"
                                        SelectedValue='<%# Bind("Role") %>'>
                                        <asp:ListItem Text="User" Value="User"></asp:ListItem>
                                        <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="CreatedAt" HeaderText="Created At" ReadOnly="true" />

                            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true"
                                EditText="✏️ Edit" DeleteText="🗑 Delete"
                                ControlStyle-CssClass="btn btn-sm btn-outline-primary btn-action mx-1" />
                        </Columns>
                    </asp:GridView>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowEditing" />
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowUpdating" />
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowDeleting" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>

<script>
    document.addEventListener("click", function (e) {
        if (e.target && e.target.classList.contains("toggle-password")) {
            const input = e.target.closest(".input-group").querySelector("input");
            if (input.type === "password") {
                input.type = "text";
                e.target.textContent = "🙈";
            } else {
                input.type = "password";
                e.target.textContent = "👁️";
            }
        }
    });
</script>
