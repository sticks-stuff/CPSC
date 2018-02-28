class com.clubpenguin.missions.managers.MusicManager
{
    function MusicManager()
    {
    } // End of the function
    static function init()
    {
        _tracks = {};
    } // End of the function
    static function addTrack($name, $url, $target)
    {
        if ($name == undefined || $name == "")
        {
        } // end if
        if (com.clubpenguin.missions.managers.MusicManager._tracks[$name])
        {
        } // end if
        if ($url == undefined || $url == "")
        {
        } // end if
        if (!$target)
        {
        } // end if
        var _loc2 = new com.clubpenguin.missions.managers.MusicTrack($name, $url, $target);
        com.clubpenguin.missions.managers.MusicManager._tracks[$name] = _loc2;
        return (_loc2);
    } // End of the function
    static function getTrack($name)
    {
        if (!com.clubpenguin.missions.managers.MusicManager._tracks[$name])
        {
        }
        else
        {
            return (com.clubpenguin.missions.managers.MusicManager._tracks[$name]);
        } // end else if
    } // End of the function
    static function removeTrack($name)
    {
        if (!com.clubpenguin.missions.managers.MusicManager._tracks[$name])
        {
        }
        else
        {
            var _loc2 = com.clubpenguin.missions.managers.MusicManager._tracks[$name];
            _loc2.remove();
            delete com.clubpenguin.missions.managers.MusicManager._tracks[$name];
            return (true);
        } // end else if
    } // End of the function
    static var _tracks = {};
} // End of Class
