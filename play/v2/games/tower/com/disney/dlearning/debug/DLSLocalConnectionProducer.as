class com.disney.dlearning.debug.DLSLocalConnectionProducer extends Object
{
    var conn;
    function DLSLocalConnectionProducer()
    {
        super();
        conn = new LocalConnection();
        conn.onStatus = onStatus;
    } // End of the function
    function sendMessage(type, message)
    {
        var _loc2 = new Object();
        _loc2.type = type;
        _loc2.message = message;
        var _loc3 = new com.disney.dlearning.serialization.JSON();
        conn.send("DLS.CONNECTION", "DLSlcHandler", _loc3.stringify(_loc2));
    } // End of the function
    function onStatus(event)
    {
        switch (event.level)
        {
            case "status":
            {
                break;
            } 
            case "error":
            {
                break;
            } 
        } // End of switch
    } // End of the function
} // End of Class
