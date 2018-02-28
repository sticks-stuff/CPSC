<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Mail {

	protected function handleGetMail($socket) {
		$penguin = $this->penguins[$socket];
		
		$receivedPostcards = $penguin->database->getPostcardsById($penguin->id);
		$receivedPostcards = array_reverse($receivedPostcards, true);
		
		$penguinPostcards = implode('%', array_map(
			function($postcard) {			
				return implode('|', $postcard);
			}, $receivedPostcards
		));
		
		$penguin->send("%xt%mg%-1%$penguinPostcards%");
	}
	
	protected function handleStartMailEngine($socket) {
		$penguin = $this->penguins[$socket];
		
		$unreadCount = $penguin->database->getUnreadPostcardCount($penguin->id);
		$postcardCount = $penguin->database->getPostcardCount($penguin->id);
		
		$penguin->send("%xt%mst%-1%$unreadCount%$postcardCount%");
	}
	
	protected function handleSendMailItem($socket) {
		$penguin = $this->penguins[$socket];

		if(is_numeric(Packet::$Data[2])) {
        $recipientId = Packet::$Data[2];
        }

		$postcardType = Packet::$Data[3];
		
		if($penguin->database->playerIdExists($recipientId) && is_numeric($postcardType)) {
			if($penguin->coins < 10) {
				$penguin->send("%xt%ms%{$penguin->room->internalId}%{$penguin->coins}%2%");
			} else {
				$postcardCount = $penguin->database->getPostcardCount($recipientId);
				if($postcardCount == 100) {
					$penguin->send("%xt%ms%{$penguin->room->internalId}%{$penguin->coins}%0%");
				} else {
					$penguin->setCoins($penguin->coins - 10);
					
					$sentDate = time();
					$postcardId = $penguin->database->sendMail($recipientId, $penguin->username, $penguin->id, "", $sentDate, $postcardType);
					$penguin->send("%xt%ms%{$penguin->room->internalId}%{$penguin->coins}%1%");
					
					if(isset($this->penguinsById[$recipientId])) {
						$this->penguinsById[$recipientId]->send("%xt%mr%-1%{$penguin->username}%{$penguin->id}%$postcardType%%$sentDate%$postcardId%");
					}
				}
			}
		}
	}
	
	protected function handleMailChecked($socket) {
		$penguin = $this->penguins[$socket];
		
		$penguin->database->mailChecked($penguin->id);
	}
	
	protected function handleDeleteMailItem($socket) {
		$penguin = $this->penguins[$socket];
		
		$postcardId = Packet::$Data[2];
		
		if(is_numeric($postcardId) && $penguin->database->ownsPostcard($postcardId, $penguin->id)) {
			$penguin->database->deleteMail($postcardId);
		}
	}
	
	protected function handleDeleteMailFromUser($socket) {
		$penguin = $this->penguins[$socket];
		
		$penguinId = Packet::$Data[2];
		
		if(is_numeric($penguinId)) {
			$penguin->database->deleteMailFromUser($penguin->id, $penguinId);
			$postcardCount = $penguin->database->getPostcardCount($penguin->id);
			
			$penguin->send("%xt%mdp%{$penguin->room->internalId}%$postcardCount%");
		}
	}

}

?>