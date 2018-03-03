<?php

//登录配置 $username - $userport 简单防止注入
$userport = addslashes(sprintf(htmlspecialchars($_GET['port'])));//端口
$password = addslashes(sprintf(htmlspecialchars($_GET['passwd'])));//ss密码

//数据库配置
$db_host = 'localhost';$db_user = 'root';$db_pw = '';$db_name = '1010';
$con = mysqli_connect($db_host, $db_user, $db_pw, $db_name) or die("Connection error." . mysqli_error());

//$login_code 查询 判断状态1/0
$sql = "SELECT IF( EXISTS (SELECT * FROM `user` WHERE `user`.port = '".$userport."' AND `user`.passwd = '".$password."') ,1 ,0) AS flag";
$login_code = mysqli_fetch_array(mysqli_query($con, $sql));

if($login_code['flag']=="1") {//验证状态重写了

    function get_ssr_url($server_id,$userport,$password,$db_host,$db_user,$db_pw,$db_name,$group_name,$group_name_base64,$after_obfs,$after_server_name,$after_group,$after_ssr_url) {
    //获取服务器配置
    $con = mysqli_connect($db_host, $db_user, $db_pw, $db_name) or die("Connection error.".mysqli_error());
    $sql = "SELECT * FROM `ss_node` WHERE `id` = '".$server_id."'";
    $server_config = mysqli_fetch_array(mysqli_query($con, $sql));
    $ssrurl_prefix = $server_config['server'] . ":" . $userport . ":" . "origin" . ":" . "aes-128-cfb" . ":" . "plain" . ":" . rtrim(strtr(base64_encode($password), '+/', '-_'), '=');
    $ssrurl_suffix = '/?' . "obfsparam=" . rtrim(strtr(base64_encode("bing.com"), '+/', '-_'), '=') . "&protoparam=" . rtrim(strtr(base64_encode(""), '+/', '-_'), '=') . "&remarks=" . rtrim(strtr(base64_encode($server_config['name']), '+/', '-_'), '=') . "&group=" . rtrim(strtr(base64_encode("AW"), '+/', '-_'), '=') ;  
    $ssqr = "ssr://" . rtrim(strtr(base64_encode($ssrurl_prefix . $ssrurl_suffix), '+/', '-_'), '=') . "\r\n";
    return $ssqr;
    }

    $mysqli = mysqli_init();
    $mysqli->options(MYSQLI_OPT_CONNECT_TIMEOUT, 2);//设置超时时间,以秒为单位的连接超时时间
    $mysqli->real_connect("$db_host","$db_user","$db_pw","$db_name");
    $mysqli->set_charset("utf8");
    $sql1 = "SELECT `id` FROM `ss_node` where `type` = '1' ";
    $result = $mysqli->query($sql1);
    if($result === false)
    {
        die('!数据库连接失败：(' . $mysqli->connect_errno . ') '. $mysqli->connect_error);
    }


    $array = array();
    while($row=$result->fetch_row()){
    $server_id = $row[0];
    $server_ssr_url= get_ssr_url("$server_id","$userport","$password","$db_host","$db_user","$db_pw","$db_name","$group_name","$group_name_base64","$after_obfs","$after_server_name","$after_group","$after_ssr_url");
    array_push($array, $server_ssr_url);
    }

    $server_all_url_1 = implode($array);
    $server_all_url_2 = (base64_encode($server_all_url_1));
    echo "$server_all_url_2";

}

else{
echo "401 Unauthorized";
}

?>

