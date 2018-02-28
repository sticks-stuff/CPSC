<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait PlayerTransformation {

	protected function handleAvatarTransformation($socket) {
		$penguin = $this->penguins[$socket];
		
		$avatarId  = Packet::$Data[2];
		
		if(is_numeric($avatarId )) {
			$penguin->avatar = $avatarId;
			$penguin->database->updateColumnById($penguin->id, "Avatar", $avatarId);
			
			$penguin->room->send("%xt%spts%{$penguin->room->internalId}%{$penguin->id}%$avatarId%");
		}
	}
	
}

?>