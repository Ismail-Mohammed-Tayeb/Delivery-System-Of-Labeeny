<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
include_once "../../../library/database.php";

if (
    isset($_POST["categoryName"])
    && isset($_POST['imageName'])
    && isset($_POST['image64'])
    && isset($_POST['subCategoryName'])

) {

    $categoryName = $_POST["categoryName"];
    $subCategoryName = $_POST["subCategoryName"];
    $item = array();
    $item = explode(",", $subCategoryName);
    $imagname = htmlspecialchars(strip_tags($_POST["imageName"]));
    $image64 = htmlspecialchars(strip_tags($_POST["image64"]));
    $image = base64_decode($image64);

    $uploadDir = "../../../images/category/";

    $pathToStore = uploadImage($imagname, $image, $uploadDir);
    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($categoryName)));
    array_push($insertArray, htmlspecialchars(strip_tags($pathToStore)));



    $sql = "INSERT INTO category_model (categoryName,categoryImage) VALUES (?,?) ";
    $database = new Database();
    $database->getConnection();
    $myCon = $database->conn;
    $result = $myCon->prepare($sql);
    $result->execute($insertArray);


    if ($result->rowCount() == 1) {
        $newId = $myCon->lastInsertId();
        foreach ($item as  $value) {
            $insertArray = array();
            array_push($insertArray, htmlspecialchars(strip_tags($value)));
            array_push($insertArray, htmlspecialchars(strip_tags($newId)));
            $sql = "INSERT INTO sub_category_model (subCategoryName,mainCategoryId) VALUES (?,?) ";
            $result1 = dbExec($sql, $insertArray);
        }


        $resJson = array("result" => "200", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "   1خطأ بالادخال ", "code" => "400", "message" => "false");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
