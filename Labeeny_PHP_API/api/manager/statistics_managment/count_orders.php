<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (

    isset($_POST["orderStatus"])    //is_auth()
) {

    $orderStatus = $_POST["orderStatus"];


    if ($orderStatus == -1) {

        $sql = "SELECT COUNT(order_model.orderId)AS countOfOrder FROM order_model";
        $result = dbExec($sql, []);

        $arrJson = array();
        if ($result->rowCount() > 0) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            // extract($row);
            $arrJson = $row['countOfOrder'];

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any order");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {

        $insertArray = array();

        array_push($insertArray, htmlspecialchars(strip_tags($orderStatus)));






        $sql = "SELECT COUNT(order_model.orderId)AS countOfOrder FROM order_model WHERE orderStatus=?";
        $result = dbExec($sql, $insertArray);

        $arrJson = array();
        if ($result->rowCount() > 0) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            // extract($row);
            $arrJson = $row['countOfOrder'];

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any order");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
