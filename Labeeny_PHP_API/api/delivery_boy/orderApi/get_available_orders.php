<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["zoneNameId"]) &&
    isset($_POST["vehicleTypeId"])
    //&& is_auth()
) {
    $zoneNameId = $_POST["zoneNameId"];
    $vehicleTypeId = $_POST["vehicleTypeId"];

    $firstArray = array();
    array_push($firstArray, htmlspecialchars(strip_tags($vehicleTypeId)));


    $sql = "SELECT * from vehicle_type_model where vehicleTypeId =?";

    $result = dbExec($sql,  $firstArray);

    $minCapacity;
    $maxCapacity;
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        $minCapacity = $row['minCapacity'];
        $maxCapacity = $row['maxCapacity'] - 1;








        $insertArray = array();
        array_push($insertArray, htmlspecialchars(strip_tags($zoneNameId)));
        array_push($insertArray, htmlspecialchars(strip_tags($minCapacity)));
        array_push($insertArray, htmlspecialchars(strip_tags($maxCapacity)));

        $sql = "SELECT * from order_model where targetedDeliveryBoysZoneId =? AND orderStatus=0 AND wholeOrderSize BETWEEN ? AND ?";




        $result = dbExec($sql,  $insertArray);

        $arrJson = array();
        if ($result->rowCount() > 0) {
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                // extract($row);
                $arrJson[] = $row;
            }
            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "empty Fail", "code" => "200", "message" => []);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } else {
        $resJson = array("result" => "fail2", "code" => "400", "message" => "error in vehicleType");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail3", "code" => "400", "message" => "error you must enter value");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
