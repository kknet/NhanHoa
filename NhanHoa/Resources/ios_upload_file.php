<?php
    $name = $_FILES["uploadedfile"]["name"];
    $folder = "uploads";
    if (($_FILES["uploadedfile"]["type"] == "image/gif")
         || ($_FILES["uploadedfile"]["type"] == "image/jpeg")
         || ($_FILES["uploadedfile"]["type"] == "image/jpg")
         || ($_FILES["uploadedfile"]["type"] == "image/pjpeg")
         || ($_FILES["uploadedfile"]["type"] == "image/x-png")
         || ($_FILES["uploadedfile"]["type"] == "image/png")) {
        if ($_FILES["uploadedfile"]["error"] > 0)
        {
            echo "Error";
        } else {
            if (file_exists($folder."/". $_FILES["uploadedfile"]["name"])) {
                echo "already exists";
            } else {
                move_uploaded_file($_FILES["uploadedfile"]["tmp_name"], "uploads/" . $name);
                echo $folder. "/" . $name;
            }
        }
    } else {
        echo "Error";
    }
?>
