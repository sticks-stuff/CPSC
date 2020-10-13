<?php

namespace Kitsune\ClubPenguin\Plugins\Events;

use Kitsune\Events;
use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class DCNotice extends Plugin {

	public $worldHandlers = array(null);

	public $xmlHandlers = array(null);

	public $eventBinder = true;

	public function __construct($server) {
	}

	public function onReady() {
		parent::__construct(__CLASS__);
		Events::Append('leave', array($this, 'logPenguinLeave'));
	}

	public function logPenguinLeave($penguin) {
		$username = $penguin->username;

		Logger::Notice($username . ' is leaving the server');
	}

}

?>