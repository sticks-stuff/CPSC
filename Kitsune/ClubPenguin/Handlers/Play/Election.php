<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Election {

	protected function handleDonateCoins($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $id = Packet::$Data[2];
        }
        if(is_numeric(Packet::$Data[2])){
        $amount = Packet::$Data[2];
        }
		if($penguin->coins < $amount) {
			return $penguin->send("%xt%e%-1%401%");
		}
		$penguin->setCoins($penguin->coins - $amount);
		$penguin->send("%xt%dc%$id%{$penguin->coins}%");
	}
	
}

?>