class com.clubpenguin.util.Tools
{
   function Tools()
   {
   }
   static function applyClassToInstance(theClass, theInstance, constructorArgs)
   {
      theInstance.__proto__ = theClass.prototype;
      theInstance.__constructor__ = theClass;
      theClass.apply(theInstance,constructorArgs);
   }
   static function disableAutoTabbing()
   {
      MovieClip.prototype.tabEnabled = false;
      Button.prototype.tabEnabled = false;
      TextField.prototype.tabEnabled = false;
      Selection.setFocus(null);
   }
   static function enableAutoTabbing()
   {
      delete MovieClip.prototype.tabEnabled;
      delete Button.prototype.tabEnabled;
      delete TextField.prototype.tabEnabled;
   }
   static function capitalize(str)
   {
      return str.substr(0,1).toUpperCase() + str.substr(1,str.length);
   }
}
