<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["categoryId"])
    && isset($_POST["subCategoryName"])
) {
    $categoryId = htmlspecialchars(strip_tags($_POST["categoryId"]));
    $subCategoryName = htmlspecialchars(strip_tags($_POST["subCategoryName"]));
    $selectArray = array();
    array_push($selectArray, $subCategoryName);
    array_push($selectArray, $categoryId);

    $sql = "INSERT INTO sub_category_model (subCategoryName,maincategoryId) VALUES (?,?) ";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {

        //bad request
        $resJson = array("result" => "fail", "code" => "400", "message" => "error");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
