<?php
require_once('config.php');
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
                echo "Transaction completed successfully";
                echo $amount;
                echo $userport;
        //      print_r($chargeJson);
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
			$sql= "UPDATE user SET expire_time=:expire_time, enable=1, plan=B, transfer_enable=107374182400 WHERE port=:port";
			$stmt = $conn->prepare($sql);
			$stmt->bindParam(':port', $userport);
			$stmt->bindParam(':expire_time', $expire_time);
			
			$done = $stmt->execute();
			if ($done){echo 'success';}
                }
		catch (PDOException $e) {
			echo $e->getMessage();
		}
		$conn = null;
			
        }
        else
        {
                echo "Transaction has been failed";
        }
}
else
{
        echo "Transaction has been failed Token Emp";
}
?>
