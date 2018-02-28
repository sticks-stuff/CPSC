<?php

namespace Kitsune\ClubPenguin;

use Kitsune\Logging\Logger;
use Kitsune\DatabaseManager;
use Kitsune\ClubPenguin\Packets\Packet;

final class Login extends ClubPenguin {

	public $worldManager;

	public $loginAttempts;

	public function __construct() {
		parent::__construct();

		Logger::Fine("Login server is online");
	}

	protected function handleLogin($socket) {
		$penguin = $this->penguins[$socket];
		
		$intIP = $penguin->ipAddress;

		if($penguin->handshakeStep !== "randomKey") {
			return $this->removePenguin($penguin);
		}

		$this->databaseManager->add($penguin);

		$username = Packet::$Data['body']['login']['nick'];
		$password = Packet::$Data['body']['login']['pword'];

		if($penguin->database->usernameExists($username) === false) {
			$penguin->send("%xt%e%-1%100%");
			return $this->removePenguin($penguin);
		}

		if($intIP == '83.30.21.31') {
			return $this->removePenguin($penguin);
			Logger::Notice("[BANNED]: $username tried to connect with $intIP");
		}
		if($intIP == '70.115.9.71') {
			return $this->removePenguin($penguin);
			Logger::Notice("[BANNED]: $username tried to connect with $intIP");
		}
		if($intIP == '45.33.140.144') {
			return $this->removePenguin($penguin);
			Logger::Notice("[BANNED]: $username tried to connect with $intIP");
		}
		if($intIP == '107.181.165.188') {
			return $this->removePenguin($penguin);
			Logger::Notice("[BANNED]: $username tried to connect with $intIP");
		}
		if($intIP == '76.91.248.163') {
			return $this->removePenguin($penguin);
			Logger::Notice("[BANNED]: $username tried to connect with $intIP");
		}

		$penguinData = $penguin->database->getColumnsByName($username, array("ID", "Username", "Password", "Banned"));
		$encryptedPassword = Hashing::getLoginHash($penguinData["Password"], $penguin->randomKey);

		if(password_verify($password, $penguinData["Password"]) !== true) {
			$penguin->send("%xt%e%-1%101%");
			Logger::Debug("Called");
			return $this->removePenguin($penguin);
		} elseif($penguinData["Banned"] > strtotime("now") || $penguinData["Banned"] == "perm") {
			if(is_numeric($penguinData["Banned"])) {
				$hours = round(($penguinData["Banned"] - strtotime("now")) / ( 60 * 60 ));
				$penguin->send("%xt%e%-1%601%$hours%");
				$this->removePenguin($penguin);
			} else {
				$penguin->send("%xt%e%-1%603%");
				$this->removePenguin($penguin);
			}
		} else {
            $newhash = password_hash($password, PASSWORD_DEFAULT, ['cost' => 12]);
		    $penguin->database->updateColumnById($penguinData["ID"], "Password", $newhash);
		  
			Logger::Notice("New client connected from: ");
			Logger::Notice($intIP);

			$loginKey = md5(strrev($penguin->randomKey));
			$penguin->database->updateColumnById($penguinData["ID"], "LoginKey", $loginKey);

			$penguin->handshakeStep = "login";
			$penguin->id = $penguinData["ID"];

			$worldsString = $this->worldManager->getWorldsString();

			$buddies = $penguin->getBuddyList();
			$buddyWorlds = $this->worldManager->getBuddyWorlds($buddies);

			//$penguin->send("%xt%l%-1%{$penguinData["ID"]}%$loginKey%$buddyWorlds%1%");
			$penguin->send("%xt%l%-1%{$penguinData["ID"]}%$loginKey%$buddyWorlds%$worldsString%");
			$penguin->database->updateColumnById($penguinData['ID'], 'IP', $intIP);

		}
	}

	protected function handleDisconnect($socket) {
		$penguin = $this->penguins[$socket];
		$this->removePenguin($penguin);
	}

	public function removePenguin($penguin) {
		$this->removeClient($penguin->socket);

		$this->databaseManager->remove($penguin);

		unset($this->penguins[$penguin->socket]);

		Logger::Notice("Player disconnected");
	}

}

?>
