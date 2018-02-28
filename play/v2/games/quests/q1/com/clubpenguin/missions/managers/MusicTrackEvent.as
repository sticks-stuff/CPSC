class com.clubpenguin.missions.managers.MusicTrackEvent
{
    var _type, _target, __get__target, __get__type;
    function MusicTrackEvent($type, $target)
    {
        _type = $type;
        _target = $target;
    } // End of the function
    function toString()
    {
        return ("MusicTrackEvent { _type: " + _type + " _target: " + _target + "}");
    } // End of the function
    function get type()
    {
        return (_type);
    } // End of the function
    function get target()
    {
        return (_target);
    } // End of the function
    static var INIT = "init";
} // End of Class
