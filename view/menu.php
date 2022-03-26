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
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">Menu Managements</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
            <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header text-right">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#model">Register New</button>
                            </div>
                            <div class="card-body">
                                <h4 class="card-title">Data Table</h4>
                                
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
                                                                        <input type="hidden" id="menu_id" name="menu_id">
                                                                    <div class="form-group col-md-6">
                                                                        <label>Name</label>
                                                                        <input type="text" id="name" name="name" class="form-control" placeholder="Name">
                                                                    </div>
                                                                    <div class="form-group col-md-6">
                                                                        <label>Module</label>
                                                                        <input type="text" id="module" name="module" class="form-control" placeholder="Module">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Link</label>
                                                                        <input type="text" id="link" name="link" class="form-control" placeholder="Link">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Register Date</label>
                                                                        <input type="date" id="date" name="date" class="form-control" placeholder="">
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

<script src="../js/menus.js"></script>