class com.clubpenguin.games.generic.NetClient
{
    var SHELL, AIRTOWER, roomID;
    function NetClient()
    {
    } // End of the function
    function init()
    {
        SHELL = _global.getCurrentShell();
        AIRTOWER = _global.getCurrentAirtower();
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GET_GAME, handleGetGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_LEAVE_GAME, handleAbortGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_UPDATE_PLAYERLIST, handleUpdateGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_START_GAME, handleStartGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_ABORT_GAME, handleCloseGameMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_PLAYER_ACTION, handlePlayerActionMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GAME_OVER, handleGameOverMessage, this);
        AIRTOWER.addListener(com.clubpenguin.games.generic.NetClient.MESSAGE_ERROR, handleErrorMessage, this);
        roomID = SHELL.getCurrentServerRoomId();
    } // End of the function
    function destroy()
    {
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GET_GAME, handleGetGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_JOIN_GAME, handleJoinGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_LEAVE_GAME, handleAbortGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_UPDATE_PLAYERLIST, handleUpdateGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_START_GAME, handleStartGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_ABORT_GAME, handleCloseGameMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_PLAYER_ACTION, handlePlayerActionMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_GAME_OVER, handleGameOverMessage, this);
        AIRTOWER.removeListener(com.clubpenguin.games.generic.NetClient.MESSAGE_ERROR, handleErrorMessage, this);
    } // End of the function
    function sendGetGameMessage()
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("sendGetGameMessage");
        AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.generic.NetClient.MESSAGE_GET_GAME, "", com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function sendJoinGameMessage()
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("sendJoinGameMessage");
        AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.generic.NetClient.MESSAGE_JOIN_GAME, "", com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function sendLeaveGameMessage()
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("sendLeaveGameMessage");
        AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.generic.NetClient.MESSAGE_LEAVE_GAME, "", com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function sendAbortGameMessage()
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("sendAbortGameMessage");
        AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.generic.NetClient.MESSAGE_ABORT_GAME, "", com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function sendPlayerActionMessage(messageData)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("sendPlayerActionMessage - messageData is...");
        for (var _loc3 in messageData)
        {
            com.clubpenguin.games.generic.NetClient.debugTrace("messageData[" + _loc3 + "] = " + messageData[_loc3]);
        } // end of for...in
        AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.generic.NetClient.MESSAGE_PLAYER_ACTION, messageData, com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function handleGetGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleGetGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleJoinGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleJoinGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleStartGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleStartGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleUpdateGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleUpdateGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handlePlayerActionMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handlePlayerActionMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleCloseGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleCloseGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleAbortGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleAbortGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleGameOverMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleGameOverMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleErrorMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleErrorMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace("(NetClient) " + message, priority);
        } // end if
    } // End of the function
    static var MESSAGE_GET_GAME = "gz";
    static var MESSAGE_JOIN_GAME = "jz";
    static var MESSAGE_LEAVE_GAME = "lz";
    static var MESSAGE_PLAYER_ACTION = "zm";
    static var MESSAGE_START_GAME = "sz";
    static var MESSAGE_UPDATE_PLAYERLIST = "uz";
    static var MESSAGE_ABORT_GAME = "cz";
    static var MESSAGE_GAME_OVER = "zo";
    static var MESSAGE_ERROR = "ez";
    static var SERVER_SIDE_EXTENSION_NAME = "z";
    static var SERVER_SIDE_MESSAGE_TYPE = "str";
} // End of Class
