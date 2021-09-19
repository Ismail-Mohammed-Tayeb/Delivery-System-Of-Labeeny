<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../../library/function.php";


if (
    isset($_POST["requestId"])
    && isset($_POST['responseMessage'])
    && isset($_POST['managerId'])
    && isset($_POST['responseStatus'])
    && isset($_POST['subCategoryName'])
    && isset($_POST['mainCategoryId'])

) {


    $requestId = $_POST["requestId"];
    $responseMessage = $_POST["responseMessage"];
    $managerId = $_POST["managerId"];
    $responseStatus = $_POST["responseStatus"];
    $mainCategoryId = $_POST["mainCategoryId"];
    $subCategoryName = $_POST["subCategoryName"];

    if ($responseStatus == 2) {

        $insertArray = array();
        array_push($insertArray, htmlspecialchars(strip_tags($responseStatus)));
        array_push($insertArray, htmlspecialchars(strip_tags($responseMessage)));
        array_push($insertArray, htmlspecialchars(strip_tags($managerId)));
        array_push($insertArray, htmlspecialchars(strip_tags($requestId)));

        $sql = "UPDATE sub_category_request_model SET responseStatus = ?,responseMessage=?,managerId=?,responseDate=NOW() WHERE requestId=? ";
        $result = dbExec($sql, $insertArray);


        if ($result->rowCount() == 1) {
            $insertArray = array();
            array_push($insertArray, htmlspecialchars(strip_tags($subCategoryName)));
            array_push($insertArray, htmlspecialchars(strip_tags($mainCategoryId)));
            $sql = "INSERT INTO sub_category_model (subCategoryName,mainCategoryId) VALUES (?,?) ";
            $result1 = dbExec($sql, $insertArray);
            if ($result1->rowCount() == 1) {
                $resJson = array("result" => "200", "code" => "200", "message" => "done");
                echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
            } else {
                //bad request
                $resJson = array("result" => "   1خطأ بالادخال ", "code" => "400", "message" => "false");
                echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
            }
        } else {
            //bad request
            $resJson = array("result" => "   2خطأ بالادخال ", "code" => "400", "message" => "false");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    } elseif ($responseStatus == 0) {
        $insertArray = array();
        array_push($insertArray, htmlspecialchars(strip_tags($responseStatus)));
        array_push($insertArray, htmlspecialchars(strip_tags($responseMessage)));
        array_push($insertArray, htmlspecialchars(strip_tags($managerId)));
        array_push($insertArray, htmlspecialchars(strip_tags($requestId)));

        $sql = "UPDATE sub_category_request_model SET responseStatus = ?,responseMessage=?,managerId=?,responseDate=NOW() WHERE requestId=? ";
        $result = dbExec($sql, $insertArray);



        if ($result->rowCount() == 1) {
            $resJson = array("result" => "200", "code" => "200", "message" => "done");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            //bad request
            $resJson = array("result" => "   1خطأ بالادخال ", "code" => "400", "message" => "false");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
    }
} else {
    //bad request
    $resJson = array("result" => "fail", "code" => "400", "message" => "error");
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}
