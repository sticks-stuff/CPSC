<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Igloo {

	private $openIgloos = array();

	protected function handleGetFurnitureList($socket) {
		$penguin = $this->penguins[$socket];

		$furnitureInventory = implode('%', array_map(
			function($furnitureId, $furnitureQuantity) {
				return sprintf("%d|%d", $furnitureId, $furnitureQuantity);
			}, array_keys($penguin->furniture), $penguin->furniture
		));

		$penguin->send("%xt%gf%{$penguin->room->internalId}%$furnitureInventory%");
	}

	protected function handleGetActiveIgloo($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $playerId = Packet::$Data[2];
        }

		if($penguin->database->playerIdExists($playerId)) {
			$activeIgloo = $penguin->database->getColumnById($playerId, "Igloo");

			if($playerId == $penguin->id) {
				$penguin->activeIgloo = $activeIgloo;
			}

			$iglooDetails = $penguin->database->getIglooDetails($activeIgloo);
			$penguin->send("%xt%gm%{$penguin->room->internalId}%$playerId%$iglooDetails%");
		}
	}

	protected function handleGetOwnedIgloos($socket) {
		$penguin = $this->penguins[$socket];

		$ownedIgloos = implode('|', $penguin->igloos);

		$penguin->send("%xt%go%{$penguin->room->internalId}%$ownedIgloos%");
	}

	protected function handleBuyFurniture($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $furnitureId = Packet::$Data[2];
        }

		if(!isset($this->furniture[$furnitureId])) {
			return $penguin->send("%xt%e%-1%402%");
		}

		$cost = $this->furniture[$furnitureId];
		if($penguin->coins < $cost) {
			return $penguin->send("%xt%e%-1%401%");
		} else {
			$penguin->buyFurniture($furnitureId, $cost);
		}
	}

	protected function handleSendBuyIglooFloor($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $floorId = Packet::$Data[2];
        }

		if(!isset($this->floors[$floorId])) {
			return $penguin->send("%xt%e%-1%402%");
		}

		$cost = $this->floors[$floorId];
		if($penguin->coins < $cost) {
			return $penguin->send("%xt%e%-1%401%");
		} else {
			$penguin->buyFloor($floorId, $cost);
		}
	}

	protected function handleSendBuyIglooType($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $iglooId = Packet::$Data[2];
        }

		if(!isset($this->igloos[$iglooId])) {
			return $penguin->send("%xt%e%-1%402%");
		} elseif(isset($penguin->igloos[$iglooId])) { // May not be right lol?
			return $penguin->send("%xt%e%-1%500%");
		}

		$cost = $this->igloos[$iglooId];
		if($penguin->coins < $cost) {
			return $penguin->send("%xt%e%-1%401%");
		} else {
			$penguin->buyIgloo($iglooId, $cost);
		}
	}

	protected function handleSendActivateIgloo($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $iglooId = Packet::$Data[2];
        }

		if(!in_array($iglooId, $penguin->igloos)) {
			return;
		}

		$penguin->database->updateIglooColumn($penguin->activeIgloo, "Type", $iglooId);
		$penguin->database->updateIglooColumn($penguin->activeIgloo, "Floor", 0);
	}

	protected function handleSaveIglooFurniture($socket) {
		$penguin = $this->penguins[$socket];

		$furniture = Packet::$Data;
		array_shift($furniture);
		array_shift($furniture);

		if(empty($furniture)) {
			return $penguin->database->updateIglooColumn($penguin->activeIgloo, "Furniture", "");
		}

		if(count($furniture) >= 100) {
			return;
		}

		foreach($furniture as $furnitureDetails) {
			$furnitureArray = explode('|', $furnitureDetails);
			list($furnitureId) = $furnitureArray;

			if(count($furnitureArray) != 5) { // people might be sneaky
				return;
			}

			if(!isset($this->furniture[$furnitureId])) {
				return;
			}

			if(!isset($penguin->furniture[$furnitureId])) {
				return;
			}
		}

		$penguin->database->updateIglooColumn($penguin->activeIgloo, "Furniture", implode(",", $furniture));
	}

	protected function handleUnlockIgloo($socket) {
		$penguin = $this->penguins[$socket];

		$this->openIgloos[$penguin->id] = $penguin->username;
	}

	protected function handleLockIgloo($socket) {
		$penguin = $this->penguins[$socket];

		unset($this->openIgloos[$penguin->id]);
	}

	protected function handleLoadPlayerIglooList($socket) {
		$penguin = $this->penguins[$socket];

		if(count($this->openIgloos) == 0) {
			return $penguin->send("%xt%gr%{$penguin->room->internalId}%");
		}

		$iglooList = implode('%', array_map(
			function($playerId, $playerName) {
				return $playerId . '|' . $playerName;
			}, array_keys($this->openIgloos), $this->openIgloos));

		$penguin->send("%xt%gr%{$penguin->room->internalId}%$iglooList%");
	}
	
	protected function handleUpdateIglooMusic($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $musicId = Packet::$Data[2];
        }
		$penguin->database->updateIglooColumn($penguin->activeIgloo, "Music", $musicId);
	}

}

?>
