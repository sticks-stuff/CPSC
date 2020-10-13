class com.clubpenguin.shell.Music
{
   var currentURL = "";
   var isMuted = false;
   function Music(container)
   {
      this.container = container;
   }
   function playMusicURL(url)
   {
      if(this.isMuted || url == this.currentURL)
      {
         return false;
      }
      if(url.length)
      {
         this.musicClip = this.container.createEmptyMovieClip("music",0);
         this.currentURL = url;
         var _loc3_ = com.clubpenguin.util.URLUtils.getCacheResetURL(url);
         this.musicClip.loadMovie(_loc3_);
         return true;
      }
      this.stopMusic();
      return false;
   }
   function stopMusic()
   {
      if(!this.currentURL.length)
      {
         return false;
      }
      this.musicClip.removeMovieClip();
      this.currentURL = "";
      return true;
   }
   function muteMusic()
   {
      this.isMuted = true;
      this.stopMusic();
   }
   function unMuteMusic()
   {
      this.isMuted = false;
   }
   function isMusicMuted()
   {
      return this.isMuted;
   }
}
