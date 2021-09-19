<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["storeId"])
    && isset($_POST['imageName'])
    && isset($_POST['image64'])
) {
    $storeId = htmlspecialchars(strip_tags($_POST["storeId"]));
    $selectArray = array();
    array_push($selectArray, $storeId);
    $sql = "SELECT productImage FROM product_model WHERE storeId=?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        unlink("../../../images/product/" . $row['productImage']);
    }
    $imagname = htmlspecialchars(strip_tags($_POST["imageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["image64"]));
    $image = base64_decode($image64);

    $uploadDir = "../../../images/product/";

    $pathToStore = uploadImage($imagname, $image, $uploadDir);
    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($pathToStore)));
    array_push($insertArray, htmlspecialchars(strip_tags($storeId)));

    $sql = "UPDATE product_model SET product_model.productImage = ? WHERE product_model.storeId=?";
    $result = dbExec($sql, $insertArray);
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
    $resJson = array("result" => "fail2", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
