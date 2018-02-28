class com.clubpenguin.stamps.PolaroidItem implements com.clubpenguin.stamps.IPolaroidItem
{
   function PolaroidItem(id, numStampsToUnlock, name, description)
   {
      this.id = id;
      this.numStampsToUnlock = numStampsToUnlock;
      this.name = name;
      this.description = description;
   }
   function getType()
   {
      return com.clubpenguin.stamps.StampBookItemType.POLAROID;
   }
   function getID()
   {
      return this.id;
   }
   function setID(id)
   {
      this.id = id;
   }
   function getNumStampsToUnlock()
   {
      return this.numStampsToUnlock;
   }
   function setNumStampsToUnlock(numStampsToUnlock)
   {
      this.numStampsToUnlock = numStampsToUnlock;
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
      return false;
   }
   function setIsMemberItem(isMemberItem)
   {
   }
}
