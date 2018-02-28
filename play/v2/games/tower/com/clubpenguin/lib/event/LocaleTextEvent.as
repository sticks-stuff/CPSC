class com.clubpenguin.lib.event.LocaleTextEvent extends com.clubpenguin.lib.event.Event
{
    function LocaleTextEvent(_source, _type, _data)
    {
        super(_source, _type, _data);
    } // End of the function
    static var LOAD_COMPLETE = "localeTextLoadComplete";
} // End of Class
