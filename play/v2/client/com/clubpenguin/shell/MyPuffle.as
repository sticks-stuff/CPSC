class com.clubpenguin.shell.MyPuffle extends com.clubpenguin.shell.AbstractPuffle
{
   static var STATS_FREQUENCY = 216000;
   function MyPuffle(model)
   {
      super(model);
   }
   function startStats()
   {
      this._stats_interval = setInterval(this,"decreaseStats",com.clubpenguin.shell.MyPuffle.STATS_FREQUENCY);
   }
   function stopStats()
   {
      clearInterval(this._stats_interval);
      this._stats_interval = null;
   }
   function decreaseStats()
   {
      this._model.health = this._model.health - this._model.__get__maxHealth() * 0.01;
      this._model.hunger = this._model.hunger - this._model.__get__maxHunger() * 0.01;
      this._model.rest = this._model.rest - this._model.__get__maxRest() * 0.01;
   }
   function cleanUp()
   {
      super.cleanUp();
      this.stopStats();
      this._model = null;
   }
}
