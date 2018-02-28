<?php

namespace Kitsune\ClubPenguin\Packets\Parsers;

class XMLParser {

	public static function Parse($xmlData) {
		$simpleXml = simplexml_load_string($xmlData, "SimpleXMLElement", LIBXML_NOCDATA);
		$xmlArray = json_decode(json_encode($simpleXml), true);
		
		return $xmlArray;
	}
	
}

?>