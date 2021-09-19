<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["vehicleTypeId"])
    && isset($_POST["vehicleType"])
    && isset($_POST["priceFactor"])
    && isset($_POST["minCapacity"])
    && isset($_POST["maxCapacity"])
) {
    $vehicleTypeId = htmlspecialchars(strip_tags($_POST["vehicleTypeId"]));
    $vehicleType = htmlspecialchars(strip_tags($_POST["vehicleType"]));
    $priceFactor = htmlspecialchars(strip_tags($_POST["priceFactor"]));
    $minCapacity = htmlspecialchars(strip_tags($_POST["minCapacity"]));
    $maxCapacity = htmlspecialchars(strip_tags($_POST["maxCapacity"]));

    $selectArray = array();
    array_push($selectArray, $vehicleType);
    array_push($selectArray, $priceFactor);
    array_push($selectArray, $minCapacity);
    array_push($selectArray, $maxCapacity);
    array_push($selectArray, $vehicleTypeId);

    $sql = "UPDATE vehicle_type_model SET vehicleType=?,priceFactor=?,minCapacity=?,maxCapacity=? WHERE vehicleTypeId=?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {

        //bad request
        $resJson = array("result" => "fail", "code" => "400", "message" => "error");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
