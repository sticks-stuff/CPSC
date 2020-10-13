class com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedList extends com.clubpenguin.stamps.stampbook.controls.List
{
   var _scrollBarWidth = 30;
   var _scrollBarPadding = 5;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedList;
   static var LINKAGE_ID = "RecentlyEarnedList";
   static var GRID_COLUMNS = 3;
   static var GRID_ROWS = 2;
   function RecentlyEarnedList()
   {
      super();
   }
   function drawGrid()
   {
      super.drawGrid();
      this.onListInitiated();
   }
   function onListInitiated()
   {
      this.bg._x = 0;
      this.bg._y = 0;
      this._gridHolder._x = this._rendererWidth / 2 - 27;
      this._gridHolder._y = this._rendererHeight / 2 - 22;
      this.bg._width = this._gridHolder._width + this._rendererWidth + this._padding;
      this.bg._height = this._gridHolder._height + this._rendererHeight + this._padding;
      this.scrollBar.setSize(this.bg._width + this._padding * 8,this._scrollBarWidth);
      this.scrollBar._x = this.bg._width - this.scrollBar._width >> 1;
      this.scrollBar._y = this.bg._height - this.scrollBar._height >> 1;
      var _loc2_ = Math.abs(this.scrollBar._x);
      this.scrollBar._x = this.scrollBar._x + _loc2_;
      this.bg._x = this.bg._x + _loc2_;
      this._gridHolder._x = this._gridHolder._x + _loc2_;
      this.dispatchEvent({type:"loadInit"});
   }
}
