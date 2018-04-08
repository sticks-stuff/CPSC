<?php

namespace Kitsune\ClubPenguin;

use Kitsune\Logging\Logger;
use Kitsune\ClubPenguin\Handlers;
use Kitsune\ClubPenguin\Packets\Packet;

final class Redemption extends ClubPenguin {

  protected $worldHandlers = array(
    "red" => array(
      "rjs" => "handleJoinRedemption",
      "rsc" => "handleSendCode"
    )
  );

  public function __construct() {
    parent::__construct();

    Logger::Fine("Redemption server is online");
  }

  protected function handleLogin($socket) {
    $penguin = $this->penguins[$socket];

    $this->databaseManager->add($penguin);

    $username = Packet::$Data['body']['login']['nick'];
    $loginKey = Packet::$Data['body']['login']['pword'];

    if(!$penguin->database->usernameExists($username)) {
      $penguin->send("%xt%e%-1%101%");
      return $this->removePenguin($penguin);
    }

    $penguinData = $penguin->database->getColumnsByName($username, array("ID", "Username", "LoginKey"));
    $id = $penguinData["ID"];
    $username = $penguinData["Username"];
    $dbLoginKey = $penguinData["LoginKey"];
    $loginHash = Hashing::encryptPassword($dbLoginKey . $penguin->randomKey) . $dbLoginKey;
    if($loginHash != $loginKey) {
      $penguin->send("%xt%e%-1%101%");
      return $this->removePenguin($penguin);
    } else {
      $penguin->id = $id;
      $penguin->username = $username;
      $penguin->identified = true;
      $penguin->send("%xt%l%-1%");
    }
  }

  protected function handleJoinRedemption($socket) {
    $penguin = $this->penguins[$socket];
    $packetId = Packet::$Data[2];
    $loginKey = Packet::$Data[3];

    if($penguin->id != $packetId || $loginKey == "") {
      $penguin->send("%xt%e%-1%1");
      return $this->removePenguin($penguin);
    }

    $dbLoginKey = $penguin->database->getColumnById($penguin->id, "LoginKey");

    if($dbLoginKey != $loginKey) {
      $penguin->send("%xt%e%-1%101");
      return $this->removePenguin($penguin);
    }

    $penguin->send("%xt%rjs%-1%%1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17%0%");
  }

  protected function handleSendCode($socket) {
    $penguin = $this->penguins[$socket];
    $code = Packet::$Data[2];

    if(!$penguin->database->redemptionCodeExists($code)) {
      return $penguin->send("%xt%e%-1%720%");
    }

    $expirationDate = $penguin->database->getRedemptionColumnByCode($code, "Expires");
    if(!$expirationDate == 0 && $expirationDate < time()) {
      return $penguin->send("%xt%e%-1%726%");
    }

    $usesRemaining = $penguin->database->getRedemptionColumnByCode($code, "Uses");
    if($usesRemaining == 0) {
      return $penguin->send("%xt%e%-1%726%");
    }

    $redeemedCodes = $penguin->database->getColumnById($penguin->id, "Redeemed");
    if(strpos($redeemedCodes, $code.",") !== false) {
      return $penguin->send("%xt%e%-1%721%");
    }

    $type = $penguin->database->getRedemptionColumnByCode($code, "Type");
    if ($type == "BLANKET") {
      $items = $penguin->database->getRedemptionColumnByCode($code, "Items");
      if ($items != "") {
        foreach (explode(',', $items) as $item) {
          if(is_numeric($item)) {
            $inventory = $penguin->database->getColumnById($penguin->id, "Inventory");
            if(strpos($inventory, "%" . $item) === false) {
              $penguin->database->updateColumnById($penguin->id, "Inventory", $inventory . "%" . $item);
            }
          }
        }
      }

      $redemptionCoins = $penguin->database->getRedemptionColumnByCode($code, "Coins");
      if ($redemptionCoins != 0) {
        $coins = $penguin->database->getColumnById($penguin->id, "Coins");
        $totalCoins = $coins + $redemptionCoins;
        $penguin->database->updateColumnById($penguin->id, "Coins", $totalCoins);
      }

      $penguin->database->updateColumnById($penguin->id, "Redeemed", $redeemedCodes . $code . ",");

      $uses = $penguin->database->getRedemptionColumnByCode($code, "Uses");
      if ($uses != -1) {
        $penguin->database->updateRedemptionColumn($code, "Uses", $uses - 1);
      }

      return $penguin->send("%xt%rsc%-1%{$type}%{$items}%{$redemptionCoins}%");
    } else {
      return $penguin->send("%xt%e%-1%1%");
    }
  }

  public function removePenguin($penguin) {
    $this->removeClient($penguin->socket);

    $this->databaseManager->remove($penguin);

    unset($this->penguins[$penguin->socket]);
  }

  protected function handleDisconnect($socket) {
    $penguin = $this->penguins[$socket];

    $this->removePenguin($penguin);

    Logger::Info("Player disconnected from redemption server");
  }

}

?>