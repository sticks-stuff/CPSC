<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Room;
use Kitsune\ClubPenguin\Packets\Packet;

trait Navigation {

	public function joinRoom($penguin, $roomId, $x = 0, $y = 0) {
		if(!isset($this->rooms[$roomId])) {
			return;
		} elseif(isset($penguin->room)) {
			$penguin->room->remove($penguin);
		}

		$this->leaveWaddle($penguin);

		$penguin->frame = 1;
		$penguin->x = $x;
		$penguin->y = $y;
		$this->rooms[$roomId]->add($penguin);
	}

	// Considering making this public
	protected function getOpenRoom() {
		$spawnRooms = $this->spawnRooms;
		shuffle($spawnRooms);

		foreach($spawnRooms as $roomId) {
			if(sizeof($this->rooms[$roomId]->penguins) < 75) {
				return $roomId;
			}
		}

		return 100;
	}

	protected function handleJoinWorld($socket) {
		$penguin = $this->penguins[$socket];

		if($penguin->id != Packet::$Data[2]) {
			return $this->removePenguin($penguin);
		}

		$loginKey = Packet::$Data[3];

		// User is attempting to perform exploit
		// See https://github.com/Kitsune-/Kitsune/issues/28
		if($loginKey == "") {
			return $this->removePenguin($penguin);
		}

		$dbLoginKey = $penguin->database->getColumnById($penguin->id, "LoginKey");

		if($dbLoginKey != $loginKey) {
			$penguin->send("%xt%e%-1%101%");
			$penguin->database->updateColumnByid($penguin->id, "LoginKey", "");
			return $this->removePenguin($penguin);
		}

		$penguin->database->updateColumnByid($penguin->id, "LoginKey", "");

		$penguin->loadPlayer();

		$this->penguinsById[$penguin->id] = $penguin;
		$this->penguinsByName[$penguin->username] = $penguin;

		$isModerator = intval($penguin->moderator);

		list($penguin->EPF['status'], $penguin->EPF['points'], $penguin->EPF['career']) = explode(",", $penguin->database->getColumnById($penguin->id, "EPF"));
		$penguin->EPF = array_reverse($penguin->EPF);

        $penguin->send("%xt%activefeatures%-1%");
        $penguin->send("%xt%js%-1%1%{$penguin->EPF['status']}%$isModerator%1%");
		$stamps = rtrim(str_replace(",", "|", $penguin->database->getColumnById($penguin->id, "Stamps")), "|");
		$penguin->send("%xt%gps%-1%{$penguin->id}%$stamps%");

		$playerString = $penguin->getPlayerString();
		$penguin->loginTime = time(); // ?

        $loadPlayer = "$playerString|%{$penguin->coins}%0%1440%{$penguin->loginTime}%{$penguin->age}%0%{$penguin->minutesPlayed}%%7%{$penguin->credits}%1%0%211843";
		$penguin->send("%xt%lp%-1%$loadPlayer%");
		$penguin->send("%xt%glr%-1%3239%");
		$penguin->send("%xt%mst%-1%0%5%");
		$penguin->send("%xt%mg%-1%%");

		$openRoom = $this->getOpenRoom();
		$this->joinRoom($penguin, $openRoom, 0, 0);

// notify all online buddies that user has joined
        foreach($penguin->buddies as $buddyId => $buddyName) {
            $buddy = $this->getPlayerById($buddyId);
            if($buddy !== null) {
                $buddy->send("%xt%bon%{$buddy->room->internalId}%{$penguin->id}%");
            }
        }
    }

   protected function handleJoinRoom($socket) {
        $penguin = $this->penguins[$socket];
        
        if(is_numeric(Packet::$Data[2]) && is_numeric(Packet::$Data[3]) && is_numeric(Packet::$Data[4])) {
            $room = Packet::$Data[2];
            $x = Packet::$Data[3];
            $y = Packet::$Data[4];
        }
        
        $this->joinRoom($penguin, $room, $x, $y);
    }

	protected function handleJoinPlayerRoom($socket) {
		$penguin = $this->penguins[$socket];
		$playerId = Packet::$Data[2] - 1000;

		if($penguin->database->playerIdExists($playerId)) {
			$externalId = $playerId + 1000;

			if(!isset($this->rooms[$externalId])) {
				$this->rooms[$externalId] = new Room($externalId, $playerId, false);
			}

			$penguin->send("%xt%jp%$playerId%$playerId%$externalId%");
			$this->joinRoom($penguin, $externalId);
		}
	}

	protected function handleRefreshRoom($socket) {
		$penguin = $this->penguins[$socket];
		
		$penguin->room->refreshRoom($penguin);
	}

}

?>
