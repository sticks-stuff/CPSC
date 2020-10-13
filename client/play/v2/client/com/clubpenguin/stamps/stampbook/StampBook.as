class com.clubpenguin.stamps.stampbook.StampBook extends MovieClip
{
   static var STAMPBOOK_COVER_VIEW_CLIP_NAME = "stampBookCoverView";
   static var RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME = "recentlyEarnedStampsView";
   static var INSIDE_PAGES_VIEW_CLIP_NAME = "insidePagesView";
   static var OOPS_MESSAGE_TRACKING = "?oops_stampbook_";
   static var _isFirstView = true;
   function StampBook()
   {
      super();
      com.clubpenguin.stamps.stampbook.util.ShellLookUp.__set__shell(com.clubpenguin.stamps.stampbook.StampBook.SHELL);
      this._visible = false;
      this.configUI();
   }
   function configUI()
   {
      if(com.clubpenguin.stamps.stampbook.StampBook.SHELL == undefined || com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER == undefined || com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER == undefined || com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id == undefined)
      {
         return undefined;
      }
      this._recentlyEarnedList = [];
      this._isMyStampBook = com.clubpenguin.stamps.stampbook.StampBook.SHELL.isMyPlayer(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
      this._insidePagesViewClip = this.attachMovie("InsidePagesView",com.clubpenguin.stamps.stampbook.StampBook.INSIDE_PAGES_VIEW_CLIP_NAME,this.getNextHighestDepth());
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMP_BOOK_CATEGORIES,this.handleGetPlayersStampBookCategories,this);
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.STAMP_BOOK_COVER_DETAILS,this.handleGetStampBookCoverDetails,this);
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMPS,this.handleGetPlayersStamps,this);
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.showLoading(com.clubpenguin.stamps.stampbook.StampBook.SHELL.getLocalizedString("Loading Content"));
      com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getPlayersStampBookCategories(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
   }
   function handleGetPlayersStampBookCategories(stampCategories)
   {
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMP_BOOK_CATEGORIES,this.handleGetPlayersStampBookCategories,this);
      this._categoryList = stampCategories;
      com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getStampBookCoverDetails(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
   }
   function handleGetStampBookCoverDetails(stampBookCover)
   {
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.STAMP_BOOK_COVER_DETAILS,this.handleGetStampBookCoverDetails,this);
      this._coverStamps = stampBookCover;
      com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getPlayersStamps(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id);
   }
   function handleGetPlayersStamps(stampsList)
   {
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.PLAYERS_STAMPS,this.handleGetPlayersStamps,this);
      this._userStampsList = stampsList;
      com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance().initialize(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER,this._categoryList,this._userStampsList,this._coverStamps,com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER);
      this._stampBookCoverViewClip = this.attachMovie("StampbookCoverView",com.clubpenguin.stamps.stampbook.StampBook.STAMPBOOK_COVER_VIEW_CLIP_NAME,this.getNextHighestDepth());
      if(this._isMyStampBook)
      {
         com.clubpenguin.stamps.stampbook.StampBook.SHELL.addListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.MY_RECENTLY_EARNED_STAMPS,this.handleGetMyRecentlyEarnedStamps,this);
         com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getMyRecentlyEarnedStamps();
      }
      else
      {
         this.drawUI();
      }
   }
   function handleGetMyRecentlyEarnedStamps(stampsList)
   {
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.removeListener(com.clubpenguin.stamps.stampbook.StampBook.SHELL.MY_RECENTLY_EARNED_STAMPS,this.handleGetMyRecentlyEarnedStamps,this);
      this._recentlyEarnedList = stampsList;
      this.drawUI();
   }
   function drawUI()
   {
      this.stampbookCoverView._visible = true;
      this.stampbookCoverView = (com.clubpenguin.stamps.stampbook.views.StampbookCoverView)this._stampBookCoverViewClip;
      this.stampbookCoverView.addEventListener("claspClicked",this.onContinueToInsidePages,this);
      this.stampbookCoverView.setModel(this._coverStamps);
      this.stampbookCoverView.__set__closeStampBookFunction(mx.utils.Delegate.create(this,this.handleCloseStampBook));
      this.stampbookCoverView.__set__toggleEditControls(!(this._isMyStampBook && com.clubpenguin.stamps.stampbook.StampBook.SHELL.isPlayerMemberById(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id))?false:true);
      if(this._recentlyEarnedList.length > 0)
      {
         this.recentlyEarnedView = (com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView)this.attachMovie("RecentlyEarnedStampsView",com.clubpenguin.stamps.stampbook.StampBook.RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME,this.getNextHighestDepth());
         this.recentlyEarnedView.setModel(this._recentlyEarnedList);
         this.recentlyEarnedView.addEventListener("close",this.onCloseRecentlyEarnedView,this);
         this.recentlyEarnedView._x = Stage.width - this.recentlyEarnedView.getWidth() >> 1;
         this.recentlyEarnedView._y = Stage.height - this.recentlyEarnedView.getHeight() >> 1;
      }
      this.insidePagesView = (com.clubpenguin.stamps.stampbook.views.InsidePagesView)this._insidePagesViewClip;
      this.insidePagesView.addEventListener("close",this.onGoBackToCover,this);
      this.insidePagesView.addEventListener("closeStampBook",this.handleCloseStampBook,this);
      this.insidePagesView._visible = false;
      this.onEnterFrame = function()
      {
         if(this._stampBookCoverViewClip._width > 0 && this._insidePagesViewClip._width > 0)
         {
            if(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id == com.clubpenguin.stamps.stampbook.StampBook.SHELL.getMyPlayerId() && com.clubpenguin.stamps.stampbook.StampBook._isFirstView && !com.clubpenguin.stamps.stampbook.StampBook.SHELL.isPlayerMemberById(com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER.player_id) && com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER.getHasModifiedStampCover())
            {
               com.clubpenguin.stamps.stampbook.StampBook._isFirstView = false;
               var _loc3_ = com.clubpenguin.stamps.stampbook.StampBook.SHELL.getPath("stampbook_cover_storage");
               this._storagePromptHolder = this.createEmptyMovieClip("_storagePromptHolder",this.getNextHighestDepth());
               var _loc2_ = new com.clubpenguin.hybrid.HybridMovieClipLoader();
               _loc2_.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,mx.utils.Delegate.create(this,this.onStoragePromptLoaded));
               _loc2_.loadClip(_loc3_,this._storagePromptHolder);
            }
            else
            {
               com.clubpenguin.stamps.stampbook.StampBook.SHELL.hideLoading();
               this._visible = true;
            }
            delete this.onEnterFrame;
         }
      };
   }
   function onStoragePromptLoaded(event)
   {
      var _loc2_ = event.target;
      _loc2_.blocker_mc.tabEnabled = false;
      _loc2_.blocker_mc.onPress = null;
      _loc2_.blocker_mc.useHandCursor = false;
      _loc2_.screen_mc.close_btn.onRelease = mx.utils.Delegate.create(this,this.onStoragePromptClose);
      _loc2_.screen_mc.buy_btn.onRelease = mx.utils.Delegate.create(this,this.onStoragePromptBuy);
      com.clubpenguin.stamps.stampbook.StampBook.SHELL.hideLoading();
      this._visible = true;
   }
   function onStoragePromptClose()
   {
      this._storagePromptHolder.removeMovieClip();
   }
   function onStoragePromptBuy()
   {
      this._storagePromptHolder.removeMovieClip();
      this.getURL(com.clubpenguin.stamps.stampbook.StampBook.SHELL.getPath("member_web") + com.clubpenguin.stamps.stampbook.StampBook.OOPS_MESSAGE_TRACKING + com.clubpenguin.stamps.stampbook.StampBook.SHELL.getLanguageAbbriviation(),"_blank");
   }
   function onContinueToInsidePages(event)
   {
      this.stampbookCoverView._visible = false;
      this.insidePagesView.setModel(this._categoryList);
      this.insidePagesView._visible = true;
   }
   function onGoBackToCover(event)
   {
      this.insidePagesView._visible = false;
      this.stampbookCoverView._visible = true;
   }
   function onCloseRecentlyEarnedView(event)
   {
      this.recentlyEarnedView._visible = false;
   }
   function handleCloseStampBook()
   {
      this._parent._root.close();
   }
   function cleanUp()
   {
      this.insidePagesView.removeEventListener("close",this.onGoBackToCover,this);
      this.insidePagesView.removeEventListener("closeStampBook",this.handleCloseStampBook,this);
      this.stampbookCoverView.removeEventListener("claspClicked",this.onContinueToInsidePages,this);
      if(this._recentlyEarnedList.length > 0)
      {
         this[com.clubpenguin.stamps.stampbook.StampBook.RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME].removeMovieClip();
         this.recentlyEarnedView.removeEventListener("close",this.onCloseRecentlyEarnedView,this);
      }
      this.recentlyEarnedView.cleanUp();
      this.stampbookCoverView.cleanUp();
      this.insidePagesView.cleanUp();
      this._stampBookCoverViewClip.removeMovieClip();
      this._insidePagesViewClip.removeMovieClip();
   }
   static function __set__shell(clip)
   {
      com.clubpenguin.stamps.stampbook.StampBook.SHELL = clip;
      return com.clubpenguin.stamps.stampbook.StampBook.__get__shell();
   }
   static function __set__stampManager(manager)
   {
      com.clubpenguin.stamps.stampbook.StampBook.STAMP_MANAGER = manager;
      return com.clubpenguin.stamps.stampbook.StampBook.__get__stampManager();
   }
   static function __set__activePlayer(activePlayerObj)
   {
      com.clubpenguin.stamps.stampbook.StampBook.ACTIVE_PLAYER = activePlayerObj;
      return com.clubpenguin.stamps.stampbook.StampBook.__get__activePlayer();
   }
}
