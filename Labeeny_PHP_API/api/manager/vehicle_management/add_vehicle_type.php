<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["vehicleType"])
    && isset($_POST["minCapacity"])
    && isset($_POST["maxCapacity"])
    && isset($_POST["priceFactor"])
    
) {
    $vehicleType = htmlspecialchars(strip_tags($_POST["vehicleType"]));
    $minCapacity = htmlspecialchars(strip_tags($_POST["minCapacity"]));
    $maxCapacity = htmlspecialchars(strip_tags($_POST["maxCapacity"]));
    $priceFactor = htmlspecialchars(strip_tags($_POST["priceFactor"]));
    $selectArray = array();
    array_push($selectArray, $vehicleType);
    array_push($selectArray, $priceFactor);
    array_push($selectArray, $minCapacity);
    array_push($selectArray, $maxCapacity);
    $sql = "INSERT INTO vehicle_type_model (vehicleType,priceFactor,minCapacity,maxCapacity) VALUES (?,?,?,?) ";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {

        //bad request
        $resJson = array("result" => "fail1", "code" => "400", "message" => "error1");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail2", "code" => "400", "message" => "error2");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
