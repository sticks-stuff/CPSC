class com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer extends MovieClip
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer;
   static var LINKAGE_ID = "CategorySelectorRenderer";
   static var ICON_SCALE_OVER = 105;
   static var ICON_SCALE_OUT = 70;
   static var STAMP_ICON_WIDTH = 22;
   static var PADDING = 5;
   static var PADDING_MULTIPLIER = 4;
   static var CATEGORY_SELECTED_ALPHA = 50;
   function CategorySelectorRenderer()
   {
      super();
      com.clubpenguin.util.EventDispatcher.initialize(this);
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
      this._stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
   }
   function onLoad()
   {
   }
   function __get__data()
   {
      return this._data;
   }
   function __set__data(value)
   {
      this._data = value;
      this.setText();
      this.setIcon();
      return this.__get__data();
   }
   function setText(value)
   {
      this._categoryID = !this._data.getID()?com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID:this._data.getID();
      var _loc2_ = this._shell.getLocalizedString(this._categoryID != com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID?this._data.getName():"all_stamps_category_title");
      this.labelField.text = _loc2_;
      if(this._stampLookUp.isCategorySelected(this._categoryID))
      {
         this.labelField._alpha = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.CATEGORY_SELECTED_ALPHA;
      }
      this.labelField._width = this.labelField.textWidth + com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING;
      this.arrow._x = this.labelField._x + this.labelField._width + com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING;
      this.bg._width = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.STAMP_ICON_WIDTH + this.labelField._width + this.arrow._width + com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING * com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING_MULTIPLIER;
      this.arrow._visible = this._data.getSubCategories().length <= 0?false:true;
   }
   function setIcon()
   {
      this.stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.stampIconLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onLoadInit));
      this.load_mc = this.stampIconHolder.createEmptyMovieClip("load_mc",this.stampIconHolder.getNextHighestDepth());
      var _loc2_ = this._shell.getPath("stampbook_category");
      this.stampIconLoader.loadClip(_loc2_ + this._categoryID + ".swf",this.load_mc);
   }
   function onLoadInit(event)
   {
      this.load_mc._xscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
      this.load_mc._yscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
   }
   function setHeight(h)
   {
      this._rendererHeight = h;
      this.bg._height = this._rendererHeight;
   }
   function setWidth(w)
   {
      this._rendererWidth = w;
      this.arrow._x = this._rendererWidth - com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.PADDING - this.arrow._width;
      this.bg._width = this._rendererWidth;
   }
   function onPress()
   {
      this.dispatchEvent({type:"onPress",data:this._data});
   }
   function onRollOver()
   {
      this.load_mc._xscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OVER;
      this.load_mc._yscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OVER;
      this.dispatchEvent({type:"onRollOver",data:this._data});
   }
   function onRollOut()
   {
      this.load_mc._xscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
      this.load_mc._yscale = com.clubpenguin.stamps.stampbook.controls.CategorySelectorRenderer.ICON_SCALE_OUT;
      this.dispatchEvent({type:"onRollOut",data:this._data});
   }
}
