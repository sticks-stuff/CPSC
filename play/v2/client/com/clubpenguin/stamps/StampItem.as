class com.clubpenguin.stamps.StampItem implements com.clubpenguin.stamps.IStampItem
{
   function StampItem(id, mainCategoryID, difficulty, name, description, isMemberItem)
   {
      this.id = id;
      this.mainCategoryID = mainCategoryID;
      this.difficulty = difficulty;
      this.name = name;
      this.description = description;
      this.isMemberItem = isMemberItem;
   }
   function getMainCategoryID()
   {
      return this.mainCategoryID;
   }
   function setMainCategoryID(id)
   {
      this.mainCategoryID = id;
   }
   function getType()
   {
      return com.clubpenguin.stamps.StampBookItemType.STAMP;
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
   function getDifficulty()
   {
      return this.difficulty;
   }
   function setDifficulty(difficulty)
   {
      this.difficulty = difficulty;
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
