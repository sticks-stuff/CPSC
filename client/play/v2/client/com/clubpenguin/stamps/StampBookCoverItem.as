class com.clubpenguin.stamps.StampBookCoverItem implements com.clubpenguin.stamps.IStampBookCoverItem
{
   function StampBookCoverItem(item, position, rotation, depth)
   {
      this.item = item;
      this.position = position;
      this.rotation = rotation;
      this.depth = depth;
   }
   function getItem()
   {
      return this.item;
   }
   function setItem(item)
   {
      this.item = item;
   }
   function getItemPosition()
   {
      return this.position;
   }
   function setItemPosition(position)
   {
      this.position = position;
   }
   function getItemRotation()
   {
      return this.rotation;
   }
   function setItemRotation(rotation)
   {
      this.rotation = rotation;
   }
   function getItemDepth()
   {
      return this.depth;
   }
   function setItemDepth(depth)
   {
      this.depth = depth;
   }
}
