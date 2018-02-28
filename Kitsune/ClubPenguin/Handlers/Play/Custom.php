<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Custom {

	protected function handleConnectionLost($socket) {
		$penguin = $this->penguins[$socket];
		$penguin->send("%xt%con%");
	}

	protected function handleSpyPhone($socket) {
		$penguin = $this->penguins[$socket];
		$isSpy = Packet::$Data[2]; // Vulnerable to playerstring injection, change if you want
		$penguin->send("%xt%spy%{$penguin->room->internalId}%{$penguin->id}%$isSpy%");
	}

	protected function handleCheckInventory($socket) {
		$penguin = $this->penguins[$socket];
		$itemId = 413;
		$inventoryList = implode('%', $penguin->inventory);
		if(strpos($inventoryList, $itemId) !== false) {
			Logger::Debug("[CheckInventory]: Found Beta Hat!");
			$penguin->send("%xt%qi%-1%$inventoryList%");
		}
	}

	protected function handleCheckName($socket) {
		$penguin = $this->penguins[$socket];
		$nameId = Packet::$Data[2]; // Vulnerable to playerstring injection, change if you want
		$penguin->send("%xt%checkname%-1%$nameId%");
	}

	public function handlePlayerIdk($socket) {
		$penguin = $this->penguins[$socket];
		$x = Packet::$Data[2]; // Vulnerable to playerstring injection, change if you want
		$penguin->send("%xt%pbsu%-1%$x%");
	}

	public function handlePlayerIdk2($socket) {
		$penguin = $this->penguins[$socket];
		$penguin->send("%xt%pbsms%-1%");
	}

	public function handlePlayerIdk3($socket) {
		$penguin = $this->penguins[$socket];
		$x = Packet::$Data[2]; // Vulnerable to playerstring injection, change if you want
		$penguin->send("%xt%pbsm%-1%$x%");
	}

	public function handlePlayerIdk4($socket) {
		$penguin = $this->penguins[$socket];
		$penguin->send("%xt%pbsmf%-1%");
	}

	public function handleSettings($socket) { // Map settings for AS3
		$penguin = $this->penguins[$socket];
		$penguin->send('%xt%gabcms%-1%{"FurnitureCatalogueLocationTest":{"variant":0},"PreActivatedPlay":{"num_seconds_play":604800,"num_seconds_grace":172800,"variant":1},"MapTest":{"MapSettingId":0,"variant":0},"PuffleOopsMemberVsFree":{"variant":2},"BOGO":{"pageId":0},"HelloRockhopperTest":{"YarrColourID":5},"MembershipUpsell":{"free":"Limited Play","membership":"Unlimited Play"},"JustForTest":{"Last":"Smith","First":"John"},"NewPlayerLoginRoom":{"roomId":100,"variant":1},"FurnitureCatalogTest":{"catalogID":1,"variant":1},"XDayTrialOffers":{"TrialMembershipSettingID":2,"variant":2},"PenguinStyleTest":{"catalogID":"1"},"ClientConfigTest":{"icon":"http://www.clubpenguin.com/sites/default/files/EN0130-PuffleParty-Homepage-Billboard-Main-1361908642-1362026304.jpg","ShowLevelAccessPopup":true,"ClassName":"MemberGameLevel2","BonusPoints":500},"EndGameScreenTest":{"variant":0},"DinosaurTransformTest":{"variant":0},"QuestTest":{"startRoom":100,"isControl":false,"variant":1},"TeenBeachItems":{"CatalogID":"0"}}%');
	}

	public function handleMessageShit($socket) {
		$penguin = $this->penguins[$socket];
		$x = Packet::$Data[2]; // Vulnerable to playerstring injection, change if you want
		return base64_decode($x);
	}

}

?>