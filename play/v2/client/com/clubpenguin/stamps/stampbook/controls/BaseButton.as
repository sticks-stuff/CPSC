class com.clubpenguin.stamps.stampbook.controls.BaseButton extends MovieClip
{
   var _enabled = true;
   var _toggle = false;
   var _selected = false;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.BaseButton;
   static var LINKAGE_ID = "BaseButton";
   function BaseButton()
   {
      super();
      com.clubpenguin.util.EventDispatcher.initialize(this);
   }
   function onLoad()
   {
      this.configUI();
   }
   function __get__enabled()
   {
      return this._enabled;
   }
   function __set__enabled(value)
   {
      this._enabled = value;
      this.useHandCursor = value;
      this.gotoAndStop(!this._selected?"up":"selected_up");
      return this.__get__enabled();
   }
   function __get__toggle()
   {
      return this._toggle;
   }
   function __set__toggle(value)
   {
      this._toggle = value;
      return this.__get__toggle();
   }
   function __get__selected()
   {
      return this._selected;
   }
   function __set__selected(value)
   {
      this._selected = value;
      this.gotoAndStop(!this._selected?"up":"selected_up");
      return this.__get__selected();
   }
   function onPress()
   {
      if(!this._enabled)
      {
         return undefined;
      }
      this.gotoAndStop(!this._toggle?"down":!!this._selected?"selected_down":"down");
      this.dispatchEvent({type:"press"});
   }
   function onRelease()
   {
      if(!this._enabled)
      {
         return undefined;
      }
      this.gotoAndStop(!this._toggle?"over":!!this._selected?"selected_over":"over");
      this.dispatchEvent({type:"release"});
   }
   function onRollOver()
   {
      if(!this._enabled)
      {
         return undefined;
      }
      this.gotoAndStop(!this._toggle?"over":!!this._selected?"selected_over":"over");
      this.dispatchEvent({type:"over"});
   }
   function onRollOut()
   {
      if(!this._enabled)
      {
         return undefined;
      }
      this.gotoAndStop(!this._toggle?"up":!!this._selected?"selected_up":"up");
      this.dispatchEvent({type:"out"});
   }
   function configUI()
   {
   }
}
