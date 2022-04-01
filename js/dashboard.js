$(document).ready(function () {

    loadChart();
    fetchStatis()


    function loadChart() {

        var data = {
            "action": "loadChart",

        };

        $.ajax({
            method: "POST",
            url: "../api/dashboard.php",
            data: data,
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;
                var days = [];
                var total = [];

                if (status) {

                    message.forEach(function (item, i) {
                        days.push(item['Day']);
                        total.push(item['amount']);

                    });

                    // single bar chart

                    var ctx = document.getElementById("singelBarChart");
                    ctx.height = 150;
                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: days,
                            datasets: [
                                {
                                    label: "Daily Sales",
                                    data: total,
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
                } else {
                    ctx.html(message);
                }

            },
            error: function (data) {

            }
        });

    }

  
    function fetchStatis() {


        $.ajax({
            method: "POST",
            url: "../api/dashboard.php",
            data: { "action": "fetchStatis" },
            dataType: "JSON",
            async: true,
            success: function (data) {
                var status = data.status;
                var message = data.message;

                if (status == true) {
                    $(".onStock").html(message[0]['onStock']);
                    $(".income").html(message[0]['income']);
                    $(".customers").html(message[0]['customers']);
                    $(".expenses").html(message[0]['expense']);



                }

            },
            error: function (data) {

            }
        });

    }

    


});