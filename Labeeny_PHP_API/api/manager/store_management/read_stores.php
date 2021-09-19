<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";
if (
    isset($_POST["mainCategoryId"])
    && isset($_POST["zoneNameId"])
) {
    $mainCategoryId = htmlspecialchars(strip_tags($_POST["mainCategoryId"]));
    $zoneNameId = htmlspecialchars(strip_tags($_POST["zoneNameId"]));

    if ($mainCategoryId == -1 && $zoneNameId == -1) {
        $sql = "SELECT * from store_model  ";
        $result = dbExec($sql,  []);

        $arrJson = array();
        if ($result->rowCount() > 1) {
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                // extract($row);
                $arrJson[] = $row;
            }

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any store");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } elseif ($mainCategoryId == -1 && $zoneNameId != -1) {
        $selectArray = array();
        array_push($selectArray, $zoneNameId);
        $sql = "SELECT * from store_model WHERE zoneNameId=? ";
        $result = dbExec($sql, $selectArray);

        $arrJson = array();
        if ($result->rowCount() > 1) {
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                // extract($row);
                $arrJson[] = $row;
            }

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any store");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } elseif ($mainCategoryId != -1 && $zoneNameId == -1) {

        $selectArray = array();
        array_push($selectArray, $mainCategoryId);
        $sql = "SELECT * from store_model WHERE mainCategoryId=? ";
        $result = dbExec($sql, $selectArray);

        $arrJson = array();
        if ($result->rowCount() > 1) {
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                // extract($row);
                $arrJson[] = $row;
            }

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any store");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } elseif ($mainCategoryId != -1 && $zoneNameId != -1) {
        $selectArray = array();
        array_push($selectArray, $mainCategoryId);
        $sql = "SELECT * from store_model WHERE mainCategoryId=? && zoneNameId=?";
        $result = dbExec($sql, $selectArray);

        $arrJson = array();
        if ($result->rowCount() > 1) {
            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                // extract($row);
                $arrJson[] = $row;
            }

            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            $resJson = array("result" => "fail", "code" => "400", "message" => "No any store");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
