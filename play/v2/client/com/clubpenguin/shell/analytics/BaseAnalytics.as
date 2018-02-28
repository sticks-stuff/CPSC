class com.clubpenguin.shell.analytics.BaseAnalytics implements com.clubpenguin.shell.analytics.IAnalytics
{
   static var ROOM_JOIN_PREFIX = "room_";
   static var IGLOO_JOIN_PREFIX = "igloo";
   function BaseAnalytics(shell, context)
   {
      this._shell = shell;
      this._context = context;
   }
   function trackEvent(eventName, data)
   {
      if(this.isBlocked(eventName))
      {
         return false;
      }
      return this.logItem(eventName,data);
   }
   function trackContent(itemName, data)
   {
      if(this.isBlocked(itemName))
      {
         return false;
      }
      return this.logItem(itemName,data);
   }
   function trackMiniGame(gameName, data)
   {
      if(this.isBlocked(gameName))
      {
         return false;
      }
      return this.logItem(gameName,data);
   }
   function trackRoomJoin(roomName, data)
   {
      if(this.isBlocked(com.clubpenguin.shell.analytics.BaseAnalytics.ROOM_JOIN_PREFIX + roomName))
      {
         return false;
      }
      return this.logItem(com.clubpenguin.shell.analytics.BaseAnalytics.ROOM_JOIN_PREFIX + roomName,data);
   }
   function trackIglooJoin(data)
   {
      if(this.isBlocked(com.clubpenguin.shell.analytics.BaseAnalytics.IGLOO_JOIN_PREFIX))
      {
         return false;
      }
      return this.logItem(com.clubpenguin.shell.analytics.BaseAnalytics.IGLOO_JOIN_PREFIX,data);
   }
   function getContext()
   {
      return this._context;
   }
   function setContext(context)
   {
      this._context = context;
   }
   function containsSuffix(itemName, suffix)
   {
      var _loc1_ = itemName.lastIndexOf(suffix);
      if(_loc1_ == -1)
      {
         return false;
      }
      var _loc2_ = suffix.length;
      if(_loc1_ + _loc2_ == itemName.length)
      {
         return true;
      }
      return false;
   }
   function containsPrefix(itemName, prefix)
   {
      if(itemName.indexOf(prefix) == 0)
      {
         return true;
      }
      return false;
   }
   function containsSubString(itemName, subString)
   {
      return itemName.indexOf(subString) != -1;
   }
   function isItemOverriden(itemName, override)
   {
      return this.containsPrefix(itemName,override);
   }
   function isBlocked(itemName)
   {
      if(!this.getContext().__get__isEnabled())
      {
         return true;
      }
      var _loc3_ = this._context.__get__blockedOverrides().length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this.isItemOverriden(itemName,this.getContext().__get__blockedOverrides()[_loc2_]))
         {
            return false;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(this.getContext().__get__isBlockingAll())
      {
         return true;
      }
      _loc3_ = this.getContext().__get__blockedPrefixes().length;
      _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this.containsPrefix(itemName,this.getContext().__get__blockedPrefixes()[_loc2_]))
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc3_ = this.getContext().__get__blockedSuffixes().length;
      _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this.containsSuffix(itemName,this.getContext().__get__blockedSuffixes()[_loc2_]))
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function logItem(itemName, data)
   {
      throw new Error("BaseAnalytics: Inheriting classes must implement logItem(itemName:String, data:Array):Boolean");
   }
   function toString()
   {
      return "[BaseAnalytics]";
   }
}
