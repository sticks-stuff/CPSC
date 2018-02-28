class com.clubpenguin.shell.RoomPuffleModel extends com.clubpenguin.shell.AbstractPuffleModel
{
   static var WALK = "walk";
   static var MOVE = "move";
   static var FRAME = "frame";
   function RoomPuffleModel()
   {
      super();
      this._x = 0;
      this._y = 0;
      this._notifyHunger = true;
      this._notifyHealth = true;
      this._notifyRest = true;
      this._isWalking = false;
      this._isInteracting = false;
   }
   function setPosition(xpos, ypos)
   {
      this.__set__x(xpos);
      this.__set__y(ypos);
      this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.MOVE,this);
   }
   function __set__isWalking(isWalking)
   {
      this._isWalking = isWalking;
      this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.WALK,this);
      return this.__get__isWalking();
   }
   function __get__isWalking()
   {
      return this._isWalking;
   }
   function __get__x()
   {
      return this._x;
   }
   function __set__x(x)
   {
      this._x = x;
      return this.__get__x();
   }
   function __get__y()
   {
      return this._y;
   }
   function __set__y(y)
   {
      this._y = y;
      return this.__get__y();
   }
   function __get__isInteracting()
   {
      return this._isInteracting;
   }
   function __set__isInteracting(bool)
   {
      this._isInteracting = bool;
      return this.__get__isInteracting();
   }
   function __set__frame(frame)
   {
      this._frame = frame;
      this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.FRAME,this);
      return this.__get__frame();
   }
   function __get__frame()
   {
      return this._frame;
   }
   function __get__notifyHunger()
   {
      return this._notifyHunger;
   }
   function __set__notifyHunger(bool)
   {
      this._notifyHunger = bool;
      return this.__get__notifyHunger();
   }
   function __get__notifyHealth()
   {
      return this._notifyHealth;
   }
   function __set__notifyHealth(bool)
   {
      this._notifyHealth = bool;
      return this.__get__notifyHealth();
   }
   function __get__notifyRest()
   {
      return this._notifyRest;
   }
   function __set__notifyRest(bool)
   {
      this._notifyRest = bool;
      return this.__get__notifyRest();
   }
   function __get__lastAction()
   {
      return this._lastAction;
   }
   function __set__lastAction(action)
   {
      this._lastAction = action;
      return this.__get__lastAction();
   }
   function cleanUp()
   {
      super.cleanUp();
      this._x = null;
      this._y = null;
      this._isWalking = null;
      this._lastAction = null;
      this._notifyHunger = null;
      this._notifyHealth = null;
      this._notifyRest = null;
      this._frame = null;
   }
}
