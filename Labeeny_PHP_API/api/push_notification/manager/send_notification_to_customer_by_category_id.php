<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include_once "../../../library/function.php";

if (
    isset($_POST["categoryId"])
    && isset($_POST["title"])
    && isset($_POST["body"])

) {




    $categoryId = $_POST["categoryId"];
    $title = htmlspecialchars(strip_tags($_POST["title"]));
    $msg = htmlspecialchars(strip_tags($_POST["body"]));


    if ($categoryId == -1) {
        $insertArray = array();
        $sql = "SELECT DISTINCT user_model.deviceToken FROM user_model WHERE user_model.userType=3";
        $result = dbExec($sql,  $insertArray);
        if ($result->rowCount() > 0) {
            $tx = array();
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                 $targeDeliveryBoyToken = $row['deviceToken'];
                if ($targeDeliveryBoyToken != null) {
                    sendFCM($title, $msg, $targeDeliveryBoyToken, "1", "w");
                }
            }
            $resJson = array("result" => "success", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any customer");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {
        $insertArray = array();
        array_push($insertArray, htmlspecialchars(strip_tags($categoryId)));
        $sql = "SELECT DISTINCT user_model.deviceToken FROM user_model JOIN order_model ON user_model.userId=order_model.customerId JOIN 
    store_model ON order_model.storeId=store_model.storeId WHERE store_model.mainCategoryId=?";
        $result = dbExec($sql,  $insertArray);

        $arrJson = array();

        if ($result->rowCount() > 0) {
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                $targeDeliveryBoyToken = $row['deviceToken'];
                if ($targeDeliveryBoyToken != null) {
                    sendFCM($title, $msg, $targeDeliveryBoyToken, "1", "w");
                }
            }
            $resJson = array("result" => "success", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any customer");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
