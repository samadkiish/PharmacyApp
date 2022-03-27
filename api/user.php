<?php
header("Content-Type: application/json");
include("../comon/database.php");
$action = $_POST['action'];

function insert_update($conn){
    extract($_POST);
    
    $query = "CALL user_sp('$user_id','$username','$password','$employee_id','$status','$date','$action_sp')"; // statement
    $result = $conn->query($query); // excution

    if($result){
        $row = $result->fetch_assoc();
        if($row['Message'] == 'inserted')
            $result_data = array("status" => true, "message" => 'User has Been Inserted.');
        else if($row['Message'] == 'updated')
            $result_data = array("status" => true, "message" => 'User has Been Updated.');
        else{
            $result_data = array("status" => false, "message" => $conn->error());
        }
    }   else{
            $result_data = array("status" => false, "message" => $conn->error());
    }

    echo json_encode($result_data);
}


function read($conn){
    extract($_POST);
    
    $query = "CALL user_read_sp('$user_id')"; // statement
    $result = $conn->query($query); // excution

    if($result){
        $num_rows = $result->num_rows;
        if ($num_rows > 0) {
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            $result_data = array("status" => true, "message" => $data);
        }
        else {
            $result_data = array("status" => false, "message" => "Data Not Found");
        }
    }else{
            $result_data = array("status" => false, "message" => $conn->error());
    }

    echo json_encode($result_data);
}


function fillEmployee($conn){
    extract($_POST);
    
    $query = "CALL employee_fill_sp()"; // statement
    $result = $conn->query($query); // excution

    if($result){
        $num_rows = $result->num_rows;
        if ($num_rows > 0) {
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            $result_data = array("status" => true, "message" => $data);
        }
        else {
            $result_data = array("status" => false, "message" => "Data Not Found");
        }
    }else{
            $result_data = array("status" => false, "message" => $conn->error());
    }

    echo json_encode($result_data);
}

function fillUser($conn){
    extract($_POST);
    
    $query = "CALL fill_user_sp()"; // statement
    $result = $conn->query($query); // excution

    if($result){
        $num_rows = $result->num_rows;
        if ($num_rows > 0) {
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            $result_data = array("status" => true, "message" => $data);
        }
        else {
            $result_data = array("status" => false, "message" => "Data Not Found");
        }
    }else{
            $result_data = array("status" => false, "message" => $conn->error());
    }

    echo json_encode($result_data);
}


function fetchUserRolls($conn){
    extract($_POST);
    
    $query = "CALL user_rolls_get_sp('$user_id')"; // statement
    $result = $conn->query($query); // excution

    if($result){
        $num_rows = $result->num_rows;
        if ($num_rows > 0) {
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            $result_data = array("status" => true, "message" => $data);
        }
        else {
            $result_data = array("status" => false, "message" => "Data Not Found");
        }
    }else{
            $result_data = array("status" => false, "message" => $conn->error());
    }

    echo json_encode($result_data);
}


function updateRolls($conn)
{
    extract($_POST);
    // $userId = $_SESSION['user_id'];
    $result_info = '';

    if ($menu_id == 0) {
        $query = "CALL user_rolls_sp('$user_id','$menu_id', '0')";
        // $conn = new mysqli(SERVER_NAME, USERNAME, PASSWORD, DATABASE);
        $result = $conn->query($query);
        $result_data = [];
        if ($result) {
            $result_data = array('status' => true, 'message' => 'User Permissions has been saved successfully ');
        } else {
            $result_data = array('status' => false, 'message' => $conn->error);
        }
    } else {
        $count = count($menu_id);
        for ($i = 0; $i < $count; $i++) {
            $query = "CALL user_rolls_sp('$user_id','$menu_id[$i]', $i)";
            $conn = new mysqli(SERVER_NAME, USERNAME, PASSWORD, DATABASE);
            $result = $conn->query($query);
            $result_data = [];
            if ($result) {
                $result_data = array('status' => true, 'message' => 'User Permissions has been saved successfully ');
            } else {
                $result_data = array('status' => false, 'message' => $conn->error);
            }
        }
    }


    echo json_encode($result_data);
}


function delete($conn){
    extract($_POST);
    
    $query = "CALL user_delete_sp('$user_id')"; // statement
    $result = $conn->query($query);// excution
    $result_data = array(); 

    if ($result) {
        $row = $result->fetch_assoc();
        echo $row['Message'];
        if ($row['Message'] == 'success') {
            $result_data = array("status" => true, "message" => "deleted successfully");
        } else {
            $result_data = array("status" => false, "message" => $row['Message']);
        }
    }
    else {
        $result_data = array("status" => false, "message" => $conn->error);
    }

    echo json_encode($result_data);
}

function readMenus($conn){
    extract($_POST);
    
    $query = "CALL user_menu_get()"; // statement
    $result = $conn->query($query); // excution

    if($result){
        $num_rows = $result->num_rows;
        if ($num_rows > 0) {
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            $result_data = array("status" => true, "message" => $data);
        }
        else {
            $result_data = array("status" => false, "message" => "Data Not Found");
        }
    }else{
            $result_data = array("status" => false, "message" => $conn->error());
    }

    echo json_encode($result_data);
}

if (isset($action)) {
    $action($conn);
}
else {
    echo json_encode(array("status"=>false, "message"=>'Not Found'));
}


?>