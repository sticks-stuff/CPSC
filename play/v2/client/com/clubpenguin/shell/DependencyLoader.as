class com.clubpenguin.shell.DependencyLoader extends com.clubpenguin.util.EventDispatcher
{
   var currentID = "";
   var currentIndex = -1;
   var baseURL = "";
   static var COMPLETE = "complete";
   static var PROGRESS = "progress";
   static var DEPENDENCY_FILE_EXTENSTION = ".swf";
   function DependencyLoader(baseURL, container)
   {
      super();
      if(baseURL == undefined)
      {
         throw new Error("DependencyLoader -> baseURL is undefined! baseURL:" + baseURL);
      }
      else if(!container)
      {
         throw new Error("DependencyLoader -> container is not set! container:" + container);
      }
      else
      {
         this.baseURL = baseURL;
         this.container = container;
      }
   }
   function load(dependencies)
   {
      if(!dependencies.length)
      {
         throw new Error("DependencyLoader.load -> dependencies array is not defined! dependencies: " + dependencies);
      }
      else
      {
         this.dependencies = dependencies.concat();
         this.currentIndex = 0;
         this.loadDependency(dependencies[this.currentIndex]);
      }
   }
   function loadDependency(dependency)
   {
      this.currentID = dependency.id;
      if(this.container[this.currentID] != undefined)
      {
         this.container[this.currentID].removeMovieClip();
      }
      var _loc4_ = this.container.createEmptyMovieClip(this.currentID,this.container.getNextHighestDepth());
      var _loc3_ = dependency.folder || "";
      var _loc5_ = com.clubpenguin.util.URLUtils.getCacheResetURL(this.baseURL + _loc3_ + this.currentID + com.clubpenguin.shell.DependencyLoader.DEPENDENCY_FILE_EXTENSTION);
      var _loc2_ = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      _loc2_.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT,com.clubpenguin.util.Delegate.create(this,this.onLoadInit));
      _loc2_.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS,com.clubpenguin.util.Delegate.create(this,this.onLoadProgress));
      _loc2_.loadClip(_loc5_,_loc4_);
   }
   function onLoadInit(event)
   {
      if(this.currentIndex >= this.dependencies.length - 1)
      {
         this.updateListeners(com.clubpenguin.shell.DependencyLoader.COMPLETE);
         return undefined;
      }
      this.currentIndex = this.currentIndex + 1;
      this.loadDependency(this.dependencies[this.currentIndex]);
   }
   function onLoadProgress(event)
   {
      event.dependencyTitle = this.dependencies[this.currentIndex].title;
      this.updateListeners(com.clubpenguin.shell.DependencyLoader.PROGRESS,event);
   }
}
