$(document).ready(function () {

    loadEmployee();

    var btn_action = "insert";
    var ModelPopup = $('#model');

    $("#table").on("click", "button.edit", function () {
        var employee_id = $(this).attr("employee_id");
        btn_action = "update";
        fetchEmployee(employee_id);
        window.scroll(0, 0);
    });



    $("#table").on("click", "button.delete", function () {
        var employee_id = $(this).attr("employee_id");
        if(confirm("Are your sure?")){
            deleteEmployee(employee_id);
        }
    });

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var employee_id = $("#employee_id").val();
        var name = $("#name").val();
        var title = $("#title").val();
        var salary = $("#salary").val();
        var status = $("#status").val();
        var mobile = $("#mobile").val();
        var gender = $("#gender").val();
        var address = $("#address").val();
        var date = $("#date").val();


        if (btn_action == "insert") {

            var data = {
                "action": "insert_update",
                "action_sp": "insert",
                "employee_id": "",
                "name": name,
                "mobile": mobile,
                "title": title,
                "salary": salary,
                "gender": gender,
                "address": address,
                "status": status,
                "date": date
                
            };

        } else {

            var data = {
                "action": "insert_update",
                "action_sp": "update",
                "employee_id": employee_id,
                "name": name,
                "mobile": mobile,
                "title": title,
                "salary": salary,
                "gender": gender,
                "address": address,
                "status": status,
                "date": date
            };
        }


        $.ajax({
            method: "POST",
            url: "../api/employee.php",
            data: data,
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    if (btn_action == "update") {

                        ModelPopup.modal("hide");
                        btn_action = "insert";
                        $("#form")[0].reset();
                        loadEmployee();


                    } else {
                        btn_action = "insert";
                        window.scroll(0, 0);
                        $("#form")[0].reset();
                        showAlert('success', message);
                        loadEmployee();
                    }


                } else {
                    showAlert('error', message)
                    window.scroll(0, 0);


                }
            },
            error: function (data) {

            }
        });

    });


    function loadEmployee() {

        var data = {
            "action": "read",
            "employee_id": "",

        };

        $.ajax({
            method: "POST",
            url: "../api/employee.php",
            data: data,
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;
                var column = '';
                var row = '';

                if (status) {
                    $('#table').dataTable().fnClearTable();
                    $('#table').dataTable().fnDestroy();

                    message.forEach(function (item, i) {

                        column = "<tr>";

                        for (index in item) {
                            column += "<th>" + index + "</th>";
                        }
                        column += "<th class='text-center'>" + 'Action' + "</th>"
                        column += "</tr>";



                        row += "<tr>";

                        for (index in item) {
                            row += "<td>" + item[index] + "</td>";
                        }

                        row += `<td class='text-center'>                         <button class='btn btn-success btn-sm edit' title="Edit" employee_id='` + item['ID'] + `'>
                                    <i class='fa fa-edit'></i>

                                    
                                </button>
                                <button class='btn btn-danger btn-sm delete' title="Delete" employee_id='` + item['ID'] + `'>
                                    <i class='fa fa-trash'></i>
                                </button>
                                </td>`;

                        row += "</tr>";

                    });

                    $("#table thead").html(column);
                    $("#table tbody").html(row);
                    $('#table').DataTable({
                        "order": [
                            [0, "desc"]
                        ]
                    });
                } else {
                    $("#table tbody").html("<tr><td colspan='4' class='text-center'>" + message + "</td></tr>");
                }

            },
            error: function (data) {

            }
        });

    }

    function deleteEmployee(employee_id) {

        $.ajax({
            method: "POST",
            url: "../api/employee.php",
            data: { "action": "delete", "employee_id": employee_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    window.scroll(0, 0);
                    loadEmployee();
                    console.log('Congratulations!', 'Employee Has Been Deleted Successfully', 'success');
                } else {

                    window.scroll(0, 0);
                    ModelPopup.modal('hide');
                    console.log('Error! '+ message + ' error');
                }

            },
            error: function (data) {

            }
        });

    }

    function fetchEmployee(employee_id) {


        $.ajax({
            method: "POST",
            url: "../api/employee.php",
            data: { "action": "read", "employee_id": employee_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    $("#employee_id").val(message[0]['emp_id']);
                    $("#name").val(message[0]['name']);
                    $("#title").val(message[0]['title']);
                    $("#salary").val(message[0]['salary']);
                    $("#status").val(message[0]['status']);
                    $("#mobile").val(message[0]['mobile']);
                    $("#gender").val(message[0]['gender']);
                    $("#address").val(message[0]['address']);
                    $("#date").val(message[0]['register_date']);


                    ModelPopup.modal('show');

                }

            },
            error: function (data) {

            }
        });

    }

    $("#btn_modle").on("click", function () {

        $("#form")[0].reset();
        ModelPopup.modal('show');
        btn_action = "insert";
    });


    


});