class com.clubpenguin.stamps.PinItem implements com.clubpenguin.stamps.IStampBookItem
{
   function PinItem(id, name, description, isMemberItem)
   {
      this.id = id;
      this.name = name;
      this.description = description;
      this.isMemberItem = isMemberItem;
   }
   function getType()
   {
      return com.clubpenguin.stamps.StampBookItemType.PIN;
   }
   function getID()
   {
      return this.id;
   }
   function setID(id)
   {
      this.id = id;
   }
   function getName()
   {
      return this.name;
   }
   function setName(name)
   {
      this.name = name;
   }
   function getDescription()
   {
      return this.description;
   }
   function setDescription(description)
   {
      this.description = description;
   }
   function getIsMemberItem()
   {
      return this.isMemberItem;
   }
   function setIsMemberItem(isMemberItem)
   {
      this.isMemberItem = isMemberItem;
   }
}
