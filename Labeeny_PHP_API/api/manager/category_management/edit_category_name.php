<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["categoryId"])
    && isset($_POST["categoryName"])
) {
    $categoryId = htmlspecialchars(strip_tags($_POST["categoryId"]));
    $categoryName = htmlspecialchars(strip_tags($_POST["categoryName"]));
    $selectArray = array();
    array_push($selectArray, $categoryName);
    array_push($selectArray, $categoryId);

    $sql = "UPDATE category_model SET category_model.categoryName=? WHERE category_model.categoryId=?";
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
