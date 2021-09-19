<?php
include_once "database.php";

const token = "wjeiwenwejwkejwke98w9e8wewnew8wehwenj232jh32j3h2j3h2j";
function dbExec($sql, $param_array)
{
    $database = new Database();
    $database->getConnection();
    $myCon = $database->conn;
    $stmt = $myCon->prepare($sql);
    $stmt->execute($param_array);
    return $stmt;
}


function is_auth()
{

    $headers = getallheaders();
    if (isset($headers['userinfo'])) {
        $user_info = base64_decode($headers['userinfo']);

        list($user, $pass) = explode(":", $user_info);

        $selectArray = array();
        array_push($selectArray, $user);
        array_push($selectArray, $pass);

        $sql = "select * from user_model where phoneNumber=? and password=?";
        $result = dbExec($sql, $selectArray);
        if ($result->rowCount() == 1) {
            $row = $result->fetch(PDO::FETCH_ASSOC);
            // if (password_verify($pass, $row['password'])) {
            return true;
        } else {

            return false;
        }
    } else {

        return false;
    }
}
function generateRandomString($length = 6)
{
    $characters = '123456789';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}
function uploadImage($imagname, $image, $uploadDir)
{

    $image_width = 1000;

    file_put_contents($uploadDir . $imagname, $image);
    $oldImagePath = $uploadDir . $imagname;
    list($width, $height, $type, $attr) = getimagesize($oldImagePath);
    //echo $width;
    $imagePath = '';
    // $thumbnailPath = '';
    $ext = substr(strrchr($imagname, "."), 1);
    $imagePath = md5(rand() * time()) . ".$ext";

    //echo "after";
    $result    = createThumbnail($oldImagePath, $uploadDir . $imagePath, $image_width);
    $imagePath = $result;

    unlink($oldImagePath);

    return $imagePath;
}
function createThumbnail($srcFile, $destFile, $width, $quality = 75)
{
    $thumbnail = '';

    if (file_exists($srcFile)  && isset($destFile)) {
        $size        = getimagesize($srcFile);
        $w           = number_format($width, 0, ',', '');
        $h           = number_format($width, 0, ',', '');

        // $h           = number_format(($size[1] / $size[0]) * $width, 0, ',', '');

        $thumbnail =  copyImage($srcFile, $destFile, $w, $h, $quality);
    }

    // return the thumbnail file name on sucess or blank on fail
    return basename($thumbnail);
}

/*
	Copy an image to a destination file. The destination
	image size will be $w X $h pixels
*/


function copyImage($srcFile, $destFile, $w, $h, $quality = 75)
{
    $tmpSrc     = pathinfo(strtolower($srcFile));
    $tmpDest    = pathinfo(strtolower($destFile));
    $size       = getimagesize($srcFile);

    if (
        $tmpDest['extension'] == "gif" || $tmpDest['extension'] == "jpg"
        || $tmpDest['extension'] == "jpeg"
        || $tmpDest['extension'] == "bmp" || $tmpDest['extension'] == "mpeg"
    ) {
        $destFile  = substr_replace($destFile, 'jpg', -3);
        $dest      = imagecreatetruecolor($w, $h);
        imageantialias($dest, TRUE);
    } elseif ($tmpDest['extension'] == "png") {
        /*   $dest = imagecreatetruecolor($w, $h);
	   $white = imagecolorallocate($dest, 255, 255, 255); 
	   imagefill($dest,0,0,$white);
       imageantialias($dest, TRUE);*/

        $dest = imagecreatetruecolor($w, $h);
        $background = imagecolorallocate($dest, 255, 255, 255);
        imagecolortransparent($dest, $background);
        imagealphablending($dest, false);
        imagesavealpha($dest, true);
    } else {
        return false;
    }

    switch ($size[2]) {
        case 1:       //GIF
            $src = imagecreatefromgif($srcFile);
            break;
        case 2:       //JPEG
            $src = imagecreatefromjpeg($srcFile);
            break;
        case 3:       //PNG
            $src = imagecreatefrompng($srcFile);
            break;
        default:
            return false;
            break;
    }

    imagecopyresampled($dest, $src, 0, 0, 0, 0, $w, $h, $size[0], $size[1]);

    switch ($size[2]) {
        case 1:
        case 2:
            imagejpeg($dest, $destFile, $quality);
            break;
        case 3:
            imagepng($dest, $destFile);
    }
    return $destFile;
}

function sendFCM($title, $message, $fcm_id, $p_id, $p_name)
{
    //$message = utf8_decode($message);

    $url = 'https://fcm.googleapis.com/fcm/send';

    $fields = array(
        'registration_ids' => array(
            $fcm_id
        ),
        'priority' => 'high',
        'content_available' => true,

        'notification' => array(
            "body" =>  $message,
            "title" =>  $title,
            "click_action" => "NOTIFICATION_CLICK"/*FLUTTER_NOTIFICATION_CLICK*/,
            "sound" => "default"

        ),
        'data' => array(
            "page_id" => $p_id,
            "page_name" => $p_name
            //			'message' => 'Hello World!'
        )

    );
    $fields = json_encode($fields);

    $headers = array(
        // 'Authorization: key=' . "AIzaSyBUuLepXI4xjIuWBO78hagHX9ntj9j_mU4",
        'Authorization: key=' . "AAAAgYdJMQE:APA91bEgDKltkvtORXNBJW_oB7hIDjrq8WmbfrjrBC3-QNcH9DUTc7fTmmPSHkyKu95ooDZRMmLO6TB6egC-X2q5ZsK1nc6F5OFzNxOlgLv5iGVwqMl57KtX5KBnZl6X58EU6Q7WzduU",
        'Content-Type: application/json'
    );

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);

    $result = curl_exec($ch);
    return $result;
    curl_close($ch);
}
