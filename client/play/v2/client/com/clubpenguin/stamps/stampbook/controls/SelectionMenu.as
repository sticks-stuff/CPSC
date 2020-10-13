class com.clubpenguin.stamps.stampbook.controls.SelectionMenu extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.SelectionMenu;
   static var LINKAGE_ID = "SelectionMenu";
   static var NUMBER_OF_ROWS = 3;
   static var RENDERER_WIDTH = 57;
   static var RENDERER_HEIGHT = 37;
   static var PADDING = 1;
   static var HORIZONTAL_OFFSET = 1.7;
   static var HORIZONTAL_DIVIDER_LINKAGE = "SelectionMenuHorizontalDivider";
   static var VERTICAL_DIVIDER_LINKAGE = "SelectionMenuVerticalDivider";
   function SelectionMenu()
   {
      super();
   }
   function setType(type)
   {
      this._type = type;
   }
   function getHeight()
   {
      return this.background._height;
   }
   function configUI()
   {
      this._renderers = [];
      this._dividers = [];
      var _this = this;
      this.mouseBlocker.onRelease = function()
      {
         _this.dispatchEvent({type:"close"});
      };
      this.mouseBlocker.useHandCursor = false;
      super.configUI();
   }
   function populateUI()
   {
      var _loc2_ = 0;
      if(this._data.length > 0)
      {
         _loc2_ = this._data.length;
      }
      else
      {
         for(var _loc3_ in this._data)
         {
            _loc2_ = _loc2_ + 1;
         }
      }
      this._rows = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.NUMBER_OF_ROWS;
      this._columns = Math.ceil(_loc2_ / this._rows);
      this.cleanUp();
      this.drawUI();
   }
   function cleanUp()
   {
      var _loc5_ = this._renderers.length <= this._dividers.length?this._dividers.length:this._renderers.length;
      if(_loc5_ > 0)
      {
         var _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            var _loc3_ = (MovieClip)this._renderers.pop();
            _loc3_.removeMovieClip();
            var _loc4_ = (MovieClip)this._dividers.pop();
            _loc4_.removeMovieClip();
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function drawUI()
   {
      this.placeHolder._x = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
      this.placeHolder._y = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
      var _loc11_ = this._columns * com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_WIDTH;
      var _loc10_ = this._rows * com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_HEIGHT;
      this.background._width = _loc11_ + com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING * 2;
      this.background._height = _loc10_ + com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING * 2;
      this.mask._width = _loc11_;
      this.mask._height = _loc10_;
      this.mask._x = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
      this.mask._y = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
      var _loc8_ = this._columns - 1;
      var _loc7_ = this._rows - 1;
      var _loc6_ = this._data.length;
      if(_loc6_ > 0)
      {
         var _loc2_ = 0;
         while(_loc2_ < _loc6_)
         {
            var _loc4_ = this.placeHolder.attachMovie(this._type + "Renderer","renderer" + _loc2_,this.placeHolder.getNextHighestDepth());
            _loc4_.addEventListener("onRollOver",this.onItemRollOver,this);
            _loc4_.addEventListener("onClick",this.onItemSelected,this);
            _loc4_.addEventListener("onRollOut",this.onItemRollOut,this);
            _loc4_.setModel(this._data[_loc2_]);
            _loc4_._x = _loc2_ % this._columns * com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_WIDTH;
            _loc4_._y = Math.floor(_loc2_ / this._columns) * com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_HEIGHT;
            this._renderers.push(_loc4_);
            _loc2_ = _loc2_ + 1;
         }
      }
      else
      {
         var _loc5_ = 0;
         for(var _loc9_ in this._data)
         {
            _loc4_ = this.placeHolder.attachMovie(this._type + "Renderer","renderer" + _loc5_,this.placeHolder.getNextHighestDepth());
            _loc4_.addEventListener("onRollOver",this.onItemRollOver,this);
            _loc4_.addEventListener("onClick",this.onItemSelected,this);
            _loc4_.addEventListener("onRollOut",this.onItemRollOut,this);
            _loc4_.setModel(_loc9_);
            _loc4_._x = _loc5_ % this._columns * com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_WIDTH;
            _loc4_._y = Math.floor(_loc5_ / this._columns) * com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_HEIGHT;
            this._renderers.push(_loc4_);
            _loc5_ = _loc5_ + 1;
         }
      }
      _loc2_ = 0;
      while(_loc2_ < _loc8_)
      {
         var _loc3_ = this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.SelectionMenu.VERTICAL_DIVIDER_LINKAGE,com.clubpenguin.stamps.stampbook.controls.SelectionMenu.VERTICAL_DIVIDER_LINKAGE + _loc2_,this.placeHolder.getNextHighestDepth());
         _loc3_._x = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_WIDTH * (_loc2_ + 1);
         _loc3_._y = this.mask._y;
         _loc3_._height = this.mask._height - com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
         this._dividers.push(_loc3_);
         _loc2_ = _loc2_ + 1;
      }
      _loc2_ = 0;
      while(_loc2_ < _loc7_)
      {
         _loc3_ = this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.SelectionMenu.HORIZONTAL_DIVIDER_LINKAGE,com.clubpenguin.stamps.stampbook.controls.SelectionMenu.HORIZONTAL_DIVIDER_LINKAGE + _loc2_,this.placeHolder.getNextHighestDepth());
         _loc3_._x = this.mask._x;
         _loc3_._y = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_HEIGHT * (_loc2_ + 1);
         _loc3_._width = this.mask._width - com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
         this._dividers.push(_loc3_);
         _loc2_ = _loc2_ + 1;
      }
      this.rollOverBg._x = -1000;
      this.rollOverBg._y = -1000;
      this.rollOverBg._width = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_WIDTH;
      this.rollOverBg._height = com.clubpenguin.stamps.stampbook.controls.SelectionMenu.RENDERER_HEIGHT;
   }
   function onItemRollOver(event)
   {
      var _loc2_ = (MovieClip)event.target;
      this.rollOverBg._x = _loc2_._x + com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
      this.rollOverBg._y = _loc2_._y + com.clubpenguin.stamps.stampbook.controls.SelectionMenu.PADDING;
   }
   function onItemRollOut(event)
   {
      this.rollOverBg._x = -1000;
      this.rollOverBg._y = -1000;
   }
   function onItemSelected(event)
   {
      this.rollOverBg._x = -1000;
      this.rollOverBg._y = -1000;
      this.dispatchEvent({type:"onItemClick",data:event.data,dataType:this._type});
   }
}
