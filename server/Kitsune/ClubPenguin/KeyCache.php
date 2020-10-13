<?php

namespace Kitsune\ClubPenguin;

final class KeyCache { 
	// used to cache login keys to improve game server authentication performance

	public static $cacheById = array();
	public static $cacheByName = array();
	
	public static function add($penguinId, $penguinName, $loginKey) {
		self::$cacheById[$penguinId] = array($penguinName, $loginKey);
		self::$cacheByName[strtolower($penguinName)] = array($penguinId, $loginKey);
	}
	
	public static function remove($penguinId) {
		if(isset(self::$cacheById[$penguinId])) {
			list($penguinName) = self::$cacheById[$penguinId];
			unset(self::$cacheByName[$penguinName]);
			unset(self::$cacheById[$penguinId]);
		}
	}
	
	public static function getKeyByName($penguinName) {
		$penguinName = strtolower($penguinName);
		list($penguinId, $loginKey) = self::$cacheByName[$penguinName];
		return array($penguinId, $loginKey);
	}
	
	public static function getKeyById($penguinId) {
		list($penguinName, $loginKey) = self::$cacheById[$penguinId];
		return array($penguinName, $loginKey);
	}
}

?>