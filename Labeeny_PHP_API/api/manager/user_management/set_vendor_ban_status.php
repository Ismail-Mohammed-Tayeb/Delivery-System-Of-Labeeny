<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";


if (
    isset($_POST["banStatus"])
    && isset($_POST["userId"])


) {
    $banStatus = htmlspecialchars(strip_tags($_POST["banStatus"]));
    $userId = htmlspecialchars(strip_tags($_POST["userId"]));

    $selectArray = array();
    array_push($selectArray, $banStatus, $userId);
    $sql = "UPDATE vendor_model SET isBanned=? WHERE userId= ?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {

        $resJson = array("result" => "999", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {

        //bad request
        $resJson = array("result" => "error", "code" => "400", "message" => "error");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
