<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Stampbook {

	protected function handleStampAdd($socket) {
		$penguin = $this->penguins[$socket];
		$stampId = Packet::$Data[2];
		if(is_numeric($stampId)){
			$stamps = $penguin->database->getColumnById($penguin->id, "Stamps");
			if(strpos($stamps, $stampId.",") === false) {
				$penguin->database->updateColumnById($penguin->id, "Stamps", $stamps . $stampId . ",");
				$penguin->send("%xt%aabs%-1%$stampId%{$penguin->coins}%");
				$penguin->recentStamps .= $stampId."|";
			}
		}
	}

	protected function addStamp($penguin, $stampId) {
		if(is_numeric($stampId)){
			$stamps = $penguin->database->getColumnById($penguin->id, "Stamps");
			if(strpos($stamps, $stampId.",") === false) {
				$penguin->database->updateColumnById($penguin->id, "Stamps", $stamps . $stampId . ",");
				$penguin->send("%xt%aabs%-1%$stampId%");
				$penguin->recentStamps .= $stampId."|";
			}
		}
	}

	protected function handleGetStamps($socket) {
		$penguin = $this->penguins[$socket];
		$playerId = Packet::$Data[2];
		if(is_numeric($playerId)) {
			$stamps = rtrim(str_replace(",", "|", $penguin->database->getColumnById($playerId, "Stamps")), "|");
			$penguin->send("%xt%gps%-1%$playerId%$stamps%");
		}
	}

	protected function handleGetRecentStamps($socket) {
		$penguin = $this->penguins[$socket];

		$recentStamps = rtrim($penguin->recentStamps, "|");
		$penguin->send("%xt%gmres%-1%$recentStamps%");
	}

	protected function handleGetBookCover($socket) {
		$penguin = $this->penguins[$socket];
		$penguinId = Packet::$Data[2];
		if(is_numeric($penguinId)) {
			$stampBook = $penguin->database->getColumnById($penguinId, "StampBook");
			$penguin->send("%xt%gsbcd%-1%$stampBook%");
		}
	}

	protected function handleUpdateBookCover($socket) {
		$penguin = $this->penguins[$socket];
		if(is_numeric(Packet::$Data[2]) && is_numeric(Packet::$Data[3]) && is_numeric(Packet::$Data[4]) && is_numeric(Packet::$Data[5])) {
			$newCover = Packet::$Data[2]."%".Packet::$Data[3]."%".Packet::$Data[4]."%".Packet::$Data[5];

			if(count(Packet::$Data) > 5) {
				foreach(range(6, 12) as $num) {
					if(isset(Packet::$Data[$num])) {
						$update = true;
						$details = explode("|", Packet::$Data[$num]);
						foreach($details as $extra) {
							if(!is_numeric($extra)) {
								$update = false;
							}
						}
						$stamps = explode(",", $penguin->database->getColumnById($penguin->id, "Stamps"));
						if(!in_array($details[1], $stamps) && !in_array($details[1], $this->pins)) {
							$update = false;
						}
						if($update) {
							$newCover .= "%" . Packet::$Data[$num];
						}
					}
				}
			}

			$penguin->database->updateColumnById($penguin->id, "StampBook", $newCover);
		}
		$penguin->send("%xt%ssbcd%-1%");
	}

}

?>
