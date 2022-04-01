<?php
    require('../comon/head.php');
    require('../comon/header.php');
    require('../comon/sidebar.php');
    // include_once('');
    // require('');
    // include_once('');
?>
      <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">

<div class="container-fluid mt-3">
    <div class="row">
        <div class="col-lg-3 col-sm-6">
            <div class="card gradient-1">
                <div class="card-body">
                    <h3 class="card-title text-white">Medicine On Stock</h3>
                    <div class="d-inline-block">
                        <h2 class="text-white onStock">0</h2>
                        <!-- <p class="text-white mb-0">Jan - March 2019</p> -->
                    </div>
                    <span class="float-right display-5 opacity-5"><i class="fa fa-shopping-cart"></i></span>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6">
            <div class="card gradient-7">
                <div class="card-body">
                    <h3 class="card-title text-white">Income</h3>
                    <div class="d-inline-block">
                        <h2 class="text-white income">$ 0.00</h2>
                        <!-- <p class="text-white mb-0">Jan - March 2019</p> -->
                    </div>
                    <span class="float-right display-5 opacity-5"><i class="fa fa-money"></i></span>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6">
            <div class="card gradient-3">
                <div class="card-body">
                    <h3 class="card-title text-white">New Customers</h3>
                    <div class="d-inline-block">
                        <h2 class="text-white customers">0</h2>
                        <!-- <p class="text-white mb-0">Jan - March 2019</p> -->
                    </div>
                    <span class="float-right display-5 opacity-5"><i class="fa fa-users"></i></span>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6">
            <div class="card gradient-2">
                <div class="card-body">
                    <h3 class="card-title text-white">Expenses</h3>
                    <div class="d-inline-block">
                        <h2 class="text-white expenses">$ 0.00</h2>
                        <!-- <p class="text-white mb-0">Jan - March 2019</p> -->
                    </div>
                    <span class="float-right display-5 opacity-5"><i class="fa fa-money"></i></span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Daily Sales Chart</h4>
                    <canvas id="singelBarChart" width="500" height="250"></canvas>
                </div>
            </div>
        </div>
    </div>


</div>
<!-- #/ container -->
</div>
        <!--**********************************
            Content body end
        ***********************************-->


<?php
    require('../comon/footer.php');
?>

<!-- Chartjs -->
<script src="../assets/plugins/chart.js/Chart.bundle.min.js"></script>
<script src="../js/dashboard.js"></script>
