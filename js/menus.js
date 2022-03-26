$(document).ready(function () {

    loadMenus();

    var btn_action = "insert";
    var ModelPopup = $('#model');

    $("#table").on("click", "button.edit", function () {
        var menu_id = $(this).attr("menu_id");
        btn_action = "update";
        fetchMenus(menu_id);
        window.scroll(0, 0);
    });



    $("#table").on("click", "button.delete", function () {
        var menu_id = $(this).attr("menu_id");
        if(confirm("Are your sure?")){
            deleteMenu(menu_id);
        }
    });

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var menu_id = $("#menu_id").val();
        var name = $("#name").val();
        var module = $("#module").val();
        var link = $("#link").val();
        var date = $("#date").val();


        if (btn_action == "insert") {

            var data = {
                "action": "insert_update",
                "action_sp": "insert",
                "menu_id": "",
                "name": name,
                "module": module,
                "link": link,
                "date": date
                
            };

        } else {

            var data = {
                "action": "insert_update",
                "action_sp": "update",
                "menu_id": menu_id,
                "name": name,
                "module": module,
                "link": link,
                "date": date
            };
        }


        $.ajax({
            method: "POST",
            url: "../api/menus.php",
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
                        loadMenus();


                    } else {
                        btn_action = "insert";
                        window.scroll(0, 0);
                        $("#form")[0].reset();
                        loadMenus();
                    }


                } else {
                    swal('Error!', message, 'error');
                    show_toast('error', message)
                    window.scroll(0, 0);


                }
            },
            error: function (data) {

            }
        });

    });


    function loadMenus() {

        var data = {
            "action": "read",
            "menu_id": "",

        };

        $.ajax({
            method: "POST",
            url: "../api/menus.php",
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

                        row += `<td class='text-center'>                         <button class='btn btn-success btn-sm edit' title="Edit" menu_id='` + item['ID'] + `'>
                                    <i class='fa fa-edit'></i>

                                    
                                </button>
                                <button class='btn btn-danger btn-sm delete' title="Delete" menu_id='` + item['ID'] + `'>
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

    function deleteMenu(menu_id) {

        $.ajax({
            method: "POST",
            url: "../api/menus.php",
            data: { "action": "delete", "menu_id": menu_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {

                    window.scroll(0, 0);
                    loadMenus();
                    console.log('Congratulations!', 'Menus Has Been Deleted Successfully', 'success');
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

    function fetchMenus(menu_id) {


        $.ajax({
            method: "POST",
            url: "../api/menus.php",
            data: { "action": "read", "menu_id": menu_id },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    console.log(message[0]['menu_id']);
                    $("#menu_id").val(message[0]['menu_id']);
                    $("#name").val(message[0]['name']);
                    $("#module").val(message[0]['module']);
                    $("#link").val(message[0]['link']);
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