class com.clubpenguin.util.Stamp
{
    function Stamp()
    {
    } // End of the function
    static function sendStamp($id)
    {
        if (com.clubpenguin.util.Stamp.debug)
        {
            com.clubpenguin.util.Stamp.stamps[$id] = true;
        }
        else
        {
            var _loc2 = _global.getCurrentShell();
            _loc2.stampEarned($id);
        } // end else if
    } // End of the function
    static function checkStamp($id)
    {
        var _loc3;
        if (com.clubpenguin.util.Stamp.debug)
        {
            if (com.clubpenguin.util.Stamp.stamps[$id])
            {
                return (true);
            } // end if
            return (false);
        } // end if
        var _loc2 = _global.getCurrentShell();
        _loc3 = _loc2.stampIsOwnedByMe($id);
        return (_loc3);
    } // End of the function
    static function setDebug(mode)
    {
        debug = mode;
    } // End of the function
    static function getDebug()
    {
        return (com.clubpenguin.util.Stamp.debug);
    } // End of the function
    static function clearStamps()
    {
        stamps = new Object();
    } // End of the function
    static function setStamps(new_stamps)
    {
        for (var _loc3 in new_stamps)
        {
            var _loc1 = new_stamps[_loc3];
            com.clubpenguin.util.Stamp.stamps[_loc1] = true;
        } // end of for...in
    } // End of the function
    static var debug = false;
    static var stamps = new Object();
} // End of Class
