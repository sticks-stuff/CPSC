class com.clubpenguin.stamps.stampbook.views.StampbookCoverView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
   var _toggleEditControls = false;
   var _editMode = false;
   var _isDragging = false;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.StampbookCoverView;
   static var LINKAGE_ID = "StampbookCoverView";
   static var BLANK_CLIP_LINKAGE_ID = "Blank";
   static var INVALID_ID = -1;
   static var ITEM_RENDERER = "BaseItemRenderer";
   static var ROTATION_VALUE = 15;
   static var ACTIVE_RENDERER = 100;
   static var INACTIVE_RENDERER = 50;
   static var PADDING = 10;
   static var MAX_ROTATION = 360;
   static var DROPSHADOW_DISTANCE = 4;
   static var DROPSHADOW_ANGLE = 45;
   static var DROPSHADOW_COLOR = 0;
   static var DROPSHADOW_ALPHA = 0.4;
   static var DROPSHADOW_BLUR_X = 10;
   static var DROPSHADOW_BLUR_Y = 10;
   static var DROPSHADOW_STRENGTH = 2;
   static var DROPSHADOW_QUALITY = 3;
   static var STAMP_BOOK_ITEM_ART_SCALE = 150;
   function StampbookCoverView()
   {
      super();
      this._stampManager = this._shell.getStampManager();
      this._coverCrumbs = this._stampManager.stampBookCoverCrumbs;
      this._colourPath = this._shell.getPath("stampbook_colour");
      this._patternPath = this._shell.getPath("stampbook_pattern");
      this._highlightPath = this._shell.getPath("stampbook_highlight");
      this._iconPath = this._shell.getPath("stampbook_clasp");
      this._wordmarkPath = this._shell.getPath("stampbook_wordmark");
   }
   function __get__toggleEditControls()
   {
      return this._toggleEditControls;
   }
   function __set__toggleEditControls(value)
   {
      if(this._toggleEditControls == value)
      {
         return undefined;
      }
      this._toggleEditControls = value;
      if(this._initialized)
      {
         this.toggleEditMode();
      }
      return this.__get__toggleEditControls();
   }
   function __set__closeStampBookFunction(fcn)
   {
      this._closeStampBookFunction = fcn;
      this.closeClip.onRelease = this._closeStampBookFunction;
      return this.__get__closeStampBookFunction();
   }
   function cleanUp()
   {
      this.clasp.removeEventListener("press",this.onClaspClicked,this);
      this.save_btn.removeEventListener("release",this.onSaveStampbookCover,this);
      this.edit_btn.removeEventListener("release",this.onEditStampbookCover,this);
      this.toolBar.removeEventListener("change",this.onCoverSettingChange,this);
      this.toolBar.removeEventListener("filter",this.onFilterByCategory,this);
      this.coverList.removeEventListener("itemPress",this.onItemPressed,this);
      this.closeClip.removeEventListener("release",this._closeStampBookFunction,this);
   }
   function configUI()
   {
      this._renderers = [];
      this.colourLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.colourLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,com.clubpenguin.util.Delegate.create(this,this.onLoadError));
      this.patternLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.patternLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,com.clubpenguin.util.Delegate.create(this,this.onLoadError));
      this.highlightClaspLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.highlightClaspLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,com.clubpenguin.util.Delegate.create(this,this.onLoadError));
      this.iconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.iconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,com.clubpenguin.util.Delegate.create(this,this.onLoadError));
      this.wordmarkLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.wordmarkLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onLoadInit));
      this.wordmarkLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,com.clubpenguin.util.Delegate.create(this,this.onLoadError));
      this.removeDropArea.gotoAndStop(this._shell.getLanguageAbbreviation());
      this._dropShadowFilter = new flash.filters.DropShadowFilter(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_DISTANCE,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_ANGLE,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_COLOR,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_ALPHA,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_BLUR_X,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_BLUR_Y,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_STRENGTH,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.DROPSHADOW_QUALITY);
      this.stageRect = new flash.geom.Rectangle(this.stageArea._x + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.PADDING,this.stageArea._y + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.PADDING,this.stageArea._width,this.stageArea._height);
      this.claspRect = new flash.geom.Rectangle(this.clasp._x,this.clasp._y,this.clasp._width,this.clasp._height);
      this.dropAreaRect = new flash.geom.Rectangle(this.removeDropArea._x,this.removeDropArea._y,this.removeDropArea._width,this.removeDropArea._height);
      this.coverList._visible = false;
      this.removeDropArea._visible = false;
      super.configUI();
   }
   function onClaspClicked()
   {
      this.dispatchEvent({type:"claspClicked"});
   }
   function onFilterByCategory(event)
   {
      this._selectedCategory = event.data;
      this.coverList.reset();
      this.coverList.dataProvider = this._stampLookUp.getStampsForCategory(this._selectedCategory);
   }
   function attachClipToHolderClip(holderClip)
   {
      if(holderClip.clip)
      {
         holderClip.clip.removeMovieClip();
      }
      holderClip.attachMovie(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
   }
   function populateUI()
   {
      var _loc8_ = this._model.getColourID();
      var _loc10_ = this._model.getPatternID();
      var _loc7_ = this._model.getHighlightID();
      var _loc9_ = this._model.getClaspIconArtID();
      var _loc11_ = this._coverCrumbs.getLogoByColourID(_loc8_);
      var _loc12_ = this._coverCrumbs.getTextHighlightByHighlightID(_loc7_);
      this._stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
      this._masterList = this._stampLookUp.getMasterList();
      this.toolBar.setModel(this._model);
      this._selectedCategory = this._masterList;
      this.coverList.dataProvider = this._stampLookUp.getStampsForCategory(this._selectedCategory);
      if(_loc8_ != undefined && _loc8_ != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
      {
         this.attachClipToHolderClip(this.colourLoaderHolder);
         this.colourLoader.loadClip(this._colourPath + _loc8_ + ".swf",this.colourLoaderHolder.clip);
      }
      if(_loc10_ != undefined && _loc10_ != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
      {
         this.attachClipToHolderClip(this.patternLoaderHolder);
         this.patternLoader.loadClip(this._patternPath + _loc10_ + ".swf",this.patternLoaderHolder.clip);
      }
      if(_loc7_ != undefined && _loc7_ != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
      {
         this.attachClipToHolderClip(this.highlightClaspLoaderHolder);
         this.highlightClaspLoader.loadClip(this._highlightPath + _loc7_ + ".swf",this.highlightClaspLoaderHolder.clip);
      }
      if(_loc9_ != undefined && _loc9_ != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
      {
         this.attachClipToHolderClip(this.iconLoaderHolder);
         this.iconLoader.loadClip(this._iconPath + _loc9_ + ".swf",this.iconLoaderHolder.clip);
      }
      if(_loc11_ != undefined && _loc11_ != com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INVALID_ID)
      {
         this.attachClipToHolderClip(this.wordmarkLoaderHolder);
         this.wordmarkLoader.loadClip(this._wordmarkPath + _loc11_ + ".swf",this.wordmarkLoaderHolder.clip);
      }
      this.penguinName.__set__colorValue(_loc12_);
      this.penguinName.__set__label(this._stampLookUp.getPlayerNickname());
      this.penguinStamps._x = this.penguinName._x + this.penguinName._width;
      this.penguinStamps._x = this.penguinName._y + this.penguinName._height - com.clubpenguin.stamps.stampbook.views.StampbookCoverView.PADDING;
      this.penguinStamps.__set__colorValue(_loc12_);
      var _loc13_ = this._shell.getLocalizedString("total_stamps");
      this.penguinStamps.__set__label(this._shell.replace_m(_loc13_,[this._stampLookUp.getNumberOfUserStamps(),this._stampLookUp.getNumberOfTotalStampsForCategory(this._masterList)]));
      this.nameRect = new flash.geom.Rectangle(this.penguinName._x,this.penguinName._y,this.penguinName._width,this.penguinName._height);
      var _loc5_ = this._model.getCoverItems();
      var _loc6_ = _loc5_.length;
      var _loc4_ = 0;
      while(_loc4_ < _loc6_)
      {
         var _loc3_ = _loc5_[_loc4_];
         var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer)this.stampsHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ITEM_RENDERER,"coverRenderer" + _loc4_,_loc3_.getItemDepth());
         _loc2_.addEventListener("loadInit",this.onStampLoaded,this);
         _loc2_.addEventListener("press",this.onStampPressed,this);
         _loc2_.setScale(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE);
         _loc2_.move(_loc3_.getItemPosition().x,_loc3_.getItemPosition().y);
         _loc2_._rotation = _loc3_.getItemRotation();
         _loc2_.setModel(_loc3_.getItem());
         _loc2_.hitArea_mc._visible = false;
         this._renderers.push(_loc2_);
         _loc4_ = _loc4_ + 1;
      }
      this.clasp.addEventListener("press",this.onClaspClicked,this);
      this.save_btn.addEventListener("release",this.onSaveStampbookCover,this);
      this.edit_btn.addEventListener("release",this.onEditStampbookCover,this);
      this.toolBar.addEventListener("change",this.onCoverSettingChange,this);
      this.toolBar.addEventListener("filter",this.onFilterByCategory,this);
      this.coverList.addEventListener("itemPress",this.onItemPressed,this);
      this.toggleEditMode();
   }
   function onLoadError(event)
   {
   }
   function onLoadInit(event)
   {
      var _loc3_ = event.target;
      if(_loc3_ == this.wordmarkLoaderHolder)
      {
         if(!this.stampRect)
         {
            var _loc2_ = _loc3_._parent;
            this.stampRect = new flash.geom.Rectangle(_loc2_._x - (_loc2_._width >> 1),_loc2_._y - (_loc2_._height >> 1),_loc2_._width,_loc2_._height);
         }
      }
   }
   function onItemPressed(event)
   {
      if(this.toolBar.__get__changingCategory())
      {
         this.toolBar.closeCategorySelector();
         return undefined;
      }
      var _loc5_ = this._renderers.length;
      if(_loc5_ >= com.clubpenguin.stamps.StampManager.MAX_STAMPBOOK_COVER_ITEMS)
      {
         this._shell.$e("[stampbookCoverView] onItemPressed() You cant have more than " + com.clubpenguin.stamps.StampManager.MAX_STAMPBOOK_COVER_ITEMS + " items on your cover! ",{error_code:this._shell.MAX_STAMPBOOK_COVER_ITEMS});
         return undefined;
      }
      var _loc3_ = (com.clubpenguin.stamps.IStampBookItem)event.data;
      var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer)this.stampsHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ITEM_RENDERER,"coverRendererNew" + new Date().getTime(),this.stampsHolder.getNextHighestDepth());
      _loc2_.setScale(com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE,com.clubpenguin.stamps.stampbook.views.StampbookCoverView.STAMP_BOOK_ITEM_ART_SCALE);
      _loc2_.move(this._xmouse,this._ymouse);
      _loc2_.setModel(_loc3_);
      this._renderers.push(_loc2_);
      this._stampLookUp.addStampToCover(_loc3_.getID());
      this.coverList.dataProvider = this._stampLookUp.getStampsForCategory(this._selectedCategory);
      var _loc4_ = {type:"press",data:_loc3_,target:_loc2_,newStamp:true};
      this.onStampPressed(_loc4_);
   }
   function onCoverSettingChange(event)
   {
      var _loc3_ = undefined;
      var _loc2_ = event.data;
      switch(event.dataType)
      {
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.COLOUR:
            this.attachClipToHolderClip(this.colourLoaderHolder);
            this.colourLoader.loadClip(this._colourPath + _loc2_ + ".swf",this.colourLoaderHolder.clip);
            var _loc4_ = this._coverCrumbs.getHighlightByColourID(_loc2_);
            _loc3_ = this._coverCrumbs.getTextHighlightByHighlightID(_loc4_[0]);
            this.penguinName.__set__colorValue(_loc3_);
            this.penguinStamps.__set__colorValue(_loc3_);
            this.attachClipToHolderClip(this.highlightClaspLoaderHolder);
            this.highlightClaspLoader.loadClip(this._highlightPath + _loc4_[0] + ".swf",this.highlightClaspLoaderHolder.clip);
            var _loc5_ = this._coverCrumbs.getLogoByColourID(_loc2_);
            this.attachClipToHolderClip(this.wordmarkLoaderHolder);
            this.wordmarkLoader.loadClip(this._wordmarkPath + _loc5_ + ".swf",this.wordmarkLoaderHolder.clip);
            break;
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.HIGHLIGHT:
            _loc3_ = this._coverCrumbs.getTextHighlightByHighlightID(_loc2_);
            this.penguinName.__set__colorValue(_loc3_);
            this.penguinStamps.__set__colorValue(_loc3_);
            this.attachClipToHolderClip(this.highlightClaspLoaderHolder);
            this.highlightClaspLoader.loadClip(this._highlightPath + _loc2_ + ".swf",this.highlightClaspLoaderHolder.clip);
            break;
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.PATTERN:
            if(_loc2_ == undefined)
            {
               this.patternLoaderHolder._visible = false;
               break;
            }
            this.attachClipToHolderClip(this.patternLoaderHolder);
            this.patternLoader.loadClip(this._patternPath + _loc2_ + ".swf",this.patternLoaderHolder.clip);
            this.patternLoaderHolder._visible = true;
            break;
         case com.clubpenguin.stamps.stampbook.controls.ToolBar.ICON:
            this.attachClipToHolderClip(this.iconLoaderHolder);
            this.iconLoader.loadClip(this._iconPath + _loc2_ + ".swf",this.iconLoaderHolder.clip);
      }
   }
   function onStampLoaded(event)
   {
      var _loc3_ = (com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer)event.target;
      var _loc2_ = new flash.geom.Rectangle(_loc3_._x - _loc3_._width / 2,_loc3_._y - _loc3_._height / 2,_loc3_._width,_loc3_._height);
      var _loc4_ = !this.intersects(_loc3_,_loc2_);
      if(!_loc4_)
      {
         _loc3_.move(Math.min(Math.max(_loc2_.x + _loc2_.width / 2,this.stageRect.x + _loc2_.width / 2),this.stageRect.width - _loc2_.width),Math.min(Math.max(_loc2_.y + _loc2_.height / 2,this.stageRect.y + _loc2_.height / 2),this.stageRect.height - _loc2_.height));
      }
   }
   function onStampPressed(event)
   {
      if(this.toolBar.__get__changingCategory())
      {
         this.toolBar.closeCategorySelector();
         return undefined;
      }
      var _loc3_ = (com.clubpenguin.stamps.IStampBookItem)event.data;
      this._currentID = _loc3_.getID();
      this._currentTarget = (com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer)event.target;
      this._currentTarget.hideShadow();
      this._currentTarget.swapDepths(this.stampsHolder.getNextHighestDepth());
      this._currentTarget.removeEventListener("press",this.onStampPressed,this);
      this._currentTarget.filters = [this._dropShadowFilter];
      this._mousexOffset = Math.round(this._xmouse - this._currentTarget._x);
      this._mouseyOffset = Math.round(this._ymouse - this._currentTarget._y);
      this._lastxPosition = Math.round(this._currentTarget._x);
      this._lastyPosition = Math.round(this._currentTarget._y);
      if(event.newStamp)
      {
         this._lastxPosition = Math.round(this._currentTarget._x);
         this._lastyPosition = Math.round(this.stageRect.y + (this._currentTarget._height >> 1));
      }
      Key.addListener(this);
      this.removeDropArea._visible = true;
      this._currentTarget.addEventListener("mouseMove",this.handleDrag,this);
      this._currentTarget.addEventListener("mouseUp",this.handleClick,this);
      this._currentTarget.hitArea_mc._visible = true;
   }
   function intersects(sourceMc, sourceRect)
   {
      var _loc8_ = !this.stageRect.containsRectangle(sourceRect) || this.clasp.hitTest(sourceMc) || this.penguinName.hitTest(sourceMc) || this.wordmarkLoaderHolder.hitTest(sourceMc) || this.penguinStamps.hitTest(sourceMc) || this.closeClip.hitTest(sourceMc);
      if(!_loc8_)
      {
         var _loc7_ = this._renderers.length;
         var _loc2_ = 0;
         while(_loc2_ < _loc7_)
         {
            var _loc3_ = (com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer)this._renderers[_loc2_];
            var _loc4_ = (com.clubpenguin.stamps.IStampBookItem)_loc3_.__get__data();
            var _loc5_ = (com.clubpenguin.stamps.IStampBookItem)sourceMc.data;
            if(_loc4_.getID() != _loc5_.getID() && _loc3_.hitTest(sourceMc))
            {
               return true;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      return true;
   }
   function onKeyDown()
   {
      var _loc2_ = Key.getCode();
      switch(_loc2_)
      {
         case 39:
            this._currentTarget._rotation = this._currentTarget._rotation + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ROTATION_VALUE;
            this._currentTarget._rotation = this._currentTarget._rotation % com.clubpenguin.stamps.stampbook.views.StampbookCoverView.MAX_ROTATION;
            break;
         case 37:
            this._currentTarget._rotation = this._currentTarget._rotation - com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ROTATION_VALUE;
            this._currentTarget._rotation = this._currentTarget._rotation % com.clubpenguin.stamps.stampbook.views.StampbookCoverView.MAX_ROTATION;
      }
   }
   function handleDrag(event)
   {
      this._currentTarget._x = Math.round(this._xmouse - this._mousexOffset);
      this._currentTarget._y = Math.round(this._ymouse - this._mouseyOffset);
      this.rect = new flash.geom.Rectangle(this._currentTarget._x - this._currentTarget._width / 2,this._currentTarget._y - this._currentTarget._height / 2,this._currentTarget._width,this._currentTarget._height);
      this._isPlaceableOnCover = !this.intersects(this._currentTarget,this.rect);
      this._removeStamp = this.dropAreaRect.intersects(this.rect);
      if(this._isPlaceableOnCover || this._removeStamp)
      {
         this._currentTarget._alpha = com.clubpenguin.stamps.stampbook.views.StampbookCoverView.ACTIVE_RENDERER;
      }
      else if(!this._removeStamp)
      {
         this._currentTarget._alpha = com.clubpenguin.stamps.stampbook.views.StampbookCoverView.INACTIVE_RENDERER;
      }
      if(!this._isDragging)
      {
         this._currentTarget.removeEventListener("mouseUp",this.handleClick,this);
         this._currentTarget.addEventListener("mouseUp",this.handleDrop,this);
      }
      this._isDragging = true;
      this._currentTarget.hitArea._visible = true;
   }
   function handleDrop()
   {
      this._isDragging = false;
      Key.removeListener(this);
      this._currentTarget.hitArea_mc._visible = false;
      if(this._removeStamp || !this._isPlaceableOnCover)
      {
         var _loc2_ = this.indexOf(this._renderers,this._currentTarget);
         this._renderers.splice(_loc2_,1);
         this._currentTarget.removeMovieClip();
         this._stampLookUp.removeStampFromCover(this._currentID);
         this.coverList.dataProvider = this._stampLookUp.getStampsForCategory(this._selectedCategory);
      }
      else
      {
         this._lastxPosition = Math.round(this._currentTarget._x);
         this._lastyPosition = Math.round(this._currentTarget._y);
      }
      this.removeDropArea._visible = false;
      this._currentTarget.filters = [];
      this._currentTarget.showShadow();
      this._currentTarget.removeEventListener("mouseMove",this.handleDrag,this);
      this._currentTarget.removeEventListener("mouseUp",this.handleDrop,this);
      this._currentTarget.removeEventListener("press",this.handleDrop,this);
      this._currentTarget.addEventListener("press",this.onStampPressed,this);
   }
   function indexOf(array, searchElement)
   {
      var _loc2_ = array.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc2_)
      {
         if(array[_loc1_] == searchElement)
         {
            return _loc1_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return -1;
   }
   function handleClick()
   {
      this._currentTarget.removeEventListener("mouseUp",this.handleClick,this);
      this._currentTarget.addEventListener("press",this.handleDrop,this);
   }
   function toggleEditMode()
   {
      if(this._toggleEditControls)
      {
         if(this._editMode)
         {
            this.showEditControls();
         }
         else
         {
            this.hideEditControls();
         }
      }
      else
      {
         this.closeEditControls();
      }
   }
   function closeEditControls()
   {
      this.hideEditControls();
      this.edit_btn._visible = false;
   }
   function showEditControls()
   {
      this.edit_btn._visible = false;
      this.help_btn._visible = false;
      this.save_btn._visible = true;
      this.editBackground._visible = true;
      this.background._visible = false;
      this.toolBar._visible = true;
      this.coverList._visible = true;
      this.clasp.enabled = false;
      this.enableStampInteraction(true);
   }
   function hideEditControls()
   {
      this.edit_btn._visible = true;
      this.help_btn._visible = false;
      this.save_btn._visible = false;
      this.editBackground._visible = false;
      this.background._visible = true;
      this.toolBar._visible = false;
      this.coverList._visible = false;
      this.clasp.enabled = true;
      this.enableStampInteraction(false);
   }
   function enableStampInteraction(value)
   {
      var _loc5_ = this._renderers.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         var _loc2_ = this._renderers[_loc3_];
         _loc2_.enabled = value;
         _loc2_.useHandCursor = value;
         if(value)
         {
            _loc2_.addEventListener("press",this.onStampPressed,this);
         }
         else
         {
            _loc2_.removeEventListener("press",this.onStampPressed,this);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function onEditStampbookCover(event)
   {
      this._editMode = true;
      this.toggleEditMode();
   }
   function onSaveStampbookCover(event)
   {
      if(this.toolBar.__get__changingCategory())
      {
         this.toolBar.closeCategorySelector();
         return undefined;
      }
      this._editMode = false;
      var _loc11_ = com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance();
      var _loc10_ = _loc11_.getPatternIndex();
      if(_loc10_ == undefined || isNaN(_loc10_))
      {
         _loc10_ = com.clubpenguin.stamps.StampManager.COVER_PATTERN_NONE_ID;
      }
      this._model.setColourID(_loc11_.getColourIndex());
      this._model.setPatternID(_loc10_);
      this._model.setHighlightID(_loc11_.getHighlightIndex());
      this._model.setClaspIconArtID(_loc11_.getIconIndex());
      var _loc9_ = [];
      var _loc4_ = 0;
      while(_loc4_ < this._renderers.length)
      {
         var _loc2_ = (com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer)this._renderers[_loc4_];
         var _loc6_ = (com.clubpenguin.stamps.IStampBookItem)_loc2_.__get__data();
         var _loc3_ = _loc2_._rotation;
         var _loc7_ = Math.round(_loc2_._x);
         var _loc5_ = Math.round(_loc2_._y);
         if(_loc3_ < 0)
         {
            _loc3_ = _loc3_ + com.clubpenguin.stamps.stampbook.views.StampbookCoverView.MAX_ROTATION;
         }
         var _loc8_ = new com.clubpenguin.stamps.StampBookCoverItem(_loc6_,new flash.geom.Point(_loc7_,_loc5_),_loc3_,_loc2_.getDepth());
         _loc9_.push(_loc8_);
         _loc4_ = _loc4_ + 1;
      }
      this._model.setCoverItems(_loc9_);
      this._stampManager.saveMyStampBookCover((com.clubpenguin.stamps.IStampBookCover)this._model);
      this.toggleEditMode();
   }
}
