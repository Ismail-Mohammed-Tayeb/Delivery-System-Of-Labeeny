
<?php


function sendGCM($title, $message, $fcm_id, $p_id, $p_name)
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
            "click_action" => "FLUTTER_NOTIFICATION_CLICK",
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


?>


