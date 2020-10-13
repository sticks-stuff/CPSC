class com.clubpenguin.shell.RoomPuffle extends com.clubpenguin.shell.AbstractPuffle
{
   static var UPDATE_MODIFIER = 10;
   static var UPDATE_BASE = 10000;
   static var ONE_SECOND_IN_MILLISECONDS = 1000;
   static var MOVE_ACTION = "moveAction";
   static var PLAY_ACTION = "playAction";
   static var PUFFLE_HUNGER_FRAME = 32;
   static var PUFFLE_HEALTH_FRAME = 33;
   static var PUFFLE_REST_FRAME = 26;
   static var NORMAL_PLAY_TYPE = 0;
   static var SUPER_PLAY_TYPE = 1;
   static var GREAT_PLAY_TYPE = 2;
   static var SUPER_PLAY_FRAME = 28;
   static var GREAT_PLAY_FRAME = 35;
   static var NORMAL_PLAY_FRAME = 27;
   static var REST_FRAME = 25;
   static var BATH_FRAME = 34;
   static var FEED_FRAME = 31;
   static var TREAT_ANGRY = 0;
   static var TREAT_COOKIE = 1;
   static var TREAT_GUM = 2;
   static var ANGRY_TREAT_FRAME = 33;
   static var GUM_TREAT_FRAME = 29;
   static var COOKIE_TREAT_FRAME = 30;
   static var NOTIFY_STAT_LEVEL = 20;
   static var playInteractionEnabled = false;
   static var restInteractionEnabled = false;
   static var feedInteractionEnabled = false;
   static var PLAY_INTERACTION_CHANCE = 100;
   static var REST_INTERACTION_CHANCE = 100;
   static var FEED_INTERACTION_CHANCE = 100;
   static var RANDOM_INTERACTION_CHANCE = 100;
   static var INTERACTION_PLAY = "playInteraction";
   static var INTERACTION_REST = "restInteraction";
   static var INTERACTION_FEED = "feedInteraction";
   static var INTERACTION_MIN_REST_LEVEL = 70;
   static var INTERACTION_MIN_HAPPY_LEVEL = 70;
   static var INTERACTION_MIN_HUNGER_LEVEL = 70;
   static var SUPER_PLAY_HAPPY_LEVEL = 80;
   static var REQUEST_MOVE = "requestMove";
   static var REQUEST_FRAME = "requestFrame";
   static var REQUEST_START_WALK = "requestStartWalk";
   static var REQUEST_STOP_WALK = "requestStopWalk";
   static var REQUEST_PLAY = "requestPlay";
   static var REQUEST_FEED = "requestFeed";
   static var REQUEST_BATH = "requestBath";
   static var REQUEST_REST = "requestRest";
   static var REQUEST_INTERACTION = "requestInteraction";
   function RoomPuffle(model)
   {
      super(model);
      this._model.__set__lastAction(com.clubpenguin.shell.RoomPuffle.PLAY_ACTION);
      this._isMine = false;
      this._selfInteract = false;
      this._interactionEnabled = true;
   }
   function startBrain()
   {
      if(!this._isMine)
      {
         return undefined;
      }
      if(this.__get__isWalking())
      {
         return undefined;
      }
      if(this._updateInterval != null)
      {
         this.stopBrain();
      }
      var _loc2_ = 0;
      var _loc5_ = com.clubpenguin.shell.RoomPuffle.UPDATE_MODIFIER;
      var _loc3_ = Math.round(Math.random() * (_loc5_ - _loc2_)) + _loc2_;
      var _loc4_ = Math.round(_loc3_ * com.clubpenguin.shell.RoomPuffle.ONE_SECOND_IN_MILLISECONDS);
      this._updateInterval = setInterval(this,"handleBrain",_loc4_ + com.clubpenguin.shell.RoomPuffle.UPDATE_BASE);
   }
   function stopBrain()
   {
      clearInterval(this._updateInterval);
      this._updateInterval = null;
   }
   function handleBrain()
   {
      if(this._model.__get__lastAction() == com.clubpenguin.shell.RoomPuffle.MOVE_ACTION)
      {
         this._model.__set__lastAction(com.clubpenguin.shell.RoomPuffle.PLAY_ACTION);
         if(this._model.__get__hunger() < com.clubpenguin.shell.RoomPuffle.NOTIFY_STAT_LEVEL && this._model.__get__notifyHunger())
         {
            this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME,{id:this._model.__get__id(),frame:com.clubpenguin.shell.RoomPuffle.PUFFLE_HUNGER_FRAME});
            this._model.__set__notifyHunger(false);
            return undefined;
         }
         if(this._model.__get__health() < com.clubpenguin.shell.RoomPuffle.NOTIFY_STAT_LEVEL && this._model.__get__notifyHealth())
         {
            this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME,{id:this._model.__get__id(),frame:com.clubpenguin.shell.RoomPuffle.PUFFLE_HEALTH_FRAME});
            this._model.__set__notifyHealth(false);
            return undefined;
         }
         if(this._model.__get__rest() < com.clubpenguin.shell.RoomPuffle.NOTIFY_STAT_LEVEL && this._model.__get__notifyRest())
         {
            this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME,{id:this._model.__get__id(),frame:com.clubpenguin.shell.RoomPuffle.PUFFLE_REST_FRAME});
            this._model.__set__notifyRest(false);
            return undefined;
         }
         this._model.__set__notifyHunger(true);
         this._model.__set__notifyHealth(true);
         this._model.__set__notifyRest(true);
         this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE,this);
      }
      else
      {
         this._model.__set__lastAction(com.clubpenguin.shell.RoomPuffle.MOVE_ACTION);
         if(this._interactionEnabled)
         {
            if(com.clubpenguin.shell.RoomPuffle.playInteractionEnabled || com.clubpenguin.shell.RoomPuffle.restInteractionEnabled)
            {
               if(this._model.__get__rest() >= com.clubpenguin.shell.RoomPuffle.INTERACTION_MIN_REST_LEVEL && this._model.__get__happy() >= com.clubpenguin.shell.RoomPuffle.INTERACTION_MIN_HAPPY_LEVEL && this._model.__get__hunger() >= com.clubpenguin.shell.RoomPuffle.INTERACTION_MIN_HUNGER_LEVEL)
               {
                  var _loc4_ = com.clubpenguin.shell.RoomPuffle.getBooleanByPercentage(com.clubpenguin.shell.RoomPuffle.RANDOM_INTERACTION_CHANCE);
                  if(_loc4_)
                  {
                     var _loc2_ = [];
                     if(com.clubpenguin.shell.RoomPuffle.playInteractionEnabled)
                     {
                        _loc2_.push(com.clubpenguin.shell.RoomPuffle.INTERACTION_PLAY);
                     }
                     if(com.clubpenguin.shell.RoomPuffle.restInteractionEnabled)
                     {
                        _loc2_.push(com.clubpenguin.shell.RoomPuffle.INTERACTION_REST);
                     }
                     var _loc3_ = Math.round(Math.random() * (_loc2_.length - 1 - 0)) + 0;
                     var _loc7_ = _loc2_[_loc3_];
                     if(_loc7_ != undefined)
                     {
                        this._selfInteract = true;
                        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION,{id:this._model.__get__id(),interactionType:_loc7_});
                        return undefined;
                     }
                  }
               }
            }
         }
         this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE,this);
      }
      this.startBrain();
   }
   function cancelSelfInteraction()
   {
      this._selfInteract = false;
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE,this);
   }
   function treat(treatID)
   {
      if(treatID == undefined)
      {
         return undefined;
      }
      if(treatID == com.clubpenguin.shell.RoomPuffle.TREAT_ANGRY)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.ANGRY_TREAT_FRAME);
      }
      else if(treatID == com.clubpenguin.shell.RoomPuffle.TREAT_COOKIE)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.COOKIE_TREAT_FRAME);
      }
      else if(treatID == com.clubpenguin.shell.RoomPuffle.TREAT_GUM)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.GUM_TREAT_FRAME);
      }
   }
   function requestPlay()
   {
      if(this._model.__get__rest() < 20 || this._model.__get__happy() < 10)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.ANGRY_TREAT_FRAME);
         return undefined;
      }
      if(this._model.__get__happy() < com.clubpenguin.shell.RoomPuffle.SUPER_PLAY_HAPPY_LEVEL)
      {
         if(com.clubpenguin.shell.RoomPuffle.playInteractionEnabled)
         {
            var _loc2_ = com.clubpenguin.shell.RoomPuffle.getBooleanByPercentage(com.clubpenguin.shell.RoomPuffle.PLAY_INTERACTION_CHANCE);
            if(_loc2_)
            {
               this._selfInteract = false;
               this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION,{id:this._model.__get__id(),interactionType:com.clubpenguin.shell.RoomPuffle.INTERACTION_PLAY});
               return undefined;
            }
         }
      }
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY,this);
   }
   function forceNormalPlay()
   {
      if(this._model.__get__rest() < 20 || this._model.__get__happy() < 10)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.ANGRY_TREAT_FRAME);
         return undefined;
      }
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY,this);
   }
   function play(playID)
   {
      if(playID == undefined)
      {
         return undefined;
      }
      if(playID == com.clubpenguin.shell.RoomPuffle.SUPER_PLAY_TYPE)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.SUPER_PLAY_FRAME);
      }
      else if(playID == com.clubpenguin.shell.RoomPuffle.GREAT_PLAY_TYPE)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.GREAT_PLAY_FRAME);
      }
      else if(playID == com.clubpenguin.shell.RoomPuffle.NORMAL_PLAY_TYPE)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.NORMAL_PLAY_FRAME);
      }
   }
   function requestStartWalk()
   {
      if(this.__get__isWalking())
      {
         return undefined;
      }
      if(this._model.__get__rest() < 20 || this._model.__get__hunger() < 40)
      {
         this.__set__frame(com.clubpenguin.shell.RoomPuffle.ANGRY_TREAT_FRAME);
         return undefined;
      }
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK,this);
   }
   function requestStopWalk()
   {
      if(!this.__get__isWalking())
      {
         return undefined;
      }
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK,this);
   }
   function requestFeed()
   {
      if(com.clubpenguin.shell.RoomPuffle.feedInteractionEnabled)
      {
         var _loc2_ = com.clubpenguin.shell.RoomPuffle.getBooleanByPercentage(com.clubpenguin.shell.RoomPuffle.FEED_INTERACTION_CHANCE);
         if(_loc2_)
         {
            this._selfInteract = false;
            this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION,{id:this._model.__get__id(),interactionType:com.clubpenguin.shell.RoomPuffle.INTERACTION_FEED});
            return undefined;
         }
      }
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED,this);
   }
   function forceNormalFeed()
   {
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED,this);
   }
   function feed()
   {
      this.__set__frame(com.clubpenguin.shell.RoomPuffle.FEED_FRAME);
   }
   function requestBath()
   {
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_BATH,this);
   }
   function bath()
   {
      this.__set__frame(com.clubpenguin.shell.RoomPuffle.BATH_FRAME);
   }
   function requestRest()
   {
      if(com.clubpenguin.shell.RoomPuffle.restInteractionEnabled)
      {
         var _loc2_ = com.clubpenguin.shell.RoomPuffle.getBooleanByPercentage(com.clubpenguin.shell.RoomPuffle.REST_INTERACTION_CHANCE);
         if(_loc2_)
         {
            this._selfInteract = false;
            this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION,{id:this._model.__get__id(),interactionType:com.clubpenguin.shell.RoomPuffle.INTERACTION_REST});
            return undefined;
         }
      }
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_REST,this);
   }
   function forceNormalRest()
   {
      this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_REST,this);
   }
   function rest()
   {
      this.__set__frame(com.clubpenguin.shell.RoomPuffle.REST_FRAME);
   }
   function startInteraction()
   {
      this.stopBrain();
      this._model.__set__isInteracting(true);
   }
   function stopInteraction()
   {
      this.startBrain();
      this._model.__set__isInteracting(false);
   }
   function moveTo(xpos, ypos)
   {
      this.startBrain();
      this._model.setPosition(xpos,ypos);
   }
   function __get__frame()
   {
      return this._model.__get__frame();
   }
   function __set__frame(frame)
   {
      this.startBrain();
      this._model.__set__frame(frame);
      return this.__get__frame();
   }
   function __get__isWalking()
   {
      return this._model.__get__isWalking();
   }
   function __set__isWalking(isWalking)
   {
      this._model.__set__isWalking(isWalking);
      if(isWalking)
      {
         this.stopBrain();
         return undefined;
      }
      this.startBrain();
      return this.__get__isWalking();
   }
   function __set__isMine(bool)
   {
      this._isMine = bool;
      return this.__get__isMine();
   }
   function __get__selfInteract()
   {
      return this._selfInteract;
   }
   function __set__interactionEnabled(bool)
   {
      this._interactionEnabled = bool;
      return this.__get__interactionEnabled();
   }
   function cleanUp()
   {
      super.cleanUp();
      this.stopBrain();
      this._model = null;
   }
   static function setAllowFeedInteraction(bool)
   {
      com.clubpenguin.shell.RoomPuffle.feedInteractionEnabled = bool;
   }
   static function setAllowRestInteraction(bool)
   {
      com.clubpenguin.shell.RoomPuffle.restInteractionEnabled = bool;
   }
   static function setAllowPlayInteraction(bool)
   {
      com.clubpenguin.shell.RoomPuffle.playInteractionEnabled = bool;
   }
   static function getBooleanByPercentage(chance)
   {
      var _loc1_ = Math.round(Math.random() * 99) + 1;
      return chance >= _loc1_;
   }
}
