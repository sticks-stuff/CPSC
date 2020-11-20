<?php

namespace Kitsune\ClubPenguin\Plugins\Commands;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class Commands extends Plugin {
	
	//public $dependencies = array("PatchedItems" => "loadPatchedItems");
	public $dependencies = array(
		"PatchedItems" => "loadPatchedItems",
		//"AntiAd" => "loadAntiAd"
	);
	
	public $worldHandlers = array(
		"s" => array(
			"m#sm" => array("handlePlayerMessage", self::Both)
		)
	);
	
	public $xmlHandlers = array(null);
	
	public $commandPrefixes = array("!", "/", "~");
	
	public $commands = array(
		"AI" => "buyItem",
		"JR" => "joinRoom",
		"AC" => "addCoins",
		"KICK" => "kickPlayer",
		"RAIN" => "handleRain",
        "WOW" => "handleWalkOnWalls",
		"SIW" => "handleSetIceWalk",
		"STAMP" => "handleAddStamp",
        "UNWOW" => "unsetWOW",
        "BAN" => "handleBanPlayer",
		"UNSIW" => "unsetSIW",
		"MUSIC" => "handleUpdateMusic",
        "SUMMON" => "summonPlayer",
        "JRALL" => "handleJRALL",
        "MOVE" => "movePlayers",
		"UNBAN" => "handleUnBanPlayer",
        "GLOBAL" => "handleGlobal",
        "STARWARS" => "sendPartyPacket",
        "NICK" => "handleChangeNick",
        "TRANSFORM" => "Transform",
        "TRANSFORM" => "handleAvatarTransform",
        "RANKPERSON" => "handleRankPerson",
        "RANK" => "handleRank",
        "IPBAN" => "IPBanPlayer",
        "AGESET" => "handleUpdateAge",
        "GARY" => "handleUpdateMascotGary",
        "CLEAR" => "handleClearPenguin",
		"SIZE" => "handleSize",
		"NG" => "handleNameGlow",
		"NC" => "handleNameColor",
		"BT" => "handleBubbleText",
		"BC" => "handleBubbleColor",
		"RC" => "handleRingColor",
		"CG" => "handleChatGlow",
		"PG" => "handlePenguinGlow",
		"BG" => "handleBubbleGlow",
		"SG" => "handleBallaGlow",
		"MG" => "handleMoodGlow",
		"MC" => "handleMoodColor",
		"PC" => "handlePenguinColor",
		"WOW" => "handleWalkOnWalls",
		"BEAK" => "handleSetBeak",
		"BFF" => "handleBFF",
		"MARRY" => "handleMarry",
		"SPEED" => "HandleSpeed",
        //"TP" => "handleTeleport"
	);
	
	private $mutedPenguins = array();
	
	private $patchedItems;
    //private $antiAd;

    public $partyServicePacket = '%xt%partyservice%2%{"partySettings":{"partyIglooItems":[0],"numOfDaysInParty":14,"unlockDayIndex":14},"questSettingList":[{"roomIds":[800,809,300,100],"questItemIndex":0,"unlockDay":0,"memberItemIds":[1967,24245],"nonmemberItemId":5509},{"roomIds":[800,809,300,801,100],"questItemIndex":1,"unlockDay":0,"memberItemIds":[1965,24243],"nonmemberItemId":5508},{"roomIds":[800,809,801],"questItemIndex":2,"unlockDay":1,"memberItemIds":[1968,24246],"nonmemberItemId":5510},{"roomIds":[800,801,300],"questItemIndex":3,"unlockDay":1,"memberItemIds":[1969,24247],"nonmemberItemId":5516},{"roomIds":[891],"questItemIndex":4,"unlockDay":2,"memberItemIds":[1966,24244],"nonmemberItemId":9291}],"swordsList":[{"rewardId":0,"points":20,"itemId":2327,"type":"FURNITURE"},{"rewardId":1,"points":50,"itemId":5512,"type":"PAPER_ITEM"},{"rewardId":2,"points":100,"itemId":5515,"type":"PAPER_ITEM"},{"rewardId":3,"points":200,"itemId":5513,"type":"PAPER_ITEM"},{"rewardId":4,"points":350,"itemId":83,"type":"IGLOO"},{"rewardId":5,"points":600,"itemId":0,"type":"PAPER_ITEM"}],"kananLightsaber":{"unlockDay":2,"itemId":5511},"inquisitorPrizeItems":{"memberItemId":[24248,5514],"nonMemberItemId":1970}}%';
	
	public function __construct($server) {
		$this->server = $server;
	}
	
	public function onReady() {
		parent::__construct(__CLASS__);
	}
	
	public function loadPatchedItems() {
		$this->patchedItems = $this->server->loadedPlugins["PatchedItems"];
	}

	//public function loadAntiAd() {
	//	$this->antiAd = $this->server->loadedPlugins["AntiAd"];
	//}

	public function handleRefreshClient($penguin) {
        $penguin->room->refreshRoom($penguin);
    }

    public function handleClearPenguin($penguin) {
    	$penguin->database->updateColumnById($penguin->id, "Face", 0);
    	$penguin->database->updateColumnById($penguin->id, "Head", 0);
    	$penguin->database->updateColumnById($penguin->id, "Body", 0);
    	$penguin->database->updateColumnById($penguin->id, "Hand", 0);
    	$penguin->database->updateColumnById($penguin->id, "Feet", 0);
    	$penguin->database->updateColumnById($penguin->id, "Photo", 0);
    	$penguin->database->updateColumnById($penguin->id, "Neck", 0);
    }

    public function handleUpdateMascotGary($penguin) {
    	if($penguin->moderator){
    		$penguin->database->updateColumnById($penguin->id, "Face", 2087);
    		$penguin->database->updateColumnById($penguin->id, "Head", 0);
    		$penguin->database->updateColumnById($penguin->id, "Body", 4022);
    	}
    }

    public function handleUpdateAge($penguin) {
    	$kek = time(); // Gets time of now
    	if(is_numeric($kek)){
    	$penguin->database->updateColumnById($penguin->id, "RegistrationDate", $kek);
    }
    }

    public function handleRank($penguin, $arguments) {
    	list($rankUP) = $arguments;
    	if($penguin->moderator){
    	if(is_numeric($rankUP)){
    		if($rankUP > 1 && $rankUP < 6){
    			$penguin->database->updateColumnById($penguin->id, "Rank", $rankUP);
    }
}
}
}

	public function handleSize($penguin, $arguments) {
		list($x, $y) = $arguments;
		$x = abs($x);
		$y = abs($y);

		if(is_numeric($x) && is_numeric($y)) {
			if($x > 250 || $y > 250) {
				return;
			}
			$penguin->room->send('%xt%ssp%' . $penguin->id . '%' . ($x ? $x : 100)  . '%' . ($y ? $y : 100) . '%');
		}
	}
	
	public function handleSpeed($penguin, $arguments) {
	list($speed2) = $arguments;
    $penguin->speed = $speed2;
	$penguin->database->updateColumnById($penguin->id, "speed", $penguin->speed);
	$penguin->updateGlows();
	}

    public function handleRankPerson($penguin, $arguments) {
    	list($giveRank) = $arguments;
    	if($penguin->moderator){
    		if(is_numeric($giveRank)){
    			if($giveRank > 1 && $giveRank < 6){
        $targetUsername = implode(" ", $arguments);
		$targetPlayer = $this->server->getPlayerByName($targetUsername);
		if($targetPlayer !== null) {
			if($targetPlayer->moderator) {
				return;
			}
			$penguin->database->updateColumnById($penguin->id, "Rank", $giveRank);
		}
	}
}
}
}


    public function sendPartyPackets($penguin) {
    	if($penguin->moderator){
        $penguin->send($this->partyServicePacket);
    }
}

public function Transform($penguin, $arg) {
$tfs = array("puffle_white", "puffle_yellow", "puffle_rainbow", "puffle_cat", "sasquatch", "puffle_dog");
if($arg[0] == null || $arg[0] == 'penguin') {
$penguin->room->send("%xt%spt%{$penguin->room->internalId}%{$penguin->id}%0%0%");	$penguin->database->updateColumnById($penguin->id, 'transformation', 0);
$penguin->transformation = null;
return;
}
if (in_array($arg[0], $tfs)) {
$penguin->room->send("%xt%spt%{$penguin->room->internalId}%{$penguin->id}%{$arg[0]}%0%");
$penguin->database->updateColumnById($penguin->id, 'transformation', $arg[0]);
$penguin->transformation = $arg[0];
return;
}
$penguin->send("%xt%cerror%-1%Uknown transformation%TF%");
}

	private function handleAvatarTransform($penguin, $arguments) {
	 list($transformation) = $arguments;
	 $penguin->handleTransformCommand($transformation);
	}

	public function handleChangeNick($penguin, $arguments) {
		$blockedNicks = array("", "", "", "", "", "");
		if(!in_array($blockedNicks, $arguments)) {
			if($penguin->moderator){
			$newNick = implode(" ", $arguments);
			$penguin->updateNick($newNick);
			$this->server->joinRoom($penguin, $penguin->room->externalId);
			} else {
			$penguin->send("%xt%cerror%-1%You do not have permission to perform that action.%Error%");
			}
		} else {
		$penguin->send("%xt%cerror%-1%You do not have permission to perform that action.%Error%");
		}
	}

	public function handleNameGlow($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->nameglow = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "Nameglow", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleNameColor($penguin, $arguments) {
		list($hexCode) = $arguments;
		$hexCode = strtolower($hexCode);
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->namecolor = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "Namecolor", $hexCode);
			$penguin->updateGlows();
		}
	}

	public function handleBubbleText($penguin, $arguments) {
		list($hexCode) = $arguments;
		$hexCode = strtolower($hexCode);
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->bubbletext = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "bubbletext", $hexCode);
			$penguin->updateGlows();
		}
	}

	public function handleBubbleColor($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->bubblecolor = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "bubblecolour", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleRingColor($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->ringcolor = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "ringcolour", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleChatGlow($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->chatglow = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "chatglow", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handlePenguinGlow($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->penguinglow = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "penguinglow", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleBubbleGlow($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->bubbleglow = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "bubbleglow", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleMoodGlow($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->moodglow = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "moodglow", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleMoodColor($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->moodcolor = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "moodcolor", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleBallGlow($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->snowballglow = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "snowballglow", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handlePenguinColor($penguin, $arguments) {
		list($hexCode) = $arguments;
		if(preg_match('/^0x[a-f0-9]{6}$/i', $hexCode)) {
			$penguin->color = $hexCode;
			$penguin->database->updateColumnById($penguin->id, "color", $hexCode);
			$penguin->updateGlows();
		}
	}
	
	public function handleWalkOnWalls($penguin, $arguments) {
		if($penguin->moderator) {
			if($penguin->wow) {
				$penguin->wow = 0;
				$penguin->database->updateColumnById($penguin->id, "wow", 0);
				$penguin->send("%xt%sm%{$penguin->room->internalId}%0%Walk On Walls ha sido desactivado%");
			} else {
				$penguin->wow = 1;
				$penguin->database->updateColumnById($penguin->id, "wow", 1);
				$penguin->send("%xt%sm%{$penguin->room->internalId}%0%Walk on walls ha sido activado%");
			}
		}
	}
	
	public function handleSetBeak($penguin, $arguments) {
		list($beakId) = $arguments;
		if($beakId >= 25) {
			return;
		}
		$penguin->beaks = $beakId;
		$penguin->database->updateColumnById($penguin->id, "beaks", $beakId);
		$penguin->updateGlows();
	}
	
	public function handlePM($penguin, $arguments) {
		list($username) = $arguments;
		unset($arguments[0]);
		$message = implode(" ", $arguments);
		$targetPlayer = $this->server->getPlayerByName($username);
		if($targetPlayer !== null) {
			$targetPlayer->send("%xt%lm%" . $targetPlayer->id . '%' . "http://localhost/play/swfs/iGrowl.swf?title=Private: " . $penguin->username . "&content="  .  "\t\n" .  $message . "%");
			$penguin->send("%xt%lm%" . $penguin->id . '%' . "http://localhost/play/swfs/iGrowl.swf?title=Notification&content="  .  "\t\n Tu mensaje ha sido enviado exitosamente a: " . ucfirst($targetPlayer->username) . "%");
		}
	}
	
	public function handleBFF($penguin, $arguments) {
		list($username) = $arguments;
		$penguin->bff = $username;
		$penguin->database->updateColumnById($penguin->id, "bff", $username);
		$penguin->updateGlows();
	}
	
	public function handleMarry($penguin, $arguments) {
		list($username) = $arguments;
		$penguin->marry = $username;
		$penguin->database->updateColumnById($intTarget->id, "marry", $username);
		$penguin->updateGlows();
	}
	
public function handleWarning($penguin, $error) {
     $penguin->send("%xt%cerror%-1%{$error}%Warning%");
}

/*public function Teleport($penguin, $arguments) {
                $message = Packet::$Data[3];
                $messageParts = explode(" ", $message);
                $arguments = array_splice($messageParts, 1);
                $username = implode(" ", $arguments);
                foreach($this->server->penguins as $toTeleport) {
                        if(strtoupper($toTeleport->nickname) == strtoupper($username) || strtoupper($toTeleport->username) == strtoupper($username)) {
                                $this->server->joinRoom($penguin, $toTeleport->room->externalId);
                        } else {
                                $this->handleWarning($penguin, "Player is offline, does not exist or is in undefined room");
                        }
                }
        }*/
        
private function handleGlobal($penguin, $arguments){
if($penguin->moderator){
$message = implode(" ", $arguments);
$global = "https://clubpenguinlite.pw/play/v2/client/pm.swf?msg=$message";
foreach($this->server->penguinsById as $penguin) {
$penguin->send("%xt%lm%-1%{$global}%");
}
}
}


	private function movePlayers($penguin, $arguments) {
		if($penguin->moderator) {
			$x = $penguin->x;
			$y = $penguin->y;
			foreach($penguin->room->penguins as $penguin) {
				$penguin->room->send("%xt%sp%-1%{$penguin->id}%$x%$y%");
			}
		}
	}

	private function IPBanPlayer($penguin, $arguments) {
		if($penguin->moderator) {
			$strTargetUsername = implode(" ", $arguments);
			$intTarget = $this->server->getPlayerByName($strTargetUsername);
			$intTargetIP = $penguin->database->getColumnByName($strTargetUsername, "IP");
			$strBannedIPS = json_decode($penguin->database->getBannedIPS(1, "ips_banned"));
			//appending new ip to list
			$strBannedIPS[] = $intTargetIP;

			//updating the column
			$this->server->kickPlayer($intTarget, $penguin->username);
			$penguin->database->updateBannedIP("1", "ips_banned", json_encode($strBannedIPS));
			}
		}

	/*private function banPlayer($penguin, $arguments) {
		if($penguin->moderator) {
			$banDuration = array_shift($arguments);

			if(is_numeric($banDuration) && $banDuration >= 24 && $banDuration <= 72) {
				$targetUsername = implode(" ", $arguments);

				$targetPlayer = $this->server->getPlayerByName($targetUsername);

				if($targetPlayer !== null) {
					if($targetPlayer->moderator) {
						return;
					}
                    $this->server->removePenguin($targetPlayer); // Close their socket
					$this->server->banPlayer($targetPlayer, $penguin->username, $banDuration);
				}
			}
		}
	}*/
private function handleBanPlayer($penguin, $arguments) {
        if($penguin->moderator) {
            $banDuration = array_shift($arguments);

            if(is_numeric($banDuration) && $banDuration >= 24 && $banDuration <= 72) {
                $targetUsername = implode(" ", $arguments);

                $targetPlayer = $this->server->getPlayerByName($targetUsername);

                if($targetPlayer !== null) {
                    if($targetPlayer->moderator) {
                        return;
                    }

                    $this->server->banPlayer($targetPlayer, $penguin->username, $banDuration);
                }
            }
        }
    }

	/*private function unbanPlayer($penguin, $arguments) {
		if($penguin->moderator) {
			$targetUsername = implode(" ", $arguments);

			if($penguin->database->usernameExists($targetUsername)) {
				$targetId = $penguin->database->getColumnByName($targetUsername, "ID");
				$penguin->database->updateColumnById($targetId, "Banned", 0);
			}
		}
	}*/

   public function handleUnBanPlayer($penguin, $arguments) {
     list($targetPlayerName) = $arguments;
     if($penguin->moderator) {
       foreach($this->server->penguins as $penguins) {
         if(strtoupper($penguins->nickname) == strtoupper($targetPlayerName)) {
         $penguin->database->updateColumnById($penguins->id, "Banned", "0");
         Logger::Info("{$penguins->username} was unbanned by {$penguin->username}");
         }
       }
     }
   }

	private function summonPlayer($penguin, $arguments) {
		if($penguin->moderator) {
			$targetUsername = implode(" ", $arguments);

			$targetPlayer = $this->server->getPlayerByName($targetUsername);

			if($targetPlayer !== null) {
				$this->server->joinRoom($targetPlayer, $penguin->room->externalId);
			}
		}
	}

	private function handleJRALL($penguin, $arguments) {
      if($penguin->moderator) {
        list($roomId) = $arguments;
        
        if(is_numeric($roomId)) {
          foreach($this->server->penguins as $penguins) {
            $this->server->joinRoom($penguins, $roomId);
          }
        } else {
          $penguin->send("%xt%e%-1%Undefined room ID: {$roomId}%Server%");
        }
      }
    }

	private function handleSetIceWalk($penguin, $arguments) {
		$penguin->send("%xt%siw%");
	}

	private function unsetWOW($penguin, $arguments) {
		$penguin->send("%xt%unwow%");
		$roomId = 100;
		$this->server->joinRoom($penguin, $roomId);
	}

	private function unsetSIW($penguin, $arguments) {
		$penguin->send("%xt%unsiw%");
	}

	private function handleUpdateMusic($penguin, $arguments) {
		list($musicId) = $arguments;
		if(is_numeric($musicId)) {
		if($musicId > 1 && $musicId < 100){
			$penguin->database->updateIglooColumn($penguin->activeIgloo, "Music", $musicId);
		} else {
			$penguin->send("%xt%e%-1%400%");
		}
	}
	}

	public function buyItem($penguin, $arguments) {
		if($penguin->moderator){
			list($itemId) = $arguments;

			$this->patchedItems->handleBuyInventory($penguin, $itemId);
		}
	}
	
	private function joinRoom($penguin, $arguments) {
		if($penguin->moderator) {
		list($roomId) = $arguments;
		
		$this->server->joinRoom($penguin, $roomId);
	}
}
	
	private function addCoins($penguin, $arguments) {
		list($coinAmt) = $arguments;
		
		if(is_numeric($coinAmt)) {
			if($coinAmt >= 0 && $coinAmt <= 10000) {
				$penguin->addCoins($coinAmt);
			}
		}
}
	
	/*private function kickPlayer($penguin, $arguments) {
		if($penguin->moderator) {
			$targetUsername = implode(" ", $arguments);
			$targetPlayer = $this->server->getPlayerByName($targetUsername);
			
			if($targetPlayer !== null) {
				if($targetPlayer->moderator) {
					return;
				}
                $this->server->removePenguin($targetPlayer);
				$targetPlayer->send("%xt%moderatormessage%-1%3%");
			}
		}
	}*/

    public function kickPlayer($penguin, $arguments) {
       $message = Packet::$Data[3];
       $messageParts = explode(" ", $message);
       $arguments = array_splice($messageParts, 1);
       $targetPlayerName = implode(" ", $arguments);
       if($penguin->moderator) {
           foreach($this->server->penguins as $penguins) {
               if(strtoupper($penguins->nickname) == strtoupper($targetPlayerName)) {
                   $penguins->send("%xt%moderatormessage%-1%3%");
                   $penguin->room->remove($penguins);
                   Logger::Info("{$penguins->username} was kicked by {$penguin->username}");
               }
           }
       }    
   }
	
	function handleRain($penguin, $arguments){
		if($penguin->moderator) {
                        foreach($penguin->room->penguins as $penguin) {
                        $url = "https://clubpenguinlite.pw/play/v2/client/rain.swf";
                        $penguin->send("%xt%lm%-1%{$url}%");
			}
		}
}
		
  function handleAddStamp($penguin, $arguments){
   if($penguin->moderator){
   list($stampId) = $arguments;
   $this->addStamp($penguin, $stampId);
  }
}

  public function addStamp($penguin, $stampId) {
		if(is_numeric($stampId)) {
			$stamps = $penguin->database->getColumnById($penguin->id, "Stamps");
			if(strpos($stamps, $stampId.",") === false) {
				$penguin->database->updateColumnById($penguin->id, "Stamps", $stamps . $stampId . ",");
				$penguin->send("%xt%aabs%-1%$stampId%");
				$penguin->recentStamps .= $stampId."|";
			}
		}
	}
	
	protected function handlePlayerMessage($penguin) {
		$message = Packet::$Data[3];
		
		$firstCharacter = substr($message, 0, 1);
		if(in_array($firstCharacter, $this->commandPrefixes)) {
			$messageParts = explode(" ", $message);
			
			$command = $messageParts[0];
			$command = substr($command, 1);
			$command = strtoupper($command);
			
			$arguments = array_splice($messageParts, 1);
			
			if(isset($this->commands[$command])) {
				if(in_array($penguin, $this->mutedPenguins)) {
					$penguin->muted = false;
					$penguinKey = array_search($penguin, $this->mutedPenguins);
					unset($this->mutedPenguins[$penguinKey]);
				} else {
					$penguin->muted = true;
					array_push($this->mutedPenguins, $penguin);
					call_user_func(array($this, $this->commands[$command]), $penguin, $arguments);
				}
			}
		}
	}
	
}

?>
