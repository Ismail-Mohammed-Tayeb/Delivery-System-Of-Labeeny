<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["orderQr"])
    && isset($_POST["customerId"])
    && isset($_POST["orderId"])


) {
    $orderQr = htmlspecialchars(strip_tags($_POST["orderQr"]));
    $customerId = htmlspecialchars(strip_tags($_POST["customerId"]));
    $orderId = htmlspecialchars(strip_tags($_POST["orderId"]));
    $selectArray = array();
    array_push($selectArray, $orderQr, $customerId, $orderId);

    $sql = "UPDATE order_model SET orderStatus=2,deliveryDate=now() WHERE orderQr=? AND customerId=? AND orderId=?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $selectArray = array();
        array_push($selectArray, $orderId);
        $sql = "SELECT deliveryBoyId FROM order_model WHERE orderId=? ";
        $result = dbExec($sql, $selectArray);
        if ($result->rowCount() == 1) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            $deliveryBoyId = $row['deliveryBoyId'];
            $selectArray = array();
            array_push($selectArray, $deliveryBoyId);
            $sql = "UPDATE delivery_boy_model SET isBusy=0 WHERE userId=?";
            $result = dbExec($sql, $selectArray);
            if ($result->rowCount() == 1) {

                $resJson = array("result" => "success", "code" => "200", "message" => $deliveryBoyId);
                echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
            } else {
                //bad request
                $resJson = array("result" => "fail", "code" => "400", "message" => "error1");
                echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
            }
        } else {
            //bad request
            $resJson = array("result" => "empty Fail", "code" => "400", "message" => "error2");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {

        //bad request
        $resJson = array("result" => "fail", "code" => "400", "message" => "error3");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error4");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
