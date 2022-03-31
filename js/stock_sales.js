$(document).ready(function () {

    loadSales();

    var btn_action = "insert";
    var ModelPopup = $('#model');

    $("#table").on("click", "button.edit", function () {
        var sale_id = $(this).attr("sale_id");
        btn_action = "update";
        fillMedicine();
        fillCustomer();
        fetchSales(sale_id);
        window.scroll(0, 0);
    });



    $("#table").on("click", "button.delete", function () {
        var sale_id = $(this).attr("sale_id");
        if(confirm("Are your sure?")){
            deleteSales(sale_id);
        }
    });

    $("#medicine_id").change(function(){
        var qty = $('option:selected', this).attr('quantity');
        var price = $('option:selected', this).attr('price');
        $("#quantity").attr('qty_from_stock', qty)
        $("#price").val(price)
    });

    $("#quantity").change(function(){
        var av_qty = Number($(this).attr('qty_from_stock'));
        var user_qty = Number($(this).val());

        if(av_qty < user_qty){
            alert(user_qty + " Is Not Avaible in the Stock");
            $(this).val(0);
            return;
        }

    });


    $("#form").on("submit", function (e) {
        e.preventDefault();
        var sale_id = $("#sale_id").val();
        var medicine_id = $("#medicine_id").val();
        var customer_id = $("#customer_id").val();
        var quantity = $("#quantity").val();
        var price = $("#price").val();
        var date = $("#date").val();


        if (btn_action == "insert") {

            var data = {
                "action": "insert_update",
                "action_sp": "insert",
                "sale_id": "",
                "medicine_id": medicine_id,
                "customer_id": customer_id,
                "quantity": quantity,
                "price": price,
                "date": date
                
            };

        } else {

            var data = {
                "action": "insert_update",
                "action_sp": "update",
                "sale_id": sale_id,
                "medicine_id": medicine_id,
                "customer_id": customer_id,
                "quantity": quantity,
                "price": price,
                "date": date
            };
        }


        $.ajax({
            method: "POST",
            url: "../api/stock_sales.php",
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
                        loadSales();
                        

                    } else {
                        btn_action = "insert";
                        window.scroll(0, 0);
                        $("#form")[0].reset();
                        loadSales();
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


    function loadSales() {

        var data = {
            "action": "read",
            "sale_id": "",

        };

        $.ajax({
            method: "POST",
            url: "../api/stock_sales.php",
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

                        row += `<td class='text-center'>                         <button class='btn btn-success btn-sm edit' title="Edit" sale_id='` + item['ID'] + `'>
                                    <i class='fa fa-edit'></i>

                                    
                                </button>
                                <button class='btn btn-danger btn-sm delete' title="Delete" sale_id='` + item['ID'] + `'>
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

    function deleteSales(sale_id) {

        $.ajax({
            method: "POST",
            url: "../api/stock_sales.php",
            data: { "action": "delete", "sale_id": sale_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    window.scroll(0, 0);
                    loadSales();
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

    function fetchSales(sale_id) {


        $.ajax({
            method: "POST",
            url: "../api/stock_sales.php",
            data: { "action": "read", "sale_id": sale_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    $("#sale_id").val(message[0]['id']);
                    $("#medicine_id").val(message[0]['medicine_id']);
                    $("#customer_id").val(message[0]['customer_id']);
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
            "key": 'Sale',
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
                            options += `<option price="`+item['price']+`" quantity="`+item['quantity']+`" value="`+item['medicine_id']+`">`+item['name']+ ' - ' + item['type'] + `</option>` 
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

    function fillCustomer(){

        var data = {
            "action": 'fillCustomer',
            "key": '',
        }

        $.ajax({

            method: "POST",
            url: "../api/customer.php",
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

                        $('#customer_id').html("<option value=''>Select Customer </option>");
                        // for(index in item){
                            options += `<option value="`+item['customer_id']+`">`+item['name']+ ' - ' + item['mobile'] + `</option>` 
                        // }
                        
                    });

                    console.log(options)
                    $("#customer_id").append(options);

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
        fillCustomer();
        ModelPopup.modal('show');
        btn_action = "insert";
    });


    


});