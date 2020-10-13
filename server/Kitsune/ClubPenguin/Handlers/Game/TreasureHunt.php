<?php

namespace Kitsune\ClubPenguin\Handlers\Game;

class TreasureHunt {

  public $boardMap = array();

  public $currentPlayer = 1;
  public $gameOver = false;

  public function convertToString() {
    $gemLocations = implode(',', array_fill(0, 20, 0));
    $treasureMap = implode(',', array_fill(0, 100, 0));
    return "10%10%34%3%12%25%1%$gemLocations%$treasureMap";
  }
  /*
  _local3.MAP_WIDTH = parseint(resObj[3]);
   _local3.MAP_HEIGHT = parseint(resObj[4]);
   _local3.COIN_NUM_HIDDEN = parseint(resObj[5]);
   _local3.GEM_NUM_HIDDEN = parseint(resObj[6]);
   _local3.NUM_TURNS = parseint(resObj[7]);
   _local3.GEM_VALUE = parseint(resObj[8]);
   _local3.COIN_VALUE = parseint(resObj[9]);
   _local3.gemLocations = resObj[10];
   _local3.treasureMap = resObj[11];

   i really don't know about this game, wtf is this shit
   */
}

?>
