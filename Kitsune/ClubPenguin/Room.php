<?php

namespace Kitsune\ClubPenguin;

class Room {

	public $penguins = array();

	public $externalId;
	public $internalId;

	public function __construct($externalId, $internalId, $isGame) {
		$this->externalId = $externalId;
		$this->internalId = $internalId;
		$this->isGame = $isGame;
	}

	public function add($penguin) {
		array_push($this->penguins, $penguin);
		
		if($this->externalId == 999 || $this->externalId == 998) {
			$penguin->send("%xt%jx%{$penguin->room->internalId}%{$this->externalId}%");
		} else {
			if($this->isGame) {
				if($penguin->room->externalId > 1000) {
					return;
                                        echo "Idk what to do but ok";
				}
				$nonBlackholeGames = array();

				if(in_array($this->externalId, $nonBlackholeGames)) {
					$penguin->send("%xt%jnbhg%{$this->internalId}%{$this->externalId}%");
				} else {
					$penguin->send("%xt%jg%{$this->internalId}%{$this->externalId}%");
				}
			} else {
				$roomString = $this->getRoomString();
				$penguin->send("%xt%jr%{$this->internalId}%{$this->externalId}%$roomString%");
				$this->send("%xt%ap%{$this->internalId}%{$penguin->getPlayerString()}%");
			}
		}
			
		$penguin->room = $this;
	}

	public function remove($penguin) {
		$playerIndex = array_search($penguin, $this->penguins);
		unset($this->penguins[$playerIndex]);
		$this->send("%xt%rp%{$this->internalId}%{$penguin->id}%");
	}

	public function send($data) {
		foreach($this->penguins as $penguin) {
			$penguin->send($data);
		}
	}

	public function refreshRoom($penguin) {
		$penguin->send("%xt%grs%-1%{$this->externalId}%{$this->getRoomString()}%");
	}

	private function getRoomString() {
		$roomString = implode('%', array_map(function($penguin) {
			return $penguin->getPlayerString();
		}, $this->penguins));

		return $roomString;
	}

	private function handleCRL($socket) {
     $penguin = $this->penguins[$socket];
     $questArray = array("CompletedQuest" => false, "QuestAvailable" => false, "QuestData" => "0,0,0,0,0");
     $penguin->send("%xt%sgs%");
     $penguin->send("%xt%equest%" . json_encode($questArray) . "%" . $penguin->room->internalId . "%");
   }

}

?>

