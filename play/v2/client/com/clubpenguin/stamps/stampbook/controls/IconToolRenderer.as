class com.clubpenguin.stamps.stampbook.controls.IconToolRenderer extends com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.IconToolRenderer;
   static var LINKAGE_ID = "IconToolRenderer";
   function IconToolRenderer()
   {
      super();
      com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance().addEventListener("highlightChange",this.handleChange,this);
   }
   function setModel(data)
   {
      this._data = String(data);
      if(this._initialized)
      {
         this.populateUI();
      }
   }
   function handleChange(event)
   {
      if(event.highlight)
      {
         this.setHighlight(event.highlight);
      }
   }
   function configUI()
   {
      this.loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      this.highlightLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      super.configUI();
   }
   function setHighlight(highlightIndex)
   {
      var _loc2_ = this._shell.getPath("stampbook_claspHighlightThumb");
      if(this.highlightHolder.clip)
      {
         this.highlightHolder.clip.removeMovieClip();
      }
      this.highlightHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
      this.highlightLoader.loadClip(_loc2_ + highlightIndex + ".swf",this.highlightHolder.clip);
   }
   function populateUI()
   {
      var _loc2_ = this._shell.getPath("stampbook_claspThumb");
      if(this.placeHolder.clip)
      {
         this.placeHolder.clip.removeMovieClip();
      }
      this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
      this.loader.loadClip(_loc2_ + this._data + ".swf",this.placeHolder.clip);
   }
}
