class com.gskinner.utils.SWFBridgeAS2
{
   var _connected = false;
   function SWFBridgeAS2(p_id, p_clientObj)
   {
      mx.events.EventDispatcher.initialize(this);
      this.baseID = p_id.split(":").join("");
      this.lc = new LocalConnection();
      var _this = this;
      this.lc.com_gskinner_utils_SWFBridge_init = function()
      {
         _this.com_gskinner_utils_SWFBridge_init();
      };
      this.lc.com_gskinner_utils_SWFBridge_receive = function()
      {
         _this.com_gskinner_utils_SWFBridge_receive.apply(_this,arguments);
      };
      this.clientObj = p_clientObj;
      this.host = this.lc.connect(this.baseID + "_host");
      this.myID = this.baseID + (!this.host?"_guest":"_host");
      this.extID = this.baseID + (!this.host?"_host":"_guest");
      if(!this.host)
      {
         this.lc.connect(this.myID);
         this.lc.send(this.extID,"com_gskinner_utils_SWFBridge_init");
      }
   }
   function close()
   {
      this.lc.close();
      delete this.clientObj;
      delete this.lc;
      this._connected = false;
   }
   function send()
   {
      if(!this._connected)
      {
         return undefined;
      }
      var _loc3_ = arguments.slice(0);
      _loc3_.unshift("com_gskinner_utils_SWFBridge_receive");
      _loc3_.unshift(this.extID);
      this.lc.send.apply(this.lc,_loc3_);
   }
   function __get__id()
   {
      return this.baseID;
   }
   function __get__connected()
   {
      return this._connected;
   }
   function com_gskinner_utils_SWFBridge_receive()
   {
      var _loc3_ = arguments.slice(0);
      var _loc4_ = String(_loc3_.shift());
      this.clientObj[_loc4_].apply(this.clientObj,_loc3_);
   }
   function com_gskinner_utils_SWFBridge_init()
   {
      if(this.host)
      {
         this.lc.send(this.extID,"com_gskinner_utils_SWFBridge_init");
      }
      this._connected = true;
      this.dispatchEvent({type:"connect"});
   }
}
