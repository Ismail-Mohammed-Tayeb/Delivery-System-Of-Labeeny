<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";



if (
    isset($_POST['imageName'])
    && isset($_POST['image64'])
    && isset($_POST['phoneNumber'])
    //  && is_auth()

) {
    $phoneNumber = $_POST['phoneNumber'];
    //delete pld photo if exsit
    $selectArray = array();
    array_push($selectArray, $phoneNumber);
    $sql = "SELECT portraitImageURL FROM user_model WHERE phoneNumber=?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        if ($row['portraitImageURL'] != null) {
            unlink("../../images/customer/" . $row['portraitImageURL']);
        }
    }

    $imagname = htmlspecialchars(strip_tags($_POST["imageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["image64"]));
    $image = base64_decode($image64);
    $uploadDir = "../../images/customer/";
    $pathToStore = uploadImage($imagname, $image, $uploadDir);
    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($pathToStore)));
    array_push($insertArray, htmlspecialchars(strip_tags($phoneNumber)));
    $sql = "UPDATE user_model SET user_model.portraitImageURL=? WHERE phoneNumber=?";
    $result = dbExec($sql, $insertArray);
    if ($result->rowCount() == 1) {
        $resJson = array("result" => "999", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "   2خطأ بالادخال ", "code" => "400", "message" => "false");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
