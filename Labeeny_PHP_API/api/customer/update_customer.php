<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";
if (
    isset($_POST["name"])
    && isset($_POST["userId"])
    && isset($_POST['imageName'])
    && isset($_POST['image64'])
) {
    $name = htmlspecialchars(strip_tags($_POST["name"]));

    $userId = htmlspecialchars(strip_tags($_POST["userId"]));
    $imagname = htmlspecialchars(strip_tags($_POST["imageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["image64"]));

    if ($imagname == "" || $image64 == "" || $imagname == 'null' || $image64 == 'null') {
        $selectArray = array();
        array_push($selectArray, $name, $userId);
        $sql = "UPDATE user_model SET name=? WHERE userId= ?";
        $result = dbExec($sql, $selectArray);
        if ($result->rowCount() == 1) {

            $resJson = array("result" => "999", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {

            //bad request
            $resJson = array("result" => "error   ", "code" => "400", "message" => "error");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {
        $selectArray = array();
        array_push($selectArray, $userId);
        $sql = "SELECT portraitImageURL FROM user_model WHERE userId=?";
        $result = dbExec($sql, $selectArray);
        if ($result->rowCount() == 1) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            unlink("../../images/customer/" . $row['portraitImageURL']);
        }
        $image = base64_decode($image64);

        $uploadDir = "../../images/customer/";

        $pathToStore = uploadImage($imagname, $image, $uploadDir);
        $selectArray = array();
        array_push($selectArray, $name, $pathToStore, $userId);
        $sql = "UPDATE user_model SET name=?,portraitImageURL=? WHERE userId= ?";
        $result = dbExec($sql, $selectArray);
        if ($result->rowCount() == 1) {

            $resJson = array("result" => "999", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {

            //bad request
            $resJson = array("result" => "error   ", "code" => "400", "message" => "error");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
