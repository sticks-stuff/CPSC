class mx.events.EventDispatcher
{
   static var _fEventDispatcher = undefined;
   static var exceptions = {move:1,draw:1,load:1};
   function EventDispatcher()
   {
   }
   function dispatchQueue(queueObj, eventObj)
   {
      var _loc7_ = "__q_" + eventObj.type;
      var _loc4_ = queueObj[_loc7_];
      if(_loc4_ != undefined)
      {
         var _loc5_ = undefined;
         for(var _loc5_ in _loc4_)
         {
            var _loc1_ = _loc4_[_loc5_];
            var _loc3_ = typeof _loc1_;
            if(_loc3_ == "object" || _loc3_ == "movieclip")
            {
               if(_loc1_.handleEvent != undefined)
               {
                  _loc1_.handleEvent(eventObj);
               }
               if(_loc1_[eventObj.type] != undefined)
               {
                  if(mx.events.EventDispatcher.exceptions[eventObj.type] == undefined)
                  {
                     this[eventObj.type].call(this,eventObj);
                  }
               }
            }
            else
            {
               _loc1_.apply(queueObj,[eventObj]);
            }
         }
      }
   }
   function dispatchEvent(eventObj)
   {
      if(eventObj.target == undefined)
      {
         eventObj.target = this;
      }
      this[eventObj.type + "Handler"].call(this,eventObj);
      this.dispatchQueue(this,eventObj);
   }
   function addEventListener(event, handler)
   {
      var _loc3_ = "__q_" + event;
      if(this[_loc3_] == undefined)
      {
         this[_loc3_] = new Array();
      }
      _global.ASSetPropFlags(this,_loc3_,1);
      mx.events.EventDispatcher._removeEventListener(this[_loc3_],event,handler);
      this[_loc3_].push(handler);
   }
   function removeEventListener(event, handler)
   {
      var _loc2_ = "__q_" + event;
      mx.events.EventDispatcher._removeEventListener(this[_loc2_],event,handler);
   }
   static function _removeEventListener(queue, event, handler)
   {
      if(queue != undefined)
      {
         var _loc4_ = queue.length;
         var _loc1_ = undefined;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            var _loc2_ = queue[_loc1_];
            if(_loc2_ == handler)
            {
               queue.splice(_loc1_,1);
               return undefined;
            }
            _loc1_ = _loc1_ + 1;
         }
      }
   }
   static function initialize(object)
   {
      if(mx.events.EventDispatcher._fEventDispatcher == undefined)
      {
         mx.events.EventDispatcher._fEventDispatcher = new mx.events.EventDispatcher();
      }
      object.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
      object.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
      object.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
      object.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
   }
}
