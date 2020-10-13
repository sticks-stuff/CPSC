class com.clubpenguin.shell.PuffleManager
{
   var _pufflesFetched = false;
   var _currentWalkingId = undefined;
   static var MAX_PUFFLES = 18;
   static var PUFFLE_INVENTORY_ID = 750;
   static var START_WALK = 1;
   static var STOP_WALK = 0;
   function PuffleManager(shell, airtower, puffleStatsForType, modelManager)
   {
      this._shell = shell;
      this._airtower = airtower;
      this._modelManager = modelManager;
      this._puffleStatsForType = puffleStatsForType;
   }
   function init()
   {
      this.attachListeners();
   }
   function attachListeners()
   {
      this._airtower.addListener(this._airtower.GET_MY_PLAYER_PUFFLES,this.handleGetMyPuffles,this);
      this._airtower.addListener(this._airtower.GET_PLAYER_PUFFLES,this.handleGetPufflesByPlayerId,this);
      this._airtower.addListener(this._airtower.PUFFLE_FRAME,this.handleSendPuffleFrame,this);
      this._airtower.addListener(this._airtower.PUFFLE_MOVE,this.handleSendPuffleMove,this);
      this._airtower.addListener(this._airtower.ADOPT_PUFFLE,this.handleSendAdoptPuffle,this);
      this._airtower.addListener(this._airtower.INTERACTION_PLAY,this.handleSendPlayInteraction,this);
      this._airtower.addListener(this._airtower.INTERACTION_REST,this.handleSendRestInteraction,this);
      this._airtower.addListener(this._airtower.INTERACTION_FEED,this.handleSendFeedInteraction,this);
      this._airtower.addListener(this._airtower.PUFFLE_INIT_INTERACTION_PLAY,this.handleSendPuffleInitPlayInteraction,this);
      this._airtower.addListener(this._airtower.PUFFLE_INIT_INTERACTION_REST,this.handleSendPuffleInitRestInteraction,this);
      this._airtower.addListener(this._airtower.PLAY_PUFFLE,this.handleSendPufflePlay,this);
      this._airtower.addListener(this._airtower.REST_PUFFLE,this.handleSendPuffleRest,this);
      this._airtower.addListener(this._airtower.BATH_PUFFLE,this.handleSendPuffleBath,this);
      this._airtower.addListener(this._airtower.FEED_PUFFLE,this.handleSendPuffleFood,this);
      this._airtower.addListener(this._airtower.TREAT_PUFFLE,this.handleSendPuffleTreat,this);
      this._airtower.addListener(this._airtower.WALK_PUFFLE,this.handleSendPuffleWalk,this);
      this._shell.addListener(this._shell.IGLOO_INIT_COMPLETE,this.handleIglooInitComplete,this);
      this._shell.addListener(this._shell.FURNITURE_INTERACTIVE_TYPES,this.handleFurnitureInteractiveTypes,this);
      this._shell.addListener(this._shell.IGLOO_EDIT_MODE,this.handleIglooEditMode,this);
      this._shell.addListener(this._shell.JOIN_ROOM,com.clubpenguin.util.Delegate.create(this,this.cleanUpRoomPuffles));
   }
   function handleFurnitureInteractiveTypes(rules)
   {
      var _loc2_ = rules.playInteractionAllowed || false;
      var _loc1_ = rules.restInteractionAllowed || false;
      var _loc4_ = rules.feedInteractionAllowed || false;
      com.clubpenguin.shell.RoomPuffle.setAllowPlayInteraction(_loc2_);
      com.clubpenguin.shell.RoomPuffle.setAllowRestInteraction(_loc1_);
      com.clubpenguin.shell.RoomPuffle.setAllowFeedInteraction(_loc4_);
   }
   function handleIglooEditMode(event)
   {
      var _loc5_ = event.active || false;
      var _loc3_ = 0;
      var _loc4_ = this._roomPuffles.length;
      while(_loc3_ < _loc4_)
      {
         var _loc2_ = this._roomPuffles[_loc3_];
         if(_loc5_)
         {
            _loc2_.stopBrain();
         }
         else
         {
            _loc2_.startBrain();
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function getMyPuffles()
   {
      if(!this._pufflesFetched)
      {
         this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.GET_MY_PLAYER_PUFFLES,[],"str",this._shell.getCurrentServerRoomId());
         return undefined;
      }
      this._shell.$e("[SHELL] PuffleManager.getMyPuffles() -> Puffles already fetched! cant get them again");
   }
   function handleGetMyPuffles(obj)
   {
      var _loc6_ = obj.shift();
      this._myPuffles = new Array();
      var _loc4_ = undefined;
      var _loc2_ = undefined;
      var _loc5_ = undefined;
      for(var _loc5_ in obj)
      {
         _loc4_ = obj[_loc5_].split("|");
         _loc2_ = this.makeMyPuffleFromCrumb(_loc4_);
         _loc2_.startStats();
         this._myPuffles.push(_loc2_);
      }
      this._pufflesFetched = true;
   }
   function getPufflesByPlayerId(player_id)
   {
      if(!isNaN(player_id))
      {
         this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.GET_PLAYER_PUFFLES,[player_id],"str",this._shell.getCurrentServerRoomId());
         return undefined;
      }
      this._shell.$e("[SHELL] PuffleManager.getPufflesByPlayerId() -> player id is not a valid number! player_id: " + player_id);
   }
   function handleGetPufflesByPlayerId(obj)
   {
      var _loc6_ = obj.shift();
      if(this._roomPuffles != undefined)
      {
         this.cleanUpRoomPuffles();
      }
      this._roomPuffles = new Array();
      var _loc2_ = undefined;
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      for(var _loc5_ in obj)
      {
         _loc2_ = obj[_loc5_].split("|");
         _loc3_ = this.makeRoomPuffleFromCrumb(_loc2_);
         this._roomPuffles.push(_loc3_);
         if(this._modelManager.isMyPuffleById(_loc3_.__get__id()))
         {
            this._modelManager.updatePuffleStatsById(_loc3_.__get__id(),Number(_loc2_[3]),Number(_loc2_[4]),Number(_loc2_[5]));
         }
      }
      this._shell.updateListeners(this._shell.GET_IGLOO_DETAILS,null);
   }
   function handleIglooInitComplete()
   {
      var _loc3_ = this._modelManager.__get__roomPuffles();
      var _loc11_ = _loc3_.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc11_)
      {
         var _loc6_ = _loc3_[_loc2_].id;
         var _loc8_ = _loc3_[_loc2_].typeID;
         var _loc7_ = _loc3_[_loc2_].isWalking;
         var _loc5_ = _loc3_[_loc2_].x;
         var _loc4_ = _loc3_[_loc2_].y;
         this._shell.updateListeners(this._shell.ADD_PUFFLE,{id:_loc6_,typeID:_loc8_,isWalking:_loc7_,x:_loc5_,y:_loc4_});
         _loc2_ = _loc2_ + 1;
      }
   }
   function startRoomPuffleBrains()
   {
      var _loc3_ = this._roomPuffles.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this._roomPuffles[_loc2_].startBrain();
         _loc2_ = _loc2_ + 1;
      }
   }
   function stopRoomPuffleBrains()
   {
      var _loc3_ = this._roomPuffles.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this._roomPuffles[_loc2_].stopBrain();
         _loc2_ = _loc2_ + 1;
      }
   }
   function handlePuffleRequestFrame(event)
   {
      var _loc2_ = event.id;
      var _loc3_ = event.frame;
      if(isNaN(_loc2_))
      {
         this._shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Puffle id is not a real number: " + _loc2_);
         return undefined;
      }
      if(isNaN(_loc3_))
      {
         this._shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Frame is undefined!: " + _loc3_);
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.PUFFLE_FRAME,[_loc2_,_loc3_],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendPuffleFrame(event)
   {
      var _loc6_ = event[0];
      var _loc2_ = Number(event[1]);
      var _loc3_ = Number(event[2]);
      if(isNaN(_loc2_))
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle ID is not a real number: " + _loc2_);
         return undefined;
      }
      if(isNaN(_loc3_))
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle frame is not a real number. puffle_frame: " + _loc3_);
         return undefined;
      }
      var _loc4_ = this.getRoomPuffleById(_loc2_);
      _loc4_.__set__frame(_loc3_);
   }
   function handlePuffleRequestMove(puffle)
   {
      this._shell.updateListeners(this._shell.REQUEST_PUFFLE_MOVE,{id:puffle.__get__id()});
   }
   function sendPuffleMove(id, xpos, ypos)
   {
      if(this._shell.getPlayersInRoomCount() > 1)
      {
         this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.PUFFLE_MOVE,[id,xpos,ypos],"str",this._shell.getCurrentServerRoomId());
      }
      else
      {
         var _loc2_ = this.getRoomPuffleById(id);
         _loc2_.moveTo(xpos,ypos);
      }
   }
   function handleSendPuffleMove(arr)
   {
      var _loc7_ = arr[0];
      var _loc4_ = Number(arr[1]);
      var _loc6_ = Number(arr[2]);
      var _loc5_ = Number(arr[3]);
      var _loc2_ = this.getRoomPuffleById(_loc4_);
      if(_loc2_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handlePuffleMove() -> Puffle was undefined! id: " + _loc4_);
         return undefined;
      }
      _loc2_.moveTo(_loc6_,_loc5_);
   }
   function sendStartPuffleWalk(puffleID)
   {
      var _loc2_ = this.getRoomPuffleById(puffleID);
      _loc2_.requestStartWalk();
   }
   function handlePuffleRequestStartWalk(puffle)
   {
      if(isNaN(puffle.__get__id()))
      {
         this._shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle Id is not a real number. id: " + puffle.__get__id());
         return undefined;
      }
      if(this.getIndexInRoomById(puffle.__get__id()) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle was not found in the room! id: " + puffle.__get__id());
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.WALK_PUFFLE,[puffle.__get__id(),com.clubpenguin.shell.PuffleManager.START_WALK],"str",this._shell.getCurrentServerRoomId());
   }
   function handlePuffleRequestStopWalk(puffle)
   {
      if(isNaN(puffle.__get__id()))
      {
         this._shell.$e("[SHELL] PuffleManager.handlePuffleRequestStopWalk() -> No puffles were found that were being walked! id: " + puffle.__get__id());
         return undefined;
      }
      if(this.getIndexInRoomById(puffle.__get__id()) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.handlePuffleRequestStopWalk() -> Puffle was not found in the room! id: " + puffle.__get__id());
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.WALK_PUFFLE,[puffle.__get__id(),com.clubpenguin.shell.PuffleManager.STOP_WALK],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendPuffleWalk(event)
   {
      var _loc8_ = event[0];
      var _loc7_ = Number(event[1]);
      var _loc4_ = event[2].split("|");
      var _loc3_ = Number(_loc4_[0]);
      var _loc5_ = Boolean(Number(_loc4_[12]));
      var _loc2_ = this.getRoomPuffleById(_loc3_);
      if(_loc2_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleWalk() -> Puffle was not found in the room! id: " + _loc3_);
         return undefined;
      }
      if(_loc5_)
      {
         if(this._shell.isMyPlayer(_loc7_))
         {
            this._shell.addPuffleToHand(_loc2_.__get__typeID());
         }
         this._currentWalkingId = _loc2_.id;
      }
      else
      {
         this._currentWalkingId = undefined;
      }
      _loc2_.__set__isWalking(_loc5_);
   }
   function stopAllPufflesWalking()
   {
      if(this._roomPuffles == undefined)
      {
         if(this._currentWalkingId == undefined)
         {
            return undefined;
         }
         this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.WALK_PUFFLE,[this._currentWalkingId,0],"str",this._shell.getCurrentServerRoomId());
         this._currentWalkingId = undefined;
         return undefined;
      }
      var _loc3_ = this._roomPuffles.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this._roomPuffles[_loc2_].requestStopWalk();
         _loc2_ = _loc2_ + 1;
      }
   }
   function requestPufflePlay(puffleID)
   {
      var _loc2_ = this.getRoomPuffleById(puffleID);
      _loc2_.requestPlay();
   }
   function handlePuffleRequestPlay(puffle)
   {
      if(isNaN(puffle.__get__id()))
      {
         this._shell.$e("[SHELL] PuffleManager.sendPufflePlay() -> Puffle Id is not a real number. id: " + puffle.__get__id());
         return undefined;
      }
      if(this.getIndexInRoomById(puffle.__get__id()) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.sendPufflePlay() -> Puffle was not found in the room! id: " + puffle.__get__id());
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.PLAY_PUFFLE,[puffle.__get__id()],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendPufflePlay(event)
   {
      var _loc10_ = event[0];
      var _loc2_ = event[1].split("|");
      var _loc9_ = event[2];
      var _loc3_ = _loc2_[0];
      var _loc4_ = this.getRoomPuffleById(_loc3_);
      if(_loc4_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.PuffleManager -> handleSendPuffleRest() -> Puffle was not found in the room! id: " + _loc3_);
         return undefined;
      }
      _loc4_.play(_loc9_);
      var _loc6_ = Number(_loc2_[3]);
      var _loc8_ = Number(_loc2_[4]);
      var _loc7_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc3_,_loc6_,_loc8_,_loc7_);
   }
   function requestPuffleRest(puffleID)
   {
      var _loc2_ = this.getRoomPuffleById(puffleID);
      _loc2_.requestRest();
   }
   function handlePuffleRequestRest(puffle)
   {
      if(isNaN(puffle.__get__id()))
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleRest() -> Puffle Id is not a real number. id: " + puffle.__get__id());
         return undefined;
      }
      if(this.getIndexInRoomById(puffle.__get__id()) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleRest() -> Puffle was not found in the room! id: " + puffle.__get__id());
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.REST_PUFFLE,[puffle.__get__id()],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendPuffleRest(event)
   {
      var _loc9_ = event[0];
      var _loc2_ = event[1].split("|");
      var _loc3_ = _loc2_[0];
      var _loc4_ = this.getRoomPuffleById(_loc3_);
      if(_loc4_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleRest() -> Puffle was not found in the room! id: " + _loc3_);
         return undefined;
      }
      _loc4_.rest();
      var _loc5_ = Number(_loc2_[3]);
      var _loc7_ = Number(_loc2_[4]);
      var _loc6_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc3_,_loc5_,_loc7_,_loc6_);
   }
   function requestPuffleBath(puffleID)
   {
      var _loc2_ = this.getRoomPuffleById(puffleID);
      _loc2_.requestBath();
   }
   function handlePuffleRequestBath(puffle)
   {
      if(isNaN(puffle.__get__id()))
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleBath() -> Puffle Id is not a real number. id: " + puffle.__get__id());
         return undefined;
      }
      if(this.getIndexInRoomById(puffle.__get__id()) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleBath() -> Puffle was not found in the room! id: " + puffle.__get__id());
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.BATH_PUFFLE,[puffle.__get__id()],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendPuffleBath(event)
   {
      var _loc10_ = event[0];
      var _loc6_ = Number(event[1]);
      var _loc2_ = event[2].split("|");
      var _loc11_ = Number(event[3]);
      var _loc3_ = _loc2_[0];
      var _loc4_ = this.getRoomPuffleById(_loc3_);
      if(_loc4_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleBath() -> Puffle was not found in the room! id: " + _loc3_);
         return undefined;
      }
      _loc4_.bath();
      var _loc7_ = Number(_loc2_[3]);
      var _loc9_ = Number(_loc2_[4]);
      var _loc8_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc3_,_loc7_,_loc9_,_loc8_);
      if(this._shell.isMyIgloo())
      {
         this._shell.setMyPlayerTotalCoins(_loc6_);
      }
   }
   function requestPuffleFeed(puffleID)
   {
      var _loc2_ = this.getRoomPuffleById(puffleID);
      _loc2_.requestFeed();
   }
   function handlePuffleRequestFeed(puffle)
   {
      if(isNaN(puffle.__get__id()))
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleFood() -> Puffle Id is not a real number. id: " + puffle.__get__id());
         return undefined;
      }
      if(this.getIndexInRoomById(puffle.__get__id()) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleFood() -> Puffle was not found in the room! id: " + puffle.__get__id());
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.FEED_PUFFLE,[puffle.__get__id()],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendPuffleFood(event)
   {
      var _loc10_ = event[0];
      var _loc6_ = Number(event[1]);
      var _loc2_ = event[2].split("|");
      var _loc11_ = event[3];
      var _loc3_ = _loc2_[0];
      var _loc4_ = this.getRoomPuffleById(_loc3_);
      if(_loc4_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleFood() -> Puffle was not found in the room! id: " + _loc3_);
         return undefined;
      }
      _loc4_.feed();
      var _loc7_ = Number(_loc2_[3]);
      var _loc9_ = Number(_loc2_[4]);
      var _loc8_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc3_,_loc7_,_loc9_,_loc8_);
      if(this._shell.isMyIgloo())
      {
         this._shell.setMyPlayerTotalCoins(_loc6_);
      }
   }
   function sendPuffleCookie(id)
   {
      if(isNaN(id))
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle Id is not a real number. id: " + id);
         return undefined;
      }
      if(this.getIndexInRoomById(id) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle was not found in the room! id: " + id);
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.TREAT_PUFFLE,[id,com.clubpenguin.shell.RoomPuffle.TREAT_COOKIE],"str",this._shell.getCurrentServerRoomId());
   }
   function sendPuffleGum(id)
   {
      if(isNaN(id))
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle Id is not a real number. id: " + id);
         return undefined;
      }
      if(this.getIndexInRoomById(id) == -1)
      {
         this._shell.$e("[SHELL] PuffleManager.sendPuffleTreat() -> Puffle was not found in the room! id: " + id);
         return undefined;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.TREAT_PUFFLE,[id,com.clubpenguin.shell.RoomPuffle.TREAT_GUM],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendPuffleTreat(event)
   {
      var _loc11_ = event[0];
      var _loc7_ = Number(event[1]);
      var _loc2_ = event[2].split("|");
      var _loc6_ = event[3];
      var _loc3_ = _loc2_[0];
      var _loc4_ = this.getRoomPuffleById(_loc3_);
      if(_loc4_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleTreat() -> Puffle was not found in the room! id: " + _loc3_);
         return undefined;
      }
      _loc4_.treat(_loc6_);
      var _loc8_ = Number(_loc2_[3]);
      var _loc10_ = Number(_loc2_[4]);
      var _loc9_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc3_,_loc8_,_loc10_,_loc9_);
      if(this._shell.isMyIgloo())
      {
         this._shell.setMyPlayerTotalCoins(_loc7_);
      }
   }
   function sendAdoptPuffle(typeID, puffleName)
   {
      if(this.__get__myPuffleCount() >= com.clubpenguin.shell.PuffleManager.MAX_PUFFLES)
      {
         this._shell.updateListeners(this._shell.ADOPT_PUFFLE,{success:false});
         return false;
      }
      if(isNaN(typeID))
      {
         this._shell.$e("[SHELL] PuffleManager.sendAdoptPuffle() -> Puffle type was not a real number! puffle_type: " + typeID);
         return false;
      }
      if(!this._shell.isValidString(puffleName))
      {
         this._shell.$e("[SHELL] PuffleManager.sendAdoptPuffle() -> Puffle name was not a real string! puffleName: " + puffleName);
         return false;
      }
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + this._airtower.ADOPT_PUFFLE,[typeID,puffleName],"str",this._shell.getCurrentServerRoomId());
   }
   function handleSendAdoptPuffle(event)
   {
      var _loc7_ = event[0];
      var _loc5_ = Number(event[1]);
      this._shell.setMyPlayerTotalCoins(_loc5_);
      var _loc3_ = event[2].split("|");
      var _loc2_ = this.makeMyPuffleFromCrumb(_loc3_);
      if(this._myPuffles == undefined)
      {
         this._myPuffles = new Array();
      }
      this._myPuffles.push(_loc2_);
      this._shell.updateListeners(this._shell.ADOPT_PUFFLE,{success:true});
   }
   function handlePuffleRequestInteraction(event)
   {
      var _loc4_ = undefined;
      switch(event.interactionType)
      {
         case com.clubpenguin.shell.RoomPuffle.INTERACTION_PLAY:
            _loc4_ = this._shell.INTERACTIVE_PLAY;
            break;
         case com.clubpenguin.shell.RoomPuffle.INTERACTION_REST:
            _loc4_ = this._shell.INTERACTIVE_REST;
            break;
         case com.clubpenguin.shell.RoomPuffle.INTERACTION_FEED:
            _loc4_ = this._shell.INTERACTIVE_FEED;
      }
      this._shell.updateListeners(this._shell.REQUEST_PUFFLE_INTERACTION,{id:event.id,interactionType:_loc4_});
   }
   function sendPuffleInteraction(success, puffleID, interactionType, xpos, ypos)
   {
      if(success)
      {
         var _loc3_ = this.getRoomPuffleById(puffleID);
         if(_loc3_ == undefined)
         {
            return undefined;
         }
         var _loc4_ = undefined;
         if(_loc3_.__get__selfInteract())
         {
            if(interactionType == this._shell.INTERACTIVE_PLAY)
            {
               _loc4_ = this._airtower.PUFFLE_INIT_INTERACTION_PLAY;
            }
            else if(interactionType == this._shell.INTERACTIVE_REST)
            {
               _loc4_ = this._airtower.PUFFLE_INIT_INTERACTION_REST;
            }
            else
            {
               this._shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect self initiated interaction type! interactionType: " + interactionType);
               return undefined;
            }
         }
         else if(interactionType == this._shell.INTERACTIVE_PLAY)
         {
            _loc4_ = this._airtower.INTERACTION_PLAY;
         }
         else if(interactionType == this._shell.INTERACTIVE_REST)
         {
            _loc4_ = this._airtower.INTERACTION_REST;
         }
         else if(interactionType == this._shell.INTERACTIVE_FEED)
         {
            _loc4_ = this._airtower.INTERACTION_FEED;
         }
         else
         {
            this._shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect interaction type! interactionType: " + interactionType);
            return undefined;
         }
         if(_loc4_ == undefined)
         {
            return undefined;
         }
         this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PET_HANDLER + "#" + _loc4_,[puffleID,xpos,ypos],"str",this._shell.getCurrentServerRoomId());
      }
      else
      {
         _loc3_ = this.getRoomPuffleById(puffleID);
         if(_loc3_ == undefined)
         {
            return undefined;
         }
         if(_loc3_.__get__selfInteract())
         {
            _loc3_.cancelSelfInteraction();
            return undefined;
         }
         if(interactionType == this._shell.INTERACTIVE_PLAY)
         {
            _loc3_.forceNormalPlay();
         }
         else if(interactionType == this._shell.INTERACTIVE_REST)
         {
            _loc3_.forceNormalRest();
         }
         else if(interactionType == this._shell.INTERACTIVE_FEED)
         {
            _loc3_.forceNormalFeed();
         }
      }
   }
   function handleSendPuffleInitPlayInteraction(event)
   {
      var _loc10_ = Number(event[0]);
      var _loc6_ = Number(event[1]);
      var _loc5_ = Number(event[2]);
      var _loc4_ = Number(event[3]);
      var _loc2_ = this.getRoomPuffleById(_loc6_);
      if(_loc2_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleInitPlayInteraction() -> Puffle was not found in the room! id: " + _loc6_);
         return undefined;
      }
      _loc2_.startInteraction();
      this._shell.updateListeners(this._shell.PUFFLE_INTERACTION,{id:_loc6_,interactionType:this._shell.INTERACTIVE_PLAY,x:_loc5_,y:_loc4_});
   }
   function handleSendPuffleInitRestInteraction(event)
   {
      var _loc10_ = Number(event[0]);
      var _loc6_ = Number(event[1]);
      var _loc5_ = Number(event[2]);
      var _loc4_ = Number(event[3]);
      var _loc2_ = this.getRoomPuffleById(_loc6_);
      if(_loc2_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleInitRestInteraction() -> Puffle was not found in the room! id: " + _loc6_);
         return undefined;
      }
      _loc2_.startInteraction();
      this._shell.updateListeners(this._shell.PUFFLE_INTERACTION,{id:_loc6_,interactionType:this._shell.INTERACTIVE_REST,x:_loc5_,y:_loc4_});
   }
   function handleSendPlayInteraction(event)
   {
      var _loc14_ = event[0];
      var _loc2_ = event[1].split("|");
      var _loc10_ = Number(_loc2_[0]);
      var _loc6_ = Number(event[2]);
      var _loc5_ = Number(event[3]);
      var _loc3_ = this.getRoomPuffleById(_loc10_);
      if(_loc3_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _loc10_);
         return undefined;
      }
      var _loc7_ = Number(_loc2_[3]);
      var _loc9_ = Number(_loc2_[4]);
      var _loc8_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc10_,_loc7_,_loc9_,_loc8_);
      _loc3_.startInteraction();
      this._shell.updateListeners(this._shell.PUFFLE_INTERACTION,{id:_loc10_,interactionType:this._shell.INTERACTIVE_PLAY,x:_loc6_,y:_loc5_});
   }
   function handleSendRestInteraction(event)
   {
      var _loc14_ = event[0];
      var _loc2_ = event[1].split("|");
      var _loc10_ = Number(_loc2_[0]);
      var _loc6_ = Number(event[2]);
      var _loc5_ = Number(event[3]);
      var _loc3_ = this.getRoomPuffleById(_loc10_);
      if(_loc3_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _loc10_);
         return undefined;
      }
      var _loc7_ = Number(_loc2_[3]);
      var _loc9_ = Number(_loc2_[4]);
      var _loc8_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc10_,_loc7_,_loc9_,_loc8_);
      _loc3_.startInteraction();
      this._shell.updateListeners(this._shell.PUFFLE_INTERACTION,{id:_loc10_,interactionType:this._shell.INTERACTIVE_REST,x:_loc6_,y:_loc5_});
   }
   function handleSendFeedInteraction(event)
   {
      var _loc15_ = event[0];
      var _loc7_ = Number(event[1]);
      var _loc2_ = event[2].split("|");
      var _loc11_ = Number(_loc2_[0]);
      var _loc6_ = Number(event[3]);
      var _loc5_ = Number(event[4]);
      var _loc4_ = this.getRoomPuffleById(_loc11_);
      if(this._shell.isMyIgloo())
      {
         this._shell.setMyPlayerTotalCoins(_loc7_);
      }
      if(_loc4_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _loc11_);
         return undefined;
      }
      var _loc8_ = Number(_loc2_[3]);
      var _loc10_ = Number(_loc2_[4]);
      var _loc9_ = Number(_loc2_[5]);
      this._modelManager.updatePuffleStatsById(_loc11_,_loc8_,_loc10_,_loc9_);
      _loc4_.startInteraction();
      this._shell.updateListeners(this._shell.PUFFLE_INTERACTION,{id:_loc11_,interactionType:this._shell.INTERACTIVE_FEED,x:_loc6_,y:_loc5_});
   }
   function setPuffleInteractionCompleteById(id)
   {
      var _loc2_ = this.getRoomPuffleById(id);
      if(_loc2_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.setPuffleInteractionCompleteById() -> Puffle was not found in the room! id: " + id);
         return undefined;
      }
      _loc2_.stopInteraction();
   }
   function disablePuffleInteractionByID(id)
   {
      var _loc2_ = this.getRoomPuffleById(id);
      if(_loc2_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.disablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
         return undefined;
      }
      _loc2_.__set__interactionEnabled(false);
   }
   function enablePuffleInteractionByID(id)
   {
      var _loc2_ = this.getRoomPuffleById(id);
      if(_loc2_ == undefined)
      {
         this._shell.$e("[SHELL] PuffleManager.enablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
         return undefined;
      }
      _loc2_.__set__interactionEnabled(true);
   }
   function makeMyPuffleFromCrumb(arr)
   {
      var _loc5_ = Number(arr[0]);
      var _loc4_ = String(arr[1]);
      var _loc3_ = Number(arr[2]);
      var _loc12_ = Number(arr[3]);
      var _loc14_ = Number(arr[4]);
      var _loc13_ = Number(arr[5]);
      var _loc7_ = Number(this._puffleStatsForType[_loc3_].max_health);
      var _loc6_ = Number(this._puffleStatsForType[_loc3_].max_hunger);
      var _loc8_ = Number(this._puffleStatsForType[_loc3_].max_rest);
      var _loc9_ = [_loc5_,_loc4_,_loc3_,_loc12_,_loc14_,_loc13_,_loc7_,_loc6_,_loc8_];
      var _loc11_ = this._modelManager.makeMyPuffleModelFromArray(_loc9_);
      var _loc10_ = new com.clubpenguin.shell.MyPuffle(_loc11_);
      return _loc10_;
   }
   function makeRoomPuffleFromCrumb(arr)
   {
      var _loc5_ = Number(arr[0]);
      var _loc4_ = Number(arr[2]);
      var _loc14_ = Number(arr[3]);
      var _loc17_ = Number(arr[4]);
      var _loc15_ = Number(arr[5]);
      var _loc8_ = Number(arr[6]);
      var _loc6_ = Number(arr[7]);
      var _loc9_ = Number(arr[8]);
      var _loc10_ = Number(arr[10]);
      var _loc7_ = Number(arr[11]);
      var _loc12_ = Boolean(Number(arr[12]));
      _loc8_ = Number(this._puffleStatsForType[_loc4_].max_health);
      _loc6_ = Number(this._puffleStatsForType[_loc4_].max_hunger);
      _loc9_ = Number(this._puffleStatsForType[_loc4_].max_rest);
      var _loc11_ = [_loc5_,_loc4_,_loc14_,_loc17_,_loc15_,_loc8_,_loc6_,_loc9_,_loc10_,_loc7_,_loc12_];
      var _loc13_ = this._modelManager.makeRoomPuffleModelFromArray(_loc11_);
      var _loc2_ = new com.clubpenguin.shell.RoomPuffle(_loc13_);
      var _loc16_ = this._modelManager.isMyPuffleById(_loc5_);
      if(_loc16_)
      {
         _loc2_.__set__isMine(true);
      }
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE,this.handlePuffleRequestMove,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME,this.handlePuffleRequestFrame,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY,this.handlePuffleRequestPlay,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED,this.handlePuffleRequestFeed,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_BATH,this.handlePuffleRequestBath,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_REST,this.handlePuffleRequestRest,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK,this.handlePuffleRequestStartWalk,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK,this.handlePuffleRequestStopWalk,this);
      _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION,this.handlePuffleRequestInteraction,this);
      return _loc2_;
   }
   function getRoomPuffleById(id)
   {
      var _loc3_ = this._roomPuffles.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._roomPuffles[_loc2_].id == id)
         {
            return this._roomPuffles[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      this._shell.$e("[SHELL] PuffleManager.getRoomPuffleById() -> Could not find puffle in room! - id: " + id);
      return undefined;
   }
   function getIndexInRoomById(id)
   {
      var _loc3_ = this._roomPuffles.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._roomPuffles[_loc2_].id == id)
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
   function cleanUpRoomPuffles()
   {
      this._modelManager.clearRoomPuffleModelArray();
      if(this._roomPuffles == undefined)
      {
         return undefined;
      }
      var _loc2_ = 0;
      var _loc3_ = this._roomPuffles.length;
      while(_loc2_ < _loc3_)
      {
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE,this.handlePuffleRequestMove,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME,this.handlePuffleRequestFrame,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY,this.handlePuffleRequestPlay,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED,this.handlePuffleRequestFeed,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_BATH,this.handlePuffleRequestBath,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_REST,this.handlePuffleRequestRest,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK,this.handlePuffleRequestStartWalk,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK,this.handlePuffleRequestStopWalk,this);
         this._roomPuffles[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION,this.handlePuffleRequestInteraction,this);
         this._roomPuffles[_loc2_].cleanUp();
         _loc2_ = _loc2_ + 1;
      }
      this._roomPuffles = undefined;
   }
   function __get__myPuffleCount()
   {
      if(this._myPuffles == undefined)
      {
         return 0;
      }
      return this._myPuffles.length;
   }
}
