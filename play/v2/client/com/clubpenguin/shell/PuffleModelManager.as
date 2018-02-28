class com.clubpenguin.shell.PuffleModelManager
{
   function PuffleModelManager(shell)
   {
      this._shell = shell;
      this._roomModels = [];
      this._myModels = [];
   }
   function makeMyPuffleModelFromArray(arr)
   {
      var _loc4_ = Number(arr[0]);
      var _loc2_ = this.getMyPuffleById(_loc4_);
      if(_loc2_ == undefined)
      {
         _loc2_ = new com.clubpenguin.shell.MyPuffleModel();
         this._myModels.push(_loc2_);
      }
      _loc2_.__set__id(_loc4_);
      _loc2_.__set__name(arr[1]);
      _loc2_.__set__typeID(arr[2]);
      _loc2_.__set__health(arr[3]);
      _loc2_.__set__hunger(arr[4]);
      _loc2_.__set__rest(arr[5]);
      _loc2_.__set__maxHealth(arr[6]);
      _loc2_.__set__maxHunger(arr[7]);
      _loc2_.__set__maxRest(arr[8]);
      return _loc2_;
   }
   function makeRoomPuffleModelFromArray(arr)
   {
      var _loc4_ = arr[0];
      var _loc2_ = this.getRoomPuffleById(_loc4_);
      if(_loc2_ == undefined)
      {
         _loc2_ = new com.clubpenguin.shell.RoomPuffleModel();
         _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK,this.handlePuffleWalk,this);
         _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME,this.handlePuffleFrame,this);
         _loc2_.addEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE,this.handlePuffleMove,this);
         this._roomModels.push(_loc2_);
      }
      _loc2_.__set__id(_loc4_);
      _loc2_.__set__typeID(arr[1]);
      _loc2_.__set__health(arr[2]);
      _loc2_.__set__hunger(arr[3]);
      _loc2_.__set__rest(arr[4]);
      _loc2_.__set__maxHealth(arr[5]);
      _loc2_.__set__maxHunger(arr[6]);
      _loc2_.__set__maxRest(arr[7]);
      _loc2_.__set__x(arr[8]);
      _loc2_.__set__y(arr[9]);
      _loc2_.__set__isWalking(arr[10]);
      return _loc2_;
   }
   function handlePuffleWalk(puffle)
   {
      var _loc3_ = puffle.__get__id();
      var _loc4_ = puffle.__get__isWalking();
      this._shell.updateListeners(this._shell.PUFFLE_WALK,{id:_loc3_,isWalking:_loc4_});
   }
   function handlePuffleFrame(puffle)
   {
      var _loc3_ = puffle.__get__id();
      var _loc4_ = puffle.__get__frame();
      this._shell.updateListeners(this._shell.PUFFLE_FRAME,{id:_loc3_,frame:_loc4_});
   }
   function handlePuffleMove(puffle)
   {
      var _loc5_ = puffle.__get__id();
      var _loc4_ = puffle.__get__x();
      var _loc3_ = puffle.__get__y();
      var _loc6_ = puffle.__get__happy();
      this._shell.updateListeners(this._shell.PUFFLE_MOVE,{id:_loc5_,x:_loc4_,y:_loc3_,happy:_loc6_});
   }
   function updatePuffleStatsById(id, health, hunger, rest)
   {
      var _loc2_ = this.getRoomPuffleById(id);
      if(_loc2_ == undefined)
      {
         return undefined;
      }
      _loc2_.__set__health(health);
      _loc2_.__set__hunger(hunger);
      _loc2_.__set__rest(rest);
      _loc2_ = this.getMyPuffleById(id);
      if(_loc2_ == undefined)
      {
         return undefined;
      }
      _loc2_.__set__health(health);
      _loc2_.__set__hunger(hunger);
      _loc2_.__set__rest(rest);
   }
   function getRoomPuffleById(id)
   {
      var _loc3_ = this._roomModels.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._roomModels[_loc2_].id == id)
         {
            return this._roomModels[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function getMyPuffleById(id)
   {
      var _loc3_ = this._myModels.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._myModels[_loc2_].id == id)
         {
            return this._myModels[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function isMyPuffleById(id)
   {
      var _loc3_ = this._myModels.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._myModels[_loc2_].id == id)
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function clearRoomPuffleModelArray()
   {
      var _loc3_ = this._roomModels.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this._roomModels[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK,this.handlePuffleWalk,this);
         this._roomModels[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME,this.handlePuffleFrame,this);
         this._roomModels[_loc2_].removeEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE,this.handlePuffleMove,this);
         this._roomModels[_loc2_].cleanUp();
         _loc2_ = _loc2_ + 1;
      }
      this._roomModels = [];
   }
   function __get__roomPuffles()
   {
      return this._roomModels.slice();
   }
   function __get__myPuffles()
   {
      return this._myModels.slice();
   }
   function toString()
   {
      return "PuffleModelManager. Shell reference: " + this._shell + ", room models: " + this._roomModels + ", my models: " + this._myModels;
   }
}
