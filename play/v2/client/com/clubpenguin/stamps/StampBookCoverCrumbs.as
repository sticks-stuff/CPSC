class com.clubpenguin.stamps.StampBookCoverCrumbs
{
   static var CRUMB_CATEGORY_PATTERN = "pattern";
   static var CRUMB_CATEGORY_CLASP = "clasp";
   static var CRUMB_CATEGORY_COLOUR = "color";
   static var CRUMB_CATEGORY_HIGHLIGHT = "highlight";
   static var CRUMB_CATEGORY_COLOUR_HIGHLIGHT = "color_highlight";
   static var CRUMB_CATEGORY_COLOUR_LOGO = "color_logo";
   function StampBookCoverCrumbs(webServiceManager)
   {
      this._coverCrumbs = webServiceManager.getServiceData(com.clubpenguin.net.WebServiceType.STAMPBOOK_COVER);
      this.setColourCrumb();
      var _loc3_ = this.__get__pattern();
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         if(_loc3_[_loc2_] == com.clubpenguin.stamps.StampManager.COVER_PATTERN_NONE_ID)
         {
            _loc3_.splice(_loc2_,1);
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function __get__pattern()
   {
      return this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_PATTERN];
   }
   function __get__clasp()
   {
      return this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_CLASP];
   }
   function __get__colour()
   {
      return this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR];
   }
   function getTextHighlightByHighlightID(highlightID)
   {
      return Number(this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_HIGHLIGHT][String(highlightID)]);
   }
   function getHighlightByColourID(colourID)
   {
      return this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR_HIGHLIGHT][String(colourID)];
   }
   function getLogoByColourID(colourID)
   {
      return Number(this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR_LOGO][String(colourID)][0]);
   }
   function setColourCrumb()
   {
      this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR] = [];
      var _loc4_ = this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR_HIGHLIGHT];
      var _loc2_ = this._coverCrumbs[com.clubpenguin.stamps.StampBookCoverCrumbs.CRUMB_CATEGORY_COLOUR];
      var _loc3_ = 0;
      for(var _loc5_ in _loc4_)
      {
         _loc3_;
         _loc2_[_loc3_++] = _loc5_;
      }
   }
}
