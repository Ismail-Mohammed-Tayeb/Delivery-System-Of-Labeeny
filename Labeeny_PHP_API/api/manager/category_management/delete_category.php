<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["categoryId"])
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

    $deleteArray = array();
    array_push($deleteArray, $categoryId);
    $sql = "delete from category_model WHERE categoryId=?";
    $result = dbExec($sql, $deleteArray);

    $resJson = array("result" => "success", "code" => "200", "message" => "done");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
