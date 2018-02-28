<?php
  function serie_encode($func_data) { return   serialize($func_data); }
  function serie_decode($func_data) { return unserialize($func_data); }
  
  function is_serie_packet($func_packet) {
    return $func_packet{1} == ':' ?
           serie_decode($func_packet) : false;
  }
?>