<?php
  final class XTParser {
    public static function Encode($func_array, $func_char = '%') {
      return $func_char . 'xt' . $func_char . join('%', $func_array) . $func_char;
    }
    
    public static function Decode($func_packet) {
      return explode($func_packet{0}, substr($func_packet, 4, -1));
    }
  }
  function xt_encode($func_data, $func_char = '%') { return XTParser::Encode($func_data, $func_char); }
  function xt_decode($func_data)                   { return XTParser::Decode($func_data);             }
  
  function is_xt_packet($func_packet) { $func_packet = trim($func_packet);
    return (($func_packet{0} == $func_packet{3}) && $func_packet{1} == 'x' && $func_packet{2} == 't' && ($func_packet{0} == $func_packet{strlen($func_packet) - 1})) ?
           xt_decode($func_packet) : false;
  }
?>