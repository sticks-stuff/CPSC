class com.clubpenguin.stamps.stampbook.controls.IconTabButton extends com.clubpenguin.stamps.stampbook.controls.BaseButton
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.IconTabButton;
   static var LINKAGE_ID = "IconTabButton";
   static var ICON_ART_SCALE = 65;
   static var ICON_WIDTH = 21;
   static var ICON_HEIGHT = 21;
   static var _SCALE_OFFSET = 10;
   function IconTabButton()
   {
      super();
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
   }
   function configUI()
   {
      this._filePath = this._shell.getPath("stampbook_category");
      this.stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onLoadInit));
      this.stampIconLoadMc = this.stampIconHolder.createEmptyMovieClip("stampIconLoadMc",this.stampIconHolder.getNextHighestDepth());
      this._initialized = true;
      if(this._data != null)
      {
         this.populateUI();
      }
   }
   function __get__data()
   {
      return this._data;
   }
   function __set__data(value)
   {
      this._data = value;
      if(this._initialized)
      {
         this.populateUI();
      }
      return this.__get__data();
   }
   function onLoadInit(event)
   {
      var _loc2_ = event.target;
      _loc2_._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_ART_SCALE;
      _loc2_._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_ART_SCALE;
      com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT = this.stampIconLoadMc._xscale + com.clubpenguin.stamps.stampbook.controls.IconTabButton._SCALE_OFFSET + (this.stampIconLoadMc._yscale + com.clubpenguin.stamps.stampbook.controls.IconTabButton._SCALE_OFFSET) >> 1;
      com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OVER = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT + com.clubpenguin.stamps.stampbook.controls.IconTabButton._SCALE_OFFSET * 1.5;
      this.stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
      this.stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
   }
   function populateUI()
   {
      this.stampIconLoader.loadClip(this._filePath + this._data.getID() + ".swf",this.stampIconLoadMc);
   }
   function onPress()
   {
      if(!this._enabled)
      {
         return undefined;
      }
      this.gotoAndStop(!this._toggle?"down":!!this._selected?"selected_down":"down");
      this.dispatchEvent({type:"press",data:this._data});
   }
   function onRollOver()
   {
      if(!this._enabled)
      {
         return undefined;
      }
      this.stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OVER;
      this.stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OVER;
      this.gotoAndStop(!this._toggle?"over":!!this._selected?"selected_over":"over");
      this.dispatchEvent({type:"over"});
   }
   function onRollOut()
   {
      if(!this._enabled)
      {
         return undefined;
      }
      this.stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
      this.stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
      this.gotoAndStop(!this._toggle?"up":!!this._selected?"selected_up":"up");
      this.dispatchEvent({type:"out"});
   }
   function __set__enabled(value)
   {
      this._enabled = value;
      this.useHandCursor = value;
      this.gotoAndStop(!this._selected?"up":"selected_up");
      return this.__get__enabled();
   }
   function __set__selected(value)
   {
      this._selected = value;
      this.stampIconLoadMc._xscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
      this.stampIconLoadMc._yscale = com.clubpenguin.stamps.stampbook.controls.IconTabButton.ICON_SCALE_OUT;
      this.gotoAndStop(!this._selected?"up":"selected_up");
      return this.__get__selected();
   }
}
