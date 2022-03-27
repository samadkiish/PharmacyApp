$(document).ready(function(){
    loadUser();
    var btn_action = 'Insert';
    var modalPopup = $("#model");

    $("#new").click(function(){
        fillEmloyee();
    });

    $('#table tbody').on('click', 'button.delete', function(){
        var user_id = $(this).attr("userId");
        console.log(user_id);

        if(confirm("Are You Sure to delete this User")){
            deleteUser(user_id);
        }
    });

    $('#table tbody').on('click', 'button.edit', function(){
        var user_id = $(this).attr("userId");
        btn_action = 'Update';
        fetchUser(user_id);
    });

    $("#form").on('submit', function(e){
        e.preventDefault()

        var user_id = $("#user_id").val();
        var employee_id = $("#employee_id").val();
        var username = $("#username").val();
        var password = $("#password").val();
        var status = $("#status").val();
        var date = $("#date").val();

        if(btn_action == 'Insert'){
                var data = {
                "action": 'insert_update',
                "action_sp": 'insert',
                "user_id":'',
                "employee_id":employee_id,
                "username":username,
                "password": password,
                "status": status,
                "date":date,
            }
        }else{
            var data = {
                "action": 'insert_update',
                "action_sp": 'update',
                "user_id":user_id,
                "employee_id":employee_id,
                "username":username,
                "password": password,
                "status": status,
                "date":date,
            }
        }
        

        console.log(data);


        $.ajax({

            method: "POST",
            url: "../api/user.php",
            data: data,
            dataType: "JSON",
            async: true,

            success: function(data){
                var status = data.status;
                var message = data.message;


                if(status){
                    if(btn_action == 'Update');
                        btn_action = 'insert';
                    $("#form")[0].reset();
                    modalPopup.modal("hide");
                        $(".alert").removeClass("alert-danger");
                        $(".alert").addClass("alert-success");
                        $(".alert .message").html(message);
                        $(".alert").show();
                        loadUser();
                        setTimeout(() => {
                            $(".alert").hide();
                        }, 3000);
                    
                }else{
                    $(".alert").removeClass("alert-success");
                        $(".alert").addClass("alert-danger");
                        $(".alert .message").html(message);
                        $(".alert").show();

                        setTimeout(() => {
                            $(".alert").hide();
                        }, 3000);
                    console.log(message);
                }
            },
            error: function(data){

            }
        });



    });

    function loadUser(){

        var data = {
            "action": 'read',
            "user_id":''
        }

        $.ajax({

            method: "POST",
            url: "../api/user.php",
            data: data,
            dataType: "JSON",
            async: true,

            success: function(data){
                var status = data.status;
                var message = data.message;
                var cols = '';
                var rows = '';

                // console.log(status);
                // console.log(message);

                if(status){

                    message.forEach(function(item , i) {
                        // console.log(item['ID']);
                        cols = '<tr>';
                        for(index in item){
                            cols += '<th>' + index + '</th>';
                        }
                        cols += '<th> Action </th>';
                        cols += '</tr>';

                        rows += '<tr>';

                        for(index in item){
                            rows += `<td>` + item[index] + `</td>`;
                        }

                        rows += `<td><button class="btn btn-success btn-sm edit" userId="`+item['ID']+`"><i class="fa fa-edit"></i></button>
                        <button class="btn btn-danger btn-sm delete" userId="`+item['ID']+`"><i class="fa fa-trash"></i></button></td>
                        `;

                        rows += '</tr>'


                    });

                    $("#table thead").html(cols);
                    $("#table tbody").html(rows);
                    $("#table").dataTable();
                }else{
                    console.log(message);
                }
            },
            error: function(data){

            }
        });



    }

    function fetchUser(user_id){

        var data = {
            "action": 'read',
            "user_id":user_id
        }

        $.ajax({

            method: "POST",
            url: "../api/user.php",
            data: data,
            dataType: "JSON",
            async: true,

            success: function(data){
                var status = data.status;
                var message = data.message;

                // console.log(status);
                // console.log(message);

                if(status){

                    message.forEach(function(item , i) {
                        $("#user_id").val(message[0]['user_id']);
                        $("#username").val(message[0]['username']);
                        $("#password").val(message[0]['password']);
                        $("#employee_id").val(message[0]['employee_id']);
                        $("#status").val(message[0]['status']);
                        $("#date").val(message[0]['register_date']);
                        
                        modalPopup.modal('show');
                    });

                }else{
                    console.log(message);
                }
            },
            error: function(data){

            }
        });



    }

    function fillEmloyee(){

        var data = {
            "action": 'fillEmployee',
        }

        $.ajax({

            method: "POST",
            url: "../api/user.php",
            data: data,
            dataType: "JSON",
            async: true,

            success: function(data){
                var status = data.status;
                var message = data.message;
                var options = '';
                // console.log(status);
                // console.log(message);

                if(status){
                    options = '';
                    message.forEach(function(item , i) {

                        $('#employee_id').html("<option value=''>Select Employee </option>");
                        // for(index in item){
                            options += `<option value="`+item['emp_id']+`">`+item['name']+ ' - ' + item['title'] + `</option>` 
                        // }
                        
                    });

                    console.log(options)
                    $("#employee_id").append(options);

                }else{
                    console.log(message);
                }
            },
            error: function(data){

            }
        });



    }

    function deleteUser(user_id){

        var data = {
            "action": 'delete',
            "user_id":user_id
        }

        $.ajax({

            method: "POST",
            url: "../api/user.php",
            data: data,
            dataType: "JSON",
            async: true,

            success: function(data){
                var status = data.status;
                var message = data.message;

                if(status){

                        console.log(message);
                        $(".alert").removeClass("alert-danger");
                        $(".alert").addClass("alert-success");
                        $(".alert .message").html(message);
                        $(".alert").show();

                        setTimeout(() => {
                            $(".alert").hide();
                        }, 3000);


                        loadUser();
            
                }else{
                    $(".alert").removeClass("alert-success");
                    $(".alert").addClass("alert-danger");
                    $(".alert .message").html(message);
                    $(".alert").show();
                    console.log(message);
                }
            },
            error: function(data){

            }
        });



    }


});