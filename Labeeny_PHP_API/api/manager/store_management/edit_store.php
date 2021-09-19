<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";


if (
    isset($_POST["storeId"])
    && isset($_POST["storeName"])
    && isset($_POST["logoImageName"])
    && isset($_POST["logoImage64"])
    && isset($_POST["bannerImageName"])
    && isset($_POST["bannerImage64"])
    && isset($_POST["quote"])

) {
    $storeId = htmlspecialchars(strip_tags($_POST["storeId"]));
    $storeName = htmlspecialchars(strip_tags($_POST["storeName"]));
    $quote = htmlspecialchars(strip_tags($_POST["quote"]));
    $logoImageName = htmlspecialchars(strip_tags($_POST["logoImageName"]));
    $logoImage64 = htmlspecialchars(strip_tags($_POST["logoImage64"]));
    $bannerImageName = htmlspecialchars(strip_tags($_POST["bannerImageName"]));
    $bannerImage64 = htmlspecialchars(strip_tags($_POST["bannerImage64"]));
    if (
        $logoImageName == "" || $logoImage64 == "" || $logoImageName == 'null' || $logoImage64 == 'null'
        || $bannerImageName == "" || $bannerImage64 == "" || $bannerImageName == 'null' || $bannerImage64 == 'null'
    ) {
        $selectArray = array();
        array_push($selectArray, $storeName, $quote, $storeId);
        $sql = "UPDATE store_model SET storeName=?,quote=? WHERE storeId= ?";
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
            unlink("../../../images/vendor/" . $row['portraitImageURL']);
        }
        $image = base64_decode($image64);

        $uploadDir = "../../../images/vendor/";

        $pathToStore = uploadImage($imagname, $image, $uploadDir);
        $selectArray = array();
        array_push($selectArray, $name, $phoneNumber, $pathToStore, $userId);
        $sql = "UPDATE user_model SET name=?,phoneNumber=?,portraitImageURL=? WHERE userId= ?";
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
