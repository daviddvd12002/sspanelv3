<?php
require_once('config.php');
$p_msg = "ERROR";
if(!empty($_POST['stripeToken']))
{
        $stripetoken = $_POST['stripeToken'];
        $userport = $_POST['userport'];
        $amount = $_POST['amount'];
        // Charge the user card:
        $charge = \Stripe\Charge::create(array(
          "amount" => $amount,
          "currency" => "usd",
          "description" => "subscription",
          "source" => $stripetoken,
          "metadata" => array("purchase_order_id" => $userport) // Custom parameter
        ));
        $chargeJson = json_decode($charge);
        if($chargeJson['amount_refunded'] == 0) 
        {
                $p_msg = "Checking payment";

                try {
		        $conn = new PDO("mysql:host=$pay_host; dbname=$pay_name", $pay_username, $pay_password);
			$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			//记录订单
			$sql = "INSERT INTO orders (amount, port) VALUES(?,?)";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(1, $amount);
			$stmt->bindParam(2, $userport);
			$stmt->execute();
			//user
			$sql = "SELECT * FROM user WHERE port='$userport'";
			$stmt = $conn->query($sql);
			if ($stmt->rowCount() ==0){exit ("fail");}
			//读取用户信息
			foreach ($stmt as $row) {
				$expire_time=$row['expire_time'];
				//$transfer_enable = $row['transfer_enable'];
			}
			//计算时间增值
			switch ($amount){
				case 999:
  				$moretime = 90;
  				break;
				case 1899:
 				$moretime = 180;
  				break;
				case 3799:
				$moretime = 360;
				break;		
				default:
  				exit ("fail");
			}
				
			if ($expire_time >time()) {$expire_time = $expire_time+$moretime*86400;}
			else {$expire_time = time()+$moretime*86400;}
					 
			//增加时间
			$sql= "UPDATE user SET expire_time=:expire_time, enable=1, plan='B', transfer_enable=107374182400 WHERE port=:port";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(':port', $userport);
			$stmt->bindParam(':expire_time', $expire_time);
			
			$done = $stmt->execute();
			if ($done){$p_msg = "Transaction completed successfully";}
                }
		catch (PDOException $e) {
			echo $e->getMessage();
		}
		$conn = null;
			
        }
        else
        {
                $p_msg = "Transaction has been failed";
        }
}
else
{
        $p_msg = "Transaction has been failed Token Emp";
}
?>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Message</title>
<style type="text/css">
*{padding:0;margin:0}
body{background:#FFF}
#mydeCms{max-width:560px;margin:50px auto;border:1px solid #D6DFE6;background:#F9F9F9;border-radius:10px;-moz-box-shadow:4px 4px 12px -2px rgba(88,103,125,.5);-webkit-box-shadow:4px 4px 12px -2px rgba(88,103,125,.5);box-shadow:4px 4px 12px -2px rgba(88,103,125,.5)}
#mydeCms h1{font-size:18px;text-indent:20px;line-height:45px;border-bottom:1px solid #D6DFE6;color:#555;position:relative;letter-spacing:2px}
#mydeCms h1 span{font-size:13px;font-style:normal;position:absolute;top:0;right:10px;font-weight:400}
#mydeCms h1 span em{font-size:14px;color:red;font-style:normal;font-weight:400}
#msg{background:#FFF}
#msg table{min-height:100px}
#msg td{padding:8px;line-height:35px;font-size:18px;color:#666}
#msgcontent{padding:5px;border-radius:3px;color:red;letter-spacing:2px}
#copyRight{height:35px;overflow:hidden;line-height:35px;border-top:1px solid #D6DFE6;font-size:12px;color:#666;text-align:center}
#copyRight a{text-decoration:none;color:#666}
#btn{ background:#FFF;}
#btn a{ display:block; text-align:center; width:135px; background:#28B5D6;border-radius:3px; color:#FFF; text-decoration:none; line-height:35px;}
#btn a:hover{background:#20A3C5;}
</style>
</head>
<body>
<div id="mydeCms">
  <h1>Message</h1>
  <div id="msg">
    <table width="100%" border="0" cellpadding="0" cellspacing="1">
      <tr>
        <td valign="middle"><div id="msgcontent"><?php echo $p_msg; ?></div><div id="btn"><table border="0" cellpadding="5" cellspacing="5" align="center" style="margin:0px auto;"><tr><td valign="middle"><a href="/user">Return</a></td></tr></table></div></td>
      </tr>
    </table>
  </div>
  <div id="copyRight">Copyright &copy; <a href="https://www.goodbyefw.com" target="_blank">GoodByeFw</a> All rights reserved. </div>
</div>
</body>
</html>
