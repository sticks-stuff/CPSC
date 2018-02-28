class com.clubpenguin.util.JSONLoader extends com.clubpenguin.util.EventDispatcher
{
   var raw = "";
   var data = null;
   static var COMPLETE = "complete";
   static var FAIL = "fail";
   static var CLASS_NAME = "com.clubpenguin.util.JSONLoader";
   function JSONLoader()
   {
      super();
   }
   function load(url)
   {
      this.raw = "";
      this.data = null;
      this.loadVars = new LoadVars();
      this.loadVars.onData = com.clubpenguin.util.Delegate.create(this,this.onData);
      this.loadVars.load(url);
   }
   function onData(jsonText)
   {
      try
      {
         this.raw = jsonText;
         this.data = cinqetdemi.JSON.parse(jsonText);
         this.updateListeners(com.clubpenguin.util.JSONLoader.COMPLETE);
      }
      catch(register0)
      {
         §§push((Error)_loc0_);
         if((Error)_loc0_ != null)
         {
            var e = §§pop();
            this.updateListeners(com.clubpenguin.util.JSONLoader.FAIL);
         }
         §§pop();
         throw _loc0_;
      }
   }
   function toString()
   {
      return "[JSONLoader]";
   }
}
