class com.clubpenguin.mail.Postcard
{
   static var RAW_POSTCARD_SEPARATOR = "|";
   function Postcard(senderName, senderID, typeID, details, date, ID)
   {
      this.senderName = senderName;
      this.senderID = senderID;
      this._typeID = typeID;
      this.details = details;
      this.date = date;
      this.ID = ID;
      this.read = false;
   }
   function __get__typeID()
   {
      return this._typeID;
   }
   static function getPostcardFromRawString(rawPostcardString)
   {
      var _loc1_ = rawPostcardString.split(com.clubpenguin.mail.Postcard.RAW_POSTCARD_SEPARATOR);
      return com.clubpenguin.mail.Postcard.getPostCardFromRawArray(_loc1_);
   }
   static function getPostCardFromRawArray(rawPostCardArray)
   {
      var _loc2_ = new com.clubpenguin.mail.Postcard(String(rawPostCardArray[0]),Number(rawPostCardArray[1]),Number(rawPostCardArray[2]),String(rawPostCardArray[3]),Number(rawPostCardArray[4]),Number(rawPostCardArray[5]));
      return _loc2_;
   }
}
