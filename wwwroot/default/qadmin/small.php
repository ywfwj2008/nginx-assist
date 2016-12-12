<?php
include_once('qadmin.php');

$adm = new Qadmin();
$adm->conf_dbhost = 'localhost:3306';   // 主机ip或者地址
$adm->conf_dbuser = 'root';             // 用户名
$adm->conf_dbpass = 'root';             // 密码

$adm->run();

// 最小运行.