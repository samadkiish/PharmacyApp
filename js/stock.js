$(document).ready(function () {

    loadStock();

    var btn_action = "insert";
    var ModelPopup = $('#model');

    $("#table").on("click", "button.edit", function () {
        var stock_id = $(this).attr("stock_id");
        btn_action = "update";
        fetchStock(stock_id);
        window.scroll(0, 0);
    });



    $("#table").on("click", "button.delete", function () {
        var stock_id = $(this).attr("stock_id");
        if(confirm("Are your sure?")){
            deleteStock(stock_id);
        }
    });

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var stock_id = $("#stock_id").val();
        var name = $("#name").val();
        var company = $("#company").val();
        var type = $("#type").val();
        var quantity = $("#quantity").val();
        var cost = $("#cost").val();
        var price = $("#price").val();
        var expire_date = $("#expire_date").val();
        var date = $("#date").val();


        if (btn_action == "insert") {

            var data = {
                "action": "insert_update",
                "action_sp": "insert",
                "stock_id": "",
                "name": name,
                "type": type,
                "company": company,
                "quantity": quantity,
                "cost": cost,
                "price": price,
                "expire_date": expire_date,
                "date": date
                
            };

        } else {

            var data = {
                "action": "insert_update",
                "action_sp": "update",
                "stock_id": stock_id,
                "name": name,
                "type": type,
                "company": company,
                "quantity": quantity,
                "cost": cost,
                "price": price,
                "expire_date": expire_date,
                "date": date
            };
        }


        $.ajax({
            method: "POST",
            url: "../api/stock.php",
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
                        loadStock();
                        

                    } else {
                        btn_action = "insert";
                        window.scroll(0, 0);
                        $("#form")[0].reset();
                        loadStock();
                    }
                    showAlert('success', message);

                } else {
                    showAlert('error', message);
                    window.scroll(0, 0);


                }
            },
            error: function (data) {

            }
        });

    });


    function loadStock() {

        var data = {
            "action": "read",
            "stock_id": "",

        };

        $.ajax({
            method: "POST",
            url: "../api/stock.php",
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

                        row += `<td class='text-center'>                         <button class='btn btn-success btn-sm edit' title="Edit" stock_id='` + item['ID'] + `'>
                                    <i class='fa fa-edit'></i>

                                    
                                </button>
                                <button class='btn btn-danger btn-sm delete' title="Delete" stock_id='` + item['ID'] + `'>
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

    function deleteStock(stock_id) {

        $.ajax({
            method: "POST",
            url: "../api/stock.php",
            data: { "action": "delete", "stock_id": stock_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    window.scroll(0, 0);
                    loadStock();
                    showAlert('success', message);
                } else {

                    window.scroll(0, 0);
                    ModelPopup.modal('hide');
                    showAlert('error', message);
                }

            },
            error: function (data) {

            }
        });

    }

    function fetchStock(stock_id) {


        $.ajax({
            method: "POST",
            url: "../api/stock.php",
            data: { "action": "read", "stock_id": stock_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    $("#stock_id").val(message[0]['stock_id']);
                    $("#name").val(message[0]['name']);
                    $("#type").val(message[0]['type']);
                    $("#company").val(message[0]['company']);
                    $("#quantity").val(message[0]['quantity']);
                    $("#cost").val(message[0]['cost']);
                    $("#price").val(message[0]['price']);
                    $("#expire_date").val(message[0]['expire_date']);
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