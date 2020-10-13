class com.clubpenguin.services.PinsService extends com.clubpenguin.services.AbstractService
{
   static var ITEM_HANDLER = "i#";
   static var QUERY_PLAYERS_PINS = "qpp";
   function PinsService(connection)
   {
      super(connection);
      this._pinsListReceived = new org.osflash.signals.Signal(Array);
      connection.getResponded().add(this.onResponded,this);
   }
   function __get__pinsListReceived()
   {
      return this._pinsListReceived;
   }
   function onResponded(responseType, responseData)
   {
      if((var _loc0_ = responseType) === com.clubpenguin.services.PinsService.QUERY_PLAYERS_PINS)
      {
         this._pinsListReceived.dispatch(responseData);
      }
      return undefined;
   }
   function queryPlayersPins(playerID)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.PinsService.ITEM_HANDLER + com.clubpenguin.services.PinsService.QUERY_PLAYERS_PINS,[playerID],this.messageFormat,-1);
      return this._pinsListReceived;
   }
}
