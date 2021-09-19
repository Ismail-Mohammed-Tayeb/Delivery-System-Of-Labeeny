<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["userId"])

) {
    $userId = htmlspecialchars(strip_tags($_POST["userId"]));

    $selectArray = array();
    array_push($selectArray, $userId);
    $sql = "SELECT * FROM user_model JOIN delivery_boy_model ON delivery_boy_model.userId=user_model.userId WHERE delivery_boy_model.userId=?";
    $result = dbExec($sql, $selectArray);
    $arrJson = array();
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        $arrJson = $row;
    }
    $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
