<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["vendorId"])
    && isset($_POST["storeName"])
    && isset($_POST["logoImageName"])
    && isset($_POST["logoImage64"])
    && isset($_POST["bannerImageName"])
    && isset($_POST["bannerImage64"])
    && isset($_POST["quote"])
    && isset($_POST["mainCategoryId"])
    && isset($_POST["location"])
    && isset($_POST["zoneNameId"])
) {
    $imagname = htmlspecialchars(strip_tags($_POST["logoImageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["logoImage64"]));
    $image = base64_decode($image64);
    $uploadDir = "../../../images/store/logo/";
    $logoImage = uploadImage($imagname, $image, $uploadDir);

    $imagname = htmlspecialchars(strip_tags($_POST["bannerImageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["bannerImage64"]));
    $image = base64_decode($image64);
    $uploadDir = "../../../images/store/banner/";
    $bannerImage = uploadImage($imagname, $image, $uploadDir);

    $vendorId = htmlspecialchars(strip_tags($_POST["vendorId"]));
    $storeName = htmlspecialchars(strip_tags($_POST["storeName"]));
    $quote = htmlspecialchars(strip_tags($_POST["quote"]));
    $mainCategoryId = htmlspecialchars(strip_tags($_POST["mainCategoryId"]));
    $location = htmlspecialchars(strip_tags($_POST["location"]));
    $zoneNameId = htmlspecialchars(strip_tags($_POST["zoneNameId"]));
    $selectArray = array();
    array_push($selectArray, $vendorId);
    array_push($selectArray, $storeName);
    array_push($selectArray, $logoImage);
    array_push($selectArray, $bannerImage);
    array_push($selectArray, $quote);
    array_push($selectArray, $mainCategoryId);
    array_push($selectArray, $location);
    array_push($selectArray, $zoneNameId);
    $sql = "INSERT INTO store_model (vendorId,storeName,logoImage,bannerImage,quote,mainCategoryId,location,zoneNameId)
     VALUES (?,?,?,?,?,?,?,?) ";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {

        //bad request
        $resJson = array("result" => "fail1", "code" => "400", "message" => "error");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
