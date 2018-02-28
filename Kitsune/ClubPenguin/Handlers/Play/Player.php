<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Player {

	protected function handleGetLastRevision($socket) {
		$this->penguins[$socket]->send("%xt%glr%-1%10915%");
	}

	protected function handleLoadPlayerObject($socket) {
		$penguin = $this->penguins[$socket];
		$playerId = Packet::$Data[2];
		if($penguin->database->playerIdExists($playerId)) {
			$playerArray = $penguin->database->getColumnsById($playerId, array("Username", "Color", "Head", "Face", "Neck", "Body", "Hand", "Feet", "Flag", "Photo"));
			array_splice($playerArray, 1, 0, array(45));
			$playerString = implode("|", $playerArray);
			$penguin->send("%xt%gp%{$penguin->room->internalId}%$playerId|$playerString%");
		}
	}

protected function handleSendPlayerMove($socket) {
        $penguin = $this->penguins[$socket];

        if(is_numeric(Packet::$Data[2]) && is_numeric(Packet::$Data[3])) {
            $penguin->x = Packet::$Data[2];
            $penguin->y = Packet::$Data[3];
        }
        $penguin->frame = 1;
        $penguin->room->send("%xt%sp%{$penguin->room->internalId}%{$penguin->id}%{$penguin->x}%{$penguin->y}%");
    }

	protected function handleSendPlayerFrame($socket) {
		$penguin = $this->penguins[$socket];

		$penguin->frame = Packet::$Data[2];
		//if($penguin->frame == 26) {
			//$penguin->room->send("%xt%sf%{$penguin->room->internalId}%{$penguin->id}%18%"); // 18 = Sledrace join frame
		//}
		$penguin->room->send("%xt%sf%{$penguin->room->internalId}%{$penguin->id}%{$penguin->frame}%");
	}

protected function handleSendHeartbeat($socket) {
    $penguin = $this->penguins[$socket];
            
    $penguin->send("%xt%h%{$penguin->room->internalId}%");
}

	protected function handleUpdatePlayerAction($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])) {
        $actionId = Packet::$Data[2];
        }
		$penguin->room->send("%xt%sa%{$penguin->room->internalId}%{$penguin->id}%{$actionId}%");
	}

	protected function handleSendEmote($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])) {
        $emoteId = Packet::$Data[2];
        }
		$penguin->room->send("%xt%se%{$penguin->room->internalId}%{$penguin->id}%$emoteId%");
	}

	protected function handlePlayerThrowBall($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])) {
        $x = Packet::$Data[2];
        }
        if(is_numeric(Packet::$Data[3])) {
        $y = Packet::$Data[3];
        }
		$penguin->room->send("%xt%sb%{$penguin->room->internalId}%{$penguin->id}%$x%$y%");
	}

	protected function handleGetBestFriendsList($socket) {
		$penguin = $this->penguins[$socket];
		$penguin->send("%xt%gbffl%{$penguin->room->internalId}%");
	}

	protected function handleSafeMessage($socket) {
		$penguin = $this->penguins[$socket];
		
		$messageId = Packet::$Data[2];

		if(is_numeric($messageId)) {
			$penguin->room->send("%xt%ss%{$penguin->room->internalId}%{$penguin->id}%$messageId%");
		}
	}

	protected function handleSendJoke($socket) {
		$penguin = $this->penguins[$socket];

		$jokeId = Packet::$Data[2];

		if(is_numeric($jokeId)) {
			$penguin->room->send("%xt%sj%{$penguin->room->internalId}%{$penguin->id}%$jokeId%");
		}
	}

	protected function handleSendLineMessage($socket) {
		$penguin = $this->penguins[$socket];

		$lineId = Packet::$Data[2];

		if(is_numeric($lineId)) {
			$penguin->room->send("%xt%sl%{$penguin->room->internalId}%{$penguin->id}%$lineId%");
		}
	}
	
	protected function handleSendTourGuideMessage($socket) {
		$penguin = $this->penguins[$socket];
		
		$messageId = Packet::$Data[2];

		if(is_numeric($messageId)) {
			$penguin->room->send("%xt%sg%{$penguin->room->internalId}%{$penguin->id}%$messageId%");
		}
	}

	protected function handleSendMascotMessage($socket) { // Added by Zaseth
		$penguin = $this->penguins[$socket];

		$mascotMessage = Packet::$Data[2];

		if(is_numeric($mascotMessage)) {
			$penguin->room->send("%xt%sma%{$penguin->room->internalId}%{$penguin->id}%$mascotMessage%");
		}
	}

}

?>
