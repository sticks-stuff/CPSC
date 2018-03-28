class com.clubpenguin.util.Stamp
{
   static var debug = false;
   static var stamps = new Object();
   function Stamp()
   {
   }
   static function sendStamp($id)
   {
      if(com.clubpenguin.util.Stamp.debug)
      {
         com.clubpenguin.util.Stamp.stamps[$id] = true;
      }
      else
      {
         var _loc7_ = _global.getCurrentShell();
         _loc7_.stampEarned($id);
      }
   }
   static function checkStamp($id)
   {
      var _loc8_ = undefined;
      if(com.clubpenguin.util.Stamp.debug)
      {
         if(com.clubpenguin.util.Stamp.stamps[$id])
         {
            return true;
         }
         return false;
      }
      var _loc7_ = _global.getCurrentShell();
      _loc8_ = _loc7_.stampIsOwnedByMe($id);
      return _loc8_;
   }
   static function setDebug(mode)
   {
      com.clubpenguin.util.Stamp.debug = mode;
   }
   static function getDebug()
   {
      return com.clubpenguin.util.Stamp.debug;
   }
   static function clearStamps()
   {
      com.clubpenguin.util.Stamp.stamps = new Object();
   }
   static function setStamps(new_stamps)
   {
      for(var _loc8_ in new_stamps)
      {
         var _loc7_ = new_stamps[_loc8_];
         com.clubpenguin.util.Stamp.stamps[_loc7_] = true;
      }
   }
}
