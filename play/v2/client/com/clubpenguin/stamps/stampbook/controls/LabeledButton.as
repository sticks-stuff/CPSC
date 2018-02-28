class com.clubpenguin.stamps.stampbook.controls.LabeledButton extends com.clubpenguin.stamps.stampbook.controls.BaseButton
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.LabeledButton;
   static var LINKAGE_ID = "LabeledButton";
   function LabeledButton()
   {
      super();
   }
   function __get__label()
   {
      return this._label;
   }
   function __set__label(value)
   {
      if(this._label == value)
      {
         return undefined;
      }
      this._label = value;
      this.setTextLabel();
      return this.__get__label();
   }
   function setTextLabel()
   {
      this.label_field.text = this._label;
   }
}
