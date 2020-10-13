<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Setting {

	protected function handleSendUpdatePlayerClothing($socket) {
		$penguin = $this->penguins[$socket];
		
		$itemId = Packet::$Data[2];
		$clothingType = substr(Packet::$Data[0], 2);
		
		$clothing = array(
			"upc" => "Color",
			"uph" => "Head",
			"upf" => "Face",
			"upn" => "Neck",
			"upb" => "Body",
			"upa" => "Hand",
			"upe" => "Feet",
			"upp" => "Photo",
			"upl" => "Flag"
		);
		
		if(isset($clothing[$clothingType]) && is_numeric($itemId) && (in_array($itemId, $penguin->inventory) || $itemId == 0)) {
			call_user_func(array($penguin, "update{$clothing[$clothingType]}"), $itemId);
		}
	}
	
}

?>