class cinqetdemi.JSON
{
   var at = 0;
   var ch = " ";
   function JSON()
   {
   }
   function error(m)
   {
      var _loc2_ = "JSONError: " + m + " at " + (this.at - 1) + "\n";
      _loc2_ = _loc2_ + (this.text.substr(this.at - 10,20) + "\n");
      _loc2_ = _loc2_ + "        ^";
      throw new Error(_loc2_);
   }
   function next()
   {
      this.ch = this.text.charAt(this.at);
      this.at = this.at + 1;
      return this.ch;
   }
   function white()
   {
      while(this.ch)
      {
         if(this.ch <= " ")
         {
            this.next();
         }
         else if(this.ch == "/")
         {
            switch(this.next())
            {
               case "/":
                  while(this.next() && this.ch != "\n" && this.ch != "\r")
                  {
                  }
                  break;
               case "*":
                  this.next();
                  while(true)
                  {
                     if(this.ch)
                     {
                        if(this.ch == "*")
                        {
                           if(this.next() == "/")
                           {
                              this.next();
                              break;
                           }
                        }
                        else
                        {
                           this.next();
                        }
                     }
                     else
                     {
                        this.error("Unterminated comment");
                     }
                  }
                  break;
               default:
                  this.error("Syntax error");
            }
         }
         else
         {
            break;
         }
      }
   }
   function str()
   {
      var _loc5_ = undefined;
      var _loc2_ = "";
      var _loc4_ = undefined;
      var _loc3_ = undefined;
      var _loc6_ = false;
      if(this.ch == "\"" || this.ch == "\'")
      {
         var _loc7_ = this.ch;
         while(this.next())
         {
            if(this.ch == _loc7_)
            {
               this.next();
               return _loc2_;
            }
            if(this.ch == "\\")
            {
               switch(this.next())
               {
                  case "b":
                     _loc2_ = _loc2_ + "\b";
                     break;
                  case "f":
                     _loc2_ = _loc2_ + "\f";
                     break;
                  case "n":
                     _loc2_ = _loc2_ + "\n";
                     break;
                  case "r":
                     _loc2_ = _loc2_ + "\r";
                     break;
                  case "t":
                     _loc2_ = _loc2_ + "\t";
                     break;
                  case "u":
                     _loc3_ = 0;
                     _loc5_ = 0;
                     while(_loc5_ < 4)
                     {
                        _loc4_ = parseInt(this.next(),16);
                        if(!isFinite(_loc4_))
                        {
                           _loc6_ = true;
                           break;
                        }
                        _loc3_ = _loc3_ * 16 + _loc4_;
                        _loc5_ = _loc5_ + 1;
                     }
                     if(_loc6_)
                     {
                        _loc6_ = false;
                        break;
                     }
                     _loc2_ = _loc2_ + String.fromCharCode(_loc3_);
                     break;
                  default:
                     _loc2_ = _loc2_ + this.ch;
               }
            }
            else
            {
               _loc2_ = _loc2_ + this.ch;
            }
         }
      }
      this.error("Bad string");
   }
   function key()
   {
      var _loc2_ = this.ch;
      var _loc6_ = false;
      var _loc3_ = this.text.indexOf(":",this.at);
      var _loc4_ = this.text.indexOf("\"",this.at);
      var _loc5_ = this.text.indexOf("\'",this.at);
      if(_loc4_ <= _loc3_ && _loc4_ > -1 || _loc5_ <= _loc3_ && _loc5_ > -1)
      {
         _loc2_ = this.str();
         this.white();
         if(this.ch == ":")
         {
            return _loc2_;
         }
         this.error("Bad key");
      }
      while(this.next())
      {
         if(this.ch == ":")
         {
            return _loc2_;
         }
         if(this.ch > " ")
         {
            _loc2_ = _loc2_ + this.ch;
         }
      }
      this.error("Bad key");
   }
   function arr()
   {
      var _loc2_ = [];
      if(this.ch == "[")
      {
         this.next();
         this.white();
         if(this.ch == "]")
         {
            this.next();
            return _loc2_;
         }
         while(this.ch)
         {
            if(this.ch == "]")
            {
               this.next();
               return _loc2_;
            }
            _loc2_.push(this.value());
            this.white();
            if(this.ch == "]")
            {
               this.next();
               return _loc2_;
            }
            if(this.ch != ",")
            {
               break;
            }
            this.next();
            this.white();
         }
      }
      this.error("Bad array");
   }
   function obj()
   {
      var _loc3_ = undefined;
      var _loc2_ = {};
      if(this.ch == "{")
      {
         this.next();
         this.white();
         if(this.ch == "}")
         {
            this.next();
            return _loc2_;
         }
         while(this.ch)
         {
            if(this.ch == "}")
            {
               this.next();
               return _loc2_;
            }
            _loc3_ = this.key();
            if(this.ch != ":")
            {
               break;
            }
            this.next();
            _loc2_[_loc3_] = this.value();
            this.white();
            if(this.ch == "}")
            {
               this.next();
               return _loc2_;
            }
            if(this.ch != ",")
            {
               break;
            }
            this.next();
            this.white();
         }
      }
      this.error("Bad object");
   }
   function num()
   {
      var _loc2_ = "";
      var _loc3_ = undefined;
      if(this.ch == "-")
      {
         _loc2_ = "-";
         this.next();
      }
      while(this.ch >= "0" && this.ch <= "9" || this.ch == "x" || this.ch >= "a" && this.ch <= "f" || this.ch >= "A" && this.ch <= "F")
      {
         _loc2_ = _loc2_ + this.ch;
         this.next();
      }
      if(this.ch == ".")
      {
         _loc2_ = _loc2_ + ".";
         this.next();
         while(this.ch >= "0" && this.ch <= "9")
         {
            _loc2_ = _loc2_ + this.ch;
            this.next();
         }
      }
      if(this.ch == "e" || this.ch == "E")
      {
         _loc2_ = _loc2_ + this.ch;
         this.next();
         if(this.ch == "-" || this.ch == "+")
         {
            _loc2_ = _loc2_ + this.ch;
            this.next();
         }
         while(this.ch >= "0" && this.ch <= "9")
         {
            _loc2_ = _loc2_ + this.ch;
            this.next();
         }
      }
      _loc3_ = Number(_loc2_);
      if(!isFinite(_loc3_))
      {
         this.error("Bad number");
      }
      return _loc3_;
   }
   function word()
   {
      switch(this.ch)
      {
         case "t":
            if(this.next() == "r" && this.next() == "u" && this.next() == "e")
            {
               this.next();
               return true;
            }
            break;
         case "f":
            if(this.next() == "a" && this.next() == "l" && this.next() == "s" && this.next() == "e")
            {
               this.next();
               return false;
            }
            break;
         case "n":
            if(this.next() == "u" && this.next() == "l" && this.next() == "l")
            {
               this.next();
               return null;
            }
            break;
      }
      this.error("Syntax error");
   }
   function value()
   {
      this.white();
      switch(this.ch)
      {
         case "{":
            return this.obj();
         case "[":
            return this.arr();
         case "\"":
         case "\'":
            return this.str();
         case "-":
            return this.num();
         default:
            return !(this.ch >= "0" && this.ch <= "9")?this.word():this.num();
      }
   }
   static function getInstance()
   {
      if(cinqetdemi.JSON.inst == null)
      {
         cinqetdemi.JSON.inst = new cinqetdemi.JSON();
      }
      return cinqetdemi.JSON.inst;
   }
   static function stringify(arg)
   {
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      var _loc6_ = undefined;
      var _loc1_ = "";
      var _loc4_ = undefined;
      switch(typeof arg)
      {
         case "object":
            if(arg)
            {
               if(arg instanceof Array)
               {
                  _loc2_ = 0;
                  while(_loc2_ < arg.length)
                  {
                     _loc4_ = cinqetdemi.JSON.stringify(arg[_loc2_]);
                     if(_loc1_)
                     {
                        _loc1_ = _loc1_ + ",";
                     }
                     _loc1_ = _loc1_ + _loc4_;
                     _loc2_ = _loc2_ + 1;
                  }
                  return "[" + _loc1_ + "]";
               }
               if(typeof arg.toString != "undefined")
               {
                  for(var _loc2_ in arg)
                  {
                     _loc4_ = arg[_loc2_];
                     if(typeof _loc4_ != "undefined" && typeof _loc4_ != "function")
                     {
                        _loc4_ = cinqetdemi.JSON.stringify(_loc4_);
                        if(_loc1_)
                        {
                           _loc1_ = _loc1_ + ",";
                        }
                        _loc1_ = _loc1_ + (cinqetdemi.JSON.stringify(_loc2_) + ":" + _loc4_);
                     }
                  }
                  return "{" + _loc1_ + "}";
               }
            }
            return "null";
         case "number":
            return !isFinite(arg)?"null":String(arg);
         case "string":
            _loc6_ = arg.length;
            _loc1_ = "\"";
            _loc2_ = 0;
            while(_loc2_ < _loc6_)
            {
               _loc3_ = arg.charAt(_loc2_);
               if(_loc3_ >= " ")
               {
                  if(_loc3_ == "\\" || _loc3_ == "\"")
                  {
                     _loc1_ = _loc1_ + "\\";
                  }
                  _loc1_ = _loc1_ + _loc3_;
               }
               else
               {
                  switch(_loc3_)
                  {
                     case "\b":
                        _loc1_ = _loc1_ + "\\b";
                        break;
                     case "\f":
                        _loc1_ = _loc1_ + "\\f";
                        break;
                     case "\n":
                        _loc1_ = _loc1_ + "\\n";
                        break;
                     case "\r":
                        _loc1_ = _loc1_ + "\\r";
                        break;
                     case "\t":
                        _loc1_ = _loc1_ + "\\t";
                        break;
                     default:
                        _loc3_ = _loc3_.charCodeAt();
                        _loc1_ = _loc1_ + ("\\u00" + Math.floor(_loc3_ / 16).toString(16) + (_loc3_ % 16).toString(16));
                  }
               }
               _loc2_ = _loc2_ + 1;
            }
            return _loc1_ + "\"";
         case "boolean":
            return String(arg);
         default:
            return "null";
      }
   }
   static function parse(text)
   {
      if(!text.length)
      {
         throw new Error("JSONError: Text missing");
      }
      else
      {
         var _loc1_ = cinqetdemi.JSON.getInstance();
         _loc1_.at = 0;
         _loc1_.ch = " ";
         _loc1_.text = text;
         return _loc1_.value();
      }
   }
}
