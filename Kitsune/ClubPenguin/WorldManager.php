<?php
namespace Kitsune\ClubPenguin;

use Kitsune\BindException;

class WorldManager {

	public $worldsById = array();

	public function add($id, $name, $address, $port, $capacity = 500, $language = "en") {
		$world = new World($id, $name, $capacity, $language);
		$world->listen($address, $port);

		$this->worldsById[$id] = $world;
	}

	public function getWorldById($id) {
		$world = $this->worldsById[$id];
		return $world;
	}

	public function getWorldPopulationById($id) {
		$pips = 6;
		$world = $this->getWorldById($id);
		$population = count($world->penguinsById);
		$threshold = round($world->capacity / 6);

		for($i = 1;$i <= $pips;$i++){
			if($population <= ($threshold * $i)){
				return $i;
			}
		}
		return $pips;
	}

	public function getWorldsString() {
		$worldPopulations = array();
		foreach($this->worldsById as $worldId => $world){
			$population = $this->getWorldPopulationById($worldId);
			$worldPopulations[] = implode(',', array($worldId, $population));
		}
		return implode('|', $worldPopulations);
	}

	public function getBuddyWorlds($buddies) {
		$worlds = array();
		foreach($this->worldsById as $worldId => $world) {
			foreach($buddies as $buddyId => $buddyName) {
				if(isset($world->penguinsById[$buddyId])) {
					array_push($worlds, $worldId);
					continue;
				}
			}
		}
		return implode('|', $worlds);
	}

}

?>
