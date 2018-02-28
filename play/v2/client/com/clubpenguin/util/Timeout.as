class com.clubpenguin.util.Timeout
{
   var _id = -1;
   var _time = -1;
   var _func = undefined;
   var _params = undefined;
   var _scope = undefined;
   var _onStop = undefined;
   function Timeout(time, func, params, scope)
   {
      this._time = time * com.clubpenguin.util.Time.ONE_SECOND_IN_MILLISECONDS;
      this._func = func;
      this._params = params;
      this._scope = scope;
   }
   function start()
   {
      this._id = _global.setTimeout(com.clubpenguin.util.Delegate.create(this,this.handler),this._time,this._params);
   }
   function stop()
   {
      _global.clearTimeout(this._id);
      this._onStop(this);
      this.cleanUp();
   }
   function handler(params)
   {
      if(this._scope == undefined)
      {
         this._func(params);
      }
      else
      {
         this._func.call(this._scope,params);
      }
      this.stop();
   }
   function cleanUp()
   {
      this._id = -1;
      this._time = -1;
      this._func = undefined;
      this._params = undefined;
      this._scope = undefined;
      this._onStop = undefined;
   }
   function __set__onStop(func)
   {
      this._onStop = func;
      return this.__get__onStop();
   }
   function toString()
   {
      var _loc2_ = "";
      _loc2_ = _loc2_ + "Timeout -> ";
      _loc2_ = _loc2_ + (" id: " + this._id);
      _loc2_ = _loc2_ + (" time: " + this._time);
      _loc2_ = _loc2_ + (" func: " + this._func);
      _loc2_ = _loc2_ + (" params: " + this._params);
      _loc2_ = _loc2_ + (" scope: " + this._scope);
      _loc2_ = _loc2_ + (" onStop: " + this._onStop);
      return _loc2_;
   }
}
