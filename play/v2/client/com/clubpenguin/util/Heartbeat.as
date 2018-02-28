class com.clubpenguin.util.Heartbeat
{
   static var TIMEOUT_FREQUENCY = 15;
   function Heartbeat(shell, airtower)
   {
      this._shell = shell;
      this._airtower = airtower;
      this._timeout = new com.clubpenguin.util.Timeout(com.clubpenguin.util.Heartbeat.TIMEOUT_FREQUENCY,this.handleTimeout,[],this);
      this._shell.addListener(this._shell.WORLD_CONNECT_SUCCESS,this.startHeartbeat,this);
      this._airtower.addListener(this._airtower.HEARTBEAT,this.handleSendHeartbeat,this);
   }
   function startHeartbeat()
   {
      this._heart_interval = setInterval(com.clubpenguin.util.Delegate.create(this,this.sendHeartbeat),com.clubpenguin.util.Time.ONE_MINUTE_IN_MILLISECONDS);
   }
   function sendHeartbeat()
   {
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PLAYER_HANDLER + "#" + this._airtower.HEARTBEAT,[],"str",this._shell.getCurrentServerRoomId());
      this._timeout.start();
   }
   function handleSendHeartbeat()
   {
      this._timeout.stop();
   }
   function handleTimeout()
   {
      this._shell.$e("[shell] handleTimeout() -> Client has timed out! Heartbeat request was not responded to fast enough.",{error_code:this._shell.CONNECTION_LOST});
      this._airtower.send(this._airtower.PLAY_EXT,this._airtower.PLAYER_HANDLER + "#" + this._airtower.TIMEOUT,[],"str",this._shell.getCurrentServerRoomId());
      clearInterval(this._heart_interval);
      this._timeout.stop();
   }
}
