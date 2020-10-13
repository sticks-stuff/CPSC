<?php

namespace Kitsune\ClubPenguin\Plugins\AntiAd;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class AntiAd extends Plugin {

	public $worldHandlers = array(
		"s" => array(
			"m#sm" => array("handleSendMessage", self::Before),
			"m#spm" => array("handleSendPrivateMessage", self::Before),
			"s#upm" => array("handleSendUpdatePlayerMood", self::Before)
		)
	);

	public $xmlHandlers = array(null);

	public $urls;
	public $excludables = array("cpps"); #~ list of phrases to exclude from the filter
	public $cache;

	const FileName = "urls.json";

	public function __construct($server) {
		$this->server = $server;
	}

	public function onReady() {
		parent::__construct(__CLASS__);

		if(file_exists(self::FileName)) {
			$jsonData = file_get_contents(self::FileName);
		} else {
			Logger::Error("Couldn't locate '" . self::FileName . "'");
			return;
		}

		$this->urls = json_decode($jsonData, true);
		$this->cache = $this->urls; #~ cache the original urls so we can update the data store

		Logger::Info("Building table of banned URLs");

		#~ generate a table of cheeky versions!
		foreach($this->urls as $url) {
			$url = explode(".", $url);
			$this->urls[] = implode("", $url);
			if(!in_array($url[0], $this->excludables)) {
				$this->urls[] = $url[0];
			}
		}

		Logger::Info("Table of " . count($this->urls) . " bad URLs built");
	}

	public function handleSendMessage($penguin) {
		$message = Packet::$Data[3];
		$pengName = $penguin->username;

		if(!$this->check($message)) {
			Packet::$Extension = null;
			Logger::Warn("{$pengName} sent bad URL '$message'");
		}
	}

	public function handleSendPrivateMessage($penguin) {
		$message = Packet::$Data[3];

		if(!$this->check($message)) {
			Packet::$Extension = null;
			Logger::Warn("{$penguin->username} sent bad URL '$message'");
		}
	}

	public function handleSendUpdatePlayerMood($penguin) {
		$mood = Packet::$Data[2];

		if(!$this->check($mood)) {
			Packet::$Extension = null;
			Logger::Warn("{$penguin->username} used a bad URL in their mood '$mood'");
		}
	}

	private function check($string) {
		#~ reverse any dumb shit the user did to fool the system

		$normalizeChars = array(
			'Š'=>'S', 'š'=>'s', 'Ð'=>'Dj','Ž'=>'Z', 'ž'=>'z', 'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A',
			'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E', 'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I',
			'Ï'=>'I', 'Ñ'=>'N', 'Ń'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O', 'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U', 'Ú'=>'U',
			'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss','à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a',
			'å'=>'a', 'æ'=>'a', 'ç'=>'c', 'è'=>'e', 'é'=>'e', 'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i',
			'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ń'=>'n', 'ò'=>'o', 'ó'=>'o', 'ô'=>'o', 'õ'=>'o', 'ö'=>'o', 'ø'=>'o', 'ù'=>'u',
			'ú'=>'u', 'û'=>'u', 'ü'=>'u', 'ý'=>'y', 'ý'=>'y', 'þ'=>'b', 'ÿ'=>'y', 'ƒ'=>'f',
			'ă'=>'a', 'î'=>'i', 'â'=>'a', 'ș'=>'s', 'ț'=>'t', 'Ă'=>'A', 'Î'=>'I', 'Â'=>'A', 'Ș'=>'S', 'Ț'=>'T',
		);
		$string = strtr($string, $normalizeChars);

		$string = strtolower($string);

		$old = $string;
		$string .= preg_replace("/(.)\\1+/", "$1", $old);

		$string = preg_replace("/[^A-Za-z0-9]/", "", $string);

		$english = array("a", "e", "s", "a", "o", "t", "l", "H", "W", "M", "D", "V", "x", ".");
		$leet = array("4", "3", "z", "4", "0", "+", "1", "|-|", "\\/\\/", "|\\/|", "|)", "\\/", "><", "dot");

		$string = str_replace($leet, $english, $string);

		#~ check if their message contains a banned URL
		foreach($this->urls as $url) {
			if(strpos($string, $url) !== false){
				return false;
			}

			$url = preg_replace("/(.)\\1+/", "$1", $url);
			if(strpos($string, $url) !== false &&  $url != $old) {
				return false;
			}
		}

		return true;
	}
}

?>
