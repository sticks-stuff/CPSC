class com.clubpenguin.util.Reporting
{
    static var output;
    function Reporting()
    {
    } // End of the function
    static function addDebugOutput(debugText)
    {
        if (com.clubpenguin.util.Reporting.output == undefined)
        {
            output = new Array();
        } // end if
        com.clubpenguin.util.Reporting.output.push(debugText);
    } // End of the function
    static function setDebugLevel(level)
    {
        if (com.clubpenguin.util.Reporting.debugLevel > com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR || com.clubpenguin.util.Reporting.debugLevel < com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE)
        {
            com.clubpenguin.util.Reporting.debugTrace("(Reporting) incorrect debug level given in setDebugLevel: " + level, com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        }
        else
        {
            debugLevel = level;
        } // end else if
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            if (com.clubpenguin.util.Reporting.debugLevel <= priority)
            {
                var _loc1;
                switch (priority)
                {
                    case com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR:
                    {
                        _loc1 = "ERROR! " + message;
                        break;
                    } 
                    case com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING:
                    {
                        _loc1 = "WARNING: " + message;
                        break;
                    } 
                    case com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE:
                    {
                        _loc1 = "MESSAGE: " + message;
                        break;
                    } 
                    case com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE:
                    default:
                    {
                        _loc1 = "VERBOSE: " + message;
                        break;
                    } 
                } // End of switch
                trace (_loc1);
                for (var _loc2 in com.clubpenguin.util.Reporting.output)
                {
                    com.clubpenguin.util.Reporting.output[_loc2].text = _loc1 + "\n" + com.clubpenguin.util.Reporting.output[_loc2].text;
                } // end of for...in
            } // end if
        } // end if
    } // End of the function
    static var DEBUG = true;
    static var DEBUG_FPS = com.clubpenguin.util.Reporting.DEBUG && true;
    static var DEBUG_SOUNDS = com.clubpenguin.util.Reporting.DEBUG && true;
    static var DEBUG_LOCALE = com.clubpenguin.util.Reporting.DEBUG && true;
    static var DEBUG_SECURITY = com.clubpenguin.util.Reporting.DEBUG && true;
    static var DEBUGLEVEL_VERBOSE = 0;
    static var DEBUGLEVEL_MESSAGE = 1;
    static var DEBUGLEVEL_WARNING = 2;
    static var DEBUGLEVEL_ERROR = 3;
    static var debugLevel = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
} // End of Class
