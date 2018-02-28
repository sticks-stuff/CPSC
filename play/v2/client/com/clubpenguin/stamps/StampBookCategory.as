class com.clubpenguin.stamps.StampBookCategory implements com.clubpenguin.stamps.IStampBookCategory
{
   function StampBookCategory(id, name, subCategories, stampBookItems, polaroids)
   {
      this.id = id;
      this.name = name;
      this.subCategories = subCategories;
      this.stampBookItems = stampBookItems;
      this.polaroids = polaroids;
   }
   function destroy()
   {
      var _loc3_ = this.subCategories.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this.subCategories[_loc2_].destroy();
         _loc2_ = _loc2_ + 1;
      }
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
   function getSubCategories()
   {
      return this.subCategories;
   }
   function setSubCategories(subCategories)
   {
      this.subCategories = subCategories;
   }
   function addSubCategory(subCategory)
   {
      if(this.subCategories == undefined)
      {
         this.subCategories = [];
      }
      this.subCategories.push(subCategory);
   }
   function getItems()
   {
      return this.stampBookItems;
   }
   function setItems(stampBookItems)
   {
      this.stampBookItems = stampBookItems;
   }
   function getPolaroids()
   {
      return this.polaroids;
   }
   function setPolaroids(polaroids)
   {
      this.polaroids = polaroids;
   }
}
