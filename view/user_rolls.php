<?php
    require('../comon/head.php');
    require('../comon/header.php');
    require('../comon/sidebar.php');
    // include_once('');
    // require('');
    // include_once('');
?>

<style>
fieldset {
    border: 1px solid #ddd !important;
    margin: 0;
    padding: 10px;
    position: relative;
    border-radius: 4px;
    background-color: #ffffff;
    padding-left: 10px !important;
}

legend {
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 0px;
    width: auto;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 5px 15px 5px 15px;
    background-color: #ffffff;
}
</style>


<!--**********************************
            Content body start
        ***********************************-->
<div class="content-body">

    <div class="row page-titles mx-0">
        <div class="col p-md-0">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:void(0)">Dashboard</a></li>
                <li class="breadcrumb-item active"><a href="javascript:void(0)">Home</a></li>
            </ol>
        </div>
    </div>
    <!-- row -->

    <div class="container-fluid">
        <div class="card">
            <form action="" method="POST" id="form">
                <div class="card-header">
                    <div class="row">
                        <div class="col-12">
                            <div class="form-group row">
                                <label class="form-label text-bold">Select User</label>
                                <select type="text" class="form-control form-control-sm" id="user_id" name="user_id"
                                    placeholder="Selet Employee">

                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <fieldset class="col-md-12 pb-5 custom-checkbox">
                        <legend style="background-color: #eb262c;color: #fff;">SYSTEM ROLES &nbsp; &nbsp; &nbsp;
                            <input type="checkbox" class="custom-control-input" id="check_all" name="check_all"> &nbsp;
                            &nbsp;
                            <label class="custom-control-label" for="check_all">CHECK ALL</label>
                        </legend>

                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="content_body" class="row" style="justify-content:center;">
                                    <fieldset class="col-md-2">
                                        <legend>Admission</legend>

                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <ul style="list-style-type:none">
                                                    <li>Fieldset content...</li>
                                                    <li>Fieldset content...</li>
                                                    <li>Fieldset content...</li>
                                                    <li>Fieldset content...</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                    </fieldset>
                </div>
                <div class="card-footer text-center">
                    <button type="submit" class="btn btn-success">Save Change</button>
                </div>
            </form>
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
<script src="../js/user_roll.js"></script>