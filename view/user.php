<?php
    require('../comon/head.php');
    require('../comon/header.php');
    require('../comon/sidebar.php');
    // include_once('');
    // require('');
    // include_once('');
?>
      <link href="../assets/plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
      <link href="../assets/plugins/toastr/css/toastr.min.css" rel="stylesheet">
      <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">

            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Dashboard</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">User Management</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
                <div class="alert alert-danger">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                    </button>
                    <div class="message"></div></div>
                <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#model" id="new">Register New User</button>
            <div class="table-responsive">
                                    <table id="table" class="table table-striped table-bordered zero-configuration">
                                       <thead>
                                           <tr>
                                            <!-- <th>#</th> -->
                                           </tr>
                                       </thead>
                                       <tbody>

                                       </tbody>
                                    </table>
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
                                
                                    <div class="form-group row">
                                        <input type="hidden" class="form-control" id="user_id" name="user_id" value="">

                                        <label class="col-sm-2 col-form-label col-form-label-sm">Employee</label>
                                        <div class="col-sm-10">
                                            <select type="text" class="form-control form-control-sm" id="employee_id" name="employee_id" placeholder="Selet Employee">

                                                <option value="">Default User</option>
                                                </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Username</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="username" name="username" placeholder="Username">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label col-form-label-lg">Password</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Password">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label col-form-label-lg">Status</label>
                                        <div class="col-sm-10">
                                            <select type="text" class="form-control form-control-lg" id="status" name="status" placeholder="Select User Status">
                                                <option value="Active">Active</option>
                                                <option value="InActive">InActive</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label col-form-label-lg">Register Date</label>
                                        <div class="col-sm-10">
                                            <input type="date" class="form-control form-control-lg" id="date" name="date" value="<?php echo Date('Y-m-d') ?>" placeholder="col-form-label-lg">
                                        </div>
                                    </div>
                                
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
    <!-- <script src="../assets/plugins/tables/js/datatable-init/datatable-basic.min.js"></script> -->
    <script src="../assets/plugins/toastr/js/toastr.min.js"></script>
    <script src="../assets/plugins/toastr/js/toastr.init.js"></script>
    <script src="../js/user.js"></script>

<script>
    $(".alert").hide();
    // $("#table").dataTable({
    //     // searching: false,
    //     // ordering: false,
    //     // paging:false
    // });

</script>