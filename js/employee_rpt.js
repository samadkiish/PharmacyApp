$(document).ready(function () {

  
   

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var date_type = $("#date_type").val();
        var from = $("#from").val();
        var to = $("#to").val();
        var status = $("#status").val();
        var gender = $("#gender").val();

            var data = {
                "action": "rpt_employee",
                "date_type": date_type,
                "from": from,
                "to": to,
                "status": status,
                "gender": gender,
            };
        


        $.ajax({
            method: "POST",
            url: "../api/employee_rpt.php",
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
                        column += "</tr>";



                        row += "<tr>";

                        for (index in item) {
                            row += "<td>" + item[index] + "</td>";
                        }

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

    });





   

    


});