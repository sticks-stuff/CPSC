class com.clubpenguin.stamps.stampbook.controls.DescriptionBox extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.DescriptionBox;
   static var LINKAGE_ID = "DescriptionBox";
   static var TOOLTIP_RIGHT_SIDE_CLIP_PADDING = -20;
   static var DESCRIPTION_TEXT_WIDTH_PADDING = 50;
   static var SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING = 12;
   static var MIN_DESCRIPTION_WIDTH = 128;
   static var SINGLE_LINE_DESCRIPTION_TEXT_PADDING = 10;
   function DescriptionBox()
   {
      super();
      this._singleLine = false;
   }
   function __set__singleLine(flag)
   {
      this._singleLine = flag;
      return this.__get__singleLine();
   }
   function populateUI()
   {
      var _loc3_ = 0;
      var _loc2_ = undefined;
      this.title_txt.text = this._data.getName();
      this.tooltipRightSideClip.memberBadge._visible = this._data.getIsMemberItem();
      if(this._singleLine)
      {
         _loc2_ = this.descriptionSingleLine_txt;
         this.descriptionSingleLine_txt.text = this._data.getDescription();
         this.descriptionSingleLine_txt._width = this.descriptionSingleLine_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.SINGLE_LINE_DESCRIPTION_TEXT_PADDING;
         if(this.descriptionSingleLine_txt._width < this.title_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING)
         {
            this.descriptionSingleLine_txt._width = this.title_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.SINGLE_LINE_TITLE_TEXT_WIDTH_PADDING;
         }
      }
      else
      {
         _loc2_ = this.description_txt;
         this.description_txt.text = this._data.getDescription();
         this.description_txt._width = this.title_txt.textWidth + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.DESCRIPTION_TEXT_WIDTH_PADDING;
         if(this.description_txt._width < com.clubpenguin.stamps.stampbook.controls.DescriptionBox.MIN_DESCRIPTION_WIDTH)
         {
            this.description_txt._width = com.clubpenguin.stamps.stampbook.controls.DescriptionBox.MIN_DESCRIPTION_WIDTH;
         }
      }
      if(this.tooltipRightSideClip.memberBadge._visible)
      {
         _loc3_ = this.tooltipRightSideClip.memberBadge._width;
      }
      this.tooltipRightSideClip._x = _loc2_._x + _loc2_._width + _loc3_ + com.clubpenguin.stamps.stampbook.controls.DescriptionBox.TOOLTIP_RIGHT_SIDE_CLIP_PADDING;
      this.tooltipMiddleSideClip._width = this.tooltipRightSideClip._x - (this.tooltipLeftSideClip._x + this.tooltipLeftSideClip._width) + 1;
   }
}
