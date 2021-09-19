<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";


if (
    isset($_POST["vendorId"])
    && isset($_POST["storeId"])
    && isset($_POST["mainCategoryId"])
    && isset($_POST["requestDate"])
    && isset($_POST["subCategoryName"])


    // && is_auth()

) {

    $vendorId = $_POST["vendorId"];
    $storeId = $_POST["storeId"];
    $mainCategoryId = $_POST["mainCategoryId"];
    $requestDate = $_POST["requestDate"];
    $subCategoryName = $_POST["subCategoryName"];



    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($vendorId)));
    array_push($insertArray, htmlspecialchars(strip_tags($storeId)));
    array_push($insertArray, htmlspecialchars(strip_tags($mainCategoryId)));
    array_push($insertArray, htmlspecialchars(strip_tags($subCategoryName)));
    array_push($insertArray, htmlspecialchars(strip_tags($requestDate)));

    $sql = "INSERT INTO sub_category_request_model (vendorId, storeId, mainCategoryId, subCategoryName, requestDate) 
    VALUES (?,?,?,?,?)";
    $result = dbExec($sql, $insertArray);



    if ($result->rowCount() > 0) {
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "fail1", "code" => "600", "message" => "error1");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail2", "code" => "400", "message" => "error2");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
