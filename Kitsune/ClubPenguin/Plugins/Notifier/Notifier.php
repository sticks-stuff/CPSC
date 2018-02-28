<?php

namespace Kitsune\ClubPenguin\Plugins\Notifier;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class Notifier extends Plugin {

	public $worldHandlers = array(null);

	public $xmlHandlers = array(null);
	
	public $loginServer = false;
	
	public function __construct($server) {
		$this->server = $server;
	}
	
	public function onReady() {
		parent::__construct(__CLASS__);
	}
	
	public function sendCustomPrompt($penguin, $message) {
		$penguin->send("%xt%cprompt%-1%$message%");
	}
	
	public function sendCustomError($penguin, $message, $type = "Server") {
		$penguin->send("%xt%cerror%-1%$message%$type%");
	}
	
}

?>