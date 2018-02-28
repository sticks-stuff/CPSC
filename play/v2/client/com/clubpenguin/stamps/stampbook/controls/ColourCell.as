class com.clubpenguin.stamps.stampbook.controls.ColourCell extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
   var ignoreChanges = false;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ColourCell;
   static var LINKAGE_ID = "ColourCell";
   static var RENDERER_WIDTH = 64;
   static var RENDERER_HEIGHT = 46;
   function ColourCell()
   {
      super();
      com.clubpenguin.stamps.stampbook.util.ColorHelper.getInstance().addEventListener("colorChange",this.handleChange,this);
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
      if(!this.ignoreChanges)
      {
         this.setModel(event.colour);
      }
   }
   function configUI()
   {
      this._filePath = this._shell.getPath("stampbook_colourThumb");
      this.loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      super.configUI();
   }
   function populateUI()
   {
      if(this.placeHolder.clip)
      {
         this.placeHolder.clip.removeMovieClip();
      }
      this.placeHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.AbstractControl.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
      this.loader.loadClip(this._filePath + this._data + ".swf",this.placeHolder.clip);
   }
}
