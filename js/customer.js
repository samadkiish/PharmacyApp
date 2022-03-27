$(document).ready(function () {

    loadCustomer();

    var btn_action = "insert";
    var ModelPopup = $('#model');

    $("#table").on("click", "button.edit", function () {
        var customer_id = $(this).attr("customer_id");
        btn_action = "update";
        fetchCustomer(customer_id);
        window.scroll(0, 0);
    });



    $("#table").on("click", "button.delete", function () {
        var customer_id = $(this).attr("customer_id");
        if(confirm("Are your sure?")){
            deleteCustomer(customer_id);
        }
    });

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var customer_id = $("#customer_id").val();
        var name = $("#name").val();
        var mobile = $("#mobile").val();
        var gender = $("#gender").val();
        var address = $("#address").val();
        var date = $("#date").val();


        if (btn_action == "insert") {

            var data = {
                "action": "insert_update",
                "action_sp": "insert",
                "customer_id": "",
                "name": name,
                "mobile": mobile,
                "gender": gender,
                "address": address,
                "date": date
                
            };

        } else {

            var data = {
                "action": "insert_update",
                "action_sp": "update",
                "customer_id": customer_id,
                "name": name,
                "mobile": mobile,
                "gender": gender,
                "address": address,
                "date": date
            };
        }


        $.ajax({
            method: "POST",
            url: "../api/customer.php",
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
                        loadCustomer();


                    } else {
                        btn_action = "insert";
                        window.scroll(0, 0);
                        $("#form")[0].reset();
                        showAlert('success', message);
                        loadCustomer();
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


    function loadCustomer() {

        var data = {
            "action": "read",
            "customer_id": "",

        };

        $.ajax({
            method: "POST",
            url: "../api/customer.php",
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

                        row += `<td class='text-center'>                         <button class='btn btn-success btn-sm edit' title="Edit" customer_id='` + item['ID'] + `'>
                                    <i class='fa fa-edit'></i>

                                    
                                </button>
                                <button class='btn btn-danger btn-sm delete' title="Delete" customer_id='` + item['ID'] + `'>
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

    function deleteCustomer(customer_id) {

        $.ajax({
            method: "POST",
            url: "../api/customer.php",
            data: { "action": "delete", "customer_id": customer_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    window.scroll(0, 0);
                    loadCustomer();
                    console.log('Congratulations!', 'Customer Has Been Deleted Successfully', 'success');
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

    function fetchCustomer(customer_id) {


        $.ajax({
            method: "POST",
            url: "../api/customer.php",
            data: { "action": "read", "customer_id": customer_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    $("#customer_id").val(message[0]['customer_id']);
                    $("#name").val(message[0]['name']);
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