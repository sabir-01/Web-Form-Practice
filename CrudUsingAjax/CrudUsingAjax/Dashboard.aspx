<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CrudUsingAjax.Dashboard" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .form-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
            font-size: 14px;
        }
        .btn:hover {
            background: #0056b3;
        }
        .btn-danger {
            background: #dc3545;
        }
        .btn-danger:hover {
            background: #c82333;
        }
        .btn-success {
            background: #28a745;
        }
        .btn-success:hover {
            background: #218838;
        }
        .btn-warning {
            background: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background: #e0a800;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #555;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .editable-row {
            background-color: #fff3cd !important;
        }
        .edit-input {
            width: 100%;
            padding: 5px;
            border: 1px solid #007bff;
            border-radius: 3px;
            font-size: 12px;
        }
        .loading {
            text-align: center;
            padding: 20px;
            color: #666;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            text-align: center;
        }
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .actions {
            white-space: nowrap;
        }
        .form-row {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .form-col {
            flex: 1;
            min-width: 200px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1><i class="fas fa-users"></i> Employee Management System</h1>
            
            <div id="message"></div>

            <!-- Add/Edit Employee Form -->
            <div class="form-section">
                <h3 id="formTitle">Add New Employee</h3>
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="txtName">Name:</label>
                            <input type="text" id="txtName" placeholder="Enter employee name">
                        </div>
                        <div class="form-group">
                            <label for="txtDepartment">Department:</label>
                            <input type="text" id="txtDepartment" placeholder="Enter department">
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="txtEmail">Email:</label>
                            <input type="email" id="txtEmail" placeholder="Enter email address">
                        </div>
                        <div class="form-group">
                            <label for="txtPhone">Phone:</label>
                            <input type="text" id="txtPhone" placeholder="Enter phone number">
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-success" onclick="saveEmployee()">
                    <i class="fas fa-save"></i> Save Employee
                </button>
                <button type="button" class="btn" onclick="clearForm()">
                    <i class="fas fa-times"></i> Clear
                </button>
                <input type="hidden" id="hdnEmployeeId" value="0">
            </div>

            <!-- Employee List -->
            <div>
                <h3>Employee List</h3>
                <div id="employeeList">
                    <div class="loading">Loading employees...</div>
                </div>
            </div>
        </div>
    </form>

    <script>
        let currentEditingRow = null;

        $(document).ready(function () {
            loadEmployees();
        });

        function loadEmployees() {
            $('#employeeList').html('<div class="loading">Loading employees...</div>');

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetEmployees",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    displayEmployees(response.d);
                },
                error: function (xhr, status, error) {
                    showMessage("Error loading employees: " + error, "error");
                    $('#employeeList').html('<div class="error">Failed to load employees</div>');
                }
            });
        }

        function displayEmployees(employees) {
            let html = '';

            if (employees && employees.length > 0) {
                html += '<table>';
                html += '<thead>';
                html += '<tr>';
                html += '<th>ID</th>';
                html += '<th>Name</th>';
                html += '<th>Department</th>';
                html += '<th>Email</th>';
                html += '<th>Phone</th>';
                html += '<th>Actions</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';

                employees.forEach(function (emp) {
                    html += '<tr id="row_' + emp.EmployeeId + '">';
                    html += '<td>' + emp.EmployeeId + '</td>';
                    html += '<td class="editable" data-field="Name">' + emp.Name + '</td>';
                    html += '<td class="editable" data-field="Department">' + emp.Department + '</td>';
                    html += '<td class="editable" data-field="Email">' + emp.Email + '</td>';
                    html += '<td class="editable" data-field="Phone">' + emp.Phone + '</td>';
                    html += '<td class="actions">';
                    html += '<button type="button" class="btn btn-warning btn-sm" onclick="editEmployee(' + emp.EmployeeId + ')">';
                    html += '<i class="fas fa-edit"></i> Edit';
                    html += '</button> ';
                    html += '<button type="button" class="btn btn-danger btn-sm" onclick="deleteEmployee(' + emp.EmployeeId + ')">';
                    html += '<i class="fas fa-trash"></i> Delete';
                    html += '</button>';
                    html += '</td>';
                    html += '</tr>';
                });

                html += '</tbody>';
                html += '</table>';
            } else {
                html = '<div class="message">No employees found.</div>';
            }

            $('#employeeList').html(html);
        }

        function editEmployee(employeeId) {
            // If another row is being edited, cancel it first
            if (currentEditingRow && currentEditingRow !== employeeId) {
                cancelEdit();
            }

            const row = $('#row_' + employeeId);

            if (currentEditingRow === employeeId) {
                // Save changes
                saveInlineEdit(employeeId);
            } else {
                // Enter edit mode
                currentEditingRow = employeeId;
                row.addClass('editable-row');

                // Convert cells to input fields
                row.find('.editable').each(function () {
                    const cell = $(this);
                    const currentValue = cell.text();
                    const fieldName = cell.data('field');

                    let inputType = 'text';
                    if (fieldName === 'Email') {
                        inputType = 'email';
                    }

                    cell.html('<input type="' + inputType + '" class="edit-input" value="' + currentValue + '" data-original="' + currentValue + '">');
                });

                // Change button text to Save/Cancel
                const actionCell = row.find('.actions');
                actionCell.html(
                    '<button type="button" class="btn btn-success btn-sm" onclick="saveInlineEdit(' + employeeId + ')">' +
                    '<i class="fas fa-check"></i> Save' +
                    '</button> ' +
                    '<button type="button" class="btn btn-danger btn-sm" onclick="cancelEdit()">' +
                    '<i class="fas fa-times"></i> Cancel' +
                    '</button>'
                );
            }
        }

        function saveInlineEdit(employeeId) {
            const row = $('#row_' + employeeId);
            const employee = {
                EmployeeId: employeeId,
                Name: row.find('[data-field="Name"] input').val(),
                Department: row.find('[data-field="Department"] input').val(),
                Email: row.find('[data-field="Email"] input').val(),
                Phone: row.find('[data-field="Phone"] input').val()
            };

            // Validate required fields
            if (!employee.Name || !employee.Department || !employee.Email || !employee.Phone) {
                showMessage("Please fill in all fields", "error");
                return;
            }

            // Validate email format
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(employee.Email)) {
                showMessage("Please enter a valid email address", "error");
                return;
            }

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/SaveEmployee",
                data: JSON.stringify({ emp: employee }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    showMessage("Employee updated successfully!", "success");
                    exitEditMode(employeeId, employee);
                },
                error: function (xhr, status, error) {
                    showMessage("Error updating employee: " + error, "error");
                }
            });
        }

        function cancelEdit() {
            if (currentEditingRow) {
                const row = $('#row_' + currentEditingRow);
                row.removeClass('editable-row');

                // Restore original values
                row.find('.editable').each(function () {
                    const cell = $(this);
                    const input = cell.find('input');
                    const originalValue = input.data('original');
                    cell.html(originalValue);
                });

                // Restore action buttons
                const actionCell = row.find('.actions');
                actionCell.html(
                    '<button type="button" class="btn btn-warning btn-sm" onclick="editEmployee(' + currentEditingRow + ')">' +
                    '<i class="fas fa-edit"></i> Edit' +
                    '</button> ' +
                    '<button type="button" class="btn btn-danger btn-sm" onclick="deleteEmployee(' + currentEditingRow + ')">' +
                    '<i class="fas fa-trash"></i> Delete' +
                    '</button>'
                );

                currentEditingRow = null;
            }
        }

        function exitEditMode(employeeId, employee) {
            const row = $('#row_' + employeeId);
            row.removeClass('editable-row');

            // Update cells with new values
            row.find('[data-field="Name"]').html(employee.Name);
            row.find('[data-field="Department"]').html(employee.Department);
            row.find('[data-field="Email"]').html(employee.Email);
            row.find('[data-field="Phone"]').html(employee.Phone);

            // Restore action buttons
            const actionCell = row.find('.actions');
            actionCell.html(
                '<button type="button" class="btn btn-warning btn-sm" onclick="editEmployee(' + employeeId + ')">' +
                '<i class="fas fa-edit"></i> Edit' +
                '</button> ' +
                '<button type="button" class="btn btn-danger btn-sm" onclick="deleteEmployee(' + employeeId + ')">' +
                '<i class="fas fa-trash"></i> Delete' +
                '</button>'
            );

            currentEditingRow = null;
        }

        function saveEmployee() {
            const employee = {
                EmployeeId: parseInt($('#hdnEmployeeId').val()),
                Name: $('#txtName').val().trim(),
                Department: $('#txtDepartment').val().trim(),
                Email: $('#txtEmail').val().trim(),
                Phone: $('#txtPhone').val().trim()
            };

            // Validation
            if (!employee.Name || !employee.Department || !employee.Email || !employee.Phone) {
                showMessage("Please fill in all fields", "error");
                return;
            }

            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(employee.Email)) {
                showMessage("Please enter a valid email address", "error");
                return;
            }

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/SaveEmployee",
                data: JSON.stringify({ emp: employee }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    const action = employee.EmployeeId === 0 ? "added" : "updated";
                    showMessage("Employee " + action + " successfully!", "success");
                    clearForm();
                    loadEmployees();
                },
                error: function (xhr, status, error) {
                    showMessage("Error saving employee: " + error, "error");
                }
            });
        }

        function deleteEmployee(employeeId) {
            if (confirm("Are you sure you want to delete this employee?")) {
                $.ajax({
                    type: "POST",
                    url: "Dashboard.aspx/DeleteEmployee",
                    data: JSON.stringify({ id: employeeId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        showMessage("Employee deleted successfully!", "success");
                        loadEmployees();
                    },
                    error: function (xhr, status, error) {
                        showMessage("Error deleting employee: " + error, "error");
                    }
                });
            }
        }

        function clearForm() {
            $('#txtName').val('');
            $('#txtDepartment').val('');
            $('#txtEmail').val('');
            $('#txtPhone').val('');
            $('#hdnEmployeeId').val('0');
            $('#formTitle').text('Add New Employee');
        }

        function showMessage(message, type) {
            const messageDiv = $('#message');
            messageDiv.removeClass('success error').addClass(type).text(message).show();
            setTimeout(function () {
                messageDiv.fadeOut();
            }, 5000);
        }

        // Handle Enter key in edit inputs
        $(document).on('keypress', '.edit-input', function (e) {
            if (e.which === 13) { // Enter key
                if (currentEditingRow) {
                    saveInlineEdit(currentEditingRow);
                }
            }
        });

        // Handle Escape key to cancel edit
        $(document).on('keyup', '.edit-input', function (e) {
            if (e.which === 27) { // Escape key
                cancelEdit();
            }
        });
    </script>
</body>
</html>