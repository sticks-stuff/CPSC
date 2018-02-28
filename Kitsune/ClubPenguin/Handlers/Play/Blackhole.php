<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Blackhole {

	protected function handleLeaveGame($socket) {
		$penguin = $this->penguins[$socket];
		
		$penguin->send("%xt%lnbhg%{$penguin->room->internalId}%{$penguin->room->externalId}%");
	}
	
}

?>