<?php

namespace Kitsune\ClubPenguin;

final class Hashing {

	private static $characterSet = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789`~@#$()_+-={}|[]:,.";

	public static function generateRandomKey() {
		$keyLength = mt_rand(7, 10);
		$randomKey = "";

		foreach(range(0, $keyLength) as $currentLength) {
			$randomKey .= substr(self::$characterSet, mt_rand(0, strlen(self::$characterSet)), 1);
		}

		return $randomKey;
	}

	public static function encryptPassword($password, $md5 = true) {
		if($md5 !== false) {
			$password = md5($password);
		}

		$hash = substr($password, 16, 16) . substr($password, 0, 16);
		return $hash;
	}

	public static function getLoginHash($password, $randomKey) {
		$hash = self::encryptPassword($password, false);
		$hash .= $randomKey;
		$hash .= 'Y(02.>\'H}t":E1';
		$hash = self::encryptPassword($hash);

		return $hash;
	}

}

?>
