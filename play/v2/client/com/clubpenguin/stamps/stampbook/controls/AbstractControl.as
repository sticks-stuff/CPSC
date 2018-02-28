class com.clubpenguin.stamps.stampbook.controls.AbstractControl extends MovieClip
{
   var _initialized = false;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.AbstractControl;
   static var LINKAGE_ID = "AbstractControl";
   static var BLANK_CLIP_LINKAGE_ID = "Blank";
   function AbstractControl()
   {
      super();
      com.clubpenguin.util.EventDispatcher.initialize(this);
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
   }
   function onLoad()
   {
      this.configUI();
   }
   function setModel(data)
   {
      this._data = data;
      if(this._initialized)
      {
         this.populateUI();
      }
   }
   function configUI()
   {
      this._initialized = true;
      if(this._data != null)
      {
         this.populateUI();
      }
   }
   function populateUI()
   {
   }
}
