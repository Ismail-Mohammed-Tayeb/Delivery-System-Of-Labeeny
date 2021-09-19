<?php
include "sendnotify.php";
$msg = "هذه الرسالة تجريبية سنقوم بتجربة الغير مجرب لأن المجرب افضل من غير المجرب كما ان التجريب بغلب الشجاعة والكثرة تغلت الشجاعة ايضا نستنتج من ذلك ان الجو جميل وصافي جد";
$title = "اخبار جديدة عن التجريب";
sendGCM($title, $msg, "dbXX4T8RTYK4uICIrqe4Vm:APA91bGPOnkicIIlgM-SV8FXD64aYtEVOkFeZM9q9xfevK7y2aDcfrtd_EnzJoPETeeQHj4QElB8-SoBkn9cphhEtvvf2tMfgGIoMegFnOCh5SyR-wlRPSlmRYryXBg-Qmc6zHLcg9yr", "1", "w");
echo "done";
