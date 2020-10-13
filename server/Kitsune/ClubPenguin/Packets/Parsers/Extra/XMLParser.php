<?php
  XMLParser::Init();
  final class XMLParser {
    static private $encoder;
    static private $decoder;
    static private $data;
    static private $pointer;
    static private $path;
    
    static public function Init($func_caseFold = false) {
      self::$encoder = new XMLWriter();
      self::$encoder->openMemory(); 
      self::$encoder->setIndent(false);
      
      self::$decoder = xml_parser_create();
      xml_set_element_handler(self::$decoder, 'XMLParser::StartElement', 'XMLParser::EndElement');
      xml_set_character_data_handler(self::$decoder, 'XMLParser::CharacterData');
      xml_parser_set_option(self::$decoder, XML_OPTION_CASE_FOLDING, $func_caseFold);
      libxml_disable_entity_loader(true); // Thanks to Jamie for noticing this.
      
      return;
    }
    
    static public function StartElement($func_parser, $func_element, $func_attributes) {
      $func_depth    = count(self::$pointer[$func_element]);
      
      self::$path[]  = $func_element;
      self::$path[]  = $func_depth;
      self::$pointer = &self::$pointer[$func_element][$func_depth];
      if($func_attributes) self::$pointer['<Attributes />'] = $func_attributes;
    }
    
    static public function EndElement($func_parser, $func_element) {
      array_pop(self::$path);
      array_pop(self::$path);
      self::$pointer = &self::$data;
      foreach(self::$path as $func_path) self::$pointer = &self::$pointer[$func_path];
    }
    
    static public function CharacterData($func_parser, $func_data) {
      self::$pointer['<CharacterData />'] = $func_data;
    }
    
    static public function Decode($func_xml, $func_caseFold = false) {
      self::Init($func_caseFold); //... Do something to avoid having the Need to re-init ...//
      
      self::$data = array();
      self::$path = array();
      self::$pointer = &self::$data;
      if(!xml_parse(self::$decoder, '<WRAPPER>' . $func_xml . '</WRAPPER>', true)) {
        EventListener::FireEvent(Events::XML_ERROR, xml_error_string(xml_get_error_code(self::$decoder)), xml_get_current_line_number(self::$decoder), self::$data, self::$path);
        
        echo $func_message = sprintf('<b>XML error:</b> %s at line %d', xml_error_string(xml_get_error_code(self::$decoder)), xml_get_current_line_number(self::$decoder));
        Debugger::Debug(DebugFlags::J_WARNING, $func_message);
        
        return false;
      } else return self::$data['WRAPPER'][0];
    }
    
    static private function AddElement($func_name, $func_data) {
      if($func_name === '<CharacterData />') self::$encoder->writeCData($func_data);
      elseif($func_name === '<Attributes />') foreach($func_data as $func_attName => $func_attValue) self::$encoder->writeAttribute($func_attName, $func_attValue);
      else if(is_array($func_data)) foreach($func_data as $func_elData) {
        self::$encoder->startElement($func_name);
        if(is_array($func_elData)) foreach($func_elData as $func_elName => $func_elItem) self::AddElement($func_elName, $func_elItem);
        self::$encoder->endElement();
      }
    }
    
    static public function Encode($func_data) {
      foreach($func_data as $func_name => $func_data) self::AddElement($func_name, $func_data);
      return self::$encoder->outputMemory(false);
    }
  }
  
  function xml_encode($func_xml) { return XMLParser::Encode($func_xml); }
  function xml_decode($func_xml) { return XMLParser::Decode($func_xml); }
  
  function is_xml_packet($func_packet) { $func_packet = trim($func_packet);
    return ($func_packet{0} == '<') && ($func_packet{strlen($func_packet) - 1} == '>') ? xml_decode($func_packet) : false;
  }
?>