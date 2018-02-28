<?php
namespace Kitsune\ClubPenguin\Handlers\Play;

use Kitsune\ClubPenguin\Packets\Packet;

trait Ignore {

  //TODO: Actually stop ignored penguins from communicating.
  protected function addIgnore($penguin, $ignoreId) {
    if(isset($penguin->ignore[$ignoreId])) {
      return;
    }

    $ignore = $this->getPlayerById($ignoreId);
    if($ignore !== null) { // we can only ignore a player if they're online
      $penguin->ignore[$ignoreId] = $ignore->username;

      $ignoreString = implode('%', array_map(
  			function($ignoreId, $ignoreName) {
  				return $ignoreId . '|' . $ignoreName;
  			}, array_keys($penguin->ignore), $penguin->ignore));

      $penguin->database->updateColumnById($penguin->id, "Ignores", $ignoreString);
    }
  }

  protected function removeIgnore($penguin, $ignoreId) {
    if(!isset($penguin->ignore[$ignoreId])) {
      return;
    }

    unset($penguin->ignore[$ignoreId]);

    $ignoreString = implode('%', array_map(
			function($ignoreId, $ignoreName) {
				return $ignoreId . '|' . $ignoreName;
			}, array_keys($penguin->ignore), $penguin->ignore));

    $penguin->database->updateColumnById($penguin->id, "Ignores", $ignoreString);
  }

  protected function handleGetIgnoreList($socket) {
    $penguin = $this->penguins[$socket];

    if(count($penguin->ignore) == 0){
      return $penguin->send("%xt%gn%{$penguin->room->internalId}%");
    }

    $ignore = implode('%', array_map(
			function($ignoreId, $ignoreName) {
				return $ignoreId . '|' . $ignoreName;
			}, array_keys($penguin->ignore), $penguin->ignore));

    $penguin->send("%xt%gn%{$penguin->room->internalId}%$ignore%");
  }

  protected function handleAddIgnore($socket) {
    $penguin = $this->penguins[$socket];

    if(is_numeric(Packet::$Data[2])){
    $ignoreId = Packet::$Data[2];
    }

    if(isset($penguin->buddies[$ignoreId])) {
      return;
    }

    $this->addIgnore($penguin, $ignoreId);
  }

  protected function handleRemoveIgnore($socket) {
    $penguin = $this->penguins[$socket];

    if(is_numeric(Packet::$Data[2])){
    $ignoreId = Packet::$Data[2];
    }

    $this->removeIgnore($penguin, $ignoreId);
  }

}

?>
