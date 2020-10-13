class com.clubpenguin.shell.AbstractPuffle
{
   function AbstractPuffle(model)
   {
      com.clubpenguin.util.EventDispatcher.initialize(this);
      this._model = model;
   }
   function __get__id()
   {
      return this._model.__get__id();
   }
   function __get__typeID()
   {
      return this._model.__get__typeID();
   }
   function cleanUp()
   {
      this._model = null;
   }
}
