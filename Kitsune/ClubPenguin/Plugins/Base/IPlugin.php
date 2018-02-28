<?php

namespace Kitsune\ClubPenguin\Plugins\Base;

interface IPlugin {

	const Before = 0;
	const After = 1;
	const Both = 3;
	const Override = 4;

	public function handleXmlPacket($penguin, $beforeCall = true);
	public function handleWorldPacket($penguin, $beforeCall = true);
	
}

?>