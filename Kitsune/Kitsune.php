<?php

namespace Kitsune;

use Kitsune\Events;
use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Penguin;
use Kitsune\ClubPenguin\Packets\Packet;

abstract class Kitsune extends Spirit {

	public $penguins = array();
	protected $packetsSent = array();

	protected $packetsAllowed = 50; // bucket capacity
	protected $seconds = 5; // fill rate of bucket

	protected function handleAccept($socket) {
		Events::Fire("accept", $socket);

		$newPenguin = new Penguin($socket);
		$this->penguins[$socket] = $newPenguin;

		/*----------------------------------------------------------
			$this->packetsSent[$socket] = array(
			"packets" => $this->packetsAllowed, // tokens in bucket
			"previousTime" => time() // current time
		);

		print_r($this->packetsSent[$socket]);
		print_r($socket);
		*/

		Events::Fire("accepted", $newPenguin);
	}

	protected function handleDisconnect($socket) {
		unset($this->penguins[$socket]);
		Logger::Notice("Player disconnected");
	}

	protected function handleReceive($socket, $data) {
		Events::Fire("receive", [$socket, $data]);

		$chunkedArray = explode("\0", $data);
		array_pop($chunkedArray);

		$ipAddress = null;
		socket_getpeername($socket, $ipAddress);

		foreach($chunkedArray as $rawData) {
			Logger::Debug("Received $rawData from IP: $ipAddress");

			$packet = Packet::Parse($rawData);

			if(Packet::$IsXML) {
				$this->handleXmlPacket($socket);
			} else {
				$this->handleWorldPacket($socket);
			}
		}

		Events::Fire("received", [$socket, $data]);
	}

	/*-------------------------------
		protected function checkRateLimit($amount, $socket) { // consumes token from bucket
		Logger::Debug("Checking rate limit...");

		$ipAddress = null;
		socket_getpeername($socket, $ipAddress);

		if ($amount <= $this->packetsRemaining($socket)) {
			$newAllowed = $this->packetsSent[$socket]["packets"] - $amount;
			$this->packetsSent[$socket]["packets"] -= $amount;
			Logger::Debug("Client at IP address $ipAddress is only allowed $newAllowed more packets to be sent over the course of $this->seconds seconds before being kicked!");
		} else {
			Logger::Warn("Client at IP address $ipAddress was kicked for sending too many packets!");

			$this->removeClient($socket);
			unset($this->penguins[$socket]);
			unset($this->packetsSent[$socket]);
		}
	}

	protected function packetsRemaining($socket) { // checks amount of tokens left in bucket
		$currentTime = time();
		if ($this->packetsSent[$socket]["packets"] < $this->packetsAllowed) {
			$interval = $this->seconds * ($currentTime - $this->packetsSent[$socket]["previousTime"]);
			$this->packetsSent[$socket]["packets"] = min($this->packetsAllowed, $this->packetsSent[$socket]["packets"] + $interval);
		}
		$this->packetsSent[$socket]["previousTime"] = $currentTime;
		return $this->packetsSent[$socket]["packets"];
	}
	*/

	protected function removePenguin($penguin) {
		$this->removeClient($penguin->socket);
		unset($this->penguins[$penguin->socket]);
		//unset($this->$packetsSent[$penguin->socket]);
	}

	abstract protected function handleXmlPacket($socket);
	abstract protected function handleWorldPacket($socket);

}

?>

 _   ___ _
| | / (_) |
| |/ / _| |_ ___ _   _ _ __   ___
|    \| | __/ __| | | | '_ \ / _ \
| |\  \ | |_\__ \ |_| | | | |  __/
\_| \_/_|\__|___/\__,_|_| |_|\___|
