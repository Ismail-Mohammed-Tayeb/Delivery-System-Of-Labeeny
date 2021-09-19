<?php
include_once "../../../library/function.php";
class DeliveryBoyNotification
{

    public function sendNotificationToTargetDelivery($zoneNameId)
    {
        $insertArray = array();
        array_push($insertArray, htmlspecialchars(strip_tags($zoneNameId)));
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
    }
}
