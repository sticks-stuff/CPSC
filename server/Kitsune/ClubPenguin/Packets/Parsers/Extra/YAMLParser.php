<?php
  final class YAMLParser {
    public static function Encode($func_data) { return yaml_emit($func_data);  }
    public static function Decode($func_data) { return yaml_parse($func_data); }
  }
  function yaml_encode($func_data) { return yaml_emit($func_data);  }
  function yaml_decode($func_data) { return yaml_parse($func_data); }
  
  function is_yaml_packet($func_packet) { $func_packet = trim($func_packet);
    return substr($func_packet, 0, 3) == '---') ? yaml_decode($func_packet) : false;
  }
?>