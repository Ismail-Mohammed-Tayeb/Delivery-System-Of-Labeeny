<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["productId"])
) {
    $productId = htmlspecialchars(strip_tags($_POST["productId"]));
    $selectArray = array();
    array_push($selectArray, $productId);
    $sql = "SELECT productImage FROM product_model WHERE productId=?";
    $result = dbExec($sql, $selectArray);
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        unlink("../../../images/product/" . $row['productImage']);
    }

    $deleteArray = array();
    array_push($deleteArray, $productId);
    $sql = "delete from product_model WHERE productId=?";
    $result = dbExec($sql, $deleteArray);

    $resJson = array("result" => "success", "code" => "200", "message" => "done");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
