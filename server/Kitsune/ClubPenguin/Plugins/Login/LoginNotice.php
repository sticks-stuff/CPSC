<?php

namespace Kitsune\ClubPenguin\Plugins\Login;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class LoginNotice extends Plugin {

	public $worldHandlers = array(null);
	
	public $xmlHandlers = array(
		"login" => array("loginAttempt", self::Before)
	);
	
	public $loginServer = true;
	
	public function __construct($server) {
		$this->server = $server;
	}
	
	public function onReady() {
		parent::__construct(__CLASS__);
	}
	
	protected function loginAttempt($penguin) {
		$username = Packet::$Data['body']['login']['nick'];
		
		if(strstr($username, '|') !== false) {
			list(,,$username) = explode('|', $username);
		}
		
		Logger::Notice("$username is attempting to login");
	}
	
}

?>