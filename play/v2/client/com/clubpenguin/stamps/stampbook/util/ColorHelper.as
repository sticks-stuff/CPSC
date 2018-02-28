class com.clubpenguin.stamps.stampbook.util.ColorHelper extends com.clubpenguin.util.EventDispatcher
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.util.ColorHelper;
   static var LINKAGE_ID = "ColorHelper";
   function ColorHelper()
   {
      super();
   }
   function getColourIndex()
   {
      return this._colourIndex;
   }
   function setColourIndex(colour)
   {
      this._colourIndex = colour;
      this.dispatchEvent({type:"colorChange",colour:this._colourIndex});
   }
   function getHighlightIndex()
   {
      return this._highlightIndex;
   }
   function setHighlightIndex(highlightIndex)
   {
      this._highlightIndex = highlightIndex;
      this.dispatchEvent({type:"highlightChange",highlight:this._highlightIndex});
   }
   function getPatternIndex()
   {
      return this._patternIndex;
   }
   function setPatternIndex(patternIndex)
   {
      this._patternIndex = patternIndex;
   }
   function getIconIndex()
   {
      return this._iconIndex;
   }
   function setIconIndex(iconIndex)
   {
      this._iconIndex = iconIndex;
   }
   static function getInstance()
   {
      if(com.clubpenguin.stamps.stampbook.util.ColorHelper._instance == null)
      {
         com.clubpenguin.stamps.stampbook.util.ColorHelper._instance = new com.clubpenguin.stamps.stampbook.util.ColorHelper();
      }
      return com.clubpenguin.stamps.stampbook.util.ColorHelper._instance;
   }
}
