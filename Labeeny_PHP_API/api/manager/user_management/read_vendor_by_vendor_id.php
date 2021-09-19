<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["vendorId"])

) {
    $vendorId = htmlspecialchars(strip_tags($_POST["vendorId"]));

    $selectArray = array();
    array_push($selectArray, $vendorId);
    $sql = "SELECT user_model.*,vendor_model.id, vendor_model.isBanned
    FROM user_model JOIN vendor_model ON vendor_model.UserId=user_model.userId 
     WHERE vendor_model.id=? ";
    $result = dbExec($sql, $selectArray);
    $arrJson = array();
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        $arrJson = $row;
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
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
