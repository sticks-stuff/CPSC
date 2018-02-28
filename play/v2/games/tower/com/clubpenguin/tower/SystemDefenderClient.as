class com.clubpenguin.tower.SystemDefenderClient
{
    var AIRTOWER;
    function SystemDefenderClient()
    {
        AIRTOWER = _global.getCurrentAirtower();
        AIRTOWER.addListener(com.clubpenguin.tower.SystemDefenderClient.MESSAGE_GET_EPF_MEDAL, handleEPFMedalCheckResponse, this);
    } // End of the function
    function destroy()
    {
        AIRTOWER.removeListener(com.clubpenguin.tower.SystemDefenderClient.MESSAGE_GET_EPF_MEDAL, handleEPFMedalCheckResponse, this);
    } // End of the function
    function sendEPFMedalCheck(stampID)
    {
        var _loc3 = _global.getCurrentShell();
        var _loc4 = _loc3.getCurrentServerRoomId();
        AIRTOWER.send(com.clubpenguin.tower.SystemDefenderClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.tower.SystemDefenderClient.MESSAGE_GET_EPF_MEDAL, [stampID], com.clubpenguin.tower.SystemDefenderClient.SERVER_SIDE_MESSAGE_TYPE, _loc4);
    } // End of the function
    function handleEPFMedalCheckResponse(resObj)
    {
        var _loc1 = resObj[1];
        switch (_loc1)
        {
            case com.clubpenguin.tower.SystemDefenderClient.RESPONSE_ERROR_ILLEGIBLE_LEVEL_ID:
            case com.clubpenguin.tower.SystemDefenderClient.RESPONSE_ERROR_NOT_AN_AGENT:
            case com.clubpenguin.tower.SystemDefenderClient.RESPONSE_INVALID_LEVEL:
            {
                break;
            } 
            case com.clubpenguin.tower.SystemDefenderClient.RESPONSE_ALREADY_HAVE_MEDAL:
            {
                break;
            } 
            case com.clubpenguin.tower.SystemDefenderClient.RESPONSE_NEW_EPF_MEDAL:
            {
                com.clubpenguin.util.Stamp.sendStamp(parseInt(resObj[2]));
                break;
            } 
        } // End of switch
    } // End of the function
    static var MESSAGE_GET_EPF_MEDAL = "epfsf";
    static var SERVER_SIDE_EXTENSION_NAME = "z";
    static var SERVER_SIDE_MESSAGE_TYPE = "str";
    static var RESPONSE_ERROR_ILLEGIBLE_LEVEL_ID = "ill";
    static var RESPONSE_ERROR_NOT_AN_AGENT = "naa";
    static var RESPONSE_INVALID_LEVEL = "inl";
    static var RESPONSE_ALREADY_HAVE_MEDAL = "ahm";
    static var RESPONSE_NEW_EPF_MEDAL = "nem";
} // End of Class
