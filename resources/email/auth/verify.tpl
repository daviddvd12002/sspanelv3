<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
</head>
<body>
  <p>Dear user：</p>
  <p>Your verification code is: <b>{$verification->token}</b>.<br>(Validity period {$ttl} minutes)</p><br>
  <p>{$config["appName"]}</p>
</body>
</html>
