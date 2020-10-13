class com.clubpenguin.stamps.stampbook.views.InsidePagesView extends com.clubpenguin.stamps.stampbook.views.BaseView
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesView;
   static var LINKAGE_ID = "InsidePagesView";
   static var BLANK_CLIP_LINKAGE_ID = "Blank";
   static var TAB_BUTTONS_PADDING = 2;
   function InsidePagesView()
   {
      super();
      this._contentsTitle = this._shell.getLocalizedString("contents_category_title");
   }
   function cleanUp()
   {
      this._navigation.reset();
      this.contentView.cleanUp();
      this.subContentView.cleanUp();
      this.stampsView.cleanUp();
      this.pinsView.cleanUp();
      this.close_btn.removeEventListener("press",this.onCloseStampBook,this);
      this.start_btn.removeEventListener("press",this.onStartInsidePage,this);
      this.next_btn.removeEventListener("press",this.onNextInsidePage,this);
      this.prev_btn.removeEventListener("press",this.onPreviousInsidePage,this);
      this.contentView.removeEventListener("itemClick",this.onContentItemClick,this);
      this.subContentView.removeEventListener("itemClick",this.onContentItemClick,this);
   }
   function showUI()
   {
      this.bitmapLines._visible = true;
      this.totalStamps1._visible = true;
      this.totalStamps2._visible = true;
      this.pageNumberOf._visible = true;
   }
   function hideUI()
   {
      this.bitmapLines._visible = false;
      this.totalStamps1._visible = false;
      this.totalStamps2._visible = false;
      this.pageNumberOf._visible = false;
   }
   function configUI()
   {
      this.start_btn = this.book_holder_mc.book_holder_mc.book_items_mc.book_mc.close_btn;
      this.backgroundLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.backgroundLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onLoadInit));
      this.contentView = (com.clubpenguin.stamps.stampbook.views.InsidePagesContentView)this.attachMovie("InsidePagesContentView","insidePagesContentView",this.getNextHighestDepth());
      this.subContentView = (com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView)this.attachMovie("InsidePagesSubContentView","insidePagesSubContentView",this.getNextHighestDepth());
      this.stampsView = (com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView)this.attachMovie("InsidePagesStampsView","insidePagesStampsView",this.getNextHighestDepth());
      this.pinsView = (com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView)this.attachMovie("InsidePagesPinsView","insidePagesPinsView",this.getNextHighestDepth());
      this.pinsView._visible = this.stampsView._visible = this.subContentView._visible = this.contentView._visible = false;
      super.configUI();
   }
   function onContentItemClick(event)
   {
      this._navigation.addSection(event.index);
   }
   function onLoadInit(event)
   {
      var _loc1_ = event.target;
      _loc1_._alpha = 100;
   }
   function onStartInsidePage(event)
   {
      if(this._navigation.__get__title() == this._contentsTitle)
      {
         this.start_btn.gotoAndStop(1);
         this._currentView._visible = false;
         this.dispatchEvent({type:"close"});
         return undefined;
      }
      this._navigation.reset();
   }
   function onNextInsidePage(event)
   {
      this._navigation.next();
   }
   function onPreviousInsidePage(event)
   {
      if(this._navigation.__get__title() == this._contentsTitle)
      {
         this.prev_btn.gotoAndStop(1);
         this._currentView._visible = false;
         this.dispatchEvent({type:"close"});
         return undefined;
      }
      this._navigation.previous();
   }
   function onCloseStampBook(event)
   {
      this.dispatchEvent({type:"closeStampBook"});
   }
   function populateUI()
   {
      this._stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
      this._pageList = this._stampLookUp.getPageList();
      if(!this._navigation)
      {
         this._navigation = new com.clubpenguin.stamps.stampbook.util.Navigation(this._model);
         this._navigation.addEventListener("change",this.onNagivationChange,this);
      }
      if(!this._tabButtonList)
      {
         this._tabButtonList = [];
         var _loc5_ = Array(this._navigation.currentSection)[0];
         var _loc6_ = _loc5_.length;
         var _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            var _loc4_ = _loc5_[_loc3_];
            if(_loc4_.getID() != com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)
            {
               var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.IconTabButton)this.tabBtnsHolder.attachMovie("IconTabButton","iconTabButton" + _loc3_,this.tabBtnsHolder.getNextHighestDepth());
               _loc2_.addEventListener("press",this.onIconTabButtonPressed,this);
               _loc2_._x = 0;
               _loc2_._y = (_loc2_._height + com.clubpenguin.stamps.stampbook.views.InsidePagesView.TAB_BUTTONS_PADDING) * _loc3_;
               _loc2_.__set__data(_loc5_[_loc3_]);
               _loc2_.indexNumber = _loc3_;
               this._tabButtonList.push(_loc2_);
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      this.close_btn.addEventListener("press",this.onCloseStampBook,this);
      this.start_btn.addEventListener("press",this.onStartInsidePage,this);
      this.next_btn.addEventListener("press",this.onNextInsidePage,this);
      this.prev_btn.addEventListener("press",this.onPreviousInsidePage,this);
      this.contentView.addEventListener("itemClick",this.onContentItemClick,this);
      this.subContentView.addEventListener("itemClick",this.onContentItemClick,this);
      this.loadContent();
   }
   function onIconTabButtonPressed(event)
   {
      var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.IconTabButton)event.target;
      this._navigation.goToSection(_loc2_.indexNumber);
   }
   function onNagivationChange(event)
   {
      this.loadContent();
   }
   function loadContent()
   {
      var _loc23_ = undefined;
      var _loc12_ = undefined;
      var _loc9_ = undefined;
      var _loc10_ = undefined;
      var _loc11_ = undefined;
      var _loc15_ = undefined;
      var _loc19_ = undefined;
      var _loc17_ = undefined;
      var _loc16_ = undefined;
      var _loc22_ = this._shell.getPath("stampbook_insidePagesBackground");
      var _loc14_ = undefined;
      this._currentView._visible = false;
      this._currentView.reset();
      this.load_mc._alpha = 0;
      var _loc7_ = this._navigation.currentSection;
      var _loc4_ = _loc7_.getID();
      var _loc18_ = undefined;
      var _loc8_ = this._tabButtonList.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc8_)
      {
         var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.IconTabButton)this._tabButtonList[_loc3_];
         var _loc6_ = _loc2_.__get__data();
         var _loc5_ = _loc6_.getID();
         _loc2_.__set__selected(!(_loc4_ != undefined && _loc5_ == _loc4_)?false:true);
         _loc2_.__set__enabled(!(_loc4_ != undefined && _loc5_ == _loc4_)?true:false);
         _loc3_ = _loc3_ + 1;
      }
      if(this._navigation.__get__title() == this._contentsTitle)
      {
         this.showUI();
         this.start_btn.__set__label(this._shell.getLocalizedString("cover"));
         _loc9_ = this._stampLookUp.getNumberOfUserStampsForCategory(this._model);
         _loc10_ = this._stampLookUp.getNumberOfTotalStampsForCategory(this._model);
         _loc11_ = this._shell.getLocalizedString("numerator_over_denominator");
         _loc12_ = this._shell.replace_m(_loc11_,[_loc9_,_loc10_]);
         this.totalStamps1.text = this._shell.getLocalizedString("total_stamps_label");
         this.totalStamps2.text = _loc12_;
         _loc15_ = 1;
         _loc19_ = this._pageList.length;
         _loc17_ = this._shell.getLocalizedString("page_number");
         _loc16_ = this._shell.replace_m(_loc17_,[_loc15_,_loc19_]);
         this.pageNumberOf.text = _loc16_;
         _loc14_ = 0;
         this._currentView = this.contentView;
         this._currentView.setModel(this._model);
         this._currentView._visible = true;
      }
      else if(this._navigation.__get__title() == com.clubpenguin.stamps.StampManager.MYSTERY_PAGE_TITLE)
      {
         this.hideUI();
         this.start_btn.__set__label(this._contentsTitle);
         _loc14_ = com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID;
      }
      else
      {
         this.showUI();
         this.start_btn.__set__label(this._contentsTitle);
         var _loc20_ = _loc7_.getItems();
         var _loc21_ = _loc7_.getSubCategories();
         if(_loc21_ != undefined && _loc21_.length > 0)
         {
            _loc9_ = this._stampLookUp.getNumberOfUserStampsForCategory(_loc7_);
            _loc10_ = this._stampLookUp.getNumberOfTotalStampsForCategory(_loc7_);
            _loc11_ = this._shell.getLocalizedString("numerator_over_denominator");
            _loc18_ = this._shell.getLocalizedString("category_stamps_label");
            this.totalStamps1.text = com.clubpenguin.util.StringUtils.replaceString("%name%",_loc7_.getName(),_loc18_);
            _loc12_ = this._shell.replace_m(_loc11_,[_loc9_,_loc10_]);
            this._currentView = this.subContentView;
         }
         else if((var _loc0_ = _loc4_) !== com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID)
         {
            _loc9_ = this._stampLookUp.getNumberOfUserStampsForCategory(_loc7_);
            _loc10_ = this._stampLookUp.getNumberOfTotalStampsForCategory(_loc7_);
            _loc11_ = this._shell.replace_m(this._shell.getLocalizedString("numerator_over_denominator"),[_loc9_,_loc10_]);
            _loc18_ = this._shell.getLocalizedString("category_label");
            this.totalStamps1.text = com.clubpenguin.util.StringUtils.replaceString("%name%",_loc7_.getName(),_loc18_);
            _loc12_ = _loc11_;
            this._currentView = this.stampsView;
         }
         else
         {
            this.totalStamps1.text = this._shell.getLocalizedString("users_pins_label");
            _loc12_ = String(_loc20_ == undefined?0:_loc20_.length);
            this._currentView = this.pinsView;
         }
         _loc14_ = _loc7_.getID() == undefined?1:_loc7_.getID();
         _loc15_ = this.getPageIndex(_loc7_) + 2;
         _loc19_ = this._pageList.length;
         _loc17_ = this._shell.getLocalizedString("page_number");
         _loc16_ = this._shell.replace_m(_loc17_,[_loc15_,_loc19_]);
         this.pageNumberOf.text = _loc16_;
         this.totalStamps2.text = _loc12_;
         this._currentView.setModel(_loc7_);
         this._currentView._visible = true;
      }
      var _loc13_ = this.book_holder_mc.book_holder_mc.book_items_mc.book_mc.paper_mc.background;
      if(_loc13_.load_mc)
      {
         _loc13_.load_mc.removeMovieClip();
      }
      _loc13_.createEmptyMovieClip("load_mc",1);
      this.backgroundLoader.loadClip(_loc22_ + _loc14_ + ".swf",_loc13_.load_mc);
   }
   function getPageIndex(page)
   {
      var _loc3_ = this._pageList.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._pageList[_loc2_] == page)
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
}
