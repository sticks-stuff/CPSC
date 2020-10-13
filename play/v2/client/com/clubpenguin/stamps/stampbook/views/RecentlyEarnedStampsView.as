class com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView extends com.clubpenguin.stamps.stampbook.views.BaseView
{
   var _coordinate = [[{x:35,y:32.75}],[{x:35,y:32.75},{x:115,y:32.75}],[{x:35,y:32.75},{x:115,y:32.75},{x:195,y:32.75}],[{x:35,y:32.75},{x:115,y:32.75},{x:35,y:108.25},{x:115,y:108.25}],[{x:35,y:32.75},{x:115,y:32.75},{x:195,y:32.75},{x:80,y:108.25},{x:160,y:108.25}],[{x:35,y:32.75},{x:115,y:32.75},{x:195,y:32.75},{x:35,y:108.25},{x:115,y:108.25},{x:195,y:108.25}]];
   var _dimensions = [{width:90,height:85.5},{width:170,height:85.5},{width:250,height:85.5},{width:170,height:161},{width:250,height:161},{width:250,height:161}];
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView;
   static var LINKAGE_ID = "RecentlyEarnedStampsView";
   static var LIST_LINKAGE_ID = "RecentlyEarnedList";
   static var ITEM_RENDERER = "RecentlyEarnedRenderer";
   static var STAMP_BOOK_ITEM_ART_SCALE = 100;
   static var PADDING = 10;
   static var DESCRIPTIONBOX_X_OFFSET = 5;
   static var DESCRIPTIONBOX_Y_OFFSET = 15;
   function RecentlyEarnedStampsView()
   {
      super();
      this._stampManager = this._shell.getStampManager();
   }
   function getWidth()
   {
      return this.background._width;
   }
   function getHeight()
   {
      return this.background._height;
   }
   function cleanUp()
   {
   }
   function configUI()
   {
      super.configUI();
      this.mouseBlocker.useHandCursor = false;
      this.closeBtn.addEventListener("release",this.onCloseButtonPressed,this);
   }
   function populateUI()
   {
      var _loc2_ = this._model.length;
      switch(_loc2_)
      {
         case 1:
         case 2:
         case 3:
         case 4:
         case 5:
         case 6:
            break;
         default:
            this.drawList();
            this.title.text = this._shell.getLocalizedString("recently_earned_title");
            this.description.text = this._shell.getLocalizedString("recently_earned_description");
            var _loc3_ = _loc2_ <= 1?this._shell.getLocalizedString("recently_earned_congrats_single_stamp"):this._shell.getLocalizedString("recently_earned_congrats_multiple_stamp");
            this.congratulationsMessage.text = this._shell.replace_m(_loc3_,[_loc2_]);
      }
      this.drawGrid();
      this.title.text = this._shell.getLocalizedString("recently_earned_title");
      this.description.text = this._shell.getLocalizedString("recently_earned_description");
      _loc3_ = _loc2_ <= 1?this._shell.getLocalizedString("recently_earned_congrats_single_stamp"):this._shell.getLocalizedString("recently_earned_congrats_multiple_stamp");
      this.congratulationsMessage.text = this._shell.replace_m(_loc3_,[_loc2_]);
   }
   function drawGrid()
   {
      var _loc5_ = this._model.length;
      var _loc6_ = _loc5_ - 1;
      this._selectedCoordinates = this._coordinate[_loc6_];
      var _loc7_ = this.stampsHolder.attachMovie("ListBackground","listBackground",this.stampsHolder.getNextHighestDepth());
      _loc7_._width = this._dimensions[_loc6_].width;
      _loc7_._height = this._dimensions[_loc6_].height;
      var _loc4_ = this.stampsHolder.createEmptyMovieClip("gridHolder",this.stampsHolder.getNextHighestDepth());
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer)_loc4_.attachMovie(com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.ITEM_RENDERER,"itemRenderer" + _loc3_,_loc4_.getNextHighestDepth());
         _loc2_.useHandCursor = false;
         _loc2_.addEventListener("over",this.onStampItemRollOver,this);
         _loc2_.addEventListener("out",this.onStampItemRollOut,this);
         _loc2_.setScale(com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.STAMP_BOOK_ITEM_ART_SCALE,com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.STAMP_BOOK_ITEM_ART_SCALE);
         _loc2_.move(this._selectedCoordinates[_loc3_].x,this._selectedCoordinates[_loc3_].y);
         _loc2_.setModel(this._model[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc4_._x = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
      _loc4_._y = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
      this.stampsHolder._x = this.background._width - this.stampsHolder._width >> 1;
      this.congratulationsMessage._y = this.stampsHolder._y + this.stampsHolder._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
      this.background._height = this.background._y + this.congratulationsMessage._y + this.congratulationsMessage._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
   }
   function onStampItemRollOver(event)
   {
      var _loc2_ = (MovieClip)event.target;
      this.descriptionBox._x = this.stampsHolder._x + _loc2_._x - _loc2_._width + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_X_OFFSET;
      this.descriptionBox._y = this.stampsHolder._y + _loc2_._y - _loc2_._height / 2 - this.descriptionBox._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_Y_OFFSET;
      this.descriptionBox.setModel(event.data);
   }
   function onStampItemRollOut(event)
   {
      this.onStampListRollOut(event);
   }
   function drawList()
   {
      var _loc2_ = 5;
      var _loc3_ = this._dimensions[_loc2_].width;
      var _loc4_ = this._dimensions[_loc2_].height;
      this.stampsList = (com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedList)this.stampsHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.LIST_LINKAGE_ID,"stamps_list",this.stampsHolder.getNextHighestDepth());
      this.stampsList.addEventListener("loadInit",this.onStampsListInit,this);
      this.stampsList.addEventListener("over",this.onStampsListRollOver,this);
      this.stampsList.addEventListener("out",this.onStampListRollOut,this);
      this.stampsList.init(_loc3_,_loc4_,com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.ITEM_RENDERER,com.clubpenguin.stamps.StampManager.STAMP_ICON_BOX_WIDTH,com.clubpenguin.stamps.StampManager.STAMP_ICON_BOX_HEIGHT,com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING);
      this.stampsList.__set__dataProvider(Array(this._model)[0]);
      this.stampsList.move(0,0);
   }
   function onStampsListInit(event)
   {
      this.stampsHolder._x = this.background._width - this.stampsHolder._width >> 1;
      this.stampsHolder._y = this.description._y + this.description._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
      this.congratulationsMessage._y = this.stampsHolder._y + this.stampsHolder._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
      this.background._height = this.background._y + this.congratulationsMessage._y + this.congratulationsMessage._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.PADDING;
   }
   function onCloseButtonPressed()
   {
      this.dispatchEvent({type:"close"});
   }
   function onStampsListRollOver(event)
   {
      var _loc2_ = (MovieClip)event.target;
      this.descriptionBox._x = this.stampsHolder._x + _loc2_._x + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_X_OFFSET;
      this.descriptionBox._y = this.stampsHolder._y + _loc2_._y - this.descriptionBox._height + com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView.DESCRIPTIONBOX_Y_OFFSET;
      this.descriptionBox.setModel(event.data);
   }
   function onStampListRollOut(event)
   {
      this.descriptionBox._x = -1000;
      this.descriptionBox._y = -1000;
   }
}
