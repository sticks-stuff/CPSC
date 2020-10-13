class com.clubpenguin.services.MailService extends com.clubpenguin.services.AbstractService
{
   var MAIL_HANDLER = "l#";
   var GET_MAIL = "mg";
   var RECEIVE_MAIL = "mr";
   function MailService(connection)
   {
      super(connection);
      this._inboxReceived = new org.osflash.signals.Signal(com.clubpenguin.mail.Inbox);
      this._postCardReceived = new org.osflash.signals.Signal(com.clubpenguin.mail.Postcard);
      connection.getResponded().add(this.onResponded,this);
   }
   function __get__inboxReceived()
   {
      return this._inboxReceived;
   }
   function __get__postCardReceived()
   {
      return this._postCardReceived;
   }
   function onResponded(responseType, responseData)
   {
      switch(responseType)
      {
         case this.GET_MAIL:
            this.onInboxReceived(responseData);
            break;
         case this.RECEIVE_MAIL:
            this.onPostCardReceived(responseData);
      }
   }
   function getInbox()
   {
      this.connection.sendXtMessage(this.extension,this.MAIL_HANDLER + this.GET_MAIL,[],this.messageFormat,-1);
      return this._inboxReceived;
   }
   function onInboxReceived(responseData)
   {
      var _loc3_ = responseData.splice(1);
      var _loc2_ = com.clubpenguin.mail.Inbox.getInboxFromRawArray(_loc3_);
      this._inboxReceived.dispatch(_loc2_);
   }
   function onPostCardReceived(responseData)
   {
      var _loc3_ = responseData.splice(1);
      var _loc2_ = com.clubpenguin.mail.Postcard.getPostCardFromRawArray(_loc3_);
      this._postCardReceived.dispatch(_loc2_);
   }
}
