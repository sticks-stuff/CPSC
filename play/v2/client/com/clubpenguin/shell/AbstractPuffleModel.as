class com.clubpenguin.shell.AbstractPuffleModel
{
   function AbstractPuffleModel()
   {
      com.clubpenguin.util.EventDispatcher.initialize(this);
   }
   function __get__happy()
   {
      var _loc2_ = this.__get__health() + this.__get__hunger() + this.__get__rest();
      var _loc3_ = this.__get__maxHealth() + this.__get__maxHunger() + this.__get__maxRest();
      return Math.round(_loc2_ / _loc3_ * 100);
   }
   function __get__id()
   {
      return this._id;
   }
   function __set__id(id)
   {
      this._id = id;
      return this.__get__id();
   }
   function __get__typeID()
   {
      return this._typeID;
   }
   function __set__typeID(id)
   {
      this._typeID = id;
      return this.__get__typeID();
   }
   function __get__health()
   {
      return this._health;
   }
   function __set__health(health)
   {
      if(health < 0)
      {
         health = 0;
      }
      this._health = health;
      return this.__get__health();
   }
   function __get__hunger()
   {
      return this._hunger;
   }
   function __set__hunger(hunger)
   {
      if(hunger < 0)
      {
         hunger = 0;
      }
      this._hunger = hunger;
      return this.__get__hunger();
   }
   function __get__rest()
   {
      return this._rest;
   }
   function __set__rest(rest)
   {
      if(rest < 0)
      {
         rest = 0;
      }
      this._rest = rest;
      return this.__get__rest();
   }
   function __get__maxHealth()
   {
      return this._maxHealth;
   }
   function __set__maxHealth(maxHealth)
   {
      this._maxHealth = maxHealth;
      return this.__get__maxHealth();
   }
   function __get__maxHunger()
   {
      return this._maxHunger;
   }
   function __set__maxHunger(maxHunger)
   {
      this._maxHunger = maxHunger;
      return this.__get__maxHunger();
   }
   function __get__maxRest()
   {
      return this._maxRest;
   }
   function __set__maxRest(maxRest)
   {
      this._maxRest = maxRest;
      return this.__get__maxRest();
   }
   function cleanUp()
   {
      this._id = null;
      this._typeID = null;
      this._health = null;
      this._hunger = null;
      this._rest = null;
      this._maxHealth = null;
      this._maxHunger = null;
      this._maxRest = null;
   }
}
