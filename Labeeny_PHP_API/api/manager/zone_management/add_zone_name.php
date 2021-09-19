<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["districtId"])
    && isset($_POST["zoneName"])
) {
    $districtId = htmlspecialchars(strip_tags($_POST["districtId"]));
    $zoneName = htmlspecialchars(strip_tags($_POST["zoneName"]));
    $selectArray = array();
    array_push($selectArray, $zoneName);
    array_push($selectArray, $districtId);

    $sql = "INSERT INTO zone_name_model (zoneName,districtId) VALUES (?,?) ";
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
