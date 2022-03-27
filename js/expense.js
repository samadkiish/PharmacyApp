$(document).ready(function () {

    loadExpense();
    var bntClick = '';

    var btn_action = "insert";
    var ModelPopup = $('#model');

    $("#table").on("click", "button.edit", function () {
        var expense_id = $(this).attr("expense_id");
        btn_action = "update";
        fetchExpense(expense_id);
        window.scroll(0, 0);
    });



    $("#table").on("click", "button.delete", function () {
        var expense_id = $(this).attr("expense_id");
        if(confirm("Are your sure?")){
            deleteExpense(expense_id);
        }
    });

    $('.btn_save').click(function(){
        bntClick = $(this).html();
        console.log(bntClick)
    });

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var expense_id = $("#expense_id").val();
        var type = $("#type").val();
        var description = $("#description").val();
        var amount = $("#amount").val();
        var date = $("#date").val();


        if (btn_action == "insert") {

            var data = {
                "action": "insert_update",
                "action_sp": "insert",
                "expense_id": "",
                "type": type,
                "description": description,
                "amount": amount,
                "date": date
                
            };

        } else {

            var data = {
                "action": "insert_update",
                "action_sp": "update",
                "expense_id": expense_id,
                "type": type,
                "description": description,
                "amount": amount,
                "date": date
            };
        }


        $.ajax({
            method: "POST",
            url: "../api/expense.php",
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
                        showAlert('success', message);
                        loadExpense();


                    } else {
                        btn_action = "insert";
                        window.scroll(0, 0);
                        $("#form")[0].reset();
                        showAlert('success', message);
                        loadExpense();
                    }

                    if(bntClick == 'Save and Close')
                        ModelPopup.modal("hide");
                } else {
                    showAlert('error', message)
                    window.scroll(0, 0);


                }
            },
            error: function (data) {

            }
        });

    });



    function loadExpense() {

        var data = {
            "action": "read",
            "expense_id": "",

        };

        $.ajax({
            method: "POST",
            url: "../api/expense.php",
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

                        row += `<td class='text-center'>                         <button class='btn btn-success btn-sm edit' title="Edit" expense_id='` + item['ID'] + `'>
                                    <i class='fa fa-edit'></i>

                                    
                                </button>
                                <button class='btn btn-danger btn-sm delete' title="Delete" expense_id='` + item['ID'] + `'>
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

    function deleteExpense(expense_id) {

        $.ajax({
            method: "POST",
            url: "../api/expense.php",
            data: { "action": "delete", "expense_id": expense_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    window.scroll(0, 0);
                    loadExpense();
                    console.log('Congratulations!', 'Expense Has Been Deleted Successfully', 'success');
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

    function fetchExpense(expense_id) {


        $.ajax({
            method: "POST",
            url: "../api/expense.php",
            data: { "action": "read", "expense_id": expense_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    $("#expense_id").val(message[0]['id']);
                    $("#type").val(message[0]['type']);
                    $("#description").html(message[0]['description']);
                    $("#amount").val(message[0]['amount']);
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