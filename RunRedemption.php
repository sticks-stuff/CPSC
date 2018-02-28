<?php

namespace Kitsune\ClubPenguin;
use Kitsune\BindException;

date_default_timezone_set("America/Los_Angeles");

error_reporting(E_ALL ^ E_STRICT);

spl_autoload_register(function ($path) {
	$realPath = str_replace("\\", "/", $path) . ".php";
	$includeSuccess = include_once $realPath;

	if(!$includeSuccess) {
		echo "Unable to load $realPath\n";
	}
});

$redemptionFile = "Redemption.xml";

$redemptionConfig = simplexml_load_file($redemptionFile);
$redemption = new Redemption();
$redemption->listen($redemptionConfig->address, (int)$redemptionConfig->port);

while(true) {
	$redemption->acceptClients();
}

?>
