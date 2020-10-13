class com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer extends com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer;
   static var LINKAGE_ID = "RecentlyEarnedRenderer";
   function RecentlyEarnedRenderer()
   {
      super();
      this._stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
      this._filePath = this._shell.getPath("stampbook_stamps");
   }
   function setModel(data)
   {
      this._data = data;
      if(!this._initialized)
      {
         this.configUI();
      }
      this.load();
   }
}
