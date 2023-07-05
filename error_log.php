<?php
echo "Hello World";
function checkForErrors() {
    $lastError = error_get_last();

    if ($lastError !== null && $lastError['type'] === E_ERROR) {
        // Handle the error
        echo "An error occurred: " . $lastError['message'];
    } else {
        echo "No errors found.";
    }
}

checkForErrors();
