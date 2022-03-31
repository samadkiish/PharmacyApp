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
                    <h3 class="card-title text-white">Products Sold</h3>
                    <div class="d-inline-block">
                        <h2 class="text-white">4565</h2>
                        <p class="text-white mb-0">Jan - March 2019</p>
                    </div>
                    <span class="float-right display-5 opacity-5"><i class="fa fa-shopping-cart"></i></span>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6">
            <div class="card gradient-2">
                <div class="card-body">
                    <h3 class="card-title text-white">Net Profit</h3>
                    <div class="d-inline-block">
                        <h2 class="text-white">$ 8541</h2>
                        <p class="text-white mb-0">Jan - March 2019</p>
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
                        <h2 class="text-white">4565</h2>
                        <p class="text-white mb-0">Jan - March 2019</p>
                    </div>
                    <span class="float-right display-5 opacity-5"><i class="fa fa-users"></i></span>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-sm-6">
            <div class="card gradient-4">
                <div class="card-body">
                    <h3 class="card-title text-white">Customer Satisfaction</h3>
                    <div class="d-inline-block">
                        <h2 class="text-white">99%</h2>
                        <p class="text-white mb-0">Jan - March 2019</p>
                    </div>
                    <span class="float-right display-5 opacity-5"><i class="fa fa-heart"></i></span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Single Bar Chart</h4>
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
    <script>
        // single bar chart
        var dataArray = [35, 55, 75, 81, 56, 55, 40];
        var ctx = document.getElementById("singelBarChart");
        ctx.height = 150;
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ["Sun", "Mon", "Tu", "Wed", "Th", "Fri", "Sat"],
                datasets: [
                    {
                        label: "My First dataset",
                        data: dataArray,
                        borderColor: "rgba(117, 113, 249, 0.9)",
                        borderWidth: "0",
                        backgroundColor: "rgba(117, 113, 249, 0.5)"
                    }
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    </script>
