class com.clubpenguin.services.EquipmentService extends com.clubpenguin.services.AbstractService
{
   static var SETTING_HANDLER = "s#";
   static var UPDATE_PLAYER_HAND = "upa";
   function EquipmentService(connection)
   {
      super(connection);
      this._handItemEquipped = new org.osflash.signals.Signal(Number,Number);
      connection.getResponded().add(this.onResponded,this);
   }
   function __get__handItemEquipped()
   {
      return this._handItemEquipped;
   }
   function onResponded(responseType, responseData)
   {
      if((var _loc0_ = responseType) === com.clubpenguin.services.EquipmentService.UPDATE_PLAYER_HAND)
      {
         this.onHandItemEquipped(responseData);
      }
   }
   function equipHandItem(handItemID)
   {
      this.connection.sendXtMessage(this.extension,com.clubpenguin.services.EquipmentService.SETTING_HANDLER + com.clubpenguin.services.EquipmentService.UPDATE_PLAYER_HAND,[handItemID],this.messageFormat,-1);
      return this._handItemEquipped;
   }
   function onHandItemEquipped(responseData)
   {
      var _loc3_ = Number(responseData[1]);
      var _loc2_ = Number(responseData[2]);
      this._handItemEquipped.dispatch(_loc3_,_loc2_);
   }
}
