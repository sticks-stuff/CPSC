class com.clubpenguin.util.EventDispatcher implements com.clubpenguin.util.IEventDispatcher
{
   function EventDispatcher()
   {
   }
   function addEventListener(eventType, handler, scope)
   {
      if(eventType.length)
      {
      }
      if(handler instanceof Function)
      {
      }
      var _loc3_ = com.clubpenguin.util.EventDispatcher.getListenersArray(this,eventType);
      var _loc4_ = com.clubpenguin.util.EventDispatcher.getListenerIndex(_loc3_,handler,scope);
      if(_loc4_ == -1)
      {
         _loc3_.push({handler:handler,scope:scope});
         return true;
      }
      return false;
   }
   function removeEventListener(eventType, handler, scope)
   {
      if(eventType.length)
      {
      }
      if(handler instanceof Function)
      {
      }
      var _loc3_ = com.clubpenguin.util.EventDispatcher.getListenersArray(this,eventType);
      var _loc4_ = com.clubpenguin.util.EventDispatcher.getListenerIndex(_loc3_,handler,scope);
      if(_loc4_ != -1)
      {
         _loc3_.splice(_loc4_,1);
         return true;
      }
      return false;
   }
   function updateListeners(eventType, event)
   {
      if(event == undefined)
      {
         event = {};
      }
      event.type = eventType;
      return this.dispatchEvent(event);
   }
   function dispatchEvent(event)
   {
      if(event.type.length)
      {
      }
      if(event.target == undefined)
      {
         event.target = this;
      }
      var _loc3_ = com.clubpenguin.util.EventDispatcher.getListenersArray(this,event.type).concat();
      var _loc5_ = _loc3_.length;
      if(_loc5_ < 1)
      {
         return false;
      }
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         !_loc3_[_loc2_].scope?_loc3_[_loc2_].handler(event):_loc3_[_loc2_].handler.call(_loc3_[_loc2_].scope,event);
         _loc2_ = _loc2_ + 1;
      }
      return true;
   }
   static function getListenerIndex(listeners, handler, scope)
   {
      var _loc4_ = listeners.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc4_)
      {
         if(listeners[_loc1_].handler == handler && (scope == undefined || listeners[_loc1_].scope == scope))
         {
            return _loc1_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return -1;
   }
   static function getListenersArray(eventSource, eventType)
   {
      if(!eventSource.__listener_obj)
      {
         eventSource.__listener_obj = {};
      }
      if(!eventSource.__listener_obj[eventType])
      {
         eventSource.__listener_obj[eventType] = [];
      }
      return eventSource.__listener_obj[eventType];
   }
   static function initialize(eventSource)
   {
      eventSource.addEventListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
      eventSource.removeEventListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
      eventSource.addListener = com.clubpenguin.util.EventDispatcher.prototype.addEventListener;
      eventSource.removeListener = com.clubpenguin.util.EventDispatcher.prototype.removeEventListener;
      eventSource.dispatchEvent = com.clubpenguin.util.EventDispatcher.prototype.dispatchEvent;
      eventSource.updateListeners = com.clubpenguin.util.EventDispatcher.prototype.updateListeners;
   }
}
