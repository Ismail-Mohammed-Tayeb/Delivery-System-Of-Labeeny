<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";
include_once "../../shared/db_constants.php";
include_once "../../library/database.php";

if (
    isset($_POST["phoneNumber"])
    && isset($_POST["password"])
    && isset($_POST["name"])
    && isset($_POST["location"])

) {
    $user_name = htmlspecialchars(strip_tags($_POST["name"]));
    $user_password = htmlspecialchars(strip_tags($_POST["password"]));
    $encpass = password_hash($user_password, PASSWORD_BCRYPT);

    $user_phone = htmlspecialchars(strip_tags($_POST["phoneNumber"]));
    $user_location = htmlspecialchars(strip_tags($_POST["location"]));

    $selectArray = array();
    array_push($selectArray, $user_name, $encpass, $user_phone);
    $sql = "INSERT INTO user_model (user_model.name,user_model.password,user_model.phoneNumber,user_model.userType) VALUES(?,?,?,3)";
    $database = new Database();
    $database->getConnection();
    $myCon = $database->conn;
    $result = $myCon->prepare($sql);
    $result->execute($selectArray);

    $arrJson = array();

    $newId = $myCon->lastInsertId();
    if ($result->rowCount() == 1) {
        $selectArray = array();
        array_push($selectArray, $newId, $user_location);
        $sql = "INSERT INTO customer_model (customer_model.UserId,customer_model.location) VALUES(?,?)";
        $result1 = dbExec($sql, $selectArray);
        if ($result1->rowCount() == 1) {
            $resJson = array("result" => "999", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            //bad request
            $resJson = array("result" => "   2خطأ بالادخال ", "code" => "400", "message" => "false");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {
        //bad request
        $resJson = array("result" => " 1 خطأ بالادخال ", "code" => "400", "message" => "false");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
