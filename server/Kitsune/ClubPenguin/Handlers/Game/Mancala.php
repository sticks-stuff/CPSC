<?php

namespace Kitsune\ClubPenguin\Handlers\Game;

class Mancala {

	const InvalidHollow = -1;
	const MoveComplete = 0;
	const Won = 1;
	const Tie = 2;
	const NoSidesEmpty = 3;
	const FreeTurn = "f";
	const Capture = "c";

	public $boardMap = array(
		4, 4, 4, 4, 4, 4, 0,
		4, 4, 4, 4, 4, 4, 0
	);

	public $currentPlayer = 1;
	public $winner = 0;
	public $gameOver = false;

	public function convertToString() {
		return implode(',', $this->boardMap);
	}

	public function changePlayer() {
		if($this->currentPlayer == 1) {
			$this->currentPlayer = 2;
		} else {
			$this->currentPlayer = 1;
		}
	}

	public function validMove($hollow) {
		if($this->currentPlayer == 1 && !in_array($hollow, range(0, 5))) {
			return false;
		}

		if($this->currentPlayer == 2 && !in_array($hollow, range(7, 12))) {
			return false;
		}

		return true;
	}

	public function determineTie() {
		if(array_sum(array_slice($this->boardMap, 0, 6)) == 0 || array_sum(array_slice($this->boardMap, 7, 6)) == 0) {
			if(array_sum(array_slice($this->boardMap, 0, 6)) == array_sum(array_slice($this->boardMap, 7, 6))) {
				return self::Tie;
			}
		}
		return self::NoSidesEmpty;
	}

	public function determineWin() {
		if(array_sum(array_slice($this->boardMap, 0, 6)) == 0 || array_sum(array_slice($this->boardMap, 7, 6)) == 0) {
			if(array_sum(array_slice($this->boardMap, 0, 6)) > array_sum(array_slice($this->boardMap, 7, 6))) {
				$this->winner = 1;
			} else {
				$this->winner = 2;
			}
			return self::Won;
		}
		return self::NoSidesEmpty;
	}

	public function processBoard() {
		$tie = $this->determineTie();

		if($tie == self::Tie) {
			return $tie;
		}

		$win = $this->determineWin();

		if($win == self::Won) {
			return $win;
		}

		return self::MoveComplete;
	}

	public function makeMove($hollow) {
		if($this->validMove($hollow)) {
			$capture = false;
			$hand = $this->boardMap[$hollow];
			$this->boardMap[$hollow] = 0;

			while($hand > 0) {
				$hollow++;
				if(!isset($this->boardMap[$hollow])) {
					$hollow = 0;
				}
				$myMancala = ($this->currentPlayer == 1 ? 6 : 13);
				$opponentMancala = ($this->currentPlayer == 1 ? 13 : 6);
				if($hollow == $opponentMancala) {
					continue; // we ran into the opponents mancala, skip it
				}
				$oppositeHollow = 12 - $hollow;
				if($this->currentPlayer == 1 && in_array($hollow, range(0, 5)) && $hand == 1 && $this->boardMap[$hollow] == 0) {
					$this->boardMap[$myMancala] = $this->boardMap[$myMancala] + $this->boardMap[$oppositeHollow] + 1;
					$this->boardMap[$oppositeHollow] = 0;
					$capture = true;
					break;
				}
				if($this->currentPlayer == 2 && in_array($hollow, range(7, 12)) && $hand == 1 && $this->boardMap[$hollow] == 0) {
					$this->boardMap[$myMancala] = $this->boardMap[$myMancala] + $this->boardMap[$oppositeHollow] + 1;
					$this->boardMap[$oppositeHollow] = 0;
					$capture = true;
					break;
				}
				$this->boardMap[$hollow]++;
				$hand--;
			}

			$gameStatus = $this->processBoard();
	
			if($gameStatus == self::MoveComplete) {
				if(($this->currentPlayer == 1 && $hollow != 6) || ($this->currentPlayer == 2 && $hollow != 13)) {
					$this->changePlayer();
					if($capture) {
						return self::Capture;
					}
				} else {
					return self::FreeTurn;
				}
			}
	
			return $gameStatus;
		} else {
			return self::InvalidHollow;
		}
	}

}

?>
