<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";


if (
    isset($_POST["deliveryBoyId"])
    && isset($_POST["orderId"])
    && isset($_POST["approximateTimeInMinutes"])


) {
    $deliveryBoyId = htmlspecialchars(strip_tags($_POST["deliveryBoyId"]));
    $orderId = htmlspecialchars(strip_tags($_POST["orderId"]));
    $approximateTimeInMinutes = htmlspecialchars(strip_tags($_POST["approximateTimeInMinutes"]));

    $selectArray = array();
    array_push($selectArray, $deliveryBoyId, $approximateTimeInMinutes, $orderId);
    $sql = "UPDATE order_model SET deliveryBoyId=?,takeOrderDate=now(),orderStatus=1,approximateTimeInMinutes=? WHERE orderId= ?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $selectArray = array();
        array_push($selectArray, $deliveryBoyId);
        $sql = "UPDATE delivery_boy_model SET isBusy=1 WHERE userId= ?";
        $result = dbExec($sql, $selectArray);

        if ($result->rowCount() == 1) {
            $resJson = array("result" => "999", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            //bad request
            $resJson = array("result" => "error1", "code" => "400", "message" => "error");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {

        //bad request
        $resJson = array("result" => "error2", "code" => "400", "message" => "error");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
