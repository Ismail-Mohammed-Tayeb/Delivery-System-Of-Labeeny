<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["districtId"])
    && isset($_POST["pricePerKm"])
) {
    $districtId = htmlspecialchars(strip_tags($_POST["districtId"]));
    $pricePerKm = htmlspecialchars(strip_tags($_POST["pricePerKm"]));
    $selectArray = array();
    array_push($selectArray, $pricePerKm);
    array_push($selectArray, $districtId);

    $sql = "UPDATE district_model SET pricePerKm=? WHERE districtId=?";
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
