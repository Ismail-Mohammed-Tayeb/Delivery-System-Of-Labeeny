<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (

    isset($_POST["isBusy"])    //is_auth()
) {

    $isBusy = $_POST["isBusy"];


    if ($isBusy == -1) {

        $sql = "SELECT COUNT(delivery_boy_model.deliveryBoyId)AS countOfDeliveryBoy FROM delivery_boy_model";
        $result = dbExec($sql, []);

        $arrJson = array();
        if ($result->rowCount() > 0) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            // extract($row);
            $arrJson = $row['countOfDeliveryBoy'];

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any deliveyBoy");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {

        $insertArray = array();

        array_push($insertArray, htmlspecialchars(strip_tags($isBusy)));






        $sql = "SELECT COUNT(delivery_boy_model.deliveryBoyId)AS countOfDeliveryBoy FROM delivery_boy_model WHERE isBusy=?";
        $result = dbExec($sql, $insertArray);

        $arrJson = array();
        if ($result->rowCount() > 0) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            // extract($row);
            $arrJson = $row['countOfDeliveryBoy'];

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
