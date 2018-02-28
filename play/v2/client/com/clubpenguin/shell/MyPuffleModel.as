class com.clubpenguin.shell.MyPuffleModel extends com.clubpenguin.shell.AbstractPuffleModel
{
   function MyPuffleModel()
   {
      super();
   }
   function __get__name()
   {
      return this._name;
   }
   function __set__name(name)
   {
      this._name = name;
      return this.__get__name();
   }
   function cleanUp()
   {
      super.cleanUp();
      this._name = null;
   }
}
