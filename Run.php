<?php

/*
Tags so people can find this repo:
Club Penguin
CPPS
Club Penguin Private Server
How to make a
CP
*/

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

$loginFile = "Login.xml";
$redemptionFile = "Redemption.xml";
$worldsDirectory = "Worlds";

$worldManager = new WorldManager();

$loginConfig = simplexml_load_file($loginFile);
$login = new Login();
$login->listen($loginConfig->address, (int)$loginConfig->port);

$redemptionConfig = simplexml_load_file($redemptionFile);
$redemption = new Redemption();
$redemption->listen($redemptionConfig->address, (int)$redemptionConfig->port);

$worldFiles = array_diff(scandir($worldsDirectory), array('..', '.'));

foreach($worldFiles as $worldFile){
	$worldConfig = simplexml_load_file($worldsDirectory . "/" . $worldFile);
	$worldManager->add((int)$worldConfig->id, $worldConfig->name, $worldConfig->address, (int)$worldConfig->port, $worldConfig->capacity, $worldConfig->language);
}

$login->worldManager = $worldManager;

while(true) {
	$login->acceptClients();
	$redemption->acceptClients();
	foreach($worldManager->worldsById as $world){
		$world->acceptClients();
	}
}

?>