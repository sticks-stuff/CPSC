<?php

namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\Events;
use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;

trait Music {

	public $lastPlayed = null; // Track string
	public $broadcastingTracks = array();
	public $broadcastingEventIndex = null;

	public $cachedMusicTracks = array();
	public $cachedTrackPatterns = array();

	protected function handleLikeMusicTrack($socket) {
		$penguin = $this->penguins[$socket];

		$ownerId = Packet::$Data[2];
		$trackId = Packet::$Data[3];

		if($penguin->database->ownsTrack($ownerId, $trackId)) {
			$trackLikes = $penguin->database->getTrackLikes($trackId);

			if(array_key_exists($penguin->username, $trackLikes)) {
				$lastLike = $trackLikes[$penguin->username];

				if(strtotime("-24 hours") >= $lastLike) {
					$trackLikes[$penguin->username] = time();
				} else {
					Logger::Warn("{$penguin->username} ({$penguin->id}) tried to like a track that they couldn't!");
					return false;
				}
			} else {
				$trackLikes[$penguin->username] = time();
			}

			$penguin->database->updateTrackLikes($trackId, $trackLikes);
			$penguin->database->incrementTrackLikes($trackId);

			$likeCount = $penguin->database->getTrackLikeCount($trackId);

			$penguin->send("%xt%liketrack%6%$ownerId%$trackId%$likeCount%");
		}
	}

	protected function handleCanLikeMusicTrack($socket) {
		$penguin = $this->penguins[$socket];

		$ownerId = Packet::$Data[2];
		$trackId = Packet::$Data[3];

		if($penguin->database->ownsTrack($ownerId, $trackId)) {
			$trackLikes = $penguin->database->getTrackLikes($trackId);

			if(array_key_exists($penguin->username, $trackLikes) || empty($trackLikes)) {
				$lastLike = $trackLikes[$penguin->username][0];

				if(strtotime("-24 hours") >= $lastLike) {
					return $penguin->send("%xt%canliketrack%-1%$trackId%1%");
				} else {
					$penguin->send("%xt%canliketrack%-1%$trackId%0%");
				}
			} else {				
				$penguin->send("%xt%canliketrack%-1%$trackId%1%");
			}
		}
	}

	public function isTrackBeingBroadcasted($trackId) {
		list($currentlyBroadcasting) = $this->broadcastingTracks;

		$trackParts = explode("|", $currentlyBroadcasting);
		$broadcastingTrackId = $trackParts[3];

		return $broadcastingTrackId == $trackId;
	}

	protected function handleDeleteMusicTrack($socket) {
		$penguin = $this->penguins[$socket];

		$trackId = Packet::$Data[2];

		if($penguin->database->ownsTrack($penguin->id, $trackId)) {
			$penguin->database->deleteTrack($trackId);

			$penguin->send("%xt%deletetrack%-1%1%");

			if($this->isTrackBeingBroadcasted($trackId)) {
				$this->broadcastNextTrack();
			}
		} else {
			Logger::Warn("{$penguin->name} tried to delete a track they don't own!");
		}
	}

	public function sendBroadcastingTracks($penguin) {
		$sharedTracksCount = count($this->broadcastingTracks);
		$sharedPlayerTracks = implode(",", $this->broadcastingTracks);
		$playlistPosition = $this->getPlaylistPosition($penguin);

		$penguin->send("%xt%broadcastingmusictracks%-1%$sharedTracksCount%$playlistPosition%$sharedPlayerTracks%");
	}

	// Sends the new list to everyone in the room
	public function refreshRoomBroadcasting() {
		$dancingPenguins = $this->rooms["120"]->penguins;
		$this->refreshTrackBroadcasting();

		$sharedPlayerTracks = implode(",", $this->broadcastingTracks);

		foreach($dancingPenguins as $dancingPenguin) {
			$this->sendBroadcastingTracks($dancingPenguin);
		}
	}

	protected function handleShareMyMusicTrack($socket) {
		$penguin = $this->penguins[$socket];

		$trackId = Packet::$Data[2];
		$doShare = Packet::$Data[3];

		if($penguin->database->trackExists($trackId) && in_array($doShare, range(0, 1))) {
			$penguin->database->updateTrackSharing($penguin->id, $trackId, $doShare);
			$penguin->send("%xt%sharemymusictrack%-1%1%");

			$this->refreshRoomBroadcasting();
		} else {
			Logger::Warn("Player sent invalid track id and/or sharing value. Track id $trackId, Sharing $doShare");
		}
	}

	protected function handleLoadMusicTrack($socket) {
		$penguin = $this->penguins[$socket];

		$playerId = Packet::$Data[2];
		$trackId = Packet::$Data[3];

		if($penguin->database->playerIdExists($playerId) && $penguin->database->trackExists($trackId)) {
			if(array_key_exists($trackId, $this->cachedMusicTracks)) {
				$musicTrack = $this->cachedMusicTracks[$trackId];
			} else {
				// ID, Name, Sharing, Pattern, Hash, Likes
				$musicTrack = $penguin->database->getMusicTrack($trackId);
				$this->cachedMusicTracks[$trackId] = $musicTrack;
			}
			
			$trackData = implode("%", $musicTrack);
			
			$penguin->send("%xt%loadmusictrack%-1%$trackData%");
		}		
	}

	protected function handleRefreshMyTrackLikes($socket) {
		$penguin = $this->penguins[$socket];

		$myMusicTracks = $penguin->database->getMyMusicTracks($penguin->id);

		if(!empty($myMusicTracks)) { // ID, Name, Sharing, Likes
			foreach($myMusicTracks as $myMusicTrack) {
				$trackId = $myMusicTrack[0];
				$trackLikes = $myMusicTrack[3];

				$penguin->send("%xt%getlikecountfortrack%-1%{$penguin->id}%$trackId%$trackLikes%");
			}
		}
	}

	// Maybe check for corrupted insertions?
	protected function handleSaveMyMusicTrack($socket) {
		$penguin = $this->penguins[$socket];

		list($trackName, $trackPattern, $trackHash) = array_slice(Packet::$Data, 2);

		$encodedPattern = $this->encodeMusicTrack($trackPattern);

		if($encodedPattern == $trackHash) {
			$trackId = $penguin->database->savePlayerTrack($penguin->id, $trackName, $trackPattern, $trackHash);

			$penguin->send("%xt%savemymusictrack%-1%$trackId%");
		} else {
			Logger::Warn("Track hashes don't match! $trackHash and $encodedPattern");

			$this->removePenguin($penguin);
		}
	}

	protected function handleGetMyMusicTracks($socket) {
		$penguin = $this->penguins[$socket];

		$myMusicTracks = $penguin->database->getMyMusicTracks($penguin->id);
		$trackCount = count($myMusicTracks);

		if($trackCount > 0) {
			$myTracks = array();

			foreach($myMusicTracks as $myMusicTrack) {
				list($trackId, $trackName, $isSharing, $trackLikes) = $myMusicTrack;
				$trackLikes = $trackLikes > 0 ? $trackLikes : -1;

				array_push($myTracks, sprintf("%d|%s|%d|%d", $trackId, $trackName, $isSharing, $trackLikes));
			}

			$musicTracks = implode(",", $myTracks);

			$penguin->send("%xt%getmymusictracks%-1%$trackCount%$musicTracks%");
		} else {
			$penguin->send("%xt%getmymusictracks%-1%0%%");
		}
	}

	protected function handleBroadcastingTracks($socket) {
		$penguin = $this->penguins[$socket];

		$this->refreshTrackBroadcasting();

		$sharedTracksCount = count($this->broadcastingTracks);

		if($sharedTracksCount < 1) {
			$penguin->send("%xt%broadcastingmusictracks%-1%0%-1%%");
		} else {
			if($this->broadcastingEventIndex == null) {
				$this->broadcastNextTrack();
			} else {
				$this->sendBroadcastingTracks($penguin);
			}
		}
	}

	/*
	Get the ids of everyone on the server, and retrieve all of the tracks
	that they're sharing.

	Idea - Possibly have an array keep track of everyone who's sharing their
	music for effiency's sake.
	*/
	protected function handleGetSharedMusicTracks($socket) {
		$penguin = $this->penguins[$socket];

		$sharedTracks = array();
		$sharedTracksCount = 0;

		foreach($this->penguins as $onlinePenguin) {
			$sharedPlayerTracks = $penguin->database->getSharedTracks($onlinePenguin->id);

			if(!empty($sharedPlayerTracks)) {
				$sharedPlayerTracksCount = count($sharedPlayerTracks);
				$sharedTracksCount += $sharedPlayerTracksCount;

				foreach($sharedPlayerTracks as $sharedPlayerTrack) {
					array_push($sharedTracks, sprintf("%d|%s|%d|%d",
						$onlinePenguin->id, $onlinePenguin->username,
						$sharedPlayerTrack["ID"], $sharedPlayerTrack["Likes"]));
				}
			}
		}

		if($sharedTracksCount > 0) {
			$sharedTracksData = implode(",", $sharedTracks);
			$penguin->send("%xt%getsharedmusictracks%-1%$sharedTracksCount%$sharedTracksData%");
		} else {
			// None are currently being shared
			$penguin->send("%xt%getsharedmusictracks%-1%0%%");
		}
	}

	private function determineSongLength($songData) {
		$songDataSplit = explode(",", $songData);
		$endData = $songDataSplit[count($songDataSplit) - 1];

		if(explode("|", $endData)[0] == "FFFF") {
			return intval(explode("|", $endData)[1], 16);
		}

		return -1;
	}

	private function encodeMusicTrack($songData) {
		$songHash = strrev($songData);
		$songHash = md5($songHash);

		return substr($songHash, -16) . substr($songHash, 0, 16);
	}

	private function refreshTrackBroadcasting() {
		$dancingPenguins = $this->rooms["120"]->penguins;
		$sharedTracks = array();

		foreach($dancingPenguins as $dancingPenguin) {
			$sharedPlayerTracks = $dancingPenguin->database->getSharedTracks($dancingPenguin->id);

			if(count($sharedPlayerTracks) > 0) {
				foreach($sharedPlayerTracks as $sharedPlayerTrack) {
					$trackData = sprintf("%d|%s|%s|%d|%d", $dancingPenguin->id, $dancingPenguin->username,
						$dancingPenguin->swid, $sharedPlayerTrack["ID"], $sharedPlayerTrack["Likes"]);

					array_push($sharedTracks, $trackData);
				}
			}
		}

		$this->broadcastingTracks = $sharedTracks;
	}

	private function getPlaylistPosition($penguin) {
		foreach($this->broadcastingTracks as $broadcastingIndex => $broadcastingTrack) {
			list($playerId) = explode("|", $broadcastingTrack);

			if($penguin->id == $playerId) {
				return $broadcastingIndex + 1;
			}
		}

		return -1;
	}

	public function broadcastNextTrack() {
		$dancingPenguins = $this->rooms["120"]->penguins;

		if(empty($dancingPenguins)) { 
			$this->stopBroadcasting();

			return false;
		}

		$this->refreshTrackBroadcasting();

		$sharedTracksCount = count($this->broadcastingTracks);

		if($sharedTracksCount > 0) {
			list($trackData) = $this->broadcastingTracks;

			if($trackData == $this->lastPlayed) {
				$lastPlayed = array_shift($this->broadcastingTracks);
				array_push($this->broadcastingTracks, $lastPlayed);
			}

			$sharedPlayerTracks = implode(",", $this->broadcastingTracks);

			$this->stopBroadcasting();

			foreach($dancingPenguins as $dancingPenguin) {
				$playlistPosition = $this->getPlaylistPosition($dancingPenguin);

				$dancingPenguin->send("%xt%broadcastingmusictracks%-1%$sharedTracksCount%$playlistPosition%$sharedPlayerTracks%");
			}

			list($trackData) = $this->broadcastingTracks;

			$trackId = explode("|", $trackData)[3];

			if(array_key_exists($trackId, $this->cachedTrackPatterns)) {
				$trackPattern = $this->cachedTrackPatterns[$trackId];
			} else {
				list($trackPattern) = end($this->penguins)->database->getTrackPattern($trackId);

				$this->cachedTrackPatterns[$trackId] = $trackPattern;
			}
			
			$songLength = ceil($this->determineSongLength($trackPattern) / 1000);

			$eventIndex = Events::AppendInterval($songLength, array($this, "broadcastNextTrack"));
			$this->broadcastingEventIndex = $eventIndex;

			$this->lastPlayed = $trackData;
		} else {
			$this->stopBroadcasting();

			return false;
		}	
	}

	public function stopBroadcasting() {		
		if($this->broadcastingEventIndex !== null) {
			Events::RemoveInterval($this->broadcastingEventIndex);
			$this->broadcastingEventIndex = null;
		}
	}

}

?>