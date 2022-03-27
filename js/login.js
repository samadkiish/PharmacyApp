$(document).ready(function () {

    function showAlert(type, message){

        if(type == 'success'){
            $(".alert").removeClass("alert-danger");
            $(".alert").addClass("alert-success");
        }else{
            $(".alert").removeClass("alert-success");
            $(".alert").addClass("alert-danger");
        }

        $(".alert .message").html(message);
        $(".alert").show();
        }

   

    $("#form").on("submit", function (e) {
        e.preventDefault();
        var username = $("#username").val();
        var password = $("#password").val();

        var data = {
            "action": "login",
            "username": username,
            "password": password
        };
        $.ajax({
            method: "POST",
            url: "../api/login.php",
            data: data,
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                        window.location =  'blank.php'

                        console.log('Success');
                } else {
                    showAlert('error', message)
                    window.scroll(0, 0);


                }
            },
            error: function (data) {

            }
        });

    });



    


});