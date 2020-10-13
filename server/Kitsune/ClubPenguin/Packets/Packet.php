<?php

namespace Kitsune\ClubPenguin\Packets;
use Kitsune\ClubPenguin\Packets\Parsers;

class Packet {

	public static $IsXML;
	public static $Extension;
	public static $Handler;
	public static $Data;
	public static $RawData;
	
	private static $Instance;
	
	public static function GetInstance() {
		if(self::$Instance == null) {
			self::$Instance = new Packet();
			Packet::Parse(self::$RawData);
		}
		
		return self::$Instance;
	}
	
	public static function Parse($rawData) {
		$firstCharacter = substr($rawData, 0, 1);
		self::$IsXML = $firstCharacter == '<';
		
		if(self::$IsXML) {
			$xmlArray = Parsers\XMLParser::Parse($rawData);
			if(!$xmlArray) {
				self::$Handler = "policy";
			} else {
				self::$Handler = $xmlArray["body"]["@attributes"]["action"];
				self::$Data = $xmlArray;
			}
			self::$RawData = $rawData;
		} else {
			$xtArray = Parsers\XTParser::Parse($rawData);
			
			self::$Extension = $xtArray[0];
			self::$Handler = $xtArray[1];
			array_shift($xtArray);
			
			self::$Data = $xtArray;
			self::$RawData = $rawData;
		}
	}
	
}

?>