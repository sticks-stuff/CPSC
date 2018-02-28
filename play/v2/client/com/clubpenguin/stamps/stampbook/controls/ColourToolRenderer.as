class com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer;
   static var LINKAGE_ID = "ColourToolRenderer";
   function ColourToolRenderer()
   {
      super();
   }
   function onPress()
   {
      this.dispatchEvent({type:"press"});
   }
}
