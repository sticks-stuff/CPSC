<?php

namespace Kitsune\ClubPenguin\Handlers\Game;

class FindFour {

	const InvalidChipPlacement = -1;
	const ChipPlaced = 0;
	const FoundFour = 1;
	const Tie = 2;
	const FourNotFound = 3;

	public $boardMap = array(
		array(0, 0, 0, 0, 0, 0, 0),
		array(0, 0, 0, 0, 0, 0, 0),
		array(0, 0, 0, 0, 0, 0, 0),
		array(0, 0, 0, 0, 0, 0, 0),
		array(0, 0, 0, 0, 0, 0, 0),
		array(0, 0, 0, 0, 0, 0, 0),
	);

	public $currentPlayer = 1;
	public $gameOver = false;

	public function convertToString() {
		return implode(",", array_map(function($row) {
			return implode(",", $row);
		}, $this->boardMap));
	}

	public function changePlayer() {
		if($this->currentPlayer == 1) {
			$this->currentPlayer = 2;
		} else {
			$this->currentPlayer = 1;
		}
	}

	public function validChipPlacement($column, $row) {
		if($this->boardMap[$row][$column] != 0) {
			echo "Invalid chip placement (!= 0)\n";
			var_dump($this->boardMap[$row][$column]);
			return false;
		}

		return true;
	}

	public function isBoardFull() {
		foreach($this->boardMap as $row) {
			if(in_array(0, $row)) {
				return false;
			}
		}

		return true;
	}

	public function determineColumnWin($column) {
		$currentPlayer = $this->currentPlayer;

		$streak = 0;

		foreach($this->boardMap as $row) {
			if($row[$column] == $currentPlayer) {
				$streak++;

				if($streak === 4) {
					return self::FoundFour;
				}
			} else {
				$streak = 0;
			}
		}

		return self::FourNotFound;
	}

	public function determineVerticalWin() {
		$rows = count($this->boardMap);

		for($column = 0; $column < $rows; $column++) {
			$foundFour = $this->determineColumnWin($column);

			if($foundFour === self::FoundFour) {
				return $foundFour;
			}
		}

		return self::FourNotFound;
	}

	public function determineHorizontalWin() {
		$currentPlayer = $this->currentPlayer;

		$rows = count($this->boardMap);
		$streak = 0;

		for($row = 0; $row < $rows; $row++) {
			$columns = count($this->boardMap[$row]);

			for($column = 0; $column < $columns; $column++) {
				if($this->boardMap[$row][$column] === $currentPlayer) {
					$streak++;

					if($streak === 4) {
						return self::FoundFour;
					}
				} else {
					$streak = 0;
				}
			}
		}

		return self::FourNotFound;
	}

	public function determineDiagonalWin() {
		$currentPlayer = $this->currentPlayer;

		$rows = count($this->boardMap);

		$streak = 0;

		for($row = 0; $row < $rows; $row++) {
			$columns = count($this->boardMap[$row]);

			for($column = 0; $column < $columns; $column++) {
				if($this->boardMap[$row][$column] === $currentPlayer) {
					if(@$this->boardMap[$row + 1][$column + 1] === $currentPlayer &&
						@$this->boardMap[$row + 2][$column + 2] === $currentPlayer &&
						@$this->boardMap[$row + 3][$column + 3] === $currentPlayer) {

						return self::FoundFour;
					} elseif(@$this->boardMap[$row - 1][$column + 1] === $currentPlayer &&
						@$this->boardMap[$row - 2][$column + 2] === $currentPlayer &&
						@$this->boardMap[$row - 3][$column + 3] === $currentPlayer) {

						return self::FoundFour;
					} elseif(@$this->boardMap[$row - 1][$column - 1] === $currentPlayer &&
						@$this->boardMap[$row - 2][$column - 2] === $currentPlayer &&
						@$this->boardMap[$row - 3][$column - 3] === $currentPlayer) {

						return self::FoundFour;
					}
				}
			}
		}

		return self::FourNotFound;
	}

	public function processBoard() {
		$fullBoard = $this->isBoardFull();

		if($fullBoard === true) {
			return self::Tie;
		}

		$horizontalWin = $this->determineHorizontalWin();

		if($horizontalWin == self::FoundFour) {
			return $horizontalWin;
		}

		$verticalWin = $this->determineVerticalWin();

		if($verticalWin == self::FoundFour) {
			return $verticalWin;
		}

		$diagonalWin = $this->determineDiagonalWin();

		if($diagonalWin == self::FoundFour) {
			return $diagonalWin;
		}

		return self::ChipPlaced;
	}

	public function placeChip($column, $row) {
		if($this->validChipPlacement($column, $row)) {
			$this->boardMap[$row][$column] = $this->currentPlayer;

			$gameStatus = $this->processBoard();

			if($gameStatus == self::ChipPlaced) {
				$this->changePlayer();
			}

			return $gameStatus;
		} else {
			return self::InvalidChipPlacement;
		}
	}

}

?>
