class com.clubpenguin.stamps.stampbook.controls.PatternToolRenderer extends com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.PatternToolRenderer;
   static var LINKAGE_ID = "PatternToolRenderer";
   static var RENDERER_WIDTH = 64;
   static var RENDERER_HEIGHT = 46;
   static var INVALID_STAMP_ID = -1;
   function PatternToolRenderer()
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
      this._data = Number(data);
      if(this._data == com.clubpenguin.stamps.stampbook.controls.PatternToolRenderer.INVALID_STAMP_ID || this._data == undefined || isNaN(this._data))
      {
         if(this.load_mc)
         {
            this.load_mc._visible = false;
         }
         return undefined;
      }
      if(this._initialized)
      {
         this.populateUI();
         this.load_mc._visible = true;
      }
   }
   function populateUI()
   {
      if(this._data == com.clubpenguin.stamps.stampbook.controls.PatternToolRenderer.INVALID_STAMP_ID || this._data == undefined || isNaN(this._data))
      {
         return undefined;
      }
      var _loc2_ = this._shell.getPath("stampbook_patternThumb");
      if(this.placeHolder.clip)
      {
         this.placeHolder.clip.removeMovieClip();
      }
      this.load_mc = this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
      this.loader.loadClip(_loc2_ + this._data + ".swf",this.load_mc);
   }
}
