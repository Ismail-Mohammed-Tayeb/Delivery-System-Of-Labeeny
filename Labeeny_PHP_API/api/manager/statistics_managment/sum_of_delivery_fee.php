<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (

    true   //is_auth()
) {



    $sql = "SELECT SUM(order_model.deliveryFee) AS deliveryFee FROM order_model WHERE order_model.orderStatus=2 ";
    $result = dbExec($sql, []);

    $arrJson = array();
    if ($result->rowCount() > 0) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        // extract($row);
        $arrJson = $row['deliveryFee'];

        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        $resJson = array("result" => "fail", "code" => "400", "message" => "No any order");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
