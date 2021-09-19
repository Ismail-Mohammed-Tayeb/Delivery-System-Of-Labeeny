<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["storeId"])
    //&& is_auth()
) {




    $storeId = $_POST["storeId"];
    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($storeId)));
    $sql = "SELECT * from store_model where storeId =? ";
    $result = dbExec($sql,  $insertArray);

    $arrJson = array();
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        // extract($row);
        $arrJson = $row;

        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        $resJson = array("result" => "fail", "code" => "400", "message" => "No any category");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
