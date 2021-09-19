<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["productId"])
    && isset($_POST["isApproved"])
) {
    $productId = htmlspecialchars(strip_tags($_POST["productId"]));
    $isApproved = htmlspecialchars(strip_tags($_POST["isApproved"]));
    if ($isApproved == -1) {
        $selectArray = array();
        array_push($selectArray, $productId);
        $sql = "DELETE from product_model where productId = ?";
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
        $selectArray = array();
        array_push($selectArray, $isApproved);
        array_push($selectArray, $productId);

        $sql = "UPDATE product_model SET isApproved=? WHERE productId=?";
        $result = dbExec($sql, $selectArray);
        if ($result->rowCount() == 1) {
            $resJson = array("result" => "success", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {

            //bad request
            $resJson = array("result" => "fail", "code" => "400", "message" => "error");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
