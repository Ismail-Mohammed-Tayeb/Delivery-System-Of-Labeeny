<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (

    isset($_POST["userType"])    //is_auth()
) {

    $userType = $_POST["userType"];


    if ($userType == -1) {

        $sql = "SELECT COUNT(user_model.phoneNumber)AS countOfAccount FROM user_model";
        $result = dbExec($sql, []);

        $arrJson = array();
        if ($result->rowCount() > 0) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            // extract($row);
            $arrJson = $row['countOfAccount'];

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any category");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {

        $insertArray = array();

        array_push($insertArray, htmlspecialchars(strip_tags($userType)));






        $sql = "SELECT COUNT(user_model.phoneNumber)AS countOfAccount FROM user_model WHERE userType=?";
        $result = dbExec($sql, $insertArray);

        $arrJson = array();
        if ($result->rowCount() > 0) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            // extract($row);
            $arrJson = $row['countOfAccount'];

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any DeliveryBoy ");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
