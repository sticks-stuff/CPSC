<?php
  # # # # # # # # # # # # # # # # # # #
  # function json_encode($func_data); #
  # function json_decode($func_data); #
  # # # # # # # # # # # # # # # # # # #
  
  final class JSONParser {
    public static function Encode($func_data) { return json_encode($func_data); }
    public static function Decode($func_data) { return json_decode($func_data); }
  }
  
  function is_json_packet($func_packet) {
    return json_decode($func_packet);
  }
?>