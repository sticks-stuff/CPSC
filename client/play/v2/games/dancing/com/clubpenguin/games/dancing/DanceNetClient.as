class com.clubpenguin.games.dancing.DanceNetClient extends com.clubpenguin.games.generic.NetClient
{
    var currentState, timeToNextSong, songName, gameEngine, AIRTOWER, netSendTimeMillis, keyPressIDs, sendPlayerActionMessage, songData, millisPerBar, roomID;
    function DanceNetClient()
    {
        super();
        currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED;
        timeToNextSong = 0;
        songName = "undefined";
    } // End of the function
    function init($gameEngine)
    {
        super.init();
        gameEngine = $gameEngine;
        AIRTOWER.addListener(com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_FINISH_GAME, handleEndGameMessage, this);
    } // End of the function
    function destroy()
    {
        super.destroy();
        currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED;
        AIRTOWER.removeListener(com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_FINISH_GAME, handleEndGameMessage, this);
    } // End of the function
    function updateKeyPresses($keyPresses)
    {
        var _loc8 = gameEngine.elapsedTimeMillis;
        if (_loc8 > netSendTimeMillis + com.clubpenguin.games.dancing.DanceNetClient.NET_SEND_INTERVAL)
        {
            netSendTimeMillis = netSendTimeMillis + com.clubpenguin.games.dancing.DanceNetClient.NET_SEND_INTERVAL;
            var _loc5 = new Array();
            var _loc4 = new Array();
            _loc4.push(gameEngine.currentScore);
            for (var _loc7 in keyPressIDs)
            {
                var _loc2 = $keyPresses[keyPressIDs[_loc7]];
                if (_loc2.noteDuration == 0 || _loc2.releaseTime != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
                {
                    var _loc3 = _loc2.noteType + "," + _loc2.pressTime + "," + _loc2.releaseTime + "," + _loc2.getNotePressResult();
                    _loc4.push(_loc3);
                    continue;
                } // end if
                _loc5.push(keyPressIDs[_loc7]);
            } // end of for...in
            keyPressIDs = _loc5;
            this.sendPlayerActionMessage(_loc4);
        } // end if
    } // End of the function
    function handleGetGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleGetGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
        com.clubpenguin.games.generic.NetClient.debugTrace("estimatedTime: " + resObj[1]);
        com.clubpenguin.games.generic.NetClient.debugTrace("nextSong: " + com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]));
        com.clubpenguin.games.generic.NetClient.debugTrace("timeToNextSong: " + resObj[3]);
        timeToNextSong = parseInt(resObj[1]) + parseInt(resObj[3]);
        songName = com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]);
        currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_ATTEMPT_TO_JOIN;
        gameEngine.setSong(parseInt(resObj[3]));
        gameEngine.startTimer();
        gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_PRE_QUEUE);
    } // End of the function
    function handleJoinGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleJoinGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
        com.clubpenguin.games.generic.NetClient.debugTrace("success: " + resObj[1]);
        com.clubpenguin.games.generic.NetClient.debugTrace("songName: " + com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]));
        com.clubpenguin.games.generic.NetClient.debugTrace("timeToNextSong: " + resObj[3]);
        var _loc3 = resObj[1] == "true";
        songName = com.clubpenguin.util.LocaleText.getText("menu_song_item_" + resObj[2]);
        timeToNextSong = parseInt(resObj[3]);
        if (_loc3)
        {
            currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_QUEUEING;
            gameEngine.setSong(parseInt(resObj[2]));
            gameEngine.startTimer();
            gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME);
        }
        else
        {
            currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED;
            gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL);
        } // end else if
    } // End of the function
    function handleStartGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleStartGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
        com.clubpenguin.games.generic.NetClient.debugTrace("noteTimes: " + resObj[1]);
        com.clubpenguin.games.generic.NetClient.debugTrace("noteTypes: " + resObj[2]);
        com.clubpenguin.games.generic.NetClient.debugTrace("noteLengths: " + resObj[3]);
        com.clubpenguin.games.generic.NetClient.debugTrace("millisPerBar: " + resObj[4]);
        var _loc4 = resObj[1].split(",");
        var _loc2 = resObj[2].split(",");
        var _loc5 = resObj[3].split(",");
        songData = [[], [], []];
        for (var _loc6 in _loc2)
        {
            songData[0][_loc6] = parseInt(_loc2[_loc6]);
            songData[1][_loc6] = parseInt(_loc4[_loc6]);
            songData[2][_loc6] = parseInt(_loc5[_loc6]);
        } // end of for...in
        millisPerBar = parseInt(resObj[4]);
        netSendTimeMillis = 0;
        currentState = com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME;
        gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
        gameEngine.startSong();
    } // End of the function
    function handleEndGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleEndGameMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        this.handlePlayerActionMessage(resObj);
        gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
        gameEngine.endSong();
    } // End of the function
    function handleUpdateGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleUpdateGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handlePlayerActionMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handlePlayerActionMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
        com.clubpenguin.games.generic.NetClient.debugTrace("playerScores: " + resObj[1]);
        var _loc4 = resObj[1].split(",");
        var _loc5 = new Array();
        for (var _loc6 in _loc4)
        {
            var _loc2 = _loc4[_loc6].split("|");
            com.clubpenguin.games.generic.NetClient.debugTrace("smartID[" + _loc6 + "]: " + _loc2[0]);
            com.clubpenguin.games.generic.NetClient.debugTrace("name[" + _loc6 + "]: " + _loc2[1]);
            com.clubpenguin.games.generic.NetClient.debugTrace("score[" + _loc6 + "]: " + _loc2[2]);
            com.clubpenguin.games.generic.NetClient.debugTrace("rating[" + _loc6 + "]: " + _loc2[3]);
            com.clubpenguin.games.generic.NetClient.debugTrace("noteStreak[" + _loc6 + "]: " + _loc2[4]);
            var _loc3 = new Object();
            _loc3.smartID = parseInt(_loc2[0]);
            _loc3.name = _loc2[1];
            _loc3.score = parseInt(_loc2[2]);
            _loc3.rating = parseInt(_loc2[3]);
            _loc3.streak = parseInt(_loc2[4]);
            if (_loc3.name != undefined && _loc3.name != "undefined")
            {
                _loc5.push(_loc3);
            } // end if
        } // end of for...in
        _loc5.sortOn("score", Array.DESCENDING | Array.NUMERIC);
        if (_loc5.length > 0)
        {
            gameEngine.updateMultiplayerScores(_loc5);
        } // end if
    } // End of the function
    function handleErrorMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("(DanceNetClient) handleErrorMessage called", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
        com.clubpenguin.games.generic.NetClient.debugTrace("smartRoomID: " + resObj[0]);
        com.clubpenguin.games.generic.NetClient.debugTrace("errorCode: " + resObj[1]);
        var _loc2 = parseInt(resObj[1]);
        if (_loc2 == com.clubpenguin.games.dancing.GameEngine.ERROR_CODE_ROOM_FULL)
        {
            gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_ROOM_FULL);
        }
        else if (_loc2 == com.clubpenguin.games.dancing.GameEngine.ERROR_CODE_MULTIPLE_CONNECTIONS)
        {
            gameEngine.loadMenu(com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_MULTIPLE_CONNECTIONS);
        } // end else if
    } // End of the function
    function handleCloseGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleCloseGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function handleAbortGameMessage(resObj)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("handleAbortGameMessage - not implemented!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
    } // End of the function
    function sendDifficultyLevelMessage($difficulty)
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("sendDifficultyLevelMessage - difficulty is " + $difficulty);
        AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_CHANGE_DIFFICULTY, [$difficulty], com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function sendGetGameAgainMessage()
    {
        com.clubpenguin.games.generic.NetClient.debugTrace("sendGetGameAgainMessage");
        AIRTOWER.send(com.clubpenguin.games.generic.NetClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.dancing.DanceNetClient.MESSAGE_GET_GAME_AGAIN, "", com.clubpenguin.games.generic.NetClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    static var MESSAGE_CHANGE_DIFFICULTY = "zd";
    static var MESSAGE_FINISH_GAME = "zf";
    static var MESSAGE_GET_GAME_AGAIN = "zr";
    static var NET_SEND_INTERVAL = 3000;
    static var STATE_DISCONNECTED = 0;
    static var STATE_ATTEMPT_TO_JOIN = 1;
    static var STATE_QUEUEING = 2;
    static var STATE_IN_GAME = 3;
} // End of Class
