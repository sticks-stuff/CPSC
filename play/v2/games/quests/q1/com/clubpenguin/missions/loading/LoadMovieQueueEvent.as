class com.clubpenguin.missions.loading.LoadMovieQueueEvent
{
    var _type, _target, __get__target, __get__type;
    function LoadMovieQueueEvent($type, $target)
    {
        _type = $type;
        _target = $target;
    } // End of the function
    function toString()
    {
        return ("LoadMovieQueueEvent { _type: " + _type + " _target: " + _target + "}");
    } // End of the function
    function get type()
    {
        return (_type);
    } // End of the function
    function get target()
    {
        return (_target);
    } // End of the function
    static var COMPLETE = "complete";
    static var PROGRESS = "progress";
} // End of Class
