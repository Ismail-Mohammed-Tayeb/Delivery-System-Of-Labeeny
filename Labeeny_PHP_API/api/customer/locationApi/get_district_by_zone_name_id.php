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
    $sql = "SELECT district_model.* FROM zone_name_model JOIN district_model ON
     zone_name_model.districtId=district_model.districtId WHERE zone_name_model.zoneNameId=? ";
    $result = dbExec($sql,  $insertArray);

    $arrJson = array();
    if ($result->rowCount() == 1) {
        $row = $result->fetch(PDO::FETCH_ASSOC);
        // extract($row);
        $arrJson = $row;

        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        $resJson = array("result" => "fail", "code" => "400", "message" => "No any district");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
