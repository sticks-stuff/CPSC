<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;

trait Moderation {

	public function mutePlayer($targetPlayer, $moderatorUsername) {
		if(!$targetPlayer->moderator) {
			if(!$targetPlayer->muted) {
				$targetPlayer->muted = true;
				Logger::Info("$moderatorUsername has muted {$targetPlayer->username}");
			} else {
				$targetPlayer->muted = false;
				Logger::Info("$moderatorUsername has unmuted {$targetPlayer->username}");
			}
		}
	}

	public function kickPlayer($targetPlayer, $moderatorUsername) {
		if(!$targetPlayer->moderator) {
			foreach($this->penguins as $penguin) {
				if($penguin->moderator) {
					$penguin->send("%xt%ma%{$penguin->room->internalId}%k%{$targetPlayer->id}%{$targetPlayer->username}%");
				}
			}

			$targetPlayer->send("%xt%e%-1%5%");
			$this->removePenguin($targetPlayer);

			Logger::Info("$moderatorUsername kicked {$targetPlayer->username}");
		}
	}

	public function banPlayer($targetPlayer, $moderatorUsername, $banDuration = 24, $type = "GAME") {
		if(!$targetPlayer->moderator) {
			foreach($this->penguins as $penguin) {
				if($penguin->moderator) {
					$penguin->send("%xt%ma%{$penguin->room->internalId}%b%{$targetPlayer->id}%{$targetPlayer->username}%");
				}
			}

			$numberOfBans = $penguin->database->getNumberOfBans($targetPlayer->id);

			if($numberOfBans < 3) {
				$targetPlayer->database->updateColumnById($targetPlayer->id, "Banned", strtotime("+".$banDuration." hours"));

				$penguin->database->addBan($targetPlayer->id, $moderatorUsername, "Banned.", $banDuration, $type);
			} else {
				$targetPlayer->database->updateColumnById($targetPlayer->id, "Banned", "perm");

				$penguin->database->addBan($targetPlayer->id, $moderatorUsername, "Banned.", 0, $type);
			}

			$targetPlayer->send("%xt%e%-1%800%");
			$this->removePenguin($targetPlayer);

			Logger::Info("$moderatorUsername banned {$targetPlayer->username} for $banDuration hours");
		}
	}

	public function specialBanPlayer($targetPlayer, $moderatorUsername, $banDuration = 24) {
			foreach($this->penguins as $penguin) {
				if($penguin->moderator) {
					$penguin->send("%xt%ma%{$penguin->room->internalId}%b%{$targetPlayer->id}%{$targetPlayer->username}%");
				}
			}

			$numberOfBans = $penguin->database->getNumberOfBans($targetPlayer->id);

			if($numberOfBans < 3) {
				$targetPlayer->database->updateColumnById($targetPlayer->id, "Banned", strtotime("+".$banDuration." hours"));

				$penguin->database->addBan($targetPlayer->id, $moderatorUsername, $banDuration);
			} else {
				$targetPlayer->database->updateColumnById($targetPlayer->id, "Banned", "perm");

				$penguin->database->addBan($targetPlayer->id, $moderatorUsername, 0);
			}

			$targetPlayer->send("%xt%e%-1%800%");
			$this->removePenguin($targetPlayer);

			Logger::Info("$moderatorUsername banned {$targetPlayer->username} for $banDuration hours");
	}

	
	protected function handleKickPlayerById($socket) {
		$penguin = $this->penguins[$socket];

		if($penguin->moderator) {
			$playerId = Packet::$Data[2];

			if(is_numeric($playerId)) {
				$targetPlayer = $this->getPlayerById($playerId);
				if($targetPlayer !== null) {
					$this->kickPlayer($targetPlayer, $penguin->username);
				}
			}
		}
	}

	protected function handleMutePlayerById($socket) {
		$penguin = $this->penguins[$socket];

		if($penguin->moderator) {
			$playerId = Packet::$Data[2];

			if(is_numeric($playerId)) {
				$targetPlayer = $this->getPlayerById($playerId);
				if($targetPlayer !== null) {
					$this->mutePlayer($targetPlayer, $penguin->username);
				}
			}
		}
	}

	protected function handleBanPlayerById($socket) {
		$penguin = $this->penguins[$socket];

		if($penguin->moderator) {
			$playerId = Packet::$Data[2];

			if(is_numeric($playerId)) {
				$targetPlayer = $this->getPlayerById($playerId);
				if($targetPlayer !== null) {
					$this->banPlayer($targetPlayer, $penguin->username);
				}
			}
		}
	}
}

?>
