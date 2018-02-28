class com.clubpenguin.util.QueryParams
{
   function QueryParams()
   {
   }
   static function getQueryParams(testingQueryString)
   {
      var _loc8_ = undefined;
      if(testingQueryString)
      {
         _loc8_ = testingQueryString;
      }
      else
      {
         _loc8_ = String(flash.external.ExternalInterface.call("parent.window.location.search.substring",1));
      }
      var _loc7_ = {};
      var _loc6_ = _loc8_.split("&");
      var _loc3_ = 0;
      var _loc2_ = -1;
      while(_loc3_ < _loc6_.length)
      {
         var _loc1_ = _loc6_[_loc3_];
         if((_loc2_ = _loc1_.indexOf("=")) > 0)
         {
            var _loc4_ = _loc1_.substring(0,_loc2_);
            _loc4_.toLowerCase();
            var _loc5_ = _loc1_.substring(_loc2_ + 1);
            _loc7_[_loc4_] = _loc5_;
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc7_;
   }
}
