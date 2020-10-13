<?php

namespace Kitsune\ClubPenguin\Plugins\Base;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;

abstract class Plugin implements IPlugin {

	public $dependencies = array();

	public $worldHandlers = array();

	public $xmlHandlers = array();

	public $loginStalker = false;

	public $worldStalker = false;

	public $loginServer = false;

	protected $server = null;

	private $pluginName;

	protected function __construct($pluginName) {
		$readableName = basename($pluginName);

		if($this->server == null) {
			Logger::Warn("$readableName didn't set a server object");
		}

		if(empty($this->xmlHandlers)) {
			$this->loginStalker = true;
		}

		if(empty($this->worldHandlers)) {
			$this->worldStalker = true;
		}

		$this->pluginName = $readableName;
	}

	abstract public function onReady();

	public function handleXmlPacket($penguin, $beforeCall = true) {
		if(isset($this->xmlHandlers[Packet::$Handler])) {
			list($methodName) = $this->xmlHandlers[Packet::$Handler];

			if(method_exists($this, $methodName)) {
				call_user_func(array($this, $methodName), $penguin);
			} else {
				Logger::Warn("Method '$methodName' doesn't exist in plugin '{$this->pluginName}'");
			}
		}
	}

	public function handleWorldPacket($penguin, $beforeCall = true) {
		if(isset($this->worldHandlers[Packet::$Extension]) && isset($this->worldHandlers[Packet::$Extension][Packet::$Handler])) {
			list($methodName) = $this->worldHandlers[Packet::$Extension][Packet::$Handler];

			if(method_exists($this, $methodName)) {
				call_user_func(array($this, $methodName), $penguin);
			} else {
				Logger::Warn("Method '$methodName' doesn't exist in plugin '{$this->pluginName}'");
			}
		}
	}

}

?>
