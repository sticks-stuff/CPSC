<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Message {

	protected function handleSendMessage($socket) {
		$penguin = $this->penguins[$socket];
		
		if(!$penguin->muted) {
			$message = Packet::$Data[3];
			
			$penguin->room->send("%xt%sm%{$penguin->room->internalId}%{$penguin->id}%$message%");
		}
	}
}

?>