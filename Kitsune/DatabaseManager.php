<?php

namespace Kitsune;
use Kitsune\Database;
use Kitsune\Logging\Logger;

class DatabaseManager {

	public $databaseConnections = array();
	public $penguinsByDatabases = array();

	// Returns database index
	public function add($penguin) {
		Logger::Debug("Adding penguino");

		if(empty($this->databaseConnections)) {
			$databaseIndex = $this->createDatabase();
			$this->penguinsByDatabases[$databaseIndex][] = $penguin;
		} else {
			$databaseIndex = $this->getOpenDatabase();
			$this->penguinsByDatabases[$databaseIndex][] = $penguin;
		}

		$penguin->database = $this->databaseConnections[$databaseIndex];

		return $databaseIndex;
	}

	public function remove($penguin) {
		Logger::Debug("Removing penguino");

		foreach($this->penguinsByDatabases as $databaseIndex => $penguinArray) {
			if(($penguinIndex = array_search($penguin, $penguinArray)) !== false) {
				Logger::Debug("Penguino found! Removing");

				unset($this->penguinsByDatabases[$databaseIndex][$penguinIndex]);

				if(count($this->penguinsByDatabases[$databaseIndex]) == 0) {
					Logger::Info("Removing empty database object");

					unset($this->penguinsByDatabases[$databaseIndex]);
					unset($this->databaseConnections[$databaseIndex]);
				}

				return true;
			} else {
				Logger::Debug("Sorry, penguino not found. :-( $penguinIndex");
			}
		}
	}

	private function getOpenDatabase() {
		foreach($this->penguinsByDatabases as $databaseIndex => $penguinArray) {
			if(count($this->penguinsByDatabases[$databaseIndex]) < 20) {
				return $databaseIndex;
			} else {
				return $this->createDatabase();
			}
		}
	}

	private function createDatabase() {
		$newDatabase = new Database();
		$this->databaseConnections[] = $newDatabase;
		$databaseIndex = array_search($newDatabase, $this->databaseConnections);

		Logger::Debug("New database created");

		return $databaseIndex;
	}
	

}

?>