<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include_once "../../../library/function.php";

if (
    isset($_POST["userId"])
    && isset($_POST["title"])
    && isset($_POST["body"])

) {




    $userId = $_POST["userId"];
    $title = htmlspecialchars(strip_tags($_POST["title"]));
    $msg = htmlspecialchars(strip_tags($_POST["body"]));



    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($userId)));
    $sql = "SELECT DISTINCT user_model.deviceToken FROM user_model WHERE userId=?  ";
    $result = dbExec($sql,  $insertArray);

    $arrJson = array();

    if ($result->rowCount() == 1) {
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            $targeDeliveryBoyToken = $row['deviceToken'];
            if ($targeDeliveryBoyToken != null) {
                sendFCM($title, $msg, $targeDeliveryBoyToken, "1", "w");
            }
        }
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        $resJson = array("result" => "fail", "code" => "400", "message" => "No any customer");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
