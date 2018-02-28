class com.clubpenguin.services.AwardsService extends com.clubpenguin.services.AbstractService
{
   static var ITEM_HANDLER = "i#";
   static var QUERY_PLAYERS_AWARDS = "qpa";
   function AwardsService(connection)
   {
      super(connection);
      this._awardsListReceived = new org.osflash.signals.Signal(Array);
      connection.getResponded().add(this.onResponded,this);
   }
   function __get__awardsListReceived()
   {
      return this._awardsListReceived;
   }
   function onResponded(responseType, responseData)
   {
      if((var _loc0_ = responseType) === com.clubpenguin.services.AwardsService.QUERY_PLAYERS_AWARDS)
      {
         this._awardsListReceived.dispatch(responseData);
      }
      return undefined;
   }
   function queryPlayersAwards(playerID)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.AwardsService.ITEM_HANDLER + com.clubpenguin.services.AwardsService.QUERY_PLAYERS_AWARDS,[playerID],this.messageFormat,-1);
      return this._awardsListReceived;
   }
}
