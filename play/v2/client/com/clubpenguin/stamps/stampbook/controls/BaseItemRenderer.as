class com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer extends MovieClip
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer;
   static var LINKAGE_ID = "BaseItemRenderer";
   static var BLANK_CLIP_LINKAGE_ID = "Blank";
   static var DROPSHADOW_ALPHA = 30;
   function BaseItemRenderer()
   {
      super();
      com.clubpenguin.util.EventDispatcher.initialize(this);
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
   }
   function onLoad()
   {
      this.configUI();
   }
   function __get__data()
   {
      return this._data;
   }
   function setModel(data)
   {
      this._data = data;
      if(!this._initialized)
      {
         this.configUI();
      }
      this._filePath = this.getPath(this._data.getType());
      this.load();
   }
   function showShadow()
   {
      this._iconHolderClip.stamp.shadow._visible = true;
   }
   function hideShadow()
   {
      this._iconHolderClip.stamp.shadow._visible = false;
   }
   function setScale(scaleX, scaleY)
   {
      this._scaleX = scaleX;
      this._scaleY = scaleY;
   }
   function move(x, y)
   {
      this._x = x;
      this._y = y;
   }
   function getPath(type)
   {
      var _loc2_ = undefined;
      switch(type)
      {
         case com.clubpenguin.stamps.StampBookItemType.STAMP:
            _loc2_ = this._shell.getPath("stampbook_stamps");
            break;
         case com.clubpenguin.stamps.StampBookItemType.AWARD:
         case com.clubpenguin.stamps.StampBookItemType.PIN:
            _loc2_ = this._shell.getPath("clothing_icons");
      }
      return _loc2_;
   }
   function configUI()
   {
      this.loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onLoadInit));
      this.loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR,com.clubpenguin.util.Delegate.create(this,this.onLoadError));
      this._initialized = true;
   }
   function load()
   {
      this.loader_mc.gotoAndStop("loading");
      if(this._data)
      {
         var _loc2_ = this._data.getID();
         if(this._data.getType() == com.clubpenguin.stamps.StampBookItemType.AWARD)
         {
            _loc2_ = com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[this._data.getID()];
         }
         if(this._iconHolderClip)
         {
            this._iconHolderClip.removeMovieClip();
         }
         this._iconHolderClip = this.attachMovie(com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer.BLANK_CLIP_LINKAGE_ID,"iconHolderClip",1,{_x:0,_y:0});
         this._iconHolderClip._xscale = this._scaleX;
         this._iconHolderClip._yscale = this._scaleY;
         this.loader.loadClip(this._filePath + _loc2_ + ".swf",this._iconHolderClip);
      }
   }
   function onLoadInit(event)
   {
      var _loc2_ = event.target;
      this.enabled = true;
      _loc2_._parent.loader_mc.gotoAndStop("complete");
      if(_loc2_.stamp)
      {
         _loc2_.stamp.shadow._alpha = com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer.DROPSHADOW_ALPHA;
      }
      if(_loc2_.hitArea_mc)
      {
         this.hitArea = _loc2_.hitArea_mc;
         _loc2_.hitArea_mc._alpha = 0;
      }
      this.dispatchEvent({type:"loadInit"});
   }
   function onLoadError(event)
   {
      var _loc2_ = event.target;
      _loc2_._parent._parent.loader_mc.gotoAndStop("loading");
      this.enabled = false;
      this.dispatchEvent({type:"loadError"});
   }
   function onMouseMove()
   {
      this.dispatchEvent({type:"mouseMove"});
   }
   function onMouseUp()
   {
      this.dispatchEvent({type:"mouseUp"});
   }
   function onMouseDown()
   {
      this.dispatchEvent({type:"mouseDown"});
   }
   function onPress()
   {
      this.dispatchEvent({type:"press",data:this._data});
   }
   function onRelease()
   {
      this.dispatchEvent({type:"release"});
   }
   function onRollOver()
   {
      this.dispatchEvent({type:"over",data:this._data});
   }
   function onRollOut()
   {
      this.dispatchEvent({type:"out"});
   }
}
