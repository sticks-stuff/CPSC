class com.clubpenguin.hybrid.AS3MovieClipLoader
{
   var __instance = null;
   var __loadInterval = null;
   var __initFunction = null;
   var __loadClip = null;
   var __path = null;
   var __host = null;
   var __iterations = null;
   var __trace = null;
   var __options = null;
   var __useIterations = null;
   var __skipLoadChecking = null;
   var __startFunction = null;
   var __progressFunction = null;
   var __errorFunction = null;
   static var INTERVAL_RATE = 10;
   static var TIME_OUT_THRESHOLD = 200;
   static var MIN_ITERATIONS = 20;
   static var MIN_BYTES = 4;
   static var AS3_ERROR = "AS3_error";
   function AS3MovieClipLoader(host, load_clip, path, init_function, start_function, progress_function, error_function, options)
   {
      this.__host = host;
      this.__loadClip = load_clip;
      this.__path = path;
      this.__options = options;
      this.__useIterations = this.__options.useIterations == undefined?false:this.__options.useIterations;
      this.__skipLoadChecking = this.__options.skipLoadChecking == undefined?false:this.__options.skipLoadChecking;
      this.__initFunction = init_function;
      this.__startFunction = start_function == undefined?null:start_function;
      this.__progressFunction = progress_function == undefined?null:progress_function;
      this.__errorFunction = error_function == undefined?null:error_function;
      this.init();
   }
   function init()
   {
      this.__trace = com.clubpenguin.hybrid.TraceOutput.getInstance();
      this.__iterations = 0;
      this.__instance = this;
      this.__loadClip.unloadMovie();
      this.__loadClip.loadMovie(this.__path);
      if(!this.__skipLoadChecking)
      {
         this.__loadInterval = setInterval(this.__instance,"checkLoadProgress",com.clubpenguin.hybrid.AS3MovieClipLoader.INTERVAL_RATE);
      }
      if(this.__startFunction != null)
      {
         this.__startFunction(this.__loadClip);
      }
   }
   function checkLoadProgress()
   {
      this.__iterations = this.__iterations + 1;
      var _loc4_ = this.__loadClip.getBytesLoaded();
      var _loc2_ = this.__loadClip.getBytesTotal();
      var _loc3_ = false;
      if(this.__useIterations)
      {
         _loc3_ = !(_loc4_ == _loc2_ && (_loc2_ > com.clubpenguin.hybrid.AS3MovieClipLoader.MIN_BYTES || this.__iterations > com.clubpenguin.hybrid.AS3MovieClipLoader.MIN_ITERATIONS))?false:true;
      }
      else
      {
         _loc3_ = !(_loc4_ == _loc2_ && _loc2_ > 4)?false:true;
      }
      if(this.__progressFunction != null)
      {
         this.__progressFunction(this.__loadClip,_loc4_,_loc2_);
      }
      if(_loc3_)
      {
         this.stopLoadListening();
      }
      if(!this.__useIterations && this.__iterations >= com.clubpenguin.hybrid.AS3MovieClipLoader.TIME_OUT_THRESHOLD)
      {
         clearInterval(this.__loadInterval);
         var _loc5_ = "Could not load: " + this.__path;
         if(this.__errorFunction != null)
         {
            this.__errorFunction(this.__loadClip);
         }
         throw new Error("Time out error, AS3MovieClipLodaer exceeded its iteration limit checking for: " + this.__path);
      }
   }
   function stopLoadListening()
   {
      clearInterval(this.__loadInterval);
      this.__initFunction(this.__loadClip);
   }
}
