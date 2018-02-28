<?php

namespace Kitsune\ClubPenguin\Plugins\AntiSpam;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class AntiSpam extends Plugin {
	
	public $worldHandlers = array(
		"s" => array(
			"m#sm" => array("reverseSpam", self::Before),
			"m#spm" => array("reverseSpam", self::Before),
			"i#ai" => array("reverseSpam", self::Before),
			"g#af" => array("reverseSpam", self::Before),
		    "g#ag" => array("reverseSpam", self::Before),
		    "g#au" => array("reverseSpam", self::Before),
		    "r#cdu" => array("reverseSpam", self::Before),
			"u#se" => array("reverseSpam", self::Before),
			"u#sa" => array("reverseSpam", self::Before), 
			"u#ss" => array("reverseSpam", self::Before),
			"u#sj" => array("reverseSpam", self::Before),
			"u#sl" => array("reverseSpam", self::Before),
			"u#sg" => array("reverseSpam", self::Before),
			"u#sp" => array("reverseSpam", self::Before),
			"u#sma" => array("reverseSpam", self::Before),
			"u#sb" => array("reverseSpam", self::Before),
			"u#gp" => array("reverseSpam", self::Before),
			"u#sq" => array("reverseSpam", self::Before),
			"u#sf" => array("reverseSpam", self::Before),
			"st#sse" => array("reverseSpam", self::Before),			
			"j#jr" => array("reverseSpam", self::Before),
			"j#jg" => array("reverseSpam", self::Before),
			"ni#gcd" => array("reverseSpam", self::Before),
			"n#an" => array("reverseSpam", self::Before),	
			"b#br" => array("reverseSpam", self::Before),
			"b#rb" => array("reverseSpam", self::Before),	
			"s#upc" => array("reverseSpam", self::Before),
			"s#uph" => array("reverseSpam", self::Before),
			"s#upf" => array("reverseSpam", self::Before),
			"s#upn" => array("reverseSpam", self::Before),
			"s#upb" => array("reverseSpam", self::Before),
			"s#upa" => array("reverseSpam", self::Before),
			"s#upe" => array("reverseSpam", self::Before),
			"s#upp" => array("reverseSpam", self::Before),
			"s#upl" => array("reverseSpam", self::Before),
			"l#ms" => array("reverseSpam", self::Before),
			"p#pn" => array("reverseSpam", self::Before),
			"f#epfai" => array("reverseSpam", self::Before)
		)
	);
	
	public $xmlHandlers = array(null);
	
	public $penguins = array();
	
	public function __construct($server) {
		$this->server = $server;
	}
	
	public function onReady() {
		parent::__construct(__CLASS__);
	}
	
	public function reverseSpam($penguin) {
		$penguinId = $penguin->id;
		$packetType = Packet::$Data[0];
		
		if(!isset($this->penguins[$penguinId][$packetType])) {
			$this->penguins[$penguinId][$packetType]['previous'] = microtime(true);
			$this->penguins[$penguinId][$packetType]['spam'] = 0;
			return;
		}
		
		$lastData = $this->penguins[$penguinId][$packetType]['previous'];
		
		if($lastData > (microtime(true) - 0.28)) {
			$this->penguins[$penguinId][$packetType]['spam']++;
		}

		$spamCount = $this->penguins[$penguinId][$packetType]['spam'];
		
		if($spamCount > 15) {
			Packet::$Extension = null;
		} 
		
		if($spamCount > 25) {
			Packet::$Extension = null;
			$this->penguins[$penguinId][$packetType]['spam'] = 15;
			$this->server->kickPlayer($penguin, "Server");
		}
		
		foreach($this->penguins as $checkPenguinId => $spam) {
			$lastData = $this->penguins[$checkPenguinId][$packetType]['previous'];
			if($lastData < (microtime(true) - 10)) {
				unset($this->penguins[$checkPenguinId]);
			}
		}
		
		if(isset($this->penguins[$penguinId])) {
			$this->penguins[$penguinId][$packetType]['previous'] = microtime(true);
		}
	}
	
}

?>