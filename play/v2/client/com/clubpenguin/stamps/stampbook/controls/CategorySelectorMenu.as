class com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
   var _maxWidth = 0;
   var includeBlankTopSpace = false;
   var includeAllCategoriesButton = false;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu;
   static var LINKAGE_ID = "CategorySelectorMenu";
   static var OFF_STAGE_POSITION = -1000;
   static var DIVIDER_RENDERER = "CategorySelectorDivider";
   static var ITEM_RENDERER = "CategorySelectorRenderer";
   static var RENDERER_HEIGHT = 25;
   static var PADDING = 1;
   static var DIVIDER_HEIGHT = 1;
   function CategorySelectorMenu()
   {
      super();
   }
   function configUI()
   {
      this._renderers = [];
      this._dividers = [];
      super.configUI();
   }
   function cleanUI()
   {
      var _loc5_ = this._renderers.length <= this._dividers.length?this._dividers.length:this._renderers.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         var _loc2_ = (MovieClip)this._renderers.pop();
         if(_loc2_)
         {
            _loc2_.removeMovieClip();
         }
         var _loc4_ = (MovieClip)this._dividers.pop();
         if(_loc4_)
         {
            _loc4_.removeMovieClip();
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function populateUI()
   {
      this.cleanUI();
      this._maxWidth = 0;
      this.rollOverBg._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
      this.rollOverBg._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
      this.placeHolder._visible = false;
      this.bg._visible = false;
      var _loc8_ = this._data.length;
      var _loc4_ = undefined;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc8_)
      {
         var _loc6_ = this._data[_loc2_];
         if(_loc6_.getID() != com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)
         {
            if(this.includeBlankTopSpace)
            {
               _loc4_ = this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER,com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER + "-1",this.placeHolder.getNextHighestDepth());
               _loc4_._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT;
               this._dividers.push(_loc4_);
            }
            _loc3_ = (com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer)this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER,com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER + _loc2_,this.placeHolder.getNextHighestDepth());
            _loc3_.addEventListener("onRollOver",this.onItemRollOver,this);
            _loc3_.addEventListener("onRollOut",this.onItemRollOut,this);
            _loc3_.addEventListener("onPress",this.onItemPress,this);
            _loc3_.__set__data(this._data[_loc2_]);
            var _loc5_ = !this.includeBlankTopSpace?_loc2_:_loc2_ + 1;
            _loc3_._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * _loc5_;
            _loc3_._x = 0;
            this._renderers.push(_loc3_);
            this._maxWidth = _loc3_._width <= this._maxWidth?this._maxWidth:_loc3_._width;
            if(!(!this.includeAllCategoriesButton && _loc2_ == _loc8_ - 1))
            {
               _loc4_ = this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER,com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.DIVIDER_RENDERER + _loc2_,this.placeHolder.getNextHighestDepth());
               _loc4_._y = _loc3_._y + com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT;
               this._dividers.push(_loc4_);
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      if(this.includeAllCategoriesButton)
      {
         var _loc11_ = _loc8_ - 1;
         _loc3_ = (com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer)this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER,com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.ITEM_RENDERER + _loc11_,this.placeHolder.getNextHighestDepth());
         _loc3_.addEventListener("onRollOver",this.onItemRollOver,this);
         _loc3_.addEventListener("onRollOut",this.onItemRollOut,this);
         _loc3_.addEventListener("onPress",this.onItemPress,this);
         _loc3_.__set__data(this._data);
         var _loc14_ = !this.includeBlankTopSpace?_loc11_:_loc11_ + 1;
         _loc3_._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * _loc14_;
         _loc3_._x = 0;
         this._renderers.push(_loc3_);
         this._maxWidth = _loc3_._width <= this._maxWidth?this._maxWidth:_loc3_._width;
      }
      var _loc7_ = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING * 2;
      var _loc13_ = this._dividers.length;
      var _loc10_ = this._renderers.length;
      var _loc9_ = _loc10_ <= _loc13_?_loc13_:_loc10_;
      _loc2_ = 0;
      while(_loc2_ < _loc9_)
      {
         _loc3_ = (com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer)this._renderers[_loc2_];
         if(_loc3_)
         {
            _loc3_.setWidth(this._maxWidth);
         }
         _loc4_ = (MovieClip)this._dividers[_loc2_];
         if(_loc4_)
         {
            _loc4_._width = this._maxWidth - _loc7_;
            _loc4_._x = _loc7_;
         }
         _loc2_ = _loc2_ + 1;
      }
      this.rollOverBg._width = this._maxWidth + _loc7_;
      this.rollOverBg._height = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT;
      var _loc12_ = !this.includeBlankTopSpace?com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * _loc10_:com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.RENDERER_HEIGHT * (_loc10_ + 1);
      this.bg._width = this._maxWidth + _loc7_;
      this.bg._height = _loc12_ + _loc7_;
      this.bg._visible = true;
      this.mask._width = this._maxWidth;
      this.mask._height = _loc12_;
      this.mask._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
      this.mask._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
      this.placeHolder._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
      this.placeHolder._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
      this.placeHolder._visible = true;
   }
   function onItemRollOver(event)
   {
      var _loc2_ = (MovieClip)event.target;
      _loc2_.swapDepths(this.placeHolder.getNextHighestDepth());
      this.rollOverBg._y = _loc2_._y + com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.PADDING;
      this.rollOverBg._x = 0;
      var _loc3_ = event.data;
      var _loc4_ = _loc3_.getSubCategories();
      this.dispatchEvent({type:"showMenu",data:_loc4_,currentTarget:_loc2_});
   }
   function onItemRollOut(event)
   {
      this.rollOverBg._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
      this.rollOverBg._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
   }
   function onItemPress(event)
   {
      var _loc3_ = (MovieClip)event.target;
      var _loc2_ = event.data;
      var _loc7_ = _loc2_.getSubCategories();
      this.rollOverBg._x = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
      this.rollOverBg._y = com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu.OFF_STAGE_POSITION;
      this.dispatchEvent({type:"onItemPress",data:_loc2_,currentTarget:_loc3_});
   }
}
