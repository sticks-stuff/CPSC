class com.clubpenguin.fieldop.FieldOp
{
   static var WIDTH = 70;
   static var HEIGHT = 70;
   function FieldOp()
   {
   }
   static function getFieldOpFromObject(rawFieldOp)
   {
      var _loc1_ = new com.clubpenguin.fieldop.FieldOp();
      _loc1_.roomID = parseInt(rawFieldOp.room_id);
      _loc1_.x = parseInt(rawFieldOp.x_pos);
      _loc1_.y = parseInt(rawFieldOp.y_pos);
      _loc1_.gameName = rawFieldOp.game_id;
      _loc1_.description = rawFieldOp.description;
      _loc1_.task = rawFieldOp.task;
      _loc1_.hit = new flash.geom.Rectangle(_loc1_.x - com.clubpenguin.fieldop.FieldOp.WIDTH / 2,_loc1_.y - com.clubpenguin.fieldop.FieldOp.HEIGHT / 2,com.clubpenguin.fieldop.FieldOp.WIDTH,com.clubpenguin.fieldop.FieldOp.HEIGHT);
      return _loc1_;
   }
}
