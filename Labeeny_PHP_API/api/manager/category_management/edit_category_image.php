<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["categoryId"])
    && isset($_POST['imageName'])
    && isset($_POST['image64'])
) {
    $categoryId = htmlspecialchars(strip_tags($_POST["categoryId"]));
    $selectArray = array();
    array_push($selectArray, $categoryId);
    $sql = "SELECT categoryImage FROM category_model WHERE categoryId=?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        unlink("../../../images/category/" . $row['categoryImage']);
    }
    $imagname = htmlspecialchars(strip_tags($_POST["imageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["image64"]));
    $image = base64_decode($image64);

    $uploadDir = "../../../images/category/";

    $pathToStore = uploadImage($imagname, $image, $uploadDir);
    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($pathToStore)));
    array_push($insertArray, htmlspecialchars(strip_tags($categoryId)));

    $sql = "UPDATE category_model SET category_model.categoryImage = ? WHERE category_model.categoryId=?";
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
