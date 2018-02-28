<?php

namespace Kitsune\ClubPenguin\Handlers\Game;

class Jitsu {
	public $player1Cards = array();
	public $player1UsedCards = array();
	public $player2Cards = array();
	public $player2UsedCards = array();
	public $player1Wins = array(
		's' => array(
			'r'=>'',
			'b'=>'',
			'y'=>'',
			'g'=>'',
			'o'=>'',
			'p'=>''
		),
		'w'=> array(
			'r'=>'',
			'b'=>'',
			'y'=>'',
			'g'=>'',
			'o'=>'',
			'p'=>''
		),
		'f'=> array(
			'r'=>'',
			'b'=>'',
			'y'=>'',
			'g'=>'',
			'o'=>'',
			'p'=>''
		)
	);
	public $player2Wins = array(
		's' => array(
			'r'=>'',
			'b'=>'',
			'y'=>'',
			'g'=>'',
			'o'=>'',
			'p'=>''
		),
		'w'=> array(
			'r'=>'',
			'b'=>'',
			'y'=>'',
			'g'=>'',
			'o'=>'',
			'p'=>''
		),
		'f'=> array(
			'r'=>'',
			'b'=>'',
			'y'=>'',
			'g'=>'',
			'o'=>'',
			'p'=>''
		)
	);
	public $addedPercentage = array(
		0=> 100, #noBelt
		1=> 30, #white
		2=> 20, #yellow
		3=> 17, #orange
		4=> 16, #green
		5=> 13, #blue
		6=> 9, #red
		7=> 8, #purple
		8=> 5 #brown
	);
	public $loserAddedPercentage = array(
		0=> 30, #noBelt
		1=> 15, #white
		2=> 10, #yellow
		3=> 9, #orange
		4=> 7, #green
		5=> 7, #blue
		6=> 5, #red
		7=> 5, #purple
		8=> 3 #brown
	);
	public $cardsArray = array();
	public $player2CardPicked = 0;
	public $player1CardPicked = 0;
	public $player1;
	public $player2;
	public $completed = false;
	public $cardsArray2 = array();
	public $sensei = false;
	public $beltsItemID = array(0,4025, 4026, 4027, 4028, 4029, 4030, 4031, 4032, 4033, 104); // List of patched items
	public $intPCard = array();

	public function __construct($sensei=false) {
		$this->sensei = $sensei;
		if($sensei) {
			$this->player1 = "Sensei";
		}
	}

	public function setCardsArray($cardsArray, $cardsArray2) {
		$this->cardsArray = $cardsArray;
		$this->cardsArray2 = $cardsArray2;
	}

	public function setPlayer1($player) {
		$this->player1 = $player;
	}

	public function setPlayer2($player) {
		$this->player2 = $player;
	}

	/*public function player1Ready($player) {
		$this->player1->isReady = 1;
	}

	public function player2Ready($player) {
		$this->player2->isReady = ? 1 : 0;
	}*/

	/*public function getPowerCard($intPCard){
		$arrPowers = array("1", "2", "3", "13", "14", "15", "16", "17", "18");
		$arrPowersTwo = array("4", "5", "6", "7", "8", "9", "10", "11", "12", "19", "20", "21", "22", "23", "24");
		$blnCheck = current($_ == $intPCard) ? $arrPowers:0;
		$blnCheckTwo = current($_ == $intPCard) ? $arrPowersTwo:0;
		if(!$blnCheck && !blnCheckTwo){
			return;
		} else {
			return $blnCheck ? 1 : 0;
		}
	}*/

	public function dealCards($penguin,$dealNum) {
		if($this->sensei and $penguin != "Sensei") {
			$this->dealCards("Sensei", $dealNum);
		}
		$myCards = ($this->player1 == $penguin) ? $this->player1Cards:$this->player2Cards;
		$myUsedCards = ($this->player1 == $penguin) ? $this->player1UsedCards:$this->player2UsedCards;
		$x = array();
		$cardsProcessed = 0;
		for($cardsProcessed = 0; $cardsProcessed != $dealNum; $cardsProcessed++) {
			$cardId = array_rand($this->cardsArray2);

			$cardDetails = sprintf("%d|%s", $cardId, implode("|", $this->cardsArray2[$cardId]));

			array_push($myCards, $cardDetails);
			array_push($x, $cardDetails);
		}
		$playerCardsString = implode("%", $x);
		if ($penguin != "Sensei") {
			$playerCardsString = implode("%", $x);
			$penguin->room->send("%xt%zm%{$penguin->waddleRoom}%deal%{$penguin->seatID}%$playerCardsString%");
		} else {
			$playerCardsString = implode("%", $x);
			$this->player2->send("%xt%zm%{$this->player2->waddleRoom}%deal%0%$playerCardsString%");
		}
		switch ($penguin) {
			case $this->player1:
				$this->player1Cards = $myCards;
				break;
			case $this->player2:
				$this->player2Cards = $myCards;
				break;
		}
	}

	public function pickCards($penguin, $cardPicked) {
		$myCards = ($this->player1 == $penguin) ? $this->player1Cards:$this->player2Cards;
		foreach($myCards as $card) {
			$cardArray = explode("|", $card);
			if($cardArray[0] == $cardPicked) {
				if ($penguin == $this->player1) {
					unset($this->player1Cards[$card]);
					$this->player1CardPicked = $cardPicked;
				}else{
					unset($this->player2Cards[$card]);
					$this->player2CardPicked = $cardPicked;
				}
				if($penguin != "Sensei") {
					$penguin->room->send("%xt%zm%{$penguin->waddleRoom}%pick%{$penguin->seatID}%$cardPicked%");
					if($this->sensei) {
						$senseiCard = $this->decideSenseiCard($penguin, $cardPicked);
						return $this->pickCards("Sensei", $senseiCard);
					}
				} else {
					$this->player2->send("%xt%zm%{$this->player2->waddleRoom}%pick%0%$cardPicked%");
				}
				if($this->player1CardPicked != null and $this->player2CardPicked != null) {
					$seatWinner = $this->determineWinner($this->player1CardPicked, $this->player2CardPicked);
					if($penguin != "Sensei")
						$penguin->room->send("%xt%zm%{$penguin->waddleRoom}%judge%$seatWinner%");
					else
						$this->player2->send("%xt%zm%{$this->player2->waddleRoom}%judge%$seatWinner%");
					if($seatWinner != -1) {
						if($seatWinner == 0) { //player 1
							$myWins = $this->player1Wins;
							$playerCardPicked = $this->player1CardPicked;
						} else { //seatWinner = 1
							$myWins = $this->player2Wins;
							$playerCardPicked = $this->player2CardPicked;
						}
						$dummyCard = $this->cardsArray2[$playerCardPicked];
						$myWins[$dummyCard[1]][$dummyCard[3]] = $playerCardPicked;
						if($seatWinner == 0) { //player 1
							$this->player1Wins = $myWins;
						} else { //seatWinner = 1
							$this->player2Wins = $myWins;
						}
						$gameEnded = $this->getGameEnded($myWins); //returns array of true/false and cards used to win
						if($gameEnded[0] != False) {
							$this->completed = true;
							foreach($penguin->room->penguins as $waddlePenguin) {
								$hasNewBelt = false;
								if($waddlePenguin != "Sensei") {
									$hasNewBelt = $this->updateNinjaPercentage($waddlePenguin, $this->sensei, $seatWinner);
									if($hasNewBelt == true) {
										$waddlePenguin->send("%xt%cza%-1%{$waddlePenguin->NinjaBelt}%");
									}
								}
							}
							if($penguin != "Sensei")
								$penguin->room->send("%xt%czo%-1%0%{$seatWinner}%{$gameEnded[1]}%");
							else
								$this->player2->send("%xt%czo%-1%0%{$seatWinner}%{$gameEnded[1]}%");
							break;
						}
						$this->player1CardPicked = null;
						$this->player2CardPicked = null;
					}  else {
						$this->player1CardPicked = null;
						$this->player2CardPicked = null;
					}
				}
				break;
			}
		}
	}

	function findKey($array, $keySearch)
	{
		foreach ($array as $key => $item) {
			if ($key == $keySearch) {
				return true;
			}
			else {
				if (is_array($item) && $this->findKey($item, $keySearch)) {
				   return true;
				}
			}
		}

		return false;
	}

	public function getGameEnded($myWins) {
		$colorsAvailable = Array('s'=>[], 'w'=>[], 'f'=>[]);
		foreach($myWins as $element=>$elementValue) {
			$cardsUsedForSingle = [];
			$colorInSingleElement = 0;
			foreach($elementValue as $color=>$cardID) {
				if($cardID != '' and $this->findKey($colorsAvailable[$element], $color) == false) {
					$colorInSingleElement += 1;
					array_push($cardsUsedForSingle, $cardID);
					$colorsAvailable[$element][$color] = $cardID;
				}
			}
			if($colorInSingleElement >= 3) {
				return [True, implode("%", $cardsUsedForSingle)];
			}
		}
		if($colorsAvailable['w'] == [] or $colorsAvailable['f'] == [] or $colorsAvailable['s'] == [])
			return [False];
		foreach($colorsAvailable as $element=>$val) {
			switch($element) {
				case "f":
					$index2 = "w";
					$index3 = "s";
					break;
				case"w":
					$index2 = "f";
					$index3 = "s";
					break;
				case "s":
					$index2 = "f";
					$index3 = "w";
					break;
			}
			$check = $this->getWinByElement($val, $colorsAvailable[$index2], $colorsAvailable[$index3]);
			if($check[0] == True) {
				return [$check[0], implode("%", $check[1])];
			}
		}
		return [False];

	}

	public function getWinByElement($el, $el2, $el3) {
		foreach($el as $color1=>$mainColorID) {
			foreach($el2 as $color=>$cardEl2ID) {
				if($color1 != $color) {
					foreach($el3 as $color2=>$color2ID) {
						if($color1 != $color2 and $color != $color2) {
							return [True, array($mainColorID,$color2ID, $cardEl2ID)];
						}
					}
				}
			}
		}
	}

	public function determineWinner($player1Card, $player2Card) {
		$cardInfo1 = $this->cardsArray2[$player1Card];
		$cardInfo2 = $this->cardsArray2[$player2Card];
		$elResult = $this->checkForElement($cardInfo1[1], $cardInfo2[1]);
		if($elResult != -1)
			return $elResult;
		$valResult = $this->checkForValue($cardInfo1[2], $cardInfo2[2]);
		return $valResult;
	}

	public function checkForElement($element1, $element2) {
		if($element1 == $element2)
			return -1;
		switch($element1){
			case "f":
				if ($element2 == 'w')
					return 1;
				return 0;
				break;
			case "w":
				if($element2 == "s")
					return 1;
				return 0;
				break;
			default: //snow
				if($element2 == "f")
					return 1;
				return 0;
		}
	}

	public function checkForValue($val1, $val2) {
		if($val1 > $val2)
			return 0;
		if($val1 < $val2)
			return 1;
		return -1;
	}

	public function updateNinjaPercentage($penguin,$sensei, $winnerSeat) {
		if($sensei) {
			if($winnerSeat == 1)
				$newPercentageArray = [true, 100];
			else
				return false;
		}
		$newPercentageArray = $this->getNewNinjaPercentage($penguin->NinjaBelt, $penguin->NinjaPercentage, $penguin->seatID, $winnerSeat); //array(True/False if new belt, NewNinjaPercentage)
		$penguin->database->updateColumnById($penguin->id, "NinjaPercentage", $newPercentageArray[1]);
		$penguin->NinjaPercentage = $newPercentageArray[1];
		if($newPercentageArray[0] == true) {
			$penguin->NinjaBelt++;
			if($sensei)
				$penguin->NinjaBelt = 10;
			$penguin->addItem($this->beltsItemID[$penguin->NinjaBelt], 0);
			$penguin->database->updateColumnById($penguin->id, "NinjaBelt", $penguin->NinjaBelt);
			return true;
		}
		return false;
	}

	public function getNewNinjaPercentage($currentNinjaBelt, $currentPercentage, $mySeat, $winnerSeat) {
		if($mySeat == $winnerSeat)
			$percentageToAdd = $this->addedPercentage[$currentNinjaBelt];
		else
			$percentageToAdd = $this->loserAddedPercentage[$currentNinjaBelt];
		$newPercentage = $currentPercentage + $percentageToAdd;
		if($newPercentage >= 100) {
			$newPercentage -= 100;
			return array(true, $newPercentage);
		}
		return array(false, $newPercentage);
	}

	public function decideSenseiCard($penguin, $cardPicked) {
		$ninjaBelt = $penguin->NinjaBelt;
		if($ninjaBelt < 8) { // realllyyyy small chance to win
			foreach($this->player1Cards as $singleCardDetails) {
				$cardDetailsArray = explode("|", $singleCardDetails);
				$penguinCardInfo = $this->cardsArray2[$cardPicked];
				$penguinCardElement = $penguinCardInfo[1];
				$senseiCardElement = $cardDetailsArray[2];
				switch($senseiCardElement) {
					case "f":
						if ($penguinCardElement == "s")
							return $cardDetailsArray[0];
						break;
					case "w":
						if($penguinCardElement == "f")
							return $cardDetailsArray[0];
						break;
					case "s":
						if($penguinCardElement == "w")
							return $cardDetailsArray[0];
						break;
				}
			}
		}
		$cardIndex = array_rand($this->player1Cards); //called if didn't find a counter card or if ninjaBelt is brown or black
		$cardDetails = $this->player1Cards[$cardIndex];
		return explode("|", $cardDetails)[0];
	}
}

?>
