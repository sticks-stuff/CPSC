class com.clubpenguin.lib.event.ClipEvent extends com.clubpenguin.lib.event.Event
{
    function ClipEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var COMPLETE = "clipEventComplete";
    static var RENDERED = "clipEventRendered";
} // End of Class
