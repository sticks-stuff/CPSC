class com.disney.dlearning.serialization.JSON
{
    var text;
    function JSON()
    {
    } // End of the function
    function stringify(arg)
    {
        var _loc4;
        var _loc3;
        var _loc7;
        var _loc2 = "";
        var _loc5;
        switch (typeof(arg))
        {
            case "object":
            {
                if (arg)
                {
                    if (arg instanceof Array)
                    {
                        for (var _loc3 = 0; _loc3 < arg.length; ++_loc3)
                        {
                            _loc5 = this.stringify(arg[_loc3]);
                            if (_loc2)
                            {
                                _loc2 = _loc2 + ",";
                            } // end if
                            _loc2 = _loc2 + _loc5;
                        } // end of for
                        return ("[" + _loc2 + "]");
                    }
                    else if (typeof(arg.toString) != "undefined")
                    {
                        for (var _loc3 in arg)
                        {
                            _loc5 = arg[_loc3];
                            if (typeof(_loc5) != "undefined" && typeof(_loc5) != "function")
                            {
                                _loc5 = this.stringify(_loc5);
                                if (_loc2)
                                {
                                    _loc2 = _loc2 + ",";
                                } // end if
                                _loc2 = _loc2 + (this.stringify(_loc3) + ":" + _loc5);
                            } // end if
                        } // end of for...in
                        return ("{" + _loc2 + "}");
                    } // end if
                } // end else if
                return ("null");
            } 
            case "number":
            {
                return (isFinite(arg) ? (String(arg)) : ("null"));
            } 
            case "string":
            {
                _loc7 = arg.length;
                _loc2 = "\"";
                for (var _loc3 = 0; _loc3 < _loc7; _loc3 = _loc3 + 1)
                {
                    _loc4 = arg.charAt(_loc3);
                    if (_loc4 >= " ")
                    {
                        if (_loc4 == "\\" || _loc4 == "\"")
                        {
                            _loc2 = _loc2 + "\\";
                        } // end if
                        _loc2 = _loc2 + _loc4;
                        continue;
                    } // end if
                    switch (_loc4)
                    {
                        case "\b":
                        {
                            _loc2 = _loc2 + "\\b";
                            break;
                        } 
                        case "\f":
                        {
                            _loc2 = _loc2 + "\\f";
                            break;
                        } 
                        case "\n":
                        {
                            _loc2 = _loc2 + "\\n";
                            break;
                        } 
                        case "\r":
                        {
                            _loc2 = _loc2 + "\\r";
                            break;
                        } 
                        case "\t":
                        {
                            _loc2 = _loc2 + "\\t";
                            break;
                        } 
                        default:
                        {
                            _loc4 = _loc4.charCodeAt();
                            _loc2 = _loc2 + ("\\u00" + Math.floor(_loc4 / 16).toString(16) + (_loc4 % 16).toString(16));
                        } 
                    } // End of switch
                } // end of for
                return (_loc2 + "\"");
            } 
            case "boolean":
            {
                return (String(arg));
            } 
        } // End of switch
        return ("null");
    } // End of the function
    function white()
    {
        while (ch)
        {
            if (ch <= " ")
            {
                this.next();
                continue;
            } // end if
            if (ch == "/")
            {
                switch (this.next())
                {
                    case "/":
                    {
                        while (this.next() && ch != "\n" && ch != "\r")
                        {
                        } // end while
                        break;
                    } 
                    case "*":
                    {
                        this.next();
                        if (ch)
                        {
                            if (ch == "*")
                            {
                                if (this.next() == "/")
                                {
                                    this.next();
                                } // end if
                            }
                            else
                            {
                                this.next();
                            } // end else if
                        }
                        else
                        {
                            this.error("Unterminated comment");
                        } // end else if
                        
                        break;
                    } 
                    default:
                    {
                        this.error("Syntax error");
                    } 
                } // End of switch
                continue;
            } // end if
            break;
        } // end while
    } // End of the function
    function error(m)
    {
        throw {name: "JSONError", message: m, at: at - 1, text: text};
    } // End of the function
    function next()
    {
        ch = text.charAt(at);
        at = at + 1;
        return (ch);
    } // End of the function
    function str()
    {
        var _loc5;
        var _loc2 = "";
        var _loc4;
        var _loc3;
        var _loc6 = false;
        if (ch == "\"")
        {
            while (this.next())
            {
                if (ch == "\"")
                {
                    this.next();
                    return (_loc2);
                    continue;
                } // end if
                if (ch == "\\")
                {
                    switch (this.next())
                    {
                        case "b":
                        {
                            _loc2 = _loc2 + "\b";
                            break;
                        } 
                        case "f":
                        {
                            _loc2 = _loc2 + "\f";
                            break;
                        } 
                        case "n":
                        {
                            _loc2 = _loc2 + "\n";
                            break;
                        } 
                        case "r":
                        {
                            _loc2 = _loc2 + "\r";
                            break;
                        } 
                        case "t":
                        {
                            _loc2 = _loc2 + "\t";
                            break;
                        } 
                        case "u":
                        {
                            _loc3 = 0;
                            for (var _loc5 = 0; _loc5 < 4; _loc5 = _loc5 + 1)
                            {
                                _loc4 = parseInt(this.next(), 16);
                                if (!isFinite(_loc4))
                                {
                                    _loc6 = true;
                                    break;
                                } // end if
                                _loc3 = _loc3 * 16 + _loc4;
                            } // end of for
                            if (_loc6)
                            {
                                _loc6 = false;
                                break;
                            } // end if
                            _loc2 = _loc2 + String.fromCharCode(_loc3);
                            break;
                        } 
                        default:
                        {
                            _loc2 = _loc2 + ch;
                        } 
                    } // End of switch
                    continue;
                } // end if
                _loc2 = _loc2 + ch;
            } // end while
        } // end if
        this.error("Bad string");
    } // End of the function
    function arr()
    {
        var _loc2 = [];
        if (ch == "[")
        {
            this.next();
            this.white();
            if (ch == "]")
            {
                this.next();
                return (_loc2);
            } // end if
            while (ch)
            {
                _loc2.push(this.value());
                this.white();
                if (ch == "]")
                {
                    this.next();
                    return (_loc2);
                }
                else if (ch != ",")
                {
                    break;
                } // end else if
                this.next();
                this.white();
            } // end while
        } // end if
        this.error("Bad array");
    } // End of the function
    function obj()
    {
        var _loc3;
        var _loc2 = {};
        if (ch == "{")
        {
            this.next();
            this.white();
            if (ch == "}")
            {
                this.next();
                return (_loc2);
            } // end if
            while (ch)
            {
                _loc3 = this.str();
                this.white();
                if (ch != ":")
                {
                    break;
                } // end if
                this.next();
                _loc2[_loc3] = this.value();
                this.white();
                if (ch == "}")
                {
                    this.next();
                    return (_loc2);
                }
                else if (ch != ",")
                {
                    break;
                } // end else if
                this.next();
                this.white();
            } // end while
        } // end if
        this.error("Bad object");
    } // End of the function
    function num()
    {
        var _loc2 = "";
        var _loc3;
        if (ch == "-")
        {
            _loc2 = "-";
            this.next();
        } // end if
        while (ch >= "0" && ch <= "9")
        {
            _loc2 = _loc2 + ch;
            this.next();
        } // end while
        if (ch == ".")
        {
            _loc2 = _loc2 + ".";
            this.next();
            while (ch >= "0" && ch <= "9")
            {
                _loc2 = _loc2 + ch;
                this.next();
            } // end while
        } // end if
        if (ch == "e" || ch == "E")
        {
            _loc2 = _loc2 + ch;
            this.next();
            if (ch == "-" || ch == "+")
            {
                _loc2 = _loc2 + ch;
                this.next();
            } // end if
            while (ch >= "0" && ch <= "9")
            {
                _loc2 = _loc2 + ch;
                this.next();
            } // end while
        } // end if
        _loc3 = Number(_loc2);
        if (!isFinite(_loc3))
        {
            this.error("Bad number");
        } // end if
        return (_loc3);
    } // End of the function
    function word()
    {
        switch (ch)
        {
            case "t":
            {
                if (this.next() == "r" && this.next() == "u" && this.next() == "e")
                {
                    this.next();
                    return (true);
                } // end if
                break;
            } 
            case "f":
            {
                if (this.next() == "a" && this.next() == "l" && this.next() == "s" && this.next() == "e")
                {
                    this.next();
                    return (false);
                } // end if
                break;
            } 
            case "n":
            {
                if (this.next() == "u" && this.next() == "l" && this.next() == "l")
                {
                    this.next();
                    return (null);
                } // end if
                break;
            } 
        } // End of switch
        this.error("Syntax error");
    } // End of the function
    function value()
    {
        this.white();
        switch (ch)
        {
            case "{":
            {
                return (this.obj());
            } 
            case "[":
            {
                return (this.arr());
            } 
            case "\"":
            {
                return (this.str());
            } 
            case "-":
            {
                return (this.num());
            } 
        } // End of switch
        return (ch >= "0" && ch <= "9" ? (this.num()) : (this.word()));
    } // End of the function
    function parse(_text)
    {
        text = _text;
        at = 0;
        ch = " ";
        return (this.value());
    } // End of the function
    var ch = "";
    var at = 0;
} // End of Class
