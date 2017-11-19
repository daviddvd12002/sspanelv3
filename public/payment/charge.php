<?php
require_once('config.php');
if(!empty($_POST['stripeToken']))
{
        $stripetoken = $_POST['stripeToken'];
        // Charge the user card:
        $charge = \Stripe\Charge::create(array(
          "amount" => 999,
          "currency" => "usd",
          "description" => "3 months",
          "source" => $stripetoken,
          "metadata" => array("purchase_order_id" => "8012") // Custom parameter
        ));
        $chargeJson = json_decode($charge);
        if($chargeJson['amount_refunded'] == 0) 
        {
                echo "Transaction completed successfully";
                echo $chargeJson['amount_refounded'];
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
