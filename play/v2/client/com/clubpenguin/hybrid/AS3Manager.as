class com.clubpenguin.hybrid.AS3Manager
{
   static var isRunningUnderAS3 = _level0 != undefined?false:true;
   static var isRunningUnderAS2 = _level0 != undefined?true:false;
   function AS3Manager()
   {
   }
   static function isUnderAS3()
   {
      return com.clubpenguin.hybrid.AS3Manager.isRunningUnderAS3;
   }
   static function isUnderAS2()
   {
      return com.clubpenguin.hybrid.AS3Manager.isRunningUnderAS2;
   }
}
