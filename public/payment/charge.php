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
