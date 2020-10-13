class com.clubpenguin.hybrid.TraceOutput
{
   var __baseLoc = null;
   var __textField = null;
   var __upArrow = null;
   var __downArrow = null;
   var __scrollInterval = null;
   var __dragHandle = null;
   var __clearButton = null;
   var __closeButton = null;
   static var DEFAULT_TRACE_GRAPHIC = "^";
   static var LINE_WIDTH = 45;
   static var SCROLL_SPEED = 100;
   static var UP = "up";
   static var DOWN = "down";
   static var SCROLL_METHOD = "scroll";
   static var __instance = null;
   function TraceOutput()
   {
   }
   function init(base_loc)
   {
      this.setBaseLoc(base_loc);
      this.setTextfield(base_loc.debugText);
      this.setScrollArrows();
      this.setupDragging();
      this.setupButtons();
      this.hide();
   }
   function setBaseLoc(base_loc)
   {
      this.__baseLoc = base_loc;
   }
   function setTextfield(text_field)
   {
      this.__textField = text_field;
   }
   function setScrollArrows()
   {
      this.__upArrow = this.__baseLoc.upArrow_mc;
      this.__downArrow = this.__baseLoc.downArrow_mc;
      this.__upArrow.useHandCursor = false;
      this.__downArrow.useHandCursor = false;
      this.__upArrow.onPress = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance,this.scrollUp);
      this.__downArrow.onPress = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance,this.scrollDown);
      this.__upArrow.onRelease = this.__downArrow.onRelease = this.__downArrow.onReleaseOutside = this.__downArrow.onReleaseOutside = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance,this.stopScrolling);
   }
   function setupDragging()
   {
      this.__dragHandle = this.__baseLoc.dragHandle_mc;
      this.__dragHandle.useHandCursor = false;
      this.__dragHandle.onPress = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance,this.startDragging);
      this.__dragHandle.onRelease = this.__dragHandle.onReleaseOutside = mx.utils.Delegate.create(com.clubpenguin.hybrid.TraceOutput.__instance,this.stopDragging);
   }
   function startDragging()
   {
      this.__baseLoc.startDrag();
   }
   function stopDragging()
   {
      this.__baseLoc.stopDrag();
   }
   function trace(msg, clear_traces, trace_graphic)
   {
      this.show();
      clear_traces = clear_traces == undefined?false:clear_traces;
      trace_graphic = trace_graphic == undefined?com.clubpenguin.hybrid.TraceOutput.DEFAULT_TRACE_GRAPHIC:trace_graphic;
      var _loc3_ = this.getTraceGraphicLine(trace_graphic);
      var _loc2_ = _loc3_;
      _loc2_ = _loc2_ + _loc3_;
      _loc2_ = _loc2_ + (msg + "\n");
      _loc2_ = _loc2_ + _loc3_;
      _loc2_ = _loc2_ + _loc3_;
      if(clear_traces)
      {
         this.clearTraces();
         this.__textField.text = _loc2_;
      }
      else
      {
         this.__textField.text = this.__textField.text + "\n";
         this.__textField.text = this.__textField.text + _loc2_;
      }
      this.__textField.scroll = this.__textField.maxscroll;
   }
   function clearTraces()
   {
      this.__textField.text = "";
   }
   function getTraceGraphicLine(trace_graphic)
   {
      var _loc2_ = "";
      var _loc1_ = 0;
      while(_loc1_ < com.clubpenguin.hybrid.TraceOutput.LINE_WIDTH)
      {
         _loc2_ = _loc2_ + trace_graphic;
         _loc1_ = _loc1_ + 1;
      }
      _loc2_ = _loc2_ + "\n";
      return _loc2_;
   }
   function hide()
   {
      this.__baseLoc._visible = false;
      this.__baseLoc.x = -2000;
   }
   function show()
   {
      this.__baseLoc._visible = true;
      this.__baseLoc.x = 0;
   }
   function scrollUp()
   {
      this.__upArrow.gotoAndStop(2);
      this.__scrollInterval = setInterval(com.clubpenguin.hybrid.TraceOutput.__instance,com.clubpenguin.hybrid.TraceOutput.SCROLL_METHOD,com.clubpenguin.hybrid.TraceOutput.SCROLL_SPEED,com.clubpenguin.hybrid.TraceOutput.UP);
   }
   function scrollDown()
   {
      this.__downArrow.gotoAndStop(2);
      this.__scrollInterval = setInterval(com.clubpenguin.hybrid.TraceOutput.__instance,com.clubpenguin.hybrid.TraceOutput.SCROLL_METHOD,com.clubpenguin.hybrid.TraceOutput.SCROLL_SPEED,com.clubpenguin.hybrid.TraceOutput.DOWN);
   }
   function scroll(scroll_dir)
   {
      if(scroll_dir == com.clubpenguin.hybrid.TraceOutput.UP)
      {
         this.__textField.scroll = this.__textField.scroll - 1;
      }
      else
      {
         this.__textField.scroll = this.__textField.scroll + 1;
      }
   }
   function stopScrolling()
   {
      this.__upArrow.gotoAndStop(1);
      this.__downArrow.gotoAndStop(1);
      clearInterval(this.__scrollInterval);
   }
   function getCanvas()
   {
      return this.__baseLoc;
   }
   function setupButtons()
   {
      this.__clearButton = this.__baseLoc.clearBtn;
      this.__closeButton = this.__baseLoc.closeBtn;
      this.__clearButton.onRelease = mx.utils.Delegate.create(this,this.clearTraces);
      this.__closeButton.onRelease = mx.utils.Delegate.create(this,this.hide);
   }
   static function getInstance()
   {
      if(com.clubpenguin.hybrid.TraceOutput.__instance == null)
      {
         com.clubpenguin.hybrid.TraceOutput.__instance = new com.clubpenguin.hybrid.TraceOutput();
      }
      return com.clubpenguin.hybrid.TraceOutput.__instance;
   }
}
