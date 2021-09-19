<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";


if (
    isset($_POST["storeId"])
    && isset($_POST["subCategoryId"])
    && isset($_POST["productName"])
    && isset($_POST["productDescription"])
    && isset($_POST["productPrice"])
    && isset($_POST["productSize"])
    && isset($_POST['imageName'])
    && isset($_POST['image64'])

    // && is_auth()

) {

    $storeId = $_POST["storeId"];
    $subCategoryId = $_POST["subCategoryId"];
    $productName = $_POST["productName"];
    $productDescription = $_POST["productDescription"];
    $productPrice = $_POST["productPrice"];
    $productSize = $_POST["productSize"];
    $imagname = htmlspecialchars(strip_tags($_POST["imageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["image64"]));
    $image = base64_decode($image64);

    $uploadDir = "../../../images/product/";

    $pathToStore = uploadImage($imagname, $image, $uploadDir);

    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($storeId)));
    array_push($insertArray, htmlspecialchars(strip_tags($subCategoryId)));
    array_push($insertArray, htmlspecialchars(strip_tags($productName)));
    array_push($insertArray, htmlspecialchars(strip_tags($productDescription)));
    array_push($insertArray, htmlspecialchars(strip_tags($pathToStore)));
    array_push($insertArray, htmlspecialchars(strip_tags($productPrice)));
    array_push($insertArray, htmlspecialchars(strip_tags($productSize)));



    $sql = "INSERT INTO product_model (storeId, subCategoryId, productName, productDescription, productImage, productPrice, productSize) 
    VALUES (?,?,?,?,?,?,?)";
    $result = dbExec($sql, $insertArray);



    if ($result->rowCount() > 0) {
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "fail1", "code" => "400", "message" => "error1");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail2", "code" => "400", "message" => "error2");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
