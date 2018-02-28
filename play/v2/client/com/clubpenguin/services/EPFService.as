class com.clubpenguin.services.EPFService extends com.clubpenguin.services.AbstractService
{
   static var EPF_HANDLER = "f#";
   static var GET_AGENT_STATUS = "epfga";
   static var SET_AGENT_STATUS = "epfsa";
   static var GET_FIELD_OP_STATUS = "epfgf";
   static var SET_FIELD_OP_STATUS = "epfsf";
   static var GET_POINTS = "epfgr";
   static var BUY_ITEM = "epfai";
   function EPFService(connection)
   {
      super(connection);
      this._agentStatusReceived = new org.osflash.signals.Signal(Boolean);
      this._fieldOpStatusReceived = new org.osflash.signals.Signal(Number);
      this._pointsReceived = new org.osflash.signals.Signal(Number,Number);
      this._itemBought = new org.osflash.signals.Signal(Number);
      connection.getResponded().add(this.onResponded,this);
   }
   function __get__agentStatusReceived()
   {
      return this._agentStatusReceived;
   }
   function __get__fieldOpStatusReceived()
   {
      return this._fieldOpStatusReceived;
   }
   function __get__pointsReceived()
   {
      return this._pointsReceived;
   }
   function __get__itemBought()
   {
      return this._itemBought;
   }
   function onResponded(responseType, responseData)
   {
      switch(responseType)
      {
         case com.clubpenguin.services.EPFService.SET_AGENT_STATUS:
            this.dispatchAgentStatusReceived("1");
            break;
         case com.clubpenguin.services.EPFService.GET_AGENT_STATUS:
            this.dispatchAgentStatusReceived(responseData[1]);
            break;
         case com.clubpenguin.services.EPFService.GET_FIELD_OP_STATUS:
         case com.clubpenguin.services.EPFService.SET_FIELD_OP_STATUS:
            this.dispatchFieldOpStatusReceived(responseData[1]);
            break;
         case com.clubpenguin.services.EPFService.GET_POINTS:
            this.dispatchPointsReceived(responseData[1],responseData[2]);
            break;
         case com.clubpenguin.services.EPFService.BUY_ITEM:
            this.dispatchItemBought(responseData[1]);
      }
   }
   function dispatchAgentStatusReceived(agentStatus)
   {
      this._agentStatusReceived.dispatch(Boolean(Number(agentStatus)));
   }
   function dispatchFieldOpStatusReceived(fieldOpStatus)
   {
      this._fieldOpStatusReceived.dispatch(Number(fieldOpStatus));
   }
   function dispatchItemBought(unusedPoints)
   {
      this._itemBought.dispatch(Number(unusedPoints));
   }
   function dispatchPointsReceived(totalPoints, unusedPoints)
   {
      this._pointsReceived.dispatch(Number(unusedPoints),Number(totalPoints));
   }
   function getAgentStatus()
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.GET_AGENT_STATUS,[],this.messageFormat,-1);
      return this._agentStatusReceived;
   }
   function setAgentStatus()
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.SET_AGENT_STATUS,[],this.messageFormat,-1);
      return this._agentStatusReceived;
   }
   function getFieldOpStatus()
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.GET_FIELD_OP_STATUS,[],this.messageFormat,-1);
      return this._fieldOpStatusReceived;
   }
   function setFieldOpStatus(fieldOpStatus)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.SET_FIELD_OP_STATUS,[fieldOpStatus],this.messageFormat,-1);
      return this._fieldOpStatusReceived;
   }
   function getPoints()
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.GET_POINTS,[],this.messageFormat,-1);
      return this._pointsReceived;
   }
   function buyItem(itemID)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.EPFService.EPF_HANDLER + com.clubpenguin.services.EPFService.BUY_ITEM,[itemID],this.messageFormat,-1);
      return this._itemBought;
   }
}
