
<?php
require_once('vendor/autoload.php');

$stripe = array(
  "secret_key"      => "sk_test_",
  "publishable_key" => "pk_test_"
);

\Stripe\Stripe::setApiKey($stripe['secret_key']);

//dbconf
$pay_host = '';
$pay_name = 'sspanelv3';
$pay_username = 'sspanelv3';
$pay_password = '';

?>
