<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";


if (
    isset($_POST["phoneNumber"])
    && isset($_POST["oldPassword"])
    && isset($_POST["newPassword"])
    && is_auth()

) {
    $phoneNumber = htmlspecialchars(strip_tags($_POST["phoneNumber"]));
    $oldPassword = htmlspecialchars(strip_tags($_POST["oldPassword"]));
    $newPassword = htmlspecialchars(strip_tags($_POST["newPassword"]));
    $encpass = password_hash($newPassword, PASSWORD_BCRYPT);
    $selectArray = array();
    array_push($selectArray, $phoneNumber);
    $sql = "SELECT * from user_model WHERE phoneNumber=?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $row1 = $result->fetch(PDO::FETCH_ASSOC);
        if (password_verify($oldPassword, $row1['password'])) {
            $selectArray = array();
            array_push($selectArray, $encpass, $phoneNumber);
            $sql = "UPDATE user_model SET password=? WHERE phoneNumber=?";
            $result = dbExec($sql, $selectArray);
            $resJson = array("result" => "999", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {

            //bad request
            $resJson = array("result" => "كلمة السر القديمة خاطئة", "code" => "400", "message" => "error");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {
        //bad request
        $resJson = array("result" => "لايوجد مستخدم بهذا الرقم ", "code" => "400", "message" => "error");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
