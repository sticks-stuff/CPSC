class com.clubpenguin.missions.ui.ScreenFadeEvent
{
    var _type, _target, __get__target, __get__type;
    function ScreenFadeEvent($type, $target)
    {
        _type = $type;
        _target = $target;
    } // End of the function
    function toString()
    {
        return ("ScreenFadeEvent { _type: " + _type + " _target: " + _target + "}");
    } // End of the function
    function get type()
    {
        return (_type);
    } // End of the function
    function get target()
    {
        return (_target);
    } // End of the function
    static var FADE = "fade";
    static var FADE_COMPLETE = "fadeComplete";
    static var FADE_IN = "fadeIn";
    static var FADE_IN_COMPLETE = "fadeInComplete";
    static var FADE_OUT = "fadeOut";
    static var FADE_OUT_COMPLETE = "fadeOutComplete";
} // End of Class
