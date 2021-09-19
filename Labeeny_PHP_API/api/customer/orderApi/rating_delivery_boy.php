<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["userId"])
    && isset($_POST["rating"])
    && isset($_POST["numberOfPeopleRating"])
) {
    $userId = htmlspecialchars(strip_tags($_POST["userId"]));
    $rating = htmlspecialchars(strip_tags($_POST["rating"]));
    $numberOfPeopleRating = htmlspecialchars(strip_tags($_POST["numberOfPeopleRating"]));
    $selectArray = array();
    array_push($selectArray, $rating);
    array_push($selectArray, $numberOfPeopleRating);
    array_push($selectArray, $userId);


    $sql = "UPDATE delivery_boy_model SET rating=?,numberOfPeopleRating=? WHERE userId=?";
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
