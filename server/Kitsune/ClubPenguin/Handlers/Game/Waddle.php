<?php

namespace Kitsune\ClubPenguin\Handlers\Game;

use Kitsune\ClubPenguin\Room;
use Kitsune\ClubPenguin\Packets\Packet;

trait Waddle {

	public $waddlesById = array(
		103 => array('', ''), 102 => array('', ''), 101 => array('', '', ''), 100 => array('', '', '', ''),
		203 => array('', ''), 202 => array('', ''), 201 => array('', ''), 200 => array('', '')
	);

	public $waddleUsers = array();

	private $sledRacing = array(100, 101, 102, 103);
	private $cardJitsu = array(200, 201, 202, 203);

	private $waddleRoomId = null;

	private $match = array();

	public $waddleRooms = array();

	protected function handleGetWaddlesPopulationById($socket) {
		$penguin = $this->penguins[$socket];

		$waddleIds = array_splice(Packet::$Data, 2);

		$waddlePopulation = implode('%', array_map(
			function($waddleId) {
				return sprintf("%d|%s", $waddleId, implode(',', $this->waddlesById[$waddleId]));
			}, $waddleIds
		));

		$penguin->send("%xt%gw%{$penguin->room->internalId}%$waddlePopulation%");
	}

	protected function handleSendJoinWaddleById($socket) {
		$penguin = $this->penguins[$socket];

		$this->leaveWaddle($penguin);

		if(is_numeric(Packet::$Data[2])) {
        $waddleId = Packet::$Data[2];
        }

		$playerSeat = isset($this->waddleUsers[$waddleId]) ? sizeof($this->waddleUsers[$waddleId]) : 0;

		$this->waddleUsers[$waddleId][$playerSeat] = $penguin;
		$this->waddlesById[$waddleId][$playerSeat] = $penguin->username;

		$penguin->send("%xt%jw%{$penguin->room->internalId}%$playerSeat%");

		if($playerSeat === sizeof($this->waddlesById[$waddleId]) - 1) {
			$this->startWaddle($waddleId);
		}

		$penguin->room->send("%xt%uw%-1%$waddleId%$playerSeat%{$penguin->username}%");
	}

	private function startWaddle($waddleId) {
		foreach($this->waddlesById[$waddleId] as $seatIndex => $playerSeat) {
			$this->waddlesById[$waddleId][$seatIndex] = '';
		}

		if($this->waddleRoomId === null) {
			$this->waddleRoomId = strlen("Kitsune");
		}

		$this->waddleRoomId++;

		$roomId = $this->determineRoomId($waddleId);
		$internalId = $this->rooms[$roomId]->internalId;

		$waddleRoomId = ($this->waddleRoomId * 42) % 365;

		$this->waddleRooms[$waddleRoomId] = new Room($roomId, $internalId, false);

		$userCount = sizeof($this->waddleUsers[$waddleId]);
		$seatID = 0;
		foreach($this->waddleUsers[$waddleId] as $waddlePenguin) {
			$waddlePenguin->waddleRoom = $waddleRoomId;
			$waddlePenguin->waddleId = $waddleId;
			$waddlePenguin->seatID = $seatID;
			if(in_array($waddleId, $this->cardJitsu)) {
				$waddlePenguin->send("%xt%scard%0%$roomId%$waddleRoomId%$userCount%");
				$waddlePenguin->send("%xt%sw%{$waddlePenguin->room->internalId}%$roomId%$waddleRoomId%$userCount%");
			} else {
				$waddlePenguin->send("%xt%sw%{$waddlePenguin->room->internalId}%$roomId%$waddleRoomId%$userCount%");
			}
			$seatID++;

		}

		$this->waddleUsers[$waddleId] = array();
	}

	private function determineRoomId($waddleId) {
		switch($waddleId) {
			case 100:
			case 101:
			case 102:
			case 103:
				return 999;
			case 200:
			case 201:
			case 202:
			case 203:
				return 998;
		}
	}

	protected function handleLeaveWaddle($socket) {
		$penguin = $this->penguins[$socket];

		$this->leaveWaddle($penguin);
	}

	public function leaveWaddle($penguin) {
		foreach($this->waddleUsers as $waddleId => $leWaddle) {
			foreach($leWaddle as $playerSeat => $waddlePenguin) {
				if($waddlePenguin == $penguin) {
					$penguin->room->send("%xt%uw%-1%$waddleId%$playerSeat%");

					$this->waddlesById[$waddleId][$playerSeat] = '';
					unset($this->waddleUsers[$waddleId][$playerSeat]);

					if($penguin->waddleRoom !== null) {
						$penguin->room->remove($penguin);

						if(empty($this->waddleRooms[$penguin->waddleRoom]->penguins)) {
							unset($this->waddleRooms[$penguin->waddleRoom]);
						}

						$penguin->waddleRoom = null;
						$penguin->waddleId = null;
					}

					break;
				}
			}
		}
	}

	protected function handleJoinWaddle($socket) {
		$penguin = $this->penguins[$socket];

		$penguin->room->remove($penguin);

		if(is_numeric(Packet::$Data[2])) {
        $roomId = Packet::$Data[2];
        }

		if($penguin->waddleRoom !== null) {
			$this->waddleRooms[$penguin->waddleRoom]->add($penguin);
		}
	}

	protected function handleJoinMatchMaking($socket) { // this is all temporary
		$penguin = $this->penguins[$socket];

		if(is_numeric(Packet::$Data[1])) {
        $waddleID = Packet::$Data[1];
        }

		array_push($this->match, $penguin);

		$matchReady = count($this->match) == 2;

		if($matchReady) {
			if($this->waddleRoomId === null) {
				$this->waddleRoomId = strlen("Kitsune");
			}

			$this->waddleRoomId++;

			$roomId = 998;
			$internalId = $this->rooms[$roomId]->internalId;

			$waddleRoomId = ($this->waddleRoomId * 42) % 365;

			$this->waddleRooms[$waddleRoomId] = new Room($roomId, $internalId, true);
			$penguin->send("%xt%jmm%0%{$penguin->username}%");
			list($firstPlayer, $secondPlayer) = $this->match;
			$playerSeat = 0;
			foreach($this->match as $waddlePenguin) {
				$waddlePenguin->send("%xt%tmm%$waddleID%-1%{$this->match[0]->username}%{$this->match[1]->username}%");
				$waddlePenguin->waddleRoom = $waddleRoomId;
				$waddlePenguin->waddleID = $waddleID;
				$waddlePenguin->seatID = $playerSeat;
				$waddlePenguin->send("%xt%scard%$waddleID%$roomId%$waddleRoomId%1%1%null%");
				$playerSeat++;
			}
			$this->match = array();
		} else {
			$penguin->send("%xt%jmm%-1%{$penguin->username}%");
		}
	}

	protected function handleJoinSensei($socket) {
		$penguin = $this->penguins[$socket];
		$this->leaveWaddle($penguin);
		if(is_numeric(Packet::$Data[1])) {
        $waddleID = Packet::$Data[1];
        }
		if($this->waddleRoomId === null) {
			$this->waddleRoomId = strlen("Kitsune");
		}
		$this->waddleRoomId++;

		$roomId = 998;
		$internalId = $this->rooms[$roomId]->internalId;

		$waddleRoomId = ($this->waddleRoomId * 42) % 365;
		$seat = 1;
		$penguin->waddleRoom = $waddleRoomId;
		$penguin->waddleID = $waddleID;
		$penguin->seatID = $seat;
		$penguin->sensei = true;
		$this->waddleRooms[$waddleRoomId] = new Room($roomId, $internalId, true);
		//array_push($this->cardJitsuWaddles, $waddleID);
		$penguin->send("%xt%scard%$waddleID%$roomId%$waddleRoomId%1%1%null%");
	}
	
}

?>
