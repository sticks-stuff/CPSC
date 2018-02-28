class com.clubpenguin.stamps.stampbook.controls.PenguinName extends MovieClip
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.PenguinName;
   static var LINKAGE_ID = "PenguinName";
   function PenguinName()
   {
      super();
   }
   function onLoad()
   {
      this.configUI();
   }
   function __set__label(value)
   {
      this._label = value;
      this.setTextLabel();
      return this.__get__label();
   }
   function __set__colorValue(value)
   {
      this.penguinName1.textColor = value;
      this.field2.penguinName.textColor = value;
      this.field3.penguinName.textColor = value;
      this.field7.penguinName.textColor = value;
      return this.__get__colorValue();
   }
   function configUI()
   {
   }
   function setTextLabel()
   {
      this.penguinName1.text = this._label;
      this.field2.penguinName.text = this._label;
      this.field3.penguinName.text = this._label;
      this.field4.penguinName.text = this._label;
      this.field5.penguinName.text = this._label;
      this.field6.penguinName.text = this._label;
      this.field7.penguinName.text = this._label;
      this.penguinName1.autoSize = "left";
      this.field2.penguinName.autoSize = "left";
      this.field3.penguinName.autoSize = "left";
      this.field4.penguinName.autoSize = "left";
      this.field5.penguinName.autoSize = "left";
      this.field6.penguinName.autoSize = "left";
      this.field7.penguinName.autoSize = "left";
   }
}
