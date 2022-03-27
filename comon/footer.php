
    
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
    <script src="../assets/js/custom.min.js"></script>
    <script src="../assets/js/settings.js"></script>
    <script src="../assets/js/gleek.js"></script>
    <script src="../assets/js/styleSwitcher.js"></script>


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

</body>


<!-- Mirrored from demo.themefisher.com/quixlab/layout-blank.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 09 Feb 2022 18:01:41 GMT -->
</html>