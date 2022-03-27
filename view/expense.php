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
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">Expense Management</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
            <div class="alert alert-danger">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                    </button>
                    <div class="message"></div></div>
            <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header text-right">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#model">Register New</button>
                            </div>
                            <div class="card-body">
                                <h4 class="card-title">Expense List</h4>
                                
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

        <div class="modal fade" id="model">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Modal title</h5>
                                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                    </button>
                                                </div>
<form id="form" action="" method="POST">
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="basic-form">
                                                                <div class="form-row">
                                                                        <input type="hidden" id="expense_id" name="expense_id">
                                                                    <div class="form-group col-md-12">
                                                                        <label>Type</label>
                                                                        <input type="text" id="type" name="type" class="form-control" placeholder="Name" required="true">
                                                                    </div>

                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Description</label>
                                                                        <textarea type="text" id="description" name="description" class="form-control" placeholder="Description">
</textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Amount</label>
                                                                        <input type="number" step="any" min="0" id="amount" name="amount" class="form-control" placeholder="Amount" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Register Date</label>
                                                                        <input type="date" id="date" name="date" class="form-control" placeholder="" value="<?php echo Date('Y-m-d')?>">
                                                                </div>
                                                               
                                                               
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary btn_save">Save and Close</button>
                                                    <button type="submit" class="btn btn-primary  btn_save">Save and New</button>
                                                </div>
                                            </form>
                                            </div>
                                        </div>
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
<script src="../js/expense.js"></script>

<script>
    $('.alert').hide();
</script>