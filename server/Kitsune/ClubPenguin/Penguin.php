<?php

namespace Kitsune\ClubPenguin;

use Kitsune;
use Kitsune\Logging\Logger;

class Penguin {

	public $id;
	public $username;
	public $nickname;
	public $swid;
	
	public $identified = false;
	public $seenMessage;
	public $randomKey;

	public $color, $head, $face, $neck, $body, $hand, $feet, $photo, $flag;
	public $age;

	public $coins;

	public $careInventory = array();
	public $inventory = array();

	public $moderator;
	public $muted = false;

	public $membershipDays;
	public $badgeLevel;

	public $loginTime;
	public $minutesPlayed;

	public $activeIgloo;

	public $furniture = array();
	public $locations = array();
	public $floors = array();
	public $igloos = array();
	public $recentStamps = "";

	public $activeTime;
	
	public $buddies = array();
	public $buddyRequests = array();

	public $ignore = array();

	public $x = 0;
	public $y = 0;
	public $frame;

	public $tableId = null;
	public $waddleId = null;

	public $waddleRoom = null; // Not an object!
	public $room;
	public $waddleID;
	public $seatID;

	public $walkingPuffle = array();
	public $puffleQuest = array();

	public $lastPaycheck;

	public $NinjaBelt;
	public $NinjaPercentage;
	public $sensei = false;

	public $socket;
	public $database;
	public $clientPlatform;

	public $msgviewed;
	public $questtasks;
	public $sw_points;
	public $qc_msg;

	public $isNew;

	public $userCount;

	public $walls;

	public $zombie = false;

	public $handshakeStep = null;
	public $ipAddress = null;

	public $avatar;
	public $transformation;
	public $avatarAttributes;

	public $status = 0;
	public $career = 0;
	public $points = 0;

	public $nameglow, $beaks, $namecolor, $bubblecolor, $bubbleglow, $penguinglow, $ringcolor, $moodcolor, $moodglow, $title, $mood, $titlecolor, $titleglow, $size, $alpha, $speed, $blend, $marry, $bff;

	public function __construct($socket) {
		$this->socket = $socket;
		socket_getpeername($socket, $this->ipAddress);
		// $this->database = new Kitsune\Database();
	}

	public function addCoins($coins) {
		$totalCoins = $this->coins + $coins;
		$this->setCoins($totalCoins);
	  $this->send("%xt%zo%{$this->room->internalId}%$totalCoins%"); // Originally had -1, patched
	}

	public function mineCoins($coins) {
        $totalCoins = $this->coins + $coins;
        $this->setCoins($totalCoins);
    }

	public function setCoins($coinAmount) {
		$this->coins = $coinAmount;

		$this->database->updateColumnById($this->id, "Coins", $this->coins);
	}

	public function updateGlows() {
		$this->room->send('%xt%up%' . $this->room->internalId . '%' . $this->getPlayerString() . '%');
	}
	
	public function buyIgloo($iglooId, $cost = 0) {
		array_push($this->igloos, $iglooId);

		$igloosString = implode(',', $this->igloos);

		$this->database->updateColumnById($this->id, "Igloos", $igloosString);

		if($cost !== 0) {
			$this->setCoins($this->coins - $cost);
		}

		$this->send("%xt%au%{$this->room->internalId}%$iglooId%{$this->coins}%");
	}

	public function buyFloor($floorId, $cost = 0) {
		$this->database->updateIglooColumn($this->activeIgloo, "Floor", $floorId);

		if($cost !== 0) {
			$this->setCoins($this->coins - $cost);
		}

		$this->send("%xt%ag%{$this->room->internalId}%$floorId%{$this->coins}%");
	}

	public function buyFurniture($furnitureId, $cost = 0) {
		$furnitureQuantity = 1;

		if(isset($this->furniture[$furnitureId])) {
			$furnitureQuantity = $this->furniture[$furnitureId];

			$furnitureQuantity += 1;

			if($furnitureQuantity >= 100) {
				return;
			}
		}

		$this->furniture[$furnitureId] = $furnitureQuantity;

		$furnitureString = implode(',', array_map(
			function($furnitureId, $furnitureQuantity) {
				return $furnitureId . '|' . $furnitureQuantity;
			}, array_keys($this->furniture), $this->furniture));

		$this->database->updateColumnById($this->id, "Furniture", $furnitureString);

		if($cost !== 0) {
			$this->setCoins($this->coins - $cost);
		}

		$this->send("%xt%af%{$this->room->internalId}%$furnitureId%{$this->coins}%");
	}

	public function updateColor($itemId) {
		if(is_numeric($itemId)) {
        $this->color = $itemId;
        }
		$this->database->updateColumnById($this->id, "Color", $itemId);
		$this->room->send("%xt%upc%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updateHead($itemId) {
		if(is_numeric($itemId)) {
        $this->head = $itemId;
        }
		$this->database->updateColumnById($this->id, "Head", $itemId);
		$this->room->send("%xt%uph%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updateFace($itemId) {
		if(is_numeric($itemId)) {
        $this->face = $itemId;
        }
		$this->database->updateColumnById($this->id, "Face", $itemId);
		$this->room->send("%xt%upf%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updateNeck($itemId) {
		if(is_numeric($itemId)) {
        $this->neck = $itemId;
        }
		$this->database->updateColumnById($this->id, "Neck", $itemId);
		$this->room->send("%xt%upn%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updateBody($itemId) {
		if(is_numeric($itemId)) {
        $this->body = $itemId;
        }
		$this->database->updateColumnById($this->id, "Body", $itemId);
		$this->room->send("%xt%upb%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updateHand($itemId) {
		if(is_numeric($itemId)) {
        $this->hand = $itemId;
        }
		$this->database->updateColumnById($this->id, "Hand", $itemId);
		$this->room->send("%xt%upa%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updateFeet($itemId) {
		if(is_numeric($itemId)) {
        $this->feet = $itemId;
        }
		$this->database->updateColumnById($this->id, "Feet", $itemId);
		$this->room->send("%xt%upe%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updatePhoto($itemId) {
		if(is_numeric($itemId)) {
        $this->photo = $itemId;
        }
		$this->database->updateColumnById($this->id, "Photo", $itemId);
		$this->room->send("%xt%upp%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	public function updateFlag($itemId) {
		if(is_numeric($itemId)) {
        $this->flag = $itemId;
        }
		$this->database->updateColumnById($this->id, "Flag", $itemId);
		$this->room->send("%xt%upl%{$this->room->internalId}%{$this->id}%$itemId%");
	}

	private function refreshPlayer($color, $head, $face, $neck, $body, $hand, $feet, $photo, $flag, $badgeLevel)
	{
		$this->database->updateColumnById($this->id, "Color", $color);
	    $this->database->updateColumnById($this->id, "Head", $head);
	    $this->database->updateColumnById($this->id, "Face", $face);
	    $this->database->updateColumnById($this->id, "Neck", $neck);
	    $this->database->updateColumnById($this->id, "Body", $body);
	    $this->database->updateColumnById($this->id, "Hand", $hand);
	    $this->database->updateColumnById($this->id, "Feet", $feet);
	    $this->database->updateColumnById($this->id, "Photo", $photo);
	    $this->database->updateColumnById($this->id, "Flag", $flag);
	    $this->database->updateColumnById($this->id, "Rank", $badgeLevel);
	}

	public function sendCustomError($message){
		$global = "https://clubpenguinlite.pw/play/v2/client/pm.swf?msg=$message";
		$this->sendXt("lm", -1, $global);
	}

	public function noModerator(){ // Probably won't even work
		$message = Packet::$Data[3];
		$this->database->updateNoModeratorHistory($this->id, "Time", time());
		$this->database->updateNoModeratorHistory($this->id, "Message", $message);
	}

	/*public function sendError($intError) {
		$this->send("%xt%e%-1%" . $intError . "%");
	}*/

	public function updateNick($nickname)
	{
	$this->database->updateColumnById($this->id, "Nickname", $nickname);
	$this->getPlayerString();
	$this->loadPlayer();
	}

	public function handleTransformCommand($avatarID) {
	  $this->database->updateColumnById($this->id, "Avatar", $avatarID);
	  $this->room->send("%xt%spts%{$this->room->internalId}%{$this->id}%$avatarID%");
	  $this->getPlayerString();
	  $this->loadPlayer();
	}

	public function mascotItemUpdate($color, $head, $face, $neck, $body, $hand, $feet) {
		$this->database->updateColumnById($this->id, "Color", $color);
		$this->room->send("%xt%upc%{$this->room->internalId}%{$this->id}%$color%");
		$this->database->updateColumnById($this->id, "Head", $head);
		$this->room->send("%xt%uph%{$this->room->internalId}%{$this->id}%$head%");
		$this->database->updateColumnById($this->id, "Face", $face);
		$this->room->send("%xt%upf%{$this->room->internalId}%{$this->id}%$face%");
		$this->database->updateColumnById($this->id, "Neck", $neck);
		$this->room->send("%xt%upn%{$this->room->internalId}%{$this->id}%$neck%");
		$this->database->updateColumnById($this->id, "Body", $body);
		$this->room->send("%xt%upb%{$this->room->internalId}%{$this->id}%$body%");
		$this->database->updateColumnById($this->id, "Hand", $hand);
		$this->room->send("%xt%upa%{$this->room->internalId}%{$this->id}%$hand%");
		$this->database->updateColumnById($this->id, "Feet", $feet);
		$this->room->send("%xt%upe%{$this->room->internalId}%{$this->id}%$feet%");
	    $this->getPlayerString();
	    $this->loadPlayer();
	}

	public function addItem($itemId, $cost) {
		array_push($this->inventory, $itemId);

		$this->database->updateColumnById($this->id, "Inventory", implode('%', $this->inventory));

		if($cost !== 0) {
			$this->setCoins($this->coins - $cost);
		}
		if($this->badgeLevel == 6) {
			$cost = 99999;
			$this->setCoins($this->coins);
			$this->send("%xt%ai%{$this->room->internalId}%$itemId%{$this->coins}%");
		}

		$this->send("%xt%ai%{$this->room->internalId}%$itemId%{$this->coins}%");
	}

	public function walkPuffle($puffleId, $walkBoolean) {
        if($walkBoolean != 0) {
            $this->walkingPuffle = $this->database->getPuffleColumns($puffleId, array("Type"));
            $this->walkingPuffle = array_values($this->walkingPuffle);
            array_unshift($this->walkingPuffle, $puffleId);
        }

        list($id, $type) = $this->walkingPuffle;

        if($walkBoolean == 0) {
            $this->walkingPuffle = array();
        }

        $this->room->send("%xt%pw%{$this->room->internalId}%{$this->id}%$id%$type%$walkBoolean%");
    }

	public function loadPlayer() {
		$this->randomKey = null;

		$clothing = array("Color", "Head", "Face", "Neck", "Body", "Hand", "Feet", "Photo", "Flag", "Walking");
		$player = array("Avatar", "AvatarAttributes", "RegistrationDate", "Moderator", "Inventory", "Coins", "Rank", "Ignores", "MinutesPlayed", "LastPaycheck");
		$igloo = array("Furniture", "Igloos");
		$ninja = array("NinjaBelt", "NinjaPercentage");
		$glows = array("Namecolor", "Nameglow");
		$glows2 = array("bubbletext", "bubblecolour", "penguinglow", "snowballglow", "bubbleglow", "wow", "moodglow", "moodcolor", "ringcolour", "chatglow", "marry", "bff", "beaks", "speed", "penguin_blend", "penguin_alpha", "isCloneable", "title", "titlecolor", "titleglow", "mood");

		//$bot = array("RegistrationDate", "Moderator", "Inventory", "Coins", "Rank", "MinutesPlayed");

        $this->halloweenmsg = "[ " . $this->database->getColumnById($this->id, 'halloweenmsg') . "]";
        $this->halloweenquest = "[ " . $this->database->getColumnById($this->id, 'halloweenquest') . "]";
        $this->halloweenvisited = $this->database->getColumnById($this->id, 'halloweenvisited');

		$columns = array_merge($clothing, $player, $igloo, $ninja, $glows, $glows2);
		$playerArray = $this->database->getColumnsById($this->id, $columns);
		$this->NinjaBelt = $playerArray["NinjaBelt"];
		$this->NinjaPercentage = $playerArray["NinjaPercentage"];
		$furnitureArray = explode(',', $playerArray["Furniture"]);
		//$botArray = $this->database->getColumnsById($this->id, $columns);


		if(!empty($furnitureArray)) {
			list($firstFurniture) = $furnitureArray;
			list($furnitureId) = explode("|", $firstFurniture);

			if($furnitureId == "") {
				array_shift($furnitureArray);

				$furniture = implode(",", $furnitureArray);

				$this->database->updateColumnById($this->id, "Furniture", $furniture);
			}

			foreach($furnitureArray as $furniture) {
				$furnitureDetails = explode('|', $furniture);
				list($furnitureId, $quantity) = $furnitureDetails;

				$this->furniture[$furnitureId] = $quantity;
			}
		}

		if($playerArray["Walking"] != 0) {
            $puffle = $this->database->getPuffleColumns($playerArray["Walking"], array("Type"));
            $this->walkingPuffle = array_values($puffle);
            array_unshift($this->walkingPuffle, $playerArray["Walking"]);
            }

		$ignoreArray = explode('%', $playerArray["Ignores"]);

		if(!empty($ignoreArray)) {
			list($firstIgnore) = $ignoreArray;
			list($ignoreId) = explode("|", $firstIgnore);

			if($ignoreId == "") {
				array_shift($ignoreArray);

				$ignore = implode("%", $ignoreArray);

				$this->database->updateColumnById($this->id, "Ignores", $ignore);
			}

			foreach($ignoreArray as $ignore) {
				$ignoreDetails = explode('|', $ignore);
				list($ignoreId, $ignoreName) = $ignoreDetails;

				$this->ignore[$ignoreId] = $ignoreName;
			}
		}

		$this->buddies = $this->getBuddyList();

		$igloosArray = explode(',', $playerArray["Igloos"]);
		foreach($igloosArray as $iglooType) {
			array_push($this->igloos, $iglooType);
		}

		list($this->color, $this->head, $this->face, $this->neck, $this->body, $this->hand, $this->feet, $this->photo, $this->flag) = array_values($playerArray); // Idk if rank should be here

		$this->transformation = $this->database->getColumnById($this->id, 'transformation');
		$this->age = floor((strtotime("NOW") - $playerArray["RegistrationDate"]) / 86400);
		$this->membershipDays = $this->age;
		$this->badgeLevel = $playerArray["Rank"];
		$this->coins = $playerArray["Coins"];
		$this->moderator = (boolean)$playerArray["Moderator"];
		$this->inventory = explode('%', $playerArray["Inventory"]);
		$this->minutesPlayed = $playerArray["MinutesPlayed"];
		$this->lastPaycheck = $playerArray["LastPaycheck"];
		$this->avatar = $playerArray["Avatar"];
		$this->avatarAttributes = $playerArray["AvatarAttributes"];
		$this->namecolor = $playerArray["Namecolor"];
		$this->nameglow = $playerArray["Nameglow"];
		$this->bubbletext = $playerArray["bubbletext"];
		$this->bubblecolor = $playerArray["bubblecolour"];
		$this->penguinglow = $playerArray["penguinglow"];
		$this->snowballglow = $playerArray["snowballglow"];
		$this->bubbleglow = $playerArray["bubbleglow"];
		$this->ringcolor = $playerArray["ringcolour"];
		$this->chatglow = $playerArray["chatglow"];
		$this->title = $playerArray["title"];
		$this->speed = $playerArray["speed"];
		$this->titlecolor = $playerArray["titlecolor"];
		$this->titleglow = $playerArray["titleglow"];
		$this->wow = $playerArray["wow"];
		$this->beaks = $playerArray["beaks"];
		$this->marry = $playerArray["marry"];
		$this->bff = $playerArray["bff"];
	}

	public function getBuddyList() { // this is here because we need to use it before world login
		$buddies = $this->database->getColumnById($this->id, "Buddies");
		$buddyArray = explode('%', $buddies);

		$buddies = array();
		if(!empty($buddyArray)) {
			list($firstBuddy) = $buddyArray;
			list($firstBuddyId) = explode("|", $firstBuddy);

			if($firstBuddyId == "") {
				array_shift($buddyArray);

				$buddies = implode("%", $buddyArray);

				$this->database->updateColumnById($this->id, "Buddies", $buddies);
			}

			$buddies = array();

			foreach($buddyArray as $buddy) {
				$buddyDetails = explode('|', $buddy);
				list($buddyId, $buddyName) = $buddyDetails;

				$buddies[$buddyId] = $buddyName;
			}
		}
		return $buddies;
	}

	public function getPlayerString() {
		$player = array(
            $this->id,
            $this->username,
            45,
            $this->color,
            $this->head,
            $this->face,
            $this->neck,
            $this->body,
            $this->hand,
            $this->feet,
            $this->flag,
            $this->photo,
            $this->x,
            $this->y,
            $this->frame,
            1,
            146 * $this->badgeLevel,
            $this->avatar,
            0, //the null byte should go here instead of in the array_push
            $this->avatarAttributes,
						$this->nameglow,
						$this->namecolor,
						$this->bubblecolor,
						$this->bubbletext,
						$this->ringcolor,
						$this->speed,
						$this->title,
						$this->mood,
						$this->chatglow,
						$this->penguinglow,
						$this->bubbleglow,
						$this->moodglow,
						$this->moodcolor,
						$this->snowballglow,
						$this->wow,
						$this->titleglow,
						$this->titlecolor,
						$this->marry,
						$this->beaks,
						$this->bff
        );

		return implode('|', $player);
	}

	/*public function getBotString() {
		$bot = array(
			$this->id,
			$this->username, // "Bot"
			45,
			$this->color = 1,
			$this->head = 413,
			$this->face,
			$this->neck,
			$this->body,
			$this->hand,
			$this->feet,
			$this->flag,
			$this->photo,
			$this->x,
			$this->y,
			$this->frame,
			1,
			146 * $this->badgeLevel,
			$this->avatar,
			0,
			$this->avatarAttributes
		);

		return implode('|', $bot);
	}*/

	public function send($data) {
		Logger::Debug("Outgoing: $data");

		$data .= "\0";
		$bytesWritten = socket_send($this->socket, $data, strlen($data), 0);

		return $bytesWritten;
	}

	function sendXt(){ // Taken from Sweater!
		$arrStrings = func_get_args();
		$strPacket = '%xt%' . implode('%', $arrStrings) . '%';
		$this->send($strPacket);
	}

}

?>
