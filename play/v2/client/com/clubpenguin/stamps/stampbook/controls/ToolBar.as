class com.clubpenguin.stamps.stampbook.controls.ToolBar extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ToolBar;
   static var LINKAGE_ID = "ToolBar";
   static var COLOUR = "Colour";
   static var HIGHLIGHT = "Highlight";
   static var PATTERN = "Pattern";
   static var ICON = "Icon";
   static var CATEGORY_SELECTOR_MENU_LINKAGE = "CategorySelectorMenu";
   static var CATEGORY_SELECTOR_MENU_OFFSET = 4;
   static var TOP_LEVEL = 10001;
   static var BOTTOM_LEVEL = 10000;
   static var SELECTION_MENU_X = 61.85;
   static var TOOLBAR_BTN_HEIGHT = 70;
   static var CATEGORY_SELECTOR_TIER1_X = 36;
   static var CATEGORY_SELECTOR_TIER1_Y = 42;
   function ToolBar()
   {
      super();
      this._coverCrumbs = this._shell.getStampManager().stampBookCoverCrumbs;
   }
   function __get__changingCategory()
   {
      return this._changingCategory;
   }
   function closeCategorySelector()
   {
      this.hideCategorySelector();
   }
   function configUI()
   {
      this._stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
      this._masterList = this._stampLookUp.getMasterList();
      this.categorySelectorBtn.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.TOP_LEVEL + 1);
      this.categorySelectorBtn.addEventListener("press",this.onCategorySelectorPress,this);
      this.colourTool.addEventListener("press",this.onToolItemPressed,this);
      this.highlightTool.addEventListener("press",this.onToolItemPressed,this);
      this.patternTool.addEventListener("press",this.onToolItemPressed,this);
      this.iconTool.addEventListener("press",this.onToolItemPressed,this);
      this.selectionMenu.addEventListener("onItemClick",this.onSelectionChange,this);
      this.selectionMenu.addEventListener("close",this.onSelectionMenuClose,this);
      super.configUI();
   }
   function populateUI()
   {
      this.colourLabel.text = this._shell.getLocalizedString("colour");
      this.highlightLabel.text = this._shell.getLocalizedString("highlight");
      this.patternLabel.text = this._shell.getLocalizedString("pattern");
      this.iconLabel.text = this._shell.getLocalizedString("icon");
      this._stampLookUp.setCategorySelected(com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID);
      this.specificCategoryBG._visible = false;
      this.specificCategoryArrow._visible = false;
      this.categorySelectorBtn.setModel(this._data);
      var _loc2_ = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
      _loc2_.setColourIndex(this._data.getColourID());
      _loc2_.setHighlightIndex(this._data.getHighlightID());
      _loc2_.setPatternIndex(this._data.getPatternID());
      _loc2_.setIconIndex(this._data.getClaspIconArtID());
      this.colourTool.setModel(this._data.getColourID());
      this.highlightTool.setModel(this._data.getHighlightID());
      this.patternTool.setModel(this._data.getPatternID());
      this.iconTool.setModel(this._data.getClaspIconArtID());
   }
   function onSelectionMenuClose(event)
   {
      this.hideSelectionMenu();
   }
   function onSelectionChange(event)
   {
      var _loc3_ = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
      var _loc2_ = event.data;
      switch(event.dataType)
      {
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.COLOUR:
            _loc3_.setColourIndex(_loc2_);
            var _loc6_ = this._coverCrumbs.getHighlightByColourID(_loc2_);
            var _loc4_ = _loc6_[0];
            _loc3_.setHighlightIndex(_loc4_);
            this.highlightTool.setModel(_loc4_);
            break;
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.HIGHLIGHT:
            _loc3_.setHighlightIndex(_loc2_);
            this.highlightTool.setModel(_loc2_);
            break;
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.PATTERN:
            _loc2_ = _loc2_ != _loc3_.getPatternIndex()?_loc2_:undefined;
            _loc3_.setPatternIndex(_loc2_);
            this.patternTool.setModel(_loc2_);
            break;
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.ICON:
            _loc3_.setIconIndex(_loc2_);
            this.iconTool.setModel(_loc2_);
      }
      this.hideSelectionMenu();
      this.dispatchEvent({type:"change",data:_loc2_,dataType:event.dataType});
   }
   function onCategorySelectorPress(event)
   {
      if(this._editing)
      {
         this.hideSelectionMenu();
      }
      if(!this._changingCategory)
      {
         if(!this.categorySelectorTier1)
         {
            this.categorySelectorTier1 = (com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu)this.categoryMenuHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE,com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE,this.categoryMenuHolder.getNextHighestDepth(),{includeAllCategoriesButton:true,includeBlankTopSpace:true});
            this.categorySelectorTier1.addEventListener("onItemPress",this.onCategorySelected,this);
            this.categorySelectorTier1.addEventListener("showMenu",this.showSubCategories,this);
         }
         this.categorySelectorTier1.setModel(this._masterList);
         this.categorySelectorTier1._x = com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_TIER1_X;
         this.categorySelectorTier1._y = com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_TIER1_Y;
         this._changingCategory = !this._changingCategory;
      }
      else
      {
         this.hideCategorySelector();
      }
      this.categoryMenuHolder.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.TOP_LEVEL);
      this.colourTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
      this.highlightTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
      this.patternTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
      this.iconTool.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
   }
   function onCategorySelected(event)
   {
      var _loc2_ = event.data;
      var _loc3_ = !_loc2_.getID()?com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID:_loc2_.getID();
      this.specificCategoryBG._visible = _loc3_ != com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID?true:false;
      this.specificCategoryArrow._visible = _loc3_ != com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID?true:false;
      this.categorySelectorBtn.setModel(_loc2_);
      com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance().setCategorySelected(_loc3_);
      this.dispatchEvent({type:"filter",data:_loc2_});
      this.hideCategorySelector();
   }
   function showSubCategories(event)
   {
      var _loc2_ = event.data;
      if(_loc2_.length <= 0)
      {
         this.categorySelectorTier2._x = -1000;
         this.categorySelectorTier2._y = -1000;
         return undefined;
      }
      if(!this.categorySelectorTier2)
      {
         this.categorySelectorTier2 = (com.clubpenguin.stamps.stampbook.controls.CategorySelectorMenu)this.categoryMenuHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE,com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_LINKAGE + 1,this.categoryMenuHolder.getNextHighestDepth());
         this.categorySelectorTier2.addEventListener("onItemPress",this.onCategorySelected,this);
      }
      var _loc4_ = (MovieClip)event.target;
      var _loc5_ = (MovieClip)event.currentTarget;
      this.categorySelectorTier2.setModel(_loc2_);
      this.categorySelectorTier2._x = this.categorySelectorTier1._x + this.categorySelectorTier1._width - com.clubpenguin.stamps.stampbook.controls.ToolBar.CATEGORY_SELECTOR_MENU_OFFSET;
      this.categorySelectorTier2._y = _loc4_._y + _loc5_._y;
   }
   function onToolItemPressed(event)
   {
      var _loc2_ = event.target;
      var _loc4_ = undefined;
      var _loc3_ = undefined;
      this.selectionMenu.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.BOTTOM_LEVEL);
      switch(_loc2_)
      {
         case this.colourTool:
            _loc4_ = com.clubpenguin.stamps.stampbook.controls.ToolBar.COLOUR;
            _loc3_ = this._coverCrumbs.colour;
            break;
         case this.highlightTool:
            _loc4_ = com.clubpenguin.stamps.stampbook.controls.ToolBar.HIGHLIGHT;
            _loc3_ = this._coverCrumbs.getHighlightByColourID(com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance().getColourIndex());
            break;
         case this.patternTool:
            _loc4_ = com.clubpenguin.stamps.stampbook.controls.ToolBar.PATTERN;
            _loc3_ = this._coverCrumbs.pattern;
            break;
         case this.iconTool:
            _loc4_ = com.clubpenguin.stamps.stampbook.controls.ToolBar.ICON;
            _loc3_ = this._coverCrumbs.clasp;
      }
      if(this._changingCategory)
      {
         this.hideCategorySelector();
      }
      if(!this._editing)
      {
         this.selectionMenu._x = com.clubpenguin.stamps.stampbook.controls.ToolBar.SELECTION_MENU_X;
         this.selectionMenu._y = _loc2_._y - com.clubpenguin.stamps.stampbook.controls.ToolBar.TOOLBAR_BTN_HEIGHT / 2;
         this.selectionMenu.setType(_loc4_);
         this.selectionMenu.setModel(_loc3_);
         this.selectionMenu._visible = true;
         this._editing = true;
         this._currentBtnPressed = _loc2_;
      }
      else if(this._editing && _loc2_ != this._currentBtnPressed)
      {
         this.selectionMenu._x = com.clubpenguin.stamps.stampbook.controls.ToolBar.SELECTION_MENU_X;
         this.selectionMenu._y = _loc2_._y - com.clubpenguin.stamps.stampbook.controls.ToolBar.TOOLBAR_BTN_HEIGHT / 2;
         this.selectionMenu.setType(_loc4_);
         this.selectionMenu.setModel(_loc3_);
         this._currentBtnPressed = _loc2_;
      }
      else if(this._editing)
      {
         this.hideSelectionMenu();
      }
      _loc2_.swapDepths(com.clubpenguin.stamps.stampbook.controls.ToolBar.TOP_LEVEL);
   }
   function hideSelectionMenu()
   {
      this.selectionMenu._visible = false;
      this._editing = false;
      this._currentBtnPressed = null;
   }
   function hideCategorySelector()
   {
      this.categorySelectorTier1._x = -1000;
      this.categorySelectorTier1._y = -1000;
      this.categorySelectorTier2._x = -1000;
      this.categorySelectorTier2._y = -1000;
      this._changingCategory = false;
   }
}
