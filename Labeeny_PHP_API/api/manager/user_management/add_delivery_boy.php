<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
include_once "../../../library/database.php";

if (
    isset($_POST["phoneNumber"])
    && isset($_POST["password"])
    && isset($_POST["name"])
    && isset($_POST['imageName'])
    && isset($_POST['image64'])
    && isset($_POST['zoneNameId'])
    && isset($_POST['vehicleTypeId'])
    && isset($_POST['vehiclePlate'])
    && isset($_POST['startHour'])
    && isset($_POST['endHour'])

) {
    $user_name = htmlspecialchars(strip_tags($_POST["name"]));
    $user_password = htmlspecialchars(strip_tags($_POST["password"]));
    $encpass = password_hash($user_password, PASSWORD_BCRYPT);

    $user_phone = htmlspecialchars(strip_tags($_POST["phoneNumber"]));
    $imagname = htmlspecialchars(strip_tags($_POST["imageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["image64"]));
    $zoneNameId = htmlspecialchars(strip_tags($_POST["zoneNameId"]));
    $vehicleTypeId = htmlspecialchars(strip_tags($_POST["vehicleTypeId"]));
    $vehiclePlate = htmlspecialchars(strip_tags($_POST["vehiclePlate"]));
    $startHour = htmlspecialchars(strip_tags($_POST["startHour"]));
    $endHour = htmlspecialchars(strip_tags($_POST["endHour"]));
    $image = base64_decode($image64);

    $uploadDir = "../../../images/delivery_boy_images/";

    $pathToStore = uploadImage($imagname, $image, $uploadDir);


    $selectArray = array();
    array_push($selectArray, $user_name, $encpass, $user_phone, $pathToStore);
    $sql = "INSERT INTO user_model (user_model.name,user_model.password,user_model.phoneNumber,user_model.portraitImageURL,user_model.userType) VALUES(?,?,?,?,2)";
    $database = new Database();
    $database->getConnection();
    $myCon = $database->conn;
    $result = $myCon->prepare($sql);
    $result->execute($selectArray);

    $arrJson = array();

    $newId = $myCon->lastInsertId();
    if ($result->rowCount() == 1) {
        $selectArray = array();
        array_push($selectArray, $zoneNameId);
        array_push($selectArray, $vehicleTypeId);
        array_push($selectArray, $vehiclePlate);
        array_push($selectArray, $startHour);
        array_push($selectArray, $endHour);
        array_push($selectArray, $newId);
        $sql = "INSERT INTO delivery_boy_model (zoneNameId,vehicleTypeId,vehiclePlate,startHour,endHour,userId) VALUES(?,?,?,?,?,?)";
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
