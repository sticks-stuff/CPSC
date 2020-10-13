class com.clubpenguin.stamps.stampbook.views.InsidePagesContentView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView;
   static var LINKAGE_ID = "InsidePagesContentView";
   static var NUM_COLUMNS = 2;
   static var NUM_ROWS = 5;
   static var VERTICAL_PADDING = 10;
   static var HORIZONTAL_PADDING = 38;
   static var BUTTON_RENDERER = "ListButton";
   function InsidePagesContentView()
   {
      super();
   }
   function cleanUp()
   {
      var _loc4_ = this._buttonsList.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         this._buttonsList[_loc2_].removeEventListener("press",this.onContentBtnPressed,this);
         _loc2_ = _loc2_ + 1;
      }
      _loc4_ = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS * com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_ROWS;
      _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         var _loc3_ = this.content_holder_mc["listButton" + _loc2_];
         if(_loc3_)
         {
            _loc3_.removeMovieClip();
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function configUI()
   {
      this._buttonsList = [];
      this.title_txt.text = this._shell.getLocalizedString("contents_category_title");
      this.legend.titleText.text = this._shell.getLocalizedString("toc_legend_title");
      this.legend.easyText.text = this._shell.getLocalizedString("toc_legend_easy");
      this.legend.mediumText.text = this._shell.getLocalizedString("toc_legend_medium");
      this.legend.hardText.text = this._shell.getLocalizedString("toc_legend_hard");
      this.legend.extremeText.text = this._shell.getLocalizedString("toc_legend_extreme");
      this.legend.memberText.text = this._shell.getLocalizedString("toc_legend_member");
      this.legend.newText.text = this._shell.getLocalizedString("toc_legend_new");
      this.legend.editText.text = this._shell.getLocalizedString("toc_legend_edit");
      this.legend.saveText.text = this._shell.getLocalizedString("toc_legend_save");
      this.legend.newClip.gotoAndStop(this._shell.getLocalizedFrame());
      super.configUI();
   }
   function populateUI()
   {
      var _loc5_ = this._buttonsList.length;
      if(_loc5_ > 0)
      {
         var _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            var _loc4_ = this._model[_loc3_];
            if(!(_loc4_.getID() == undefined || _loc4_.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID))
            {
               var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.ListButton)this._buttonsList[_loc3_];
               _loc2_.setModel(_loc4_);
               _loc2_.indexNumber = _loc3_;
            }
            _loc3_ = _loc3_ + 1;
         }
         return undefined;
      }
      _loc5_ = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS * com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_ROWS;
      _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         _loc4_ = this._model[_loc3_];
         if(!(_loc4_.getID() == undefined || _loc4_.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID))
         {
            _loc2_ = (com.clubpenguin.stamps.stampbook.controls.ListButton)this.content_holder_mc.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.BUTTON_RENDERER,"listButton" + _loc3_,this.content_holder_mc.getNextHighestDepth());
            _loc2_.addEventListener("press",this.onContentBtnPressed,this);
            _loc2_._x = _loc3_ % com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS * (_loc2_._width + com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.HORIZONTAL_PADDING);
            _loc2_._y = Math.floor(_loc3_ / com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.NUM_COLUMNS) * (_loc2_._height + com.clubpenguin.stamps.stampbook.views.InsidePagesContentView.VERTICAL_PADDING);
            _loc2_.setModel(_loc4_);
            _loc2_.indexNumber = _loc3_;
            this._buttonsList.push(_loc2_);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function onContentBtnPressed(event)
   {
      var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.ListButton)event.target;
      var _loc3_ = event.data;
      this.dispatchEvent({type:"itemClick",category:_loc3_.getName(),index:_loc2_.indexNumber});
   }
}
