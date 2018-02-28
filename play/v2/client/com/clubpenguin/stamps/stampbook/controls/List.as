class com.clubpenguin.stamps.stampbook.controls.List extends MovieClip
{
   var _initialized = false;
   var _scrollBarWidth = 30;
   var _scrollBarPadding = 5;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.List;
   static var LINKAGE_ID = "List";
   function List()
   {
      super();
      com.clubpenguin.util.EventDispatcher.initialize(this);
   }
   function onLoad()
   {
      this.configUI();
   }
   function __get__dataProvider()
   {
      return this._dataProvider;
   }
   function __set__dataProvider(value)
   {
      this._dataProvider = value;
      this.loadContent();
      return this.__get__dataProvider();
   }
   function move(x, y)
   {
      this._x = x;
      this._y = y;
   }
   function init(w, h, renderer, rendererW, rendererH, padding, useHandCursor)
   {
      this._listWidth = w;
      this._listHeight = h;
      this._itemRendererLinkage = renderer;
      this._rendererWidth = rendererW;
      this._rendererHeight = rendererH;
      this._padding = padding;
      this._useHandCursor = useHandCursor == undefined?true:useHandCursor;
      if(this._initialized)
      {
         this.populateUI();
      }
   }
   function reset()
   {
      this._selectedIndex = 0;
   }
   function configUI()
   {
      if(this._dataProvider == null)
      {
         this._dataProvider = [];
      }
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
      this._gridHolder = this.createEmptyMovieClip("gridHolder",this.getNextHighestDepth());
      this.scrollBar.addEventListener("down",this.onNextPage,this);
      this.scrollBar.addEventListener("up",this.onPreviousPage,this);
      this._initialized = true;
      if(this._itemRendererLinkage != undefined)
      {
         this.populateUI();
      }
   }
   function onPreviousPage(event)
   {
      this._selectedIndex = this._selectedIndex - 1;
      this.loadContent();
   }
   function onNextPage(event)
   {
      this._selectedIndex = this._selectedIndex + 1;
      this.loadContent();
   }
   function populateUI()
   {
      this.drawGrid();
   }
   function drawGrid()
   {
      this._rendererPaddedWidth = this._rendererWidth + this._padding;
      this._rendererPaddedHeight = this._rendererHeight + this._padding;
      this._numberOfColumns = Math.floor(this._listWidth / this._rendererPaddedWidth);
      var _loc2_ = Math.floor(this._listHeight / this._rendererPaddedHeight);
      this._selectedIndex = 0;
      this._totalRenderersPerPage = this._numberOfColumns * _loc2_;
      if(this._dataProvider.length > 0)
      {
         this.loadContent();
      }
      this.onListInitiated();
   }
   function onListInitiated()
   {
      this.scrollBar.setSize(this._scrollBarWidth,this._height);
      this.scrollBar._x = this._gridHolder._x + this._gridHolder._width + this._rendererWidth;
      this.scrollBar._y = 0;
      this.dispatchEvent({type:"loadInit"});
   }
   function onItemRollOver(event)
   {
      this.dispatchEvent(event);
   }
   function onItemRollOut(event)
   {
      this.dispatchEvent(event);
   }
   function loadContent()
   {
      if(!this._initialized)
      {
         return undefined;
      }
      var _loc7_ = this._selectedIndex + 1;
      var _loc8_ = Math.ceil(this._dataProvider.length / this._totalRenderersPerPage);
      this.scrollBar.downBtn.__set__enabled(_loc7_ < _loc8_);
      this.scrollBar.downBtn._visible = _loc7_ < _loc8_;
      this.scrollBar.upBtn.__set__enabled(_loc7_ > 1);
      this.scrollBar.upBtn._visible = _loc7_ > 1;
      this.scrollBar._visible = this._dataProvider.length > this._totalRenderersPerPage;
      var _loc6_ = this._dataProvider.slice(this._selectedIndex * this._totalRenderersPerPage,this._selectedIndex * this._totalRenderersPerPage + this._totalRenderersPerPage);
      if(this._itemRendererList != undefined)
      {
         var _loc5_ = this._itemRendererList.length;
         var _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            this._itemRendererList[_loc3_].removeEventListener("over",this.onItemRollOver,this);
            this._itemRendererList[_loc3_].removeEventListener("out",this.onItemRollOut,this);
            _loc3_ = _loc3_ + 1;
         }
      }
      this._itemRendererList = [];
      _loc3_ = 0;
      while(_loc3_ < this._totalRenderersPerPage)
      {
         var _loc2_ = this._gridHolder["itemRenderer" + _loc3_];
         if(_loc2_)
         {
            _loc2_.removeMovieClip();
         }
         _loc2_ = this._gridHolder.attachMovie(this._itemRendererLinkage,"itemRenderer" + _loc3_,this._gridHolder.getNextHighestDepth());
         _loc2_.useHandCursor = this._useHandCursor;
         _loc2_.addEventListener("over",this.onItemRollOver,this);
         _loc2_.addEventListener("out",this.onItemRollOut,this);
         _loc2_.move(_loc3_ % this._numberOfColumns * this._rendererPaddedWidth + this._rendererWidth / 2,Math.floor(_loc3_ / this._numberOfColumns) * this._rendererPaddedHeight + this._rendererHeight / 2);
         var _loc4_ = _loc6_[_loc3_];
         if(_loc4_.getID() == undefined && _loc4_.id == undefined)
         {
            _loc2_._visible = false;
         }
         else
         {
            _loc2_._visible = true;
            _loc2_.setModel(_loc4_);
            this._itemRendererList.push(_loc2_);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
}
