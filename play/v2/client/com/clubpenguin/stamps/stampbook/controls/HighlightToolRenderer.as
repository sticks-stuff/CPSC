class com.clubpenguin.stamps.stampbook.controls.HighlightToolRenderer extends com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.HighlightToolRenderer;
   static var LINKAGE_ID = "HighlightToolRenderer";
   function HighlightToolRenderer()
   {
      super();
   }
   function configUI()
   {
      this.loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      super.configUI();
   }
   function setModel(data)
   {
      this._data = String(data);
      if(this._initialized)
      {
         this.populateUI();
      }
   }
   function populateUI()
   {
      var _loc2_ = this._shell.getPath("stampbook_highlightThumb");
      if(this.placeHolder.clip)
      {
         this.placeHolder.clip.removeMovieClip();
      }
      this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
      this.loader.loadClip(_loc2_ + this._data + ".swf",this.placeHolder.clip);
   }
}
