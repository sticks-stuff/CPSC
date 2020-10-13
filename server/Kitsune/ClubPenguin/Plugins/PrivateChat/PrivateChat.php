<?php

namespace Kitsune\ClubPenguin\Plugins\PrivateChat;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class PrivateChat extends Plugin {

	public $worldHandlers = array(
		"s" => array(
			"m#spm" => array("handleSendPrivateMessage", self::Override)
		)
	);

	public $xmlHandlers = array(null);

	public function __construct($server) {
		$this->server = $server;
	}

	public function onReady() {
		parent::__construct(__CLASS__);
	}

	public function handleSendPrivateMessage($penguin) {
		$playerId = Packet::$Data[2];
		$message = Packet::$Data[3];
		
		#~aloha
		if(isset($penguin->buddies[$playerId])) {
			$buddy = $this->server->getPlayerById($playerId);
			if($buddy !== null) {
				$buddy->send("%xt%spm%-1%{$penguin->id}%{$message}%");
			}
		}
	}

}

?>
