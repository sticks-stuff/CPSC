<?php

namespace Kitsune\ClubPenguin\Plugins\MascotStamps;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Packets\Packet;
use Kitsune\ClubPenguin\Plugins\Base\Plugin;

final class MascotStamps extends Plugin {

	public $worldHandlers = array(
		"s" => array(
			"j#jr" => array("handleJoinRoom", self::After)
		)
	);

	public $xmlHandlers = array(null);

	public function __construct($server) {
		$this->server = $server;
	}

	public function onReady() {
		parent::__construct(__CLASS__);

		Logger::Notice("[MASCOT STAMPS]: Successfully loaded!");
	}

	public function handleJoinRoom($penguin) {
    //TODO: ADD FRANKY, PETEY K, P.H.

    foreach ($penguin->room->penguins as $mascotPenguin) {
      if ($mascotPenguin->id == 1 && $penguin-> id != 1) {
        $this->addStamp($penguin, 7); // Rockhopper
        return;
      }
      if ($mascotPenguin->id == 33 && $penguin-> id != 33) {
        $this->addStamp($penguin, 8); // Gary
        return;
      }
      if ($mascotPenguin->id == 95 && $penguin-> id != 95) {
        $this->addStamp($penguin, 31); // Cadence
        return;
      }
      if ($mascotPenguin->id == 30 && $penguin-> id != 30) {
        $this->addStamp($penguin, 33); // Aunt Arctic
        return;
      }
      if ($mascotPenguin->id == 3 && $penguin-> id != 3) {
        $this->addStamp($penguin, 34); // G Billy
        return;
      }
      if ($mascotPenguin->id == 94 && $penguin-> id != 94) {
        $this->addStamp($penguin, 36); // Stomping Bob
        return;
      }
      if ($mascotPenguin->id == 4023 && $penguin-> id != 4023) {
        $this->addStamp($penguin, 290); // Sensei
        return;
      }
      if ($mascotPenguin->id == 9 && $penguin-> id != 9) {
        $this->addStamp($penguin, 358); // Rookie
        return;
      }
    }

    if ($penguin->id == 1) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 1) {
          $this->addStamp($roomPenguin, 7); // Rockhopper
          return;
        }
      }
    }
    if ($penguin->id == 33) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 33) {
          $this->addStamp($roomPenguin, 8); // Gary
          return;
        }
      }
    }
    if ($penguin->id == 95) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 95) {
          $this->addStamp($roomPenguin, 31); // Cadence
          return;
        }
      }
    }
    if ($penguin->id == 30) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 30) {
          $this->addStamp($roomPenguin, 33); // Aunt Arctic
          return;
        }
      }
    }
    if ($penguin->id == 3) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 3) {
          $this->addStamp($roomPenguin, 34); // G Billy
          return;
        }
      }
    }
    if ($penguin->id == 94) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 94) {
          $this->addStamp($roomPenguin, 36); // Stompin Bob
          return;
        }
      }
    }
    if ($penguin->id == 4023) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 4023) {
          $this->addStamp($penguin, 290); // Sensei
          return;
        }
      }
    }
    if ($penguin->id == 9) {
      foreach ($penguin->room->penguins as $roomPenguin) {
        if ($roomPenguin->id != 9) {
          $this->addStamp($penguin, 358); // Rookie
          return;
        }
      }
    }
  }

  public function addStamp($penguin, $stampId) {
		if(is_numeric($stampId)) {
			$stamps = $penguin->database->getColumnById($penguin->id, "Stamps");
			if(strpos($stamps, $stampId.",") === false) {
				$penguin->database->updateColumnById($penguin->id, "Stamps", $stamps . $stampId . ",");
				$penguin->send("%xt%aabs%-1%$stampId%");
				$penguin->recentStamps .= $stampId."|";
			}
		}
	}
}

?>
