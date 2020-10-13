<?php

namespace Kitsune\ClubPenguin\Plugins\Patched;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class PatchedItems extends Plugin {

	public $worldHandlers = array(
		"s" => array(
			"i#ai" => array("handleBuyInventory", self::Override)
		)
	);

	public $xmlHandlers = array(null);
	public $patchedItems = array(115, 152, 161, 183, 230, 335, 371, 442, 466, 532, 1000, 1001, 1002, 1003, 1032, 1034, 1044, 1068, 1107, 1200, 2030, 1235, 1273, 1274, 1275, 1384, 1458, 1459, 1476, 1521, 1562, 1682, 1805, 2102, 2113, 1999, 2000, 2007, 2009, 2015, 2034, 2087, 2999,3011, 3016, 3082, 3130, 3131, 3999, 4022, 4148, 4281, 4365, 4366, 4321, 4383, 4384, 4555, 4690, 4691, 4712, 4752, 4818, 4999, 5000, 5020, 5023, 5024, 5025, 5105, 5106, 5107, 5168, 5169, 5999, 6000, 6078, 6079, 6080, 6127, 6128, 6999);


	public function __construct($server) {
		$this->server = $server;
		}

	public function onReady() {
		parent::__construct(__CLASS__);

		Logger::Notice("The following items are unavailable: " . implode(", ", $this->patchedItems) . " (PatchedItems)");
	}

	public function handleBuyInventory($penguin, $itemId = null) {
		if($itemId === null) {
			$itemId = Packet::$Data[2];
		}

		if(!isset($this->server->items[$itemId])) {
			return $penguin->send("%xt%e%-1%402%"); // Item is unavailable
		} elseif(in_array($itemId, $penguin->inventory)) {
			return $penguin->send("%xt%e%-1%400%"); // Already owned item
		} elseif(in_array($itemId, $this->patchedItems)) {
			return $penguin->send("%xt%e%-1%402%"); // Item is unavailable
		}

		$cost = $this->server->items[$itemId];
		if($penguin->coins < $cost) {
			return $penguin->send("%xt%e%-1%401%"); // Not enough coins
		} else {
			$penguin->addItem($itemId, $cost);
		}

		if($itemId == 428) { // they're becoming a tour guide
			$time = time();
			$postcardId = $penguin->database->sendMail($penguin->id, "sys", 0, "", $time, 126);
			$penguin->send("%xt%mr%-1%sys%0%126%%$time%$postcardId%");
		}
	}

}

?>
