<?php

namespace Kitsune\ClubPenguin\Plugins\Dunce;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class Dunce extends Plugin {

	public $worldHandlers = array(
		"s" => array(
			"s#uph" => array("handleSendUpdatePlayerClothing", self::Override)
		)
	);

	public $xmlHandlers = array(null);

	public $dunceHatId = 40000;

	public function __construct($server) {
		$this->server = $server;
	}

	public function onReady() {
		parent::__construct(__CLASS__);
	}

	public function setDunce($penguin, $time = 10) {
		$penguin->updateHead($this->dunceHatId);
		
		$penguin->database->updateColumnById($penguin->id, "Dunce", time() + ($time * 60));
	}

	public function handleSendUpdatePlayerClothing($penguin) {
		$itemId = Packet::$Data[2];
		
		if($penguin->head == $this->dunceHatId) {
			$dunce = $penguin->database->getColumnById($penguin->id, "Dunce");
			$isDunce = ($dunce > time() ? true : false);
			
			if($isDunce) {
				return $penguin->updateHead($this->dunceHatId);
			}
		}
		$penguin->updateHead($itemId);
	}
}

?>
