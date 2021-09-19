<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
include_once "../../push_notification/delivery_boy/handle_delivery_boy_notification.php";


if (
    isset($_POST["storeId"])
    && isset($_POST["customerId"])
    && isset($_POST["wholeCartPrice"])
    && isset($_POST["deliveryFee"])
    && isset($_POST["cartProductDetails"])
    && isset($_POST["wholeOrderSize"])
    && isset($_POST["orderLocation"])
    && isset($_POST["orderNote"])
    && isset($_POST["orderQr"])
    && isset($_POST["submittionDate"])
    && isset($_POST["targetedDeliveryBoysZoneId"])
    // && is_auth()

) {


    $storeId = $_POST["storeId"];
    $customerId = $_POST["customerId"];
    $wholeCartPrice = $_POST["wholeCartPrice"];
    $deliveryFee = $_POST["deliveryFee"];
    $cartProductDetails = $_POST["cartProductDetails"];
    $wholeOrderSize = $_POST["wholeOrderSize"];
    $orderLocation = $_POST["orderLocation"];
    $orderNote = $_POST["orderNote"];
    $orderQr = $_POST["orderQr"];
    $submittionDate = $_POST["submittionDate"];
    $targetedDeliveryBoysZoneId = $_POST["targetedDeliveryBoysZoneId"];





    $insertArray = array();

    array_push($insertArray, htmlspecialchars(strip_tags($storeId)));
    array_push($insertArray, htmlspecialchars(strip_tags($customerId)));
    array_push($insertArray, htmlspecialchars(strip_tags($wholeCartPrice)));
    array_push($insertArray, htmlspecialchars(strip_tags($deliveryFee)));
    array_push($insertArray, htmlspecialchars(strip_tags($cartProductDetails)));
    array_push($insertArray, htmlspecialchars(strip_tags($wholeOrderSize)));
    array_push($insertArray, htmlspecialchars(strip_tags($orderLocation)));
    array_push($insertArray, htmlspecialchars(strip_tags($orderNote)));
    array_push($insertArray, htmlspecialchars(strip_tags($orderQr)));
    array_push($insertArray, htmlspecialchars(strip_tags($submittionDate)));
    array_push($insertArray, htmlspecialchars(strip_tags($targetedDeliveryBoysZoneId)));
    $sql = "INSERT INTO order_model (storeId, customerId, wholeCartPrice, deliveryFee, cartProductDetails,wholeOrderSize,orderLocation,orderNote,orderQr,submittionDate,targetedDeliveryBoysZoneId,orderStatus) 
    VALUES (?,?,?,?,?,?,?,?,?,?,?,0)";
    $result = dbExec($sql, $insertArray);



    if ($result->rowCount() > 0) {
        $resJson = array("result" => "success", "code" => "200", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        $insertArray = array();
        array_push($insertArray, htmlspecialchars(strip_tags($targetedDeliveryBoysZoneId)));
        $sql = "SELECT deviceToken 
        FROM user_model JOIN delivery_boy_model ON user_model.userId=delivery_boy_model.userId WHERE zoneNameId=?";
        $result = dbExec($sql, $insertArray);

        $title = "تنبيه";
        $msg = "يوجد لديك طلبات جديدة يمكنك تلبيتها، كن سباقاً لها";
        if ($result->rowCount() > 0) {
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                $targeDeliveryBoyToken = $row['deviceToken'];
                if ($targeDeliveryBoyToken != null) {
                    sendFCM($title, $msg, $targeDeliveryBoyToken, "1", "w");
                }
            }
        }
        // $final = new DeliveryBoyNotification;
        // $final->sendNotificationToTargetDelivery($targetedDeliveryBoysZoneId);
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
