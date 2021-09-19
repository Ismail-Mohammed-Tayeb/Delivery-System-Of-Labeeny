<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";
include_once "../../shared/db_constants.php";

if (
    isset($_POST["phoneNumber"])


) {
    $use_mobile = htmlspecialchars(strip_tags($_POST["phoneNumber"]));

    $selectArray = array();
    array_push($selectArray, $use_mobile);
    $sql = "SELECT * FROM user_model WHERE phoneNumber=? ";
    $result = dbExec($sql, $selectArray);
    $arrJson = array();
    if ($result->rowCount() == 0) {
        $random = generateRandomString();
        $resJson = array("result" => "999", "code" => "200", "message" => $arrJson, "verification_code" => $random);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => " يوجد حساب بالفعل على هذا الرقم", "code" => "400", "message" => "empty");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
