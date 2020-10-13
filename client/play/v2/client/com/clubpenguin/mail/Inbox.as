class com.clubpenguin.mail.Inbox
{
   function Inbox()
   {
      this.postCards = [];
   }
   function addPostCard(postCard)
   {
      this.postCards.push(postCard);
   }
   function getPostCardsByTypeID(typeID)
   {
      var _loc3_ = undefined;
      var _loc4_ = [];
      var _loc2_ = 0;
      while(_loc2_ < this.postCards.length)
      {
         _loc3_ = this.postCards[_loc2_];
         if(_loc3_.__get__typeID() == typeID)
         {
            _loc4_.push(_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   static function getInboxFromRawArray(rawInbox)
   {
      var _loc3_ = new com.clubpenguin.mail.Inbox();
      var _loc1_ = 0;
      while(_loc1_ < rawInbox.length)
      {
         _loc3_.addPostCard(com.clubpenguin.mail.Postcard.getPostcardFromRawString(rawInbox[_loc1_]));
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
}
