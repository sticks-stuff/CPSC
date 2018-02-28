class com.clubpenguin.stamps.StampBookCover implements com.clubpenguin.stamps.IStampBookCover
{
   function StampBookCover(coverItems, colourID, highlightID, patternID, claspIconArtID)
   {
      this.coverItems = coverItems;
      this.colourID = colourID;
      this.highlightID = highlightID;
      this.patternID = patternID;
      this.claspIconArtID = claspIconArtID;
   }
   function getColourID()
   {
      return this.colourID;
   }
   function setColourID(id)
   {
      this.colourID = id;
   }
   function getHighlightID()
   {
      return this.highlightID;
   }
   function setHighlightID(id)
   {
      this.highlightID = id;
   }
   function getPatternID()
   {
      return this.patternID;
   }
   function setPatternID(id)
   {
      this.patternID = id;
   }
   function getClaspIconArtID()
   {
      return this.claspIconArtID;
   }
   function setClaspIconArtID(id)
   {
      this.claspIconArtID = id;
   }
   function getCoverItems()
   {
      return this.coverItems;
   }
   function setCoverItems(coverItems)
   {
      this.coverItems = coverItems;
   }
}
