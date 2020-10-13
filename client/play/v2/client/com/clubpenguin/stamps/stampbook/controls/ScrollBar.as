class com.clubpenguin.stamps.stampbook.controls.ScrollBar extends MovieClip
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ScrollBar;
   static var LINKAGE_ID = "ScrollBar";
   function ScrollBar()
   {
      super();
      com.clubpenguin.util.EventDispatcher.initialize(this);
   }
   function onLoad()
   {
      this.configUI();
   }
   function move(x, y)
   {
      this._x = x;
      this._y = y;
   }
   function setSize(w, h)
   {
      if(this._scrollBarWidth == w && this._scrollBarHeight == h)
      {
         return undefined;
      }
      this._scrollBarWidth = w;
      this._scrollBarHeight = h;
      this.handleResize();
   }
   function configUI()
   {
      this.upBtn.addEventListener("press",this.onUpButtonPressed,this);
      this.downBtn.addEventListener("press",this.onDownButtonPressed,this);
   }
   function handleResize()
   {
      this._yscale = 100;
      this._xscale = 100;
      this.upBtn._x = this.upBtn._width / 2;
      this.upBtn._y = this.upBtn._height / 2;
      this.downBtn._x = this.downBtn._width / 2;
      this.downBtn._y = this._scrollBarHeight - this.downBtn._height / 2;
   }
   function onDownButtonPressed(event)
   {
      this.dispatchEvent({type:"down"});
   }
   function onUpButtonPressed(event)
   {
      this.dispatchEvent({type:"up"});
   }
}
