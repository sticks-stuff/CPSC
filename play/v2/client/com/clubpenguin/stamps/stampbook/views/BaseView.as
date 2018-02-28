class com.clubpenguin.stamps.stampbook.views.BaseView extends MovieClip
{
   var _initialized = false;
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.BaseView;
   static var LINKAGE_ID = "BaseView";
   function BaseView()
   {
      super();
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
      com.clubpenguin.util.EventDispatcher.initialize(this);
   }
   function onLoad()
   {
      this.configUI();
   }
   function reset()
   {
   }
   function cleanUp()
   {
   }
   function setModel(_model)
   {
      this._model = _model;
      if(this._initialized)
      {
         this.populateUI();
      }
   }
   function configUI()
   {
      this._initialized = true;
      if(this._model != null)
      {
         this.populateUI();
      }
   }
   function populateUI()
   {
   }
}
