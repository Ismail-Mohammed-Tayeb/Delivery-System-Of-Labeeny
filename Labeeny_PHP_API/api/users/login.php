<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";
include_once "../../shared/db_constants.php";

if (
    isset($_POST["user_phone"])
    && isset($_POST["user_password"])

) {
    $use_pwd = htmlspecialchars(strip_tags($_POST["user_password"]));
    $use_mobile = htmlspecialchars(strip_tags($_POST["user_phone"]));

    $selectArray = array();
    array_push($selectArray, $use_mobile);
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
