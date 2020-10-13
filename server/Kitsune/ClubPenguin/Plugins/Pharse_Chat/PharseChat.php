<?php

namespace Kitsune\ClubPenguin\Plugins\Pharse_Chat;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class PharseChat extends Plugin {
	
	public $worldHandlers = array(
		"s" => array(
			"m#pcam" => array("handlePharseChat", self::Override)
		)
	);
	public $trans;
	public $reversedTrans = array();
	
	public $xmlHandlers = array(null);

	
	public function __construct($server) {
		$this->server = $server;
		$this->trans = array(
			"a" => "!a^7#nF", 
		    "b" => "Bj*&02;",
		    "c" => "!@vkjry",
		    "d" => "LoHG*_*^2",
		    "e" => "Po-In/\"",
		    "f" => "Me@@*_*;&",
		    "g" => "<';45@(",
		    "h" => "HdjT#;;",
		    "i" => "Awe2245",
		    "j" => "+-_32RR",
		    "k" => "|Vd3^!!",
		    "l" => "Kjdh452",
		    "m" => "cVdW33R",
		    "n" => "[nn]H6h",
		    "o" => "LnO86Ns",
		    "p" => "Lssddek",
		    "q" => "M4453ud",
		    "r" => "HJtr47f",
		    "s" => "NNy6fn4",
		    "t" => "C43@#*_*!",
		    "u" => "!@#*_**_**_**_*",
		    "v" => "()!!bB4",
		    "w" => "443G5@@",
		    "x" => "44@#Hnn",
		    "y" => "BfhtftT",
		    "z" => "54gbTTj",
		    "A" => "D*_**_*^#D#T#_#T",
		    "B" => "sSk7gI386N",
		    "C" => "H6BOER7NF!",
		    "D" => "H78t#@R8er",
		    "E" => "J!ffu38*_*@^&",
		    "F" => "Av#TGedje8w",
		    "G" => "N@cf<>??/{}",
		    "H" => ";=>\o|cnd7m3",
		    "I" => "M,<soryrnf0",
		    "J" => "/?vneu3##5t",
		    "K" => "BS@gj8*_*^&o0",
		    "L" => "M,<?s[tPfje",
		    "M" => "_-=-#;G&(&*_*",
		    "N" => "\"'=>;>>bvDF",
		    "O" => "=>fgjru4D#_#GD",
		    "P" => "F#T6tro5854",
		    "Q" => "6nE#;Gr48y#",
		    "R" => "H7b4#*_*545ny",
		    "S" => "BHt8#;Vnh;*_*",
		    "T" => "H884;5uhfk;",
		    "U" => "hgueG;^i854",
		    "V" => "tromt[}yo6o",
		    "W" => "-_Ib48dmrho",  
		    "X" => "H8ntbyER8#_#B",
		    "Y" => "J#448nyBETD",
		    "Z" => "BU83grn;BHr",
		    " " => "Bh#9db;*_*4fn94"
		);
	}
	
	public function onReady() {
		parent::__construct(__CLASS__);
		Logger::Info("Pharse Chat Active!");

		foreach ($this->trans as $key => $value) {
			# Reversed Trans
			$this->reversedTrans[$value] = $key;
		}
	}

	public function handlePharseChat($penguin){
		$EncryptedData = Packet::$Data[2];
		# 300 Considered minimum, I'll change this later :P
		if (strlen($EncryptedData)==0 || strlen($EncryptedData)=='' || strlen($EncryptedData)<300){
			return $this->server->removePenguin($penguin);
		}

		$Algorithms = [hash('md5','This[]/'), "-><-", hash("md5", "String")]; 
		$havingEncryptedData = explode($Algorithms[1], $EncryptedData);
		$check = strtr("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$$:^&*()_+1234567890-=", $this->trans).$Algorithms[2];
		if ($havingEncryptedData[1] != $check){
			return $this->server->removePenguin($penguin);
		}

		$encrypted_data = explode($Algorithms[0], $havingEncryptedData[0])[1];

		$decrypted_text = strtr($encrypted_data, $this->reversedTrans);
		$message = $decrypted_text;

		if (sizeof(Packet::$Data)-1 == 3) {
			array_pop(Packet::$Data);
			array_push(Packet::$Data, $message);
		} else if (sizeof(Packet::$Data)-2 == 2) {
			array_push(Packet::$Data, $message);
		} else {
			# DO NOTHING!!
		}
		// Check for Plugins.. Plugin initiator.. There may be a better way to do this.. :?

		foreach($this->server->loadedPlugins as $loadedPlugin) {
			if(isset($loadedPlugin->worldHandlers["s"]["m#sm"])) {
				list($handlerCallback, $callInformation) = $loadedPlugin->worldHandlers["s"]["m#sm"];
				
				if($callInformation == Plugin::Before || $callInformation == Plugin::Both) {
					$loadedPlugin->handleWorldPacket($penguin);
				}
			}
		}
		# Send the message ..
		$this->server->handleSendMessage($penguin->socket, $message);

		# Plugin again!!
		foreach($this->server->loadedPlugins as $loadedPlugin) {
			if(isset($loadedPlugin->worldHandlers["s"]["m#sm"])) {
				list($handlerCallback, $callInformation) = $loadedPlugin->worldHandlers["s"]["m#sm"];
				
				if($callInformation == Plugin::After || $callInformation == Plugin::Both) {
					$loadedPlugin->handleWorldPacket($penguin);
				}
			}
		}
	}
	
}

?>