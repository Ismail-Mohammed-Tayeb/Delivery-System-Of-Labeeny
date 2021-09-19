<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["zoneNameId"])
    //&& is_auth()
) {




    $zoneNameId = $_POST["zoneNameId"];
    $insertArray = array();
    array_push($insertArray, htmlspecialchars(strip_tags($zoneNameId)));
    $sql = "SELECT zone_name_model.zoneNameId,zone_name_model.zoneName, district_model.districtName from zone_name_model JOIN district_model
     ON district_model.districtId=zone_name_model.districtId where zoneNameId =? ";
    $result = dbExec($sql,  $insertArray);

    $arrJson = array();
    if ($result->rowCount() == 1) {
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            // extract($row);
            $arrJson = $row;
        }
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        $resJson = array("result" => "fail1", "code" => "400", "message" => "No any category");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail2", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
