<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["txtSearch"])

    && is_auth()
) {


    $txtsearch = $_POST["txtSearch"];
    $selectArray = array();

    array_push($selectArray, "%" . htmlspecialchars(strip_tags($txtsearch)) . "%");
    if (trim($txtsearch) != "") {
        $sql = "SELECT category_model.categoryId FROM category_model WHERE category_model.categoryName LIKE ? ";
        $result = dbExec($sql, $selectArray);
        $arrJson = array();
        if ($result->rowCount() > 0) {

            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {

                $arrJson[] = $row;
            }
            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "لا يوجد نتائج", "code" => "400", "message" => "error");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {

        $resJson = array("result" => "لا يوجد نص بحث", "code" => "400", "message" => "error");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
