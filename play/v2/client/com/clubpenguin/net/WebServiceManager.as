class com.clubpenguin.net.WebServiceManager extends com.clubpenguin.util.EventDispatcher
{
   var debugTracesEnabled = true;
   static var EVENT_INIT_COMPLETE = "initComplete";
   function WebServiceManager()
   {
      super();
      this._shell = _global.getCurrentShell();
      this._isLoading = false;
   }
   function getServiceData(type)
   {
      var _loc2_ = this._servicesData[type.__get__name()];
      if(_loc2_ == null)
      {
         this._shell.$e("[WebCrumbsManager] getServiceData could not find a loaded crumb object for \'" + type + "\'");
      }
      return _loc2_;
   }
   function init()
   {
      if(this._isLoading)
      {
         this._shell.$e("[WebCrumbsManager] Initialization called while init already in progress.");
         return undefined;
      }
      this._isLoading = true;
      this._arrServicesToLoad = com.clubpenguin.net.WebServiceType.getServiceTypes();
      this._jsonLoader = new com.clubpenguin.util.JSONLoader();
      this._jsonLoader.addEventListener(com.clubpenguin.util.JSONLoader.COMPLETE,this.onJsonLoadCompleteHandler,this);
      this._jsonLoader.addEventListener(com.clubpenguin.util.JSONLoader.FAIL,this.onJsonLoadFailHandler,this);
      this._servicesData = {};
      this.loadNextService();
   }
   function loadNextService()
   {
      if(this._arrServicesToLoad.length == 0)
      {
         this._jsonLoader.removeEventListener(com.clubpenguin.util.JSONLoader.COMPLETE,this.onJsonLoadCompleteHandler,this);
         this._jsonLoader.removeEventListener(com.clubpenguin.util.JSONLoader.FAIL,this.onJsonLoadFailHandler,this);
         this.dispatchEvent({type:com.clubpenguin.net.WebServiceManager.EVENT_INIT_COMPLETE,target:this});
         return undefined;
      }
      this._loadingServiceType = (com.clubpenguin.net.WebServiceType)this._arrServicesToLoad.shift();
      var _loc2_ = "";
      if(this._loadingServiceType.__get__isLocalized())
      {
         _loc2_ = this._shell.getWebService().url + this._shell.getLanguageAbbreviation() + "/" + this._loadingServiceType.__get__webServiceCrumbPath();
      }
      else
      {
         _loc2_ = this._shell.getWebService().url + this._loadingServiceType.__get__webServiceCrumbPath();
      }
      this.debugTrace("Loading crumb from web service: Name=" + this._loadingServiceType + " url=" + _loc2_);
      this._jsonLoader.load(_loc2_);
   }
   function onJsonLoadCompleteHandler(event)
   {
      var _loc2_ = this._jsonLoader.data;
      if(_loc2_ == null)
      {
         this._shell.$e("[WebCrumbsManager] Failed to load crumbs json: " + this._loadingServiceType);
      }
      else
      {
         this._servicesData[this._loadingServiceType.__get__name()] = _loc2_;
      }
      this._loadingServiceType = null;
      this.loadNextService();
   }
   function onJsonLoadFailHandler()
   {
      this._shell.$e("[WebCrumbsManager] Failed to load crumbs json: " + this._loadingServiceType);
      this._loadingServiceType = null;
      this.loadNextService();
   }
   function debugTrace(msg)
   {
      if(!this.debugTracesEnabled)
      {
      }
   }
}
