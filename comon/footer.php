
    
      <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright &copy; Designed & Developed by <a href="#">JTECH JTECH</a> 2022</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->
    <!--**********************************
        Scripts
    ***********************************-->
    
    

    <script src="../assets/plugins/common/common.min.js"></script>
    <script>
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
    </script>

<script>
        load_menu();

        function load_menu() {
            $.ajax({
                method: "POST",
                url: "../api/menus.php",
                data: {
                    "action": "load_nav"
                },
                dataType: "JSON",
                async: false,
                success: function(data) {
                    var status = data.status;
                    var message = data.message;
                    var strHTML = '';
                    var modules = '';

                    if (status) {

                        strHTML += `<li class="">`;
                        message.forEach(function(item, i) {

                            // <li class="">
                            //     <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            //         <i class="icon-speedometer menu-icon"></i><span class="nav-text">Dashboard</span>
                            //     </a>
                            //     <ul aria-expanded="false" class="collapse" style="height: 0px;">
                            //         <li><a href="">Home 1</a></li>
                            //     </ul>
                            // </li>


                            if (modules != item['module']) {
                                if (modules != '') {
                                    strHTML += `</ul></li><li class="">`;
                                }

                                strHTML +=
                                    `
                                    <a class="has-arrow" href="javascript:void()" module="`+item['module']+`" aria-expanded="false">
                                        <i class="icon-grid menu-icon"></i><span class="nav-text">`+item['module']+`</span>
                                    </a>
                                    <ul aria-expanded="false" class="collapse" style="height: 0px;">                           
                                `;

                                modules = item['module'];
                            }

                            strHTML += `  
                            <li><a href="`+item['link']+`" module="` + item['module'] + `">`+item['menu']+`</a></li>

                            `;

                        });
                        strHTML += '</li>';

                        $("#menu").html(strHTML);


                    }
                
                
                },
                error: function(data) {

                }
            });

        }
    
        $(function() {
        for (var nk = window.location, 
            o = $("ul#menu a").filter(function() {
                    return this.href == nk;
                })
                .addClass("active")
                .parent()
                .addClass("active");;) {
            if (!o.is("li")) break;
            o = o.parent()
                .addClass("in")
                .parent()
                .addClass("active");
        }
    });
    </script>



    <script src="../assets/js/custom.min.js"></script>
    <script src="../assets/js/settings.js"></script>
    <script src="../assets/js/gleek.js"></script>
    <script src="../assets/js/styleSwitcher.js"></script>

</body>


<!-- Mirrored from demo.themefisher.com/quixlab/layout-blank.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 09 Feb 2022 18:01:41 GMT -->
</html>