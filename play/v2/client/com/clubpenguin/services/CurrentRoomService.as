class com.clubpenguin.services.CurrentRoomService extends com.clubpenguin.services.AbstractService
{
   static var NAVIGATION_HANDLER = "j#";
   static var JOIN_ROOM = "jr";
   static var REFRESH_ROOM = "grs";
   function CurrentRoomService(connection)
   {
      super(connection);
      this._roomJoined = new org.osflash.signals.Signal(Array);
      connection.getResponded().add(this.onResponded,this);
   }
   function __get__roomJoined()
   {
      return this._roomJoined;
   }
   function onResponded(responseType, responseData)
   {
      if((var _loc0_ = responseType) === com.clubpenguin.services.CurrentRoomService.JOIN_ROOM)
      {
         this.onRoomJoined(responseData);
      }
   }
   function joinRoom(targetRoomServerSideID, x, y)
   {
      if(x && y)
      {
         this.connection.sendXtMessage(this.extension,com.clubpenguin.services.CurrentRoomService.NAVIGATION_HANDLER + com.clubpenguin.services.CurrentRoomService.JOIN_ROOM,[targetRoomServerSideID,x,y],this.messageFormat,-1);
      }
      else
      {
         this.connection.sendXtMessage(this.extension,com.clubpenguin.services.CurrentRoomService.NAVIGATION_HANDLER + com.clubpenguin.services.CurrentRoomService.JOIN_ROOM,[targetRoomServerSideID,0,0],this.messageFormat,-1);
      }
      return this._roomJoined;
   }
   function refreshRoom()
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.CurrentRoomService.NAVIGATION_HANDLER + com.clubpenguin.services.CurrentRoomService.REFRESH_ROOM,[],this.messageFormat,-1);
   }
   function onRoomJoined(responseData)
   {
      this._roomJoined.dispatch(responseData);
   }
}
