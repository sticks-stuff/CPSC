class com.clubpenguin.security.Security
{
    function Security()
    {
    } // End of the function
    static function doSecurityCheck($stageURL, $stageParent)
    {
        com.clubpenguin.security.Security.allowDomains();
        com.clubpenguin.security.Security.checkDomain($stageURL, $stageParent);
    } // End of the function
    static function checkDomain($stageURL, $stageParent)
    {
        if (com.clubpenguin.util.Reporting.DEBUG_SECURITY)
        {
            com.clubpenguin.util.Reporting.debugTrace("(Security) checking launch from within club penguin:", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            com.clubpenguin.util.Reporting.debugTrace("(Security) stageURL = " + $stageURL + ", stageParent = " + $stageParent, com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        } // end if
        var _loc2 = false;
        if ($stageURL.substr(0, 4) == "http")
        {
            var _loc4 = new Array();
            _loc4 = $stageURL.split("/");
            var _loc3 = "clubpenguin.com";
            if (_loc4[2].substr(-_loc3.length) == _loc3)
            {
                _loc2 = true;
            } // end if
        } // end if
        if ($stageParent == undefined)
        {
            _loc2 = false;
        } // end if
        if (!_loc2)
        {
            _root.loadMovie();
        } // end if
    } // End of the function
    static function allowDomains()
    {
        if (com.clubpenguin.util.Reporting.DEBUG_SECURITY)
        {
            com.clubpenguin.util.Reporting.debugTrace("(Security) allowing all domains", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        } // end if
        var _loc2 = com.clubpenguin.security.Domains.getAllowedDomains();
        var _loc1 = 0;
        var _loc3 = _loc2.length;
        while (_loc1 < _loc3)
        {
            if (com.clubpenguin.util.Reporting.DEBUG_SECURITY)
            {
                com.clubpenguin.util.Reporting.debugTrace("(Security) allowing domain " + _loc2[_loc1], com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            } // end if
            System.security.allowDomain(_loc2[_loc1]);
            ++_loc1;
        } // end while
    } // End of the function
} // End of Class
