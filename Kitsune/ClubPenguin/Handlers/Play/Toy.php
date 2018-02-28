<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Toy {

	// Maybe add spam-filter-thing for this?
	protected function handleClosePlayerBook($socket) {
		$penguin = $this->penguins[$socket];
		
		$penguin->room->send("%xt%rt%{$penguin->room->internalId}%{$penguin->id}%");
	}
	
	protected function handleOpenPlayerBook($socket) {
		$penguin = $this->penguins[$socket];
		$toyId = Packet::$Data[2];
		
		if(is_numeric($toyId) && is_numeric(Packet::$Data[3])) {
			$penguin->room->send("%xt%at%{$penguin->room->internalId}%{$penguin->id}%$toyId%1%");
		}
	}
	
}

?>