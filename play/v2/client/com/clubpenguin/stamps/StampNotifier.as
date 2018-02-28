class com.clubpenguin.stamps.StampNotifier
{
   function StampNotifier(shell)
   {
      this._shell = shell;
      this._queue = [];
      this._stampEarnedAnimationDone = true;
      this._pauseNotification = false;
      this._shell.addListener(this._shell.STAMP_EARNED_ANIM_DONE,this.handleStampEarnedAnimationDone,this);
   }
   function destroy()
   {
      delete this._queue;
      this._shell.removeListener(this._shell.STAMP_EARNED_ANIM_DONE,this.handleStampEarnedAnimationDone);
   }
   function __set___interface(interfacer)
   {
      this.__interface = interfacer;
      return this.__get___interface();
   }
   function add(stamp)
   {
      this._queue.push(stamp);
      this.showStampEarnedAnimation();
   }
   function __set__pauseNotification(pause)
   {
      this._pauseNotification = pause;
      if(!this._pauseNotification)
      {
         this.showStampEarnedAnimation();
      }
      return this.__get__pauseNotification();
   }
   function handleStampEarnedAnimationDone()
   {
      this._stampEarnedAnimationDone = true;
      this.showStampEarnedAnimation();
   }
   function showStampEarnedAnimation()
   {
      if(!this._pauseNotification && this._queue.length > 0 && this._stampEarnedAnimationDone)
      {
         var _loc2_ = (com.clubpenguin.stamps.IStampItem)this._queue.shift();
         this._stampEarnedAnimationDone = false;
         this.__interface.animateStampEarned(_loc2_.getMainCategoryID(),_loc2_.getDifficulty(),_loc2_.getName());
      }
   }
}
