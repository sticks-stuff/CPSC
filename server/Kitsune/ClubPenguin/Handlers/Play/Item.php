<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Item {

	protected function handleGetInventoryList($socket) {
		$penguin = $this->penguins[$socket];

		$inventoryList = implode('%', $penguin->inventory);
		$penguin->send("%xt%gi%-1%$inventoryList%");
	}

	protected function handleBuyInventory($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])) {
        $itemId = Packet::$Data[2];
        }

		if(!isset($this->items[$itemId])) {
			return $penguin->send("%xt%e%-1%402%");
		} elseif(in_array($itemId, $penguin->inventory)) {
			return $penguin->send("%xt%e%-1%400%");
		}

		$cost = $this->items[$itemId];
		if($penguin->coins < $cost) {
			return $penguin->send("%xt%e%-1%401%");
		} else {
			$penguin->addItem($itemId, $cost);
		}

		if($itemId == 428) { // they're becoming a tour guide
			$time = time();
			$postcardId = $penguin->database->sendMail($penguin->id, "sys", 0, "", $time, 126);
			$penguin->send("%xt%mr%-1%sys%0%126%%$time%$postcardId%");
		}
	}

	protected function handleGetPlayerPins($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2])){
        $playerId = Packet::$Data[2];
        }
		$pins = "";

			$inventory = explode('%', $penguin->database->getColumnById($playerId, "Inventory"));
			foreach($this->pins as $pin){
				if(in_array($pin, $inventory)){
					$pins .= "$pin|".time()."|0%";
				}
			}
			$pins = rtrim($pins, "%");
			$penguin->send("%xt%qpp%-1%$pins%");
	}

	protected function handleGetPlayerAwards($socket) {
		$penguin = $this->penguins[$socket];
        if(is_numeric(Packet::$Data[2])){
        $playerId = Packet::$Data[2];
        }
		$penguin->send("%xt%qpa%-1%$playerId%%");
	}

}

?>
