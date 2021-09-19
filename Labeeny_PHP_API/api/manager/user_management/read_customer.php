<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    // isset($_POST["offset"])
    // && is_numeric($_POST["offset"])
    // && isset($_POST["pagesize"])
    // && is_numeric($_POST["pagesize"])

    true
) {
    //$offset = $_POST["offset"];
    // $pagesize = $_POST["pagesize"];


    $txtsearch = !isset($_POST["txtsearch"])   ? "" : $_POST["txtsearch"];
    $selectArray = array();

    array_push($selectArray, "%" . htmlspecialchars(strip_tags($txtsearch)) . "%");
    array_push($selectArray, "%" . htmlspecialchars(strip_tags($txtsearch)) . "%");
    if (trim($txtsearch) != "") {
        $sql = "SELECT user_model.*, customer_model.location 
        FROM user_model JOIN customer_model ON customer_model.UserId=user_model.userId 
         where  name like ?  OR phoneNumber like ? order by userId desc ";
        $result = dbExec($sql, $selectArray);
    } else {
        $sql = "SELECT user_model.*, customer_model.location 
        FROM user_model JOIN customer_model ON customer_model.UserId=user_model.userId 
         order by userId desc";
        $result = dbExec($sql, []);
    }
    $arrJson = array();
    if ($result->rowCount() > 0) {
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            // extract($row);
            $arrJson[] = $row;
        }
    }
    $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
