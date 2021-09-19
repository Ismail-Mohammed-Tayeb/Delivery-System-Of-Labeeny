<?php
$sub = "سلطة ,فواكه, جزر ,خضرة";
$l = array();
$l = explode(",", $sub);
foreach ($l as  $value) {
    echo $value;
    echo  "\n";
}
