<?php

namespace Kitsune\ClubPenguin\Plugins\Statistics;

use Kitsune\Events;
use Kitsune\Database;
use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class Statistics extends Plugin {

	public $worldHandlers = array(
		"s" => array(
			"j#js" => array("handleJoinWorld", self::After)
		)
	);

	public $xmlHandlers = array(null);
	public $loginServer = false;

	private $database;
	private $count;

	public function __construct($server) {
		$this->server = $server;
	}

	public function onReady() {
		parent::__construct(__CLASS__);

		$this->database = new StatisticsDatabase();
		$this->count = -1;

		if(!$this->database->worldExists($this->server->name)) {
			$this->database->addWorld($this->server->id, $this->server->name, $this->server->language);
		}

		Events::Append("disconnected", array($this, 'onDisconnect'));
	}

	public function handleJoinWorld($penguin) {
		$this->updateStatistics();
	}

	public function onDisconnect($socket) {
		$this->updateStatistics();
	}

	private function updateStatistics() {
		$count = count($this->server->penguinsById);

		if($count != $this->count) {
			$this->database = new StatisticsDatabase();
			$this->database->updateWorldStatistics($this->server->name, $count);
			$this->count = $count;
		}
	}
}

class StatisticsDatabase extends Database {

	public function addWorld($worldId, $worldName, $worldLanguage) {
		try {
			$addWorld = $this->prepare("INSERT INTO `servers` (`ID`, `Name`, `Language`) VALUES (:ID, :Name, :Language)");
			print($worldName);
			$addWorld->bindValue(":ID", $worldId);
			$addWorld->bindValue(":Name", $worldName);
			$addWorld->bindValue(":Language", $worldLanguage);
			$addWorld->execute();
			$addWorld->closeCursor();
		} catch(\PDOException $pdoException) {
			Logger::Warn($pdoException->getMessage());
		}
	}

	public function worldExists($worldName) {
		try {
			$existsStatement = $this->prepare("SELECT Name FROM `servers` WHERE Name = :Name");
			$existsStatement->bindValue(":Name", $worldName);
			$existsStatement->execute();
			$rowCount = $existsStatement->rowCount();
			$existsStatement->closeCursor();

			return $rowCount > 0;
		} catch(\PDOException $pdoException) {
			Logger::Warn($pdoException->getMessage());
		}
	}

	public function updateWorldStatistics($worldName, $playerCount) {
		try {
			$updateStatisticsStatement = $this->prepare("UPDATE `servers` SET Max = IF(Max < :Value, :Value, Max), Players = :Value WHERE Name = :Name");
			$updateStatisticsStatement->bindValue(":Value", $playerCount);
			$updateStatisticsStatement->bindValue(":Name", $worldName);
			$updateStatisticsStatement->execute();
			$updateStatisticsStatement->closeCursor();
		} catch(\PDOException $pdoException) {
			Logger::Warn($pdoException->getMessage());
		}
	}
}

?>
