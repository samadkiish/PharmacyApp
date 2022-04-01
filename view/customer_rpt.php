<?php
    require('../comon/head.php');
    require('../comon/header.php');
    require('../comon/sidebar.php');
    // include_once('');
    // require('');
    // include_once('');
?>
<link href="../assets/plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">

<!--**********************************
            Content body start
        ***********************************-->
<div class="content-body">

    <div class="row page-titles mx-0">
        <div class="col p-md-0">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:void(0)">Dashboard</a></li>
                <li class="breadcrumb-item active"><a href="javascript:void(0)">Report Customer Management</a></li>
            </ol>
        </div>
    </div>
    <!-- row -->

    <div class="container-fluid">
        <div class="alert alert-danger">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">×</span>
            </button>
            <div class="message"></div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header text-right">
                        <form id="form" action="" method="POST">
                            <div class="row">

                                <div class="col-3">
                                <label class="float-left">Gender</label>
                                        <select id="gender" name="gender" class="form-control" placeholder="">
                                            <option value=""> All</option>
                                            <option value="Male"> Male</option>
                                            <option value="Female"> Female</option>
                                        </select>
                                </div>

                                <div class="col-3">
                                    <div class="form-group">
                                        <label class="float-left">Data Type</label>
                                        <select id="date_type" name="date_type" class="form-control" placeholder="">
                                            <option value="All"> All</option>
                                            <option value="Custom"> Custom</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="form-group">
                                        <label class="float-left">From</label>
                                        <input type="date" id="from" name="from" class="form-control" placeholder=""
                                            value="<?php echo Date('Y-m-d')?>">
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="form-group">
                                        <label class="float-left">To</label>
                                        <input type="date" id="to" name="to" class="form-control" placeholder=""
                                            value="<?php echo Date('Y-m-d')?>">
                                    </div>
                                </div>
                                <div class="col-12 text-center">
                                    <button type="submit" class="btn btn-primary" id='submit'>Generate</button>
                                </div>
                            </div>

                            
                        </form>
                    </div>
                    <div class="card-body">
                        <h4 class="card-title">Customer List</h4>

                        <div class="table-responsive">
                            <table id="table" class="table table-striped table-bordered zero-configuration">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>

                            </table>
                        </div>
                    </div>
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

<script src="../assets/plugins/tables/js/jquery.dataTables.min.js"></script>
<script src="../assets/plugins/tables/js/datatable/dataTables.bootstrap4.min.js"></script>
<script src="../assets/plugins/tables/js/datatable-init/datatable-basic.min.js"></script>
<script src="../js/customer_rpt.js"></script>

<script>
$('.alert').hide();
</script>