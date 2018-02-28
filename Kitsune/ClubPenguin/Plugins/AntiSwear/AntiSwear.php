<?php

namespace Kitsune\ClubPenguin\Plugins\AntiSwear;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class AntiSwear extends Plugin {

	public $worldHandlers = array(
		"s" => array(
			"m#sm" => array("handleSendMessage", self::Override)
		)
	);

	public $xmlHandlers = array(null);

  public $swearFilter = array("sex", "fuck", "fk", "ngr", "fgt", "cunt", "fuck you", "masturbate", "masterbate", "jackoff", "lets have sex", "lets fuck", "lets sex", "i want to have sex", "wanna have sex?", "do u want to have sex?", "do you want to have sex?", "do u want to have sex", "do you want to have sex", "do u want 2 have sex?", "do u want 2 have sex", "do you want 2 have sex?", "do you want 2 have sex", "sex do u want 2 have", "sxe lets have some", "do you want 2 have se x", "do u want 2 have se x", "do you want to have se x", "do you want 2 have sex", "dick", "cancer", "dickhead", "fucked", "shit", "faggot", "retard", "faggots", "fucking", "dicks", "dickheads", "fucks", "gay", "pula", "pulas", "kanker", "nigger", "niggers", "nigga", "niggas", "niggu", "niggus", "nikka", "nikkas", "nugga", "nuggas", "bitch", "b1tch", "b|tch", "hoe", "hoes", "bitches", "b1tches", "biatch", "b|tches", "b!+ch", "ayir", "damn", "dyke", "@$$", "amcik", "andskota", "arschloch", "arse", "asshole", "assramer", "atouche", "bastard", "b17ch", "boiolas", "bollock", "breasts", "buceta", "butt-pirate", "c0ck", "cabron", "cawk", "cazzo", "chink", "chraa", "chuj", "cipa", "clits", "cock", "cum", "dago", "daygo", "dego", "dike", "dildo", "dirsa", "dupa", "dziwka", "ejackulate", "ekrem", "ekto", "enculer", "faen", "fag", "fanculo", "fanny", "fatass", "fcuk", "felcher", "ficken", "fitta", "flikker", "fitte", "foreskin", "fotze", "fu(", "fuk", "futkretzn", "fux0r", "gook", "guiena", "h0r", "h4x0r", "hoer", "honkey", "hore", "kankerhoer", "cancerhoe", "cancerhoes", "kankerhoeren", "kankerhoertjes", "huevon", "hui", "ddos", "ddosed", "stress", "booter", "pigeon squad", "pigeonsquad", "pigeon patrol", "pigeonpatrol", "patrol pigeon", "patrolpigeon", "lizard squad", "lizardsquad", "skid", "kawk", "kike", "klootzak", "jizz", "jism", "injun", "phantom squad", "phantomsquad", "f4ck3d", "f4ck", "knulle", "kraut", "kuk", "kuksuger", "kurac", "kurwa", "kusi", "kyrpä", "kyrpa", "l3i+ch", "lesbian", "l3itch", "lesbo", "lesbos", "mamhoon", "masturbat", "srna", "merd", "merde", "mibun", "putain", "monkleigh", "motherfucker", "motherfuckers", "mouliewop", "muie", "mulkku", "muschi", "nazis", "ognazi", "nazi", "nepesaurio", "nutsack", "orospu", "weeb", "niggeria", "paska", "pendejo", "nuckas", "penis", "boob", "boobs", "perse", "phuck", "picka", "pierdol", "pillu", "pimmel", "pimpis", "piemel", "piss", "pizda", "poontsee", "poop", "porn", "pr0n", "preteen", "cameltoe", "camelt03", "c4m3lt03", "c4meltoe", "c4melt03", "cam3ltoe", "cam3lt0e", "cam3lt03", "preud", "pule", "prick", "pule", "pussy", "puta", "puto", "qahbeh", "queef", "queer", "qweef", "rautenberg", "schaffer", "scheiss", "schlampe", "schmuck", "screw", "scrotum", "sh!t", "sharmuta", "sharmute", "shipal", "shiz", "skribz", "skurwysyn", "slut", "smut", "sphencter", "spierdalaj", "splooge", "suka", "cyka", "blyat", "teets", "teez", "testicles", "tits", "titties", "titty", "twat", "twaty", "twatty", "vittu", "votze", "w00se", "w00s3", "wank", "wetback", "whoar", "wichser", "wop", "zemmel", "zabourah", "natzi", "asswipe", "ƒuck", "rape", "raping", "nligger", "hitler", "rhape", "pedo", "p3d0", "vagina", "v4g1in4", "v4gin4", "puta", "pute", "fhag", "nigg", "niger", "nigerr", "phaggot", "ni99", "bytch", "pussies", "ni66", "n1gg", "nlgg", "gringo", "fhaggot", "jewmad", "fuhrer");

	public function __construct($server) {
		$this->server = $server;
	}

	public function onReady() {
		parent::__construct(__CLASS__);

		Logger::Notice("[ANTISWEAR]: Successfully loaded " . count($this->swearFilter) . " bad words");
	}

	public function handleSendMessage($penguin) {
		$strMessage = Packet::$Data[3];
		$pengName = $penguin->username;
		foreach ($this->swearFilter as $swearWord) {
		  if (stripos($strMessage, $swearWord) !== FALSE) {
			  Logger::Notice('ANTISWEAR DETECTION: ' . $pengName . ' is attempting to swear in the following message: \'' . $strMessage . '\'');
				$penguin->room->send("%xt%sm%{$penguin->room->internalId}%{$penguin->id}%I attempted to swear and was kicked by the server!%");
			  $penguin->send("%xt%e%-1%5%");
				$this->server->removePenguin($penguin);
				return;
			}
		}
		if(!$penguin->muted) {
			$penguin->room->send("%xt%sm%{$penguin->room->internalId}%{$penguin->id}%$strMessage%");
		}
	}
}

?>
