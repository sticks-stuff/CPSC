<?php

namespace Kitsune\ClubPenguin\Packets\Parsers;

class XTParser {

	public static function Parse($xtData) {
		$xtArray = explode('%', $xtData);
		array_shift($xtArray);
		array_shift($xtArray);
		array_pop($xtArray);
		
		return $xtArray;
	}
	
}

?>