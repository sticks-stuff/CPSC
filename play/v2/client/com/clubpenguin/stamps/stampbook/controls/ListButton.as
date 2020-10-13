class com.clubpenguin.stamps.stampbook.controls.ListButton extends MovieClip
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ListButton;
   static var LINKAGE_ID = "ListButton";
   static var ROLLOVER_ALPHA = 100;
   static var ROLLOUT_ALPHA = 50;
   static var ROLLOVER_COLOR = 3355443;
   static var ROLLOUT_COLOR = 6184542;
   static var PADDING = 10;
   function ListButton()
   {
      super();
      com.clubpenguin.util.EventDispatcher.initialize(this);
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
   }
   function onLoad()
   {
      this.configUI();
   }
   function populateUI()
   {
      this.stampIconLoader.loadClip(this._filePath + this._model.getID() + ".swf",this.load_mc);
      this.label_field.text = this._model.getName();
      this.label_field.autoSize = "left";
      this.btnHitArea._width = this.label_field._x + this.label_field._width + com.clubpenguin.stamps.stampbook.controls.ListButton.PADDING;
      this.label_field.textColor = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_COLOR;
   }
   function setModel(model)
   {
      this._model = model;
      if(this._initialized)
      {
         this.populateUI();
      }
   }
   function configUI()
   {
      this._filePath = this._shell.getPath("stampbook_category");
      this.stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onLoadInit));
      this.load_mc = this.stampIconHolder.createEmptyMovieClip("load_mc",this.stampIconHolder.getNextHighestDepth());
      this._initialized = true;
      if(this._model != null)
      {
         this.populateUI();
      }
   }
   function onLoadInit(event)
   {
      var _loc1_ = event.target;
      _loc1_.btnIcon._alpha = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_ALPHA;
   }
   function onRollOver()
   {
      var _loc2_ = this.load_mc.btnIcon;
      _loc2_._alpha = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOVER_ALPHA;
      this.label_field.textColor = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOVER_COLOR;
      this.dispatchEvent({type:"over"});
   }
   function onRollOut()
   {
      var _loc2_ = this.load_mc.btnIcon;
      _loc2_._alpha = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_ALPHA;
      this.label_field.textColor = com.clubpenguin.stamps.stampbook.controls.ListButton.ROLLOUT_COLOR;
      this.dispatchEvent({type:"out"});
   }
   function onPress()
   {
      this.dispatchEvent({type:"press",data:this._model});
   }
   function onRelease()
   {
      this.dispatchEvent({type:"release",data:this._model});
   }
}
