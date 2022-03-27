<?php
header("Content-Type: application/json");
include("../comon/database.php");
$action = $_POST['action'];

function insert_update($conn)
{
    extract($_POST);

    // $userId = $_SESSION['user_id'];
    $data = [];

    $query = "CALL 	customer_sp('$customer_id','$name','$mobile','$gender','$address','$date','USR001','$action_sp')";
    $result = $conn->query($query);

    if ($result) {
        $Message = $result->fetch_assoc();
        $data = array();
        if ($Message['Message'] == 'inserted') {
            $data = array('status' => true, 'message' => 'New Customer has been saved successfully');
        }elseif ($Message['Message'] == 'updated') {
            $data = array('status' => true, 'message' => 'Customer has been saved successfully');
        }
    } else {
        $data = array('status' => false, 'message' => $conn->error);
    }

    echo json_encode($data);
}


function read($conn) {
    extract($_POST);
    $query = "CALL `customer_read_sp`('$customer_id')";
    $result = $conn->query($query);
    $result_data = array();
    if ($result) {
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
    }
    else {
        $result_data = array("status" => false, "message" => $conn->error);
    }

    echo json_encode($result_data);
}


function delete($conn) {
    extract($_POST);
    $query = "CALL `customer_delete_sp`('$customer_id')";
    $result = $conn->query($query);
    $result_data = array();

    if ($result) {
        $row = $result->fetch_assoc();
        if ($row['Message'] == 'success') {
            $result_data = array("status" => true, "message" => "Customer has been deleted successfully");
        }
    }
    else {
        $result_data = array("status" => false, "message" => $conn->error);
    }

    echo json_encode($result_data);
}



if (isset($action)) {
    $action($conn);
}
else {
    echo json_encode(array("status"=>false, "message"=>'Not Found'));
}
