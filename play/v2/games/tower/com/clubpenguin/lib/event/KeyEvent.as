class com.clubpenguin.lib.event.KeyEvent extends com.clubpenguin.lib.event.Event
{
    var __ascii, __get__ascii, __code, __get__code, __eventType, __get__char, __set__ascii, __set__code;
    function KeyEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    function set ascii(_val)
    {
        __ascii = _val;
        //return (this.ascii());
        null;
    } // End of the function
    function set code(_val)
    {
        __code = _val;
        //return (this.code());
        null;
    } // End of the function
    function get ascii()
    {
        return (__ascii);
    } // End of the function
    function get code()
    {
        return (__code);
    } // End of the function
    function get char()
    {
        return (String.fromCharCode(__ascii));
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "[KeyEvent]\n";
        _loc2 = _loc2 + ("\t" + __eventType + "\n");
        _loc2 = _loc2 + ("\t" + __ascii + "\n");
        _loc2 = _loc2 + ("\t" + __code + "\n");
        _loc2 = _loc2 + ("\t" + this.__get__char() + "\n");
        return (_loc2);
    } // End of the function
    static var PRESSED = "keyEventPressed";
    static var RELEASED = "keyEventRelease";
} // End of Class
