class com.clubpenguin.stamps.stampbook.controls.ToolBarStampRenderer extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ToolBarStampRenderer;
   static var LINKAGE_ID = "ToolBarStampRenderer";
   function ToolBarStampRenderer()
   {
      super();
   }
   function onPress()
   {
      this.dispatchEvent({type:"press"});
   }
   function configUI()
   {
      this._filePath = this._shell.getPath("stampbook_categoryHeader");
      this.stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      super.configUI();
   }
   function populateUI()
   {
      var _loc2_ = !this._data.getID()?com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID:this._data.getID();
      var _loc3_ = com.clubpenguin.stamps.StampManager.ALL_CATEGORY_ID;
      this.specificCategoryBG._visible = _loc2_ != _loc3_?true:false;
      this.allStampsLabel.text = _loc2_ != _loc3_?"":this._shell.getLocalizedString("all_stamps_category_title");
      this.allStampsLabel._visible = _loc2_ != _loc3_?false:true;
      this.specificCategoryLabel.text = _loc2_ != _loc3_?this._data.getName():"";
      this.specificCategoryLabel._visible = _loc2_ != _loc3_?true:false;
      this.specificCategoryLabelShadow.text = _loc2_ != _loc3_?this._data.getName():"";
      this.specificCategoryLabelShadow._visible = _loc2_ != _loc3_?true:false;
      if(this._iconHolderClip)
      {
         this._iconHolderClip.removeMovieClip();
      }
      this._iconHolderClip = this.stampIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID,"iconHolderClip",1,{_x:0,_y:0});
      this.stampIconLoader.loadClip(this._filePath + _loc2_ + ".swf",this._iconHolderClip);
   }
}
