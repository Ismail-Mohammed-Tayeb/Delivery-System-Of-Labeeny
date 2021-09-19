<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["subCategoryId"])
    && isset($_POST["subCategoryName"])
) {
    $subCategoryId = htmlspecialchars(strip_tags($_POST["subCategoryId"]));
    $subCategoryName = htmlspecialchars(strip_tags($_POST["subCategoryName"]));
    $selectArray = array();
    array_push($selectArray, $subCategoryName);
    array_push($selectArray, $subCategoryId);

    $sql = "UPDATE sub_category_model SET sub_category_model.subCategoryName=? WHERE sub_category_model.subCategoryId=?";
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
