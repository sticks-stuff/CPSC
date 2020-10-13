class com.clubpenguin.shell.analytics.WebLoggerAnalytics extends com.clubpenguin.shell.analytics.BaseAnalytics
{
   var LOGGER_URL = "http://logger.clubpenguin.com/log_event";
   function WebLoggerAnalytics(shell)
   {
      super(shell,new com.clubpenguin.shell.analytics.WebLoggerContext());
      this._webLoggerContext = (com.clubpenguin.shell.analytics.WebLoggerContext)this._context;
   }
   function getContext()
   {
      return this._webLoggerContext;
   }
   function setContext(context)
   {
      super.setContext(context);
      this._webLoggerContext = (com.clubpenguin.shell.analytics.WebLoggerContext)context;
   }
   function logItem(itemName, data)
   {
      if(!this._shell.isValidString(itemName))
      {
         return false;
      }
      var _loc3_ = this.getItemCategory(itemName);
      if(_loc3_ == undefined || _loc3_.length == 0)
      {
         return false;
      }
      var _loc4_ = this._shell.getMyPlayerObject().player_id;
      var _loc5_ = _loc4_ != undefined?String(_loc4_):"0";
      var _loc2_ = new LoadVars();
      _loc2_.land = "1";
      _loc2_.user = _loc5_;
      _loc2_.event = _loc3_;
      _loc2_.data = itemName + "|" + this._shell.getLanguageAbbriviation() + this.parseCustomDataToString(data);
      _loc2_.debug = 0;
      _loc2_.onLoad = function(success)
      {
      };
      if(this._shell.getEnvironment() != this._shell.ENV_LOCAL)
      {
         _loc2_.sendAndLoad(this.LOGGER_URL,_loc2_,"POST");
         return true;
      }
      return false;
   }
   function getItemCategory(itemName)
   {
      if(this.containsPrefix(itemName,"oops"))
      {
         itemName = "oops";
      }
      return this._webLoggerContext.__get__categoryIndexMap()[this._webLoggerContext.__get__categoryMap()[itemName]];
   }
   function parseCustomDataToString(customData)
   {
      var _loc3_ = "";
      if(customData == null || customData.length == 0)
      {
         return _loc3_;
      }
      var _loc1_ = 0;
      while(_loc1_ < customData.length)
      {
         _loc3_ = _loc3_ + ("|" + String(customData[_loc1_]));
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   function toString()
   {
      return "[WebLoggerAnalytics]";
   }
}
