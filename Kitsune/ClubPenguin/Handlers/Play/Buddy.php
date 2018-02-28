<?php
namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Buddy {

	public function addBuddy($penguin, $buddyId) {
		if(!isset($penguin->buddyRequests[$buddyId])) {
			return;
		}

		list($buddyName, $buddyBuddies) = $penguin->buddyRequests[$buddyId];

		$penguin->buddies[$buddyId] = $buddyName;

		$buddyString = implode('%', array_map(
			function($buddyId, $buddyName) {
				return $buddyId . '|' . $buddyName;
			}, array_keys($penguin->buddies), $penguin->buddies));

		$penguin->database->updateColumnById($penguin->id, "Buddies", $buddyString);

		$buddyBuddies[$penguin->id] = $penguin->username;

		$buddyString = implode('%', array_map(
			function($buddyId, $buddyName) {
				return $buddyId . '|' . $buddyName;
			}, array_keys($buddyBuddies), $buddyBuddies));

		$penguin->database->updateColumnById($buddyId, "Buddies", $buddyString);

		unset($penguin->buddyRequests[$buddyId]);

		$buddy = $this->getPlayerById($buddyId);
		if($buddy !== null) {
			$buddy->send("%xt%ba%{$buddy->room->internalId}%{$penguin->id}%{$penguin->username}%");
			$buddy->buddies[$penguin->id] = $penguin->username;
		} else {
			$penguin->send("%xt%bof%{$penguin->room->internalId}%{$buddyId}%");
		}
	}

	protected function removeBuddy($penguin, $buddyId) {
		unset($penguin->buddies[$buddyId]);

		$buddyString = implode('%', array_map(
			function($buddyId, $buddyName) {
				return $buddyId . '|' . $buddyName;
			}, array_keys($penguin->buddies), $penguin->buddies));

		$penguin->database->updateColumnById($penguin->id, "Buddies", $buddyString);

		$buddyBuddies = $penguin->database->getColumnById($buddyId, "Buddies");
		$buddyArray = explode('%', $buddyBuddies);
		$buddyBuddies = array();

		foreach($buddyArray as $buddy) {
			$buddyDetails = explode('|', $buddy);
			list($checkBuddyId, $buddyName) = $buddyDetails;

			if($checkBuddyId != $penguin->id) {
				$buddyBuddies[$checkBuddyId] = $buddyName;
			}
		}

		$buddyString = implode('%', array_map(
			function($buddyId, $buddyName) {
				return $buddyId . '|' . $buddyName;
			}, array_keys($buddyBuddies), $buddyBuddies));

		$penguin->database->updateColumnById($buddyId, "Buddies", $buddyString);

		$buddy = $this->getPlayerById($buddyId);
		if($buddy !== null) {
			$buddy->send("%xt%rb%{$buddy->room->internalId}%{$penguin->id}%");
			unset($buddy->buddies[$penguin->id]);
		}
	}

	protected function handleGetBuddyList($socket) {
		$penguin = $this->penguins[$socket];

		if(count($penguin->buddies) == 0){
			return $penguin->send("%xt%gb%{$penguin->room->internalId}%");
		}

		$buddies = implode('%', array_map(
			function($buddyId, $buddyName) {
				$online = ($this->getPlayerById($buddyId) !== null ? 1 : 0);
				return $buddyId . '|' . $buddyName . '|' . $online;
			}, array_keys($penguin->buddies), $penguin->buddies));

		$penguin->send("%xt%gb%{$penguin->room->internalId}%$buddies%");
	}

	protected function handleFindBuddy($socket) {
		$penguin = $this->penguins[$socket];
		
		if(is_numeric(Packet::$Data[2])){
        $buddyId = Packet::$Data[2];
        }

		if(isset($penguin->buddies[$buddyId])) {
			$buddy = $this->getPlayerById($buddyId);
			if($buddy !== null) {
				$penguin->send("%xt%bf%{$penguin->room->internalId}%{$buddy->room->externalId}%");
			}
		}
	}

	protected function handleBuddyRequest($socket) {
		$penguin = $this->penguins[$socket];

		if(is_numeric(Packet::$Data[2])){
        $buddyId = Packet::$Data[2];
        }

		if(count($penguin->buddies) >= 100)  {
			return;
		}

		if(isset($penguin->buddies[$buddyId])) {
			return;
		}

		$buddy = $this->getPlayerById($buddyId);
		if($buddy !== null) {
			if(isset($buddy->ignore[$penguin->id])) {
				return;
			}

			$buddy->buddyRequests[$penguin->id] = array($penguin->username, $penguin->buddies);
			$buddy->send("%xt%br%{$buddy->room->internalId}%{$penguin->id}%{$penguin->username}%");
		}
	}

	protected function handleBuddyAccept($socket) {
		$penguin = $this->penguins[$socket];

		if(is_numeric(Packet::$Data[2])){
        $buddyId = Packet::$Data[2];
        }

		if(count($penguin->buddies) >= 100)  {
			return;
		}

		if(isset($penguin->buddies[$buddyId])) {
			return;
		}

		$this->addBuddy($penguin, $buddyId);
	}

	protected function handleRemoveBuddy($socket) {
		$penguin = $this->penguins[$socket];

		if(is_numeric(Packet::$Data[2])){
        $buddyId = Packet::$Data[2];
        }

		$this->removeBuddy($penguin, $buddyId);
	}
}
?>
