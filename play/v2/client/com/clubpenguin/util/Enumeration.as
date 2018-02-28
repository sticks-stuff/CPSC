class com.clubpenguin.util.Enumeration
{
   function Enumeration(value_p)
   {
      var _loc2_ = this.__constructor__;
      if(value_p == null)
      {
         this._value = _loc2_.__enumCount != null?_loc2_.__enumCount = _loc2_.__enumCount + 1:_loc2_.__enumCount = 0;
      }
      else
      {
         this._value = value_p;
         if(_loc2_.__enumCount == null || value_p > _loc2_.__enumCount)
         {
            _loc2_.__enumCount = value_p;
         }
      }
   }
   function __get__name()
   {
      for(var _loc2_ in this.__constructor__)
      {
         if(this == this.__constructor__[_loc2_])
         {
            return _loc2_;
         }
      }
      return null;
   }
   function __get__value()
   {
      return this._value;
   }
}
