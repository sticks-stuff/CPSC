class com.clubpenguin.stamps.stampbook.controls.ContentList extends com.clubpenguin.stamps.stampbook.controls.List
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ContentList;
   static var LINKAGE_ID = "ContentList";
   function ContentList()
   {
      super();
   }
   function drawGrid()
   {
      var _loc3_ = Math.floor(this._listWidth / (this._rendererWidth + this._padding));
      var _loc2_ = Math.floor(this._listHeight / (this._rendererHeight + this._padding));
      this._selectedIndex = 0;
      this._totalRenderersPerPage = _loc3_ * _loc2_;
      if(this._dataProvider.length > 0)
      {
         this.loadContent();
      }
      this.onListInitiated();
   }
   function onListInitiated()
   {
      this.scrollBar.setSize(this._scrollBarWidth,this._height);
      this.scrollBar._x = this._gridHolder._x + this._gridHolder._width + this._scrollBarPadding;
      this.scrollBar._y = 0;
      this.dispatchEvent({type:"loadInit"});
   }
   function onItemClick(event)
   {
      var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.ListButton)event.target;
      var _loc3_ = event.data;
      this.dispatchEvent({type:"itemClick",category:_loc3_.getName(),index:_loc2_.indexNumber});
   }
   function loadContent()
   {
      if(!this._initialized)
      {
         return undefined;
      }
      var _loc5_ = Math.floor(this._listWidth / (this._rendererWidth + this._padding));
      var _loc10_ = Math.floor(this._listHeight / (this._rendererHeight + this._padding));
      var _loc8_ = this._selectedIndex + 1;
      var _loc9_ = Math.ceil(this._dataProvider.length / this._totalRenderersPerPage);
      this.scrollBar.downBtn.__set__enabled(_loc8_ < _loc9_);
      this.scrollBar.upBtn.__set__enabled(_loc8_ > 1);
      this.scrollBar._visible = this._dataProvider.length > this._totalRenderersPerPage;
      var _loc6_ = this._dataProvider.slice(this._selectedIndex * this._totalRenderersPerPage,this._selectedIndex * this._totalRenderersPerPage + this._totalRenderersPerPage);
      if(this._itemRendererList != undefined)
      {
         var _loc7_ = this._itemRendererList.length;
         var _loc2_ = 0;
         while(_loc2_ < _loc7_)
         {
            this._itemRendererList[_loc2_].removeEventListener("press",this.onItemClick,this);
            _loc2_ = _loc2_ + 1;
         }
      }
      this._itemRendererList = [];
      _loc2_ = 0;
      while(_loc2_ < this._totalRenderersPerPage)
      {
         var _loc4_ = this._gridHolder["itemRenderer" + _loc2_];
         if(_loc4_)
         {
            _loc4_.removeMovieClip();
         }
         _loc4_ = this._gridHolder.attachMovie(this._itemRendererLinkage,"itemRenderer" + _loc2_,this._gridHolder.getNextHighestDepth());
         var _loc3_ = (com.clubpenguin.stamps.stampbook.controls.ListButton)_loc4_;
         _loc3_.addEventListener("press",this.onItemClick,this);
         _loc3_._x = _loc2_ % _loc5_ * (this._rendererWidth + this._padding);
         _loc3_._y = Math.floor(_loc2_ / _loc5_) * (this._rendererHeight + this._padding);
         if(_loc6_[_loc2_] == undefined)
         {
            _loc3_._visible = false;
         }
         else
         {
            _loc3_._visible = true;
            _loc3_.setModel(_loc6_[_loc2_]);
            _loc3_.indexNumber = this._totalRenderersPerPage * this._selectedIndex + _loc2_;
            this._itemRendererList.push(_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
