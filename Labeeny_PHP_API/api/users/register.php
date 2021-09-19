<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";
include_once "../../shared/db_constants.php";

if (
    isset($_POST["user_phone"])
    && isset($_POST["user_password"])
    && isset($_POST["user_name"])
    && isset($_POST["user_location"])
    && isset($_POST["user_type"])

) {
    $user_name = htmlspecialchars(strip_tags($_POST["user_name"]));
    $user_password = htmlspecialchars(strip_tags($_POST["user_password"]));
    $user_phone = htmlspecialchars(strip_tags($_POST["user_phone"]));
    $user_location = htmlspecialchars(strip_tags($_POST["user_location"]));
    $user_type = htmlspecialchars(strip_tags($_POST["user_type"]));

    $selectArray = array();
    array_push($selectArray, $user_name);
    array_push($selectArray, $user_password);
    array_push($selectArray, $user_phone);
    array_push($selectArray, $user_type);
    array_push($selectArray, $user_location);

    $sql = "select * from " . DataBaseTablesNames::$userModelTable . "where phoneNumber = ? ";
    $result = dbExec($sql, $selectArray);
    $arrJson = array();
    if ($result->rowCount() == 1) {
        $row1 = $result->fetch(PDO::FETCH_ASSOC);
        if (password_verify($use_pwd, $row1['password'])) {
            if ($row1['userType'] == 0) {
                $selectArray = array();
                array_push($selectArray, $row1['userId']);
                $sql = "select location from " . DataBaseTablesNames::$customerModelTable . "where UserId = ? ";
                $result = dbExec($sql, $selectArray);
                if ($result->rowCount() == 1) {
                    $row2 = $result->fetch(PDO::FETCH_ASSOC);
                    array_push($row1, $row2);
                }
            }
            $arrJson  = $row1;
            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            //bad request
            $resJson = array("result" => "كلمة السر خاطئة", "code" => "400", "message" => "false");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {
        //bad request
        $resJson = array("result" => "لا يوجد مستخدم بهذاالإسم", "code" => "400", "message" => "empty");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
