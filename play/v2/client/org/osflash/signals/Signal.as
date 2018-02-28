class org.osflash.signals.Signal implements org.osflash.signals.IDispatcher, org.osflash.signals.ISignal
{
   var listenersNeedCloning = false;
   function Signal()
   {
      this.listenerBoxes = [];
      this.setValueClasses(arguments);
   }
   function getNumListeners()
   {
      return this.listenerBoxes.length;
   }
   function getValueClasses()
   {
      return this._valueClasses;
   }
   function add(listener, scope)
   {
      this.registerListener(listener,scope,false);
   }
   function addOnce(listener, scope)
   {
      this.registerListener(listener,scope,true);
   }
   function remove(listener, scope)
   {
      if(this.listenersNeedCloning)
      {
         this.listenerBoxes = this.listenerBoxes.slice();
         this.listenersNeedCloning = false;
      }
      var _loc2_ = this.listenerBoxes.length;
      while(true)
      {
         _loc2_;
         if(_loc2_--)
         {
            if(this.listenerBoxes[_loc2_].listener == listener && this.listenerBoxes[_loc2_].scope == scope)
            {
               this.listenerBoxes.splice(_loc2_,1);
               return undefined;
            }
            continue;
         }
         break;
      }
   }
   function removeAll()
   {
      var _loc2_ = this.listenerBoxes.length;
      while(true)
      {
         _loc2_;
         if(_loc2_--)
         {
            this.remove(this.listenerBoxes[_loc2_].listener,this.listenerBoxes[_loc2_].scope);
            continue;
         }
         break;
      }
   }
   function dispatch()
   {
      var _loc6_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < this._valueClasses.length)
      {
         if(!this.primitiveMatchesValueClass(arguments[_loc3_],this._valueClasses[_loc3_]))
         {
            if(!((_loc6_ = arguments[_loc3_]) == null || _loc6_ instanceof this._valueClasses[_loc3_]))
            {
               throw new Error("Value object <" + _loc6_ + "> is not an instance of <" + this._valueClasses[_loc3_] + ">.");
            }
         }
         _loc3_ = _loc3_ + 1;
      }
      var _loc7_ = this.listenerBoxes;
      var _loc8_ = _loc7_.length;
      var _loc4_ = undefined;
      var _loc9_ = undefined;
      this.listenersNeedCloning = true;
      var _loc5_ = 0;
      while(_loc5_ < _loc8_)
      {
         _loc4_ = _loc7_[_loc5_];
         if(_loc4_.once)
         {
            this.remove(_loc4_.listener,_loc4_.scope);
         }
         _loc4_.listener.apply(_loc4_.scope,arguments);
         _loc5_ = _loc5_ + 1;
      }
      this.listenersNeedCloning = false;
   }
   function primitiveMatchesValueClass(primitive, valueClass)
   {
      if(typeof primitive == "string" && valueClass == String || typeof primitive == "number" && valueClass == Number || typeof primitive == "boolean" && valueClass == Boolean)
      {
         return true;
      }
      return false;
   }
   function setValueClasses(valueClasses)
   {
      this._valueClasses = valueClasses || [];
      var _loc2_ = this._valueClasses.length;
      while(true)
      {
         _loc2_;
         if(_loc2_--)
         {
            if(!(this._valueClasses[_loc2_] instanceof Function))
            {
               throw new Error("Invalid valueClasses argument: item at index " + _loc2_ + " should be a Class but was:<" + this._valueClasses[_loc2_] + ">.");
            }
            else
            {
               continue;
            }
         }
         else
         {
            break;
         }
      }
   }
   function registerListener(listener, scope, once)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.listenerBoxes.length)
      {
         if(this.listenerBoxes[_loc2_].listener == listener && this.listenerBoxes[_loc2_].scope == scope)
         {
            if(this.listenerBoxes[_loc2_].once && !once)
            {
               throw new Error("You cannot addOnce() then try to add() the same listener without removing the relationship first.");
            }
            else if(once && !this.listenerBoxes[_loc2_].once)
            {
               throw new Error("You cannot add() then addOnce() the same listener without removing the relationship first.");
            }
            else
            {
               return undefined;
            }
         }
         else
         {
            _loc2_ = _loc2_ + 1;
            continue;
         }
      }
      if(this.listenersNeedCloning)
      {
         this.listenerBoxes = this.listenerBoxes.slice();
      }
      this.listenerBoxes.push({listener:listener,scope:scope,once:once});
   }
}
