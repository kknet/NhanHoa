<?php
    $passphrase = 'nhanhoa123456';

    $ctx = stream_context_create();
	stream_context_set_option($ctx, 'ssl', 'local_cert', 'releaseck.pem');
    stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

    $errstr = '';
    // Open a connection to the APNS server
    $fp = stream_socket_client('ssl://gateway.push.apple.com:2195', $err,
                               $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);
    //  $host = 'gateway.sandbox.push.apple.com;
    //  $host = 'gateway.push.apple.com';
    
    if (!$fp)
        exit("Failed to connect amarnew: $err $errstr" . PHP_EOL);

        echo 'Connected to APNS' . PHP_EOL;
   $deviceToken = $_REQUEST["deviceToken"];
   $callid = $_REQUEST["callid"];

    $message = "This is message from NhanHoa";
    $body['aps'] = array(
                          'badge' => +1,
                          'alert' => $message,
                          'sound' => 'default'
                          );
    
    $payload = json_encode($body);
    $deviceToken = '6529d4d355b8150a382d998e48af254953e5a1f059aab914b21dba518465561e';
    
    // Build the binary notification
    $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

    // Send it to the server
    $result = fwrite($fp, $msg, strlen($msg));

    if (!$result)
    echo 'Message not delivered' . PHP_EOL;
    else
    echo 'Message successfully delivered amar' .$message. PHP_EOL;

    // Close the connection to the server
    fclose($fp);
?>
