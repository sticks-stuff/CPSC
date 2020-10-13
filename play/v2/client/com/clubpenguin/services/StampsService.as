class com.clubpenguin.services.StampsService extends com.clubpenguin.services.AbstractService
{
   static var STAMPS_HANDLER = "st#";
   static var SEND_STAMP_EARNED = "sse";
   static var GET_PLAYERS_STAMPS = "gps";
   static var GET_MY_RECENTLY_EARNED_STAMPS = "gmres";
   static var GET_STAMP_BOOK_COVER_DETAILS = "gsbcd";
   static var SET_STAMP_BOOK_COVER_DETAILS = "ssbcd";
   static var RECEIVE_STAMP_EARNED = "aabs";
   function StampsService(connection)
   {
      super(connection);
      this._playersStampsReceived = new org.osflash.signals.Signal(Array);
      this._recentlyEarnedStampsReceived = new org.osflash.signals.Signal(Array);
      this._playersStampBookCoverDetailsReceived = new org.osflash.signals.Signal(Array);
      this._playerEarnedStampReceived = new org.osflash.signals.Signal(Array);
      connection.getResponded().add(this.onResponded,this);
   }
   function __get__playersStampsReceived()
   {
      return this._playersStampsReceived;
   }
   function __get__recentlyEarnedStampsReceived()
   {
      return this._recentlyEarnedStampsReceived;
   }
   function __get__playersStampBookCoverDetailsReceived()
   {
      return this._playersStampBookCoverDetailsReceived;
   }
   function __get__playerEarnedStampReceived()
   {
      return this._playerEarnedStampReceived;
   }
   function onResponded(responseType, responseData)
   {
      switch(responseType)
      {
         case com.clubpenguin.services.StampsService.GET_PLAYERS_STAMPS:
            this._playersStampsReceived.dispatch(responseData);
            break;
         case com.clubpenguin.services.StampsService.GET_MY_RECENTLY_EARNED_STAMPS:
            this._recentlyEarnedStampsReceived.dispatch(responseData);
            break;
         case com.clubpenguin.services.StampsService.GET_STAMP_BOOK_COVER_DETAILS:
            this._playersStampBookCoverDetailsReceived.dispatch(responseData);
            break;
         case com.clubpenguin.services.StampsService.RECEIVE_STAMP_EARNED:
            this._playerEarnedStampReceived.dispatch(responseData);
         default:
            return undefined;
      }
   }
   function sendStampEarned(stampID)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.SEND_STAMP_EARNED,[stampID],this.messageFormat,-1);
      return this._recentlyEarnedStampsReceived;
   }
   function getPlayersStamps(playerID)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.GET_PLAYERS_STAMPS,[playerID],this.messageFormat,-1);
      return this._playersStampsReceived;
   }
   function getMyRecentlyEarnedStamps()
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.GET_MY_RECENTLY_EARNED_STAMPS,[],this.messageFormat,-1);
      return this._recentlyEarnedStampsReceived;
   }
   function getStampBookCoverDetails(playerID)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.GET_STAMP_BOOK_COVER_DETAILS,[playerID],this.messageFormat,-1);
      return this._playersStampBookCoverDetailsReceived;
   }
   function setStampBookCoverDetails(colourID, highlightID, patternID, claspID, coverItemDetails)
   {
      var _loc3_ = [];
      var _loc4_ = coverItemDetails.length;
      _loc3_.push(colourID);
      _loc3_.push(highlightID);
      _loc3_.push(patternID);
      _loc3_.push(claspID);
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_.push(coverItemDetails[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.StampsService.STAMPS_HANDLER + com.clubpenguin.services.StampsService.SET_STAMP_BOOK_COVER_DETAILS,_loc3_,this.messageFormat,-1);
      return this._playersStampBookCoverDetailsReceived;
   }
}
