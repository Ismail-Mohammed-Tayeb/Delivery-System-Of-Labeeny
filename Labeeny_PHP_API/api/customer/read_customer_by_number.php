<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";
if (
    isset($_POST["phoneNumber"])
    && is_numeric($_POST["phoneNumber"])
    && is_auth()
) {
    $phoneNumber = htmlspecialchars(strip_tags($_POST["phoneNumber"]));

    $selectArray = array();
    array_push($selectArray, $phoneNumber);
    $sql = "SELECT user_model.*,customer_model.location from user_model JOIN customer_model ON customer_model.UserId=user_model.userId
    WHERE user_model.phoneNumber=?";
    $result = dbExec($sql, $selectArray);
    $arrJson = array();
    if ($result->rowCount() == 1) {
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            $arrJson[] = $row;
        }
    }
    $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
