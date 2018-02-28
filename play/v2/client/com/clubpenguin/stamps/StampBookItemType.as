class com.clubpenguin.stamps.StampBookItemType extends com.clubpenguin.util.Enumeration
{
   static var STAMP = new com.clubpenguin.stamps.StampBookItemType("stamp");
   static var PIN = new com.clubpenguin.stamps.StampBookItemType("pin");
   static var AWARD = new com.clubpenguin.stamps.StampBookItemType("award");
   static var POLAROID = new com.clubpenguin.stamps.StampBookItemType("polaroid");
   function StampBookItemType(type)
   {
      super();
      this.type = type;
   }
   function toString()
   {
      return "[StampBookItemType type=\"" + this.type + "\"]";
   }
}
