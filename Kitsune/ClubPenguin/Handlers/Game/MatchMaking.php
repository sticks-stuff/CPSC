<?php

namespace Kitsune\ClubPenguin\Handlers\Game;

use Kitsune\Events;
use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;

trait MatchMaking {

	public $tickEventIndex;
	
	public $matches = array();
	
	public function handleJoinMatchMaking($socket) {
		$penguin = $this->penguins[$socket];
		
		if(is_numeric(Packet::$Data[1])) {
        $roomId = Packet::$Data[1];
        }
		
		if(!isset($this->matches[$roomId])) {
			$this->matches[$roomId]["players"] = array($penguin);
		} else {
			$this->matches[$roomId]["players"][] = $penguin;
		}
		
		$penguin->send("%xt%jmm%-1%{$penguin->username}%");
		
		if(!isset($this->tickEventIndex)) {
			$this->tickEventIndex = Events::AppendInterval(1, array($this, "tickMatches"));
		}
	}
	
	public function handleLeaveMatchMaking($socket) {
		$penguin = $this->penguins[$socket];
		
		if(is_numeric(Packet::$Data[1])) {
        $roomId = Packet::$Data[1];
        }
		
		$this->leaveMatch($penguin);
	}
	
	public function leaveMatch($penguin) {
		if(!isset($this->matches[$penguin->room->externalId])) {
			return;
		}
		
		$playerKey = array_search($penguin, $this->matches[$penguin->room->externalId]["players"]);
		if($playerKey) {
			unset($this->matches[$penguin->room->externalId]["players"][$playerKey]);
		} else {
			return false;
		}
	}
	
	public function tickMatches() {
		foreach($this->matches as $roomId => $match) {
			if(!isset($match["tick"])) {
				$canStart = count($this->matches[$roomId]["players"]) == 2;
				if($canStart) {
					$this->matches[$roomId]["tick"] = 10;
				} else {
					return;
				}
			} elseif($match["tick"] > -1) {
				$this->matches[$roomId]["tick"]--;
			}
			
			$tickCount = $this->matches[$roomId]["tick"];
			
			$matchPlayers = array();
			foreach($this->matches[$roomId]["players"] as $matchPlayer) {
				$matchPlayers[] = $matchPlayer->username;
			}
			
			if($tickCount == -1) {
				foreach($this->matches[$roomId]["players"] as $matchPlayer) {
					$matchPlayer->send("%xt%tmm%-1%$tickCount%" . implode("%", $matchPlayers) . "%");
				}
				
				if(count($this->matches[$roomId]["players"]) < 2) {
					unset($this->matches[$roomId]["tick"]);
				} else {
					foreach($this->matches[$roomId]["players"] as $matchPlayer) {
						$matchPlayer->send("%xt%scard%-1%");
					}
					unset($this->matches[$roomId]);
				}
			} else {
				foreach($this->matches[$roomId]["players"] as $matchPlayer) {
					$matchPlayer->send("%xt%tmm%-1%$tickCount%");
				}
			}
		}
	}
}

?>