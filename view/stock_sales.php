<?php
    require('../comon/head.php');
    require('../comon/header.php');
    require('../comon/sidebar.php');
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
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">Stock Sales Managements</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
            <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header text-right">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#model" id="btn_modle">Register New</button>
                            </div>
                            <div class="card-body">
                            <div class="alert alert-danger">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                    </button>
                    <div class="message"></div></div>
                                <h4 class="card-title">Stock Sale List Table</h4>
                                
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
            <!-- #/ container -->
        </div>
        <!--**********************************
            Content body end
        ***********************************-->
 <div class="modal fade" id="model">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Stock Sale Edit / New</h5>
                                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                    </button>
                                                </div>
<form id="form" action="" method="POST">
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="basic-form">
                                                                <div class="form-row">
                                                                        <input type="hidden" id="sale_id" name="sale_id">
                                                                    <div class="form-group col-md-6">
                                                                        <label>Medicine Name</label>
                                                                        <select type="text" id="medicine_id" name="medicine_id" class="form-control" placeholder="Medicine Name" required="true">
                                                                        
</select>
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label>Customer</label>
                                                                        <select type="text" id="customer_id" name="customer_id" class="form-control" placeholder="" required="true">
</select>
                                                                    </div>
                                                                </div>

                                                                <div class="form-row">
                                                                    <div class="form-group col-md-6">
                                                                        <label>Quantity</label>
                                                                        <input type="number" id="quantity" step="any" name="quantity" class="form-control" placeholder="Medicine Quantity">
                                                                    </div>

                                                                    <div class="form-group col-md-6">
                                                                        <label>Price</label>
                                                                        <input type="number" step="any" id="price" name="price" class="form-control" placeholder="Medicine Price">
                                                                    </div>
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
                                                    <button type="submit" class="btn btn-primary">Save changes</button>
                                                </div>
                                            </form>
                                            </div>
                                        </div>
                                    </div>

        <?php
    require('../comon/footer.php');
?>
<script src="../assets/plugins/tables/js/jquery.dataTables.min.js"></script>
<script src="../assets/plugins/tables/js/datatable/dataTables.bootstrap4.min.js"></script>
<script src="../assets/plugins/tables/js/datatable-init/datatable-basic.min.js"></script>

<script src="../js/stock_sales.js"></script>

<script>
    $('.alert').hide();
</script>