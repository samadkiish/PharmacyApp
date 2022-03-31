$(document).ready(function () {

    loadPurchases();

    var btn_action = "insert";
    var ModelPopup = $('#model');

    $("#table").on("click", "button.edit", function () {
        var purchase_id = $(this).attr("purchase_id");
        btn_action = "update";
        fillMedicine();
        fillSupplier();
        fetchPurchases(purchase_id);
        window.scroll(0, 0);
    });



    $("#table").on("click", "button.delete", function () {
        var purchase_id = $(this).attr("purchase_id");
        if(confirm("Are your sure?")){
            deletePurchases(purchase_id);
        }
    });

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var purchase_id = $("#purchase_id").val();
        var medicine_id = $("#medicine_id").val();
        var supplier_id = $("#supplier_id").val();
        var quantity = $("#quantity").val();
        var cost = $("#cost").val();
        var price = $("#price").val();
        var expire_date = $("#expire_date").val();
        var date = $("#date").val();


        if (btn_action == "insert") {

            var data = {
                "action": "insert_update",
                "action_sp": "insert",
                "purchase_id": "",
                "medicine_id": medicine_id,
                "supplier_id": supplier_id,
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
                "purchase_id": purchase_id,
                "medicine_id": medicine_id,
                "supplier_id": supplier_id,
                "quantity": quantity,
                "cost": cost,
                "price": price,
                "expire_date": expire_date,
                "date": date
            };
        }


        $.ajax({
            method: "POST",
            url: "../api/stock_purchase.php",
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
                        loadPurchases();
                        

                    } else {
                        btn_action = "insert";
                        window.scroll(0, 0);
                        $("#form")[0].reset();
                        loadPurchases();
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


    function loadPurchases() {

        var data = {
            "action": "read",
            "purchase_id": "",

        };

        $.ajax({
            method: "POST",
            url: "../api/stock_purchase.php",
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

                        row += `<td class='text-center'>                         <button class='btn btn-success btn-sm edit' title="Edit" purchase_id='` + item['ID'] + `'>
                                    <i class='fa fa-edit'></i>

                                    
                                </button>
                                <button class='btn btn-danger btn-sm delete' title="Delete" purchase_id='` + item['ID'] + `'>
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

    function deletePurchases(purchase_id) {

        $.ajax({
            method: "POST",
            url: "../api/stock_purchase.php",
            data: { "action": "delete", "purchase_id": purchase_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    window.scroll(0, 0);
                    loadPurchases();
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

    function fetchPurchases(purchase_id) {


        $.ajax({
            method: "POST",
            url: "../api/stock_purchase.php",
            data: { "action": "read", "purchase_id": purchase_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    $("#purchase_id").val(message[0]['id']);
                    $("#medicine_id").val(message[0]['medicine_id']);
                    $("#supplier_id").val(message[0]['supplier_id']);
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


    function fillMedicine(){

        var data = {
            "action": 'fillMedicine',
            "key": 'Purchase',
        }

        $.ajax({

            method: "POST",
            url: "../api/stock.php",
            data: data,
            dataType: "JSON",
            async: true,

            success: function(data){
                var status = data.status;
                var message = data.message;
                var options = '';

                if(status){
                    options = '';
                    message.forEach(function(item , i) {

                        $('#medicine_id').html("<option value=''>Select Medicine Name </option>");
                        // for(index in item){
                            options += `<option value="`+item['medicine_id']+`">`+item['name']+ ' - ' + item['type'] + `</option>` 
                        // }
                        
                    });

                    console.log(options)
                    $("#medicine_id").append(options);

                }else{
                    console.log(message);
                }
            },
            error: function(data){

            }
        });



    }

    function fillSupplier(){

        var data = {
            "action": 'fillSupplier',
            "key": '',
        }

        $.ajax({

            method: "POST",
            url: "../api/supplier.php",
            data: data,
            dataType: "JSON",
            async: false,

            success: function(data){
                var status = data.status;
                var message = data.message;
                var options = '';

                if(status){
                    options = '';
                    message.forEach(function(item , i) {

                        $('#supplier_id').html("<option value=''>Select Supplier </option>");
                        // for(index in item){
                            options += `<option value="`+item['supplier_id']+`">`+item['name']+ ' - ' + item['mobile'] + `</option>` 
                        // }
                        
                    });

                    console.log(options)
                    $("#supplier_id").append(options);

                }else{
                    console.log(message);
                }
            },
            error: function(data){

            }
        });



    }

    $("#btn_modle").on("click", function () {

        $("#form")[0].reset();
        fillMedicine();
        fillSupplier();
        ModelPopup.modal('show');
        btn_action = "insert";
    });


    


});