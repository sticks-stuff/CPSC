class com.clubpenguin.util.Delegate
{
   function Delegate()
   {
   }
   static function create(target, handler)
   {
      var _loc2_ = function()
      {
         var _loc2_ = arguments.callee;
         var _loc3_ = arguments.concat(_loc2_.initArgs);
         return _loc2_.handler.apply(_loc2_.target,_loc3_);
      };
      _loc2_.target = target;
      _loc2_.handler = handler;
      _loc2_.initArgs = arguments.slice(2);
      return _loc2_;
   }
}
