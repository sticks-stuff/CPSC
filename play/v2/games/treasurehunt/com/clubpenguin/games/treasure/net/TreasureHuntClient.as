class com.clubpenguin.games.treasure.net.TreasureHuntClient
{
    var gameEngine, smartFox, playerData, netData, SHELL, roomID, AIRTOWER, gameOverDelay;
    function TreasureHuntClient(gameEngineReference)
    {
        gameEngine = gameEngineReference;
        smartFox = _root.smartfox;
        playerData = _root.myPlayer;
        netData = _root.myTable;
        SHELL = _global.getCurrentShell();
        roomID = SHELL.getCurrentGameRoomId();
    } // End of the function
    function init()
    {
        AIRTOWER = _global.getCurrentAirtower();
        AIRTOWER.addListener("gz", handleGetGameMessage, this);
        AIRTOWER.addListener("jz", handleJoinGameMessage, this);
        AIRTOWER.addListener("lz", handleAbortGameMessage, this);
        AIRTOWER.addListener("uz", handleUpdateGameMessage, this);
        AIRTOWER.addListener("sz", handleStartGameMessage, this);
        AIRTOWER.addListener("cz", handleCloseGameMessage, this);
        AIRTOWER.addListener("zm", handlePlayerDigMessage, this);
        AIRTOWER.addListener("zo", handleGameOverMessage, this);
    } // End of the function
    function destroy()
    {
        AIRTOWER.removeListener("gz", handleGetGameMessage, this);
        AIRTOWER.removeListener("jz", handleJoinGameMessage, this);
        AIRTOWER.removeListener("lz", handleAbortGameMessage, this);
        AIRTOWER.removeListener("uz", handleUpdateGameMessage, this);
        AIRTOWER.removeListener("sz", handleStartGameMessage, this);
        AIRTOWER.removeListener("cz", handleCloseGameMessage, this);
        AIRTOWER.removeListener("zm", handlePlayerDigMessage, this);
        AIRTOWER.removeListener("zo", handleGameOverMessage, this);
    } // End of the function
    function sendGetGameMessage()
    {
        this.debugTrace("sendGetGameMessage");
        AIRTOWER.send(com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.treasure.net.TreasureHuntClient.MESSAGE_GET_GAME, "", com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function sendJoinGameMessage(seatID)
    {
        this.debugTrace("sendJoinGameMessage - seatID:" + seatID);
        if (seatID == undefined)
        {
            AIRTOWER.send(com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.treasure.net.TreasureHuntClient.MESSAGE_JOIN_GAME, "", com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
        }
        else
        {
            AIRTOWER.send(com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.treasure.net.TreasureHuntClient.MESSAGE_JOIN_GAME, [seatID], com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
        } // end else if
    } // End of the function
    function sendDigMessage(buttonName, buttonDir, buttonNum)
    {
        this.debugTrace("sendDigMessage - buttonName:" + buttonName + ", buttonDir:" + buttonDir + ", buttonNum:" + buttonNum);
        AIRTOWER.send(com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.treasure.net.TreasureHuntClient.MESSAGE_PLAYER_DIG, [buttonName, buttonDir, buttonNum], com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function sendLeaveMessage()
    {
        AIRTOWER.send(com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_EXTENSION_NAME, com.clubpenguin.games.treasure.net.TreasureHuntClient.MESSAGE_LEAVE_GAME, "", com.clubpenguin.games.treasure.net.TreasureHuntClient.SERVER_SIDE_MESSAGE_TYPE, roomID);
    } // End of the function
    function handleGetGameMessage(resObj)
    {
        this.debugTrace("handleGetGameMessage");
        this.debugTrace("smartRoomID: " + resObj[0]);
        this.debugTrace("player1Name: " + resObj[1]);
        this.debugTrace("player2Name: " + resObj[2]);
        var _loc3 = new Object();
        _loc3.player1Name = resObj[1];
        _loc3.player2Name = resObj[2];
        if (_loc3.player1Name == "" || _loc3.player2Name == "")
        {
            if (_loc3.player1Name != "")
            {
                gameEngine.updatePlayerNames(0, _loc3.player1Name);
            } // end if
            if (_loc3.player2Name != "")
            {
                gameEngine.updatePlayerNames(1, _loc3.player2Name);
            } // end if
            this.sendJoinGameMessage();
        }
        else
        {
            this.debugTrace("MAP_WIDTH: " + resObj[3]);
            this.debugTrace("MAP_HEIGHT: " + resObj[4]);
            this.debugTrace("COIN_NUM_HIDDEN: " + resObj[5]);
            this.debugTrace("GEM_NUM_HIDDEN: " + resObj[6]);
            this.debugTrace("NUM_TURNS: " + resObj[7]);
            this.debugTrace("GEM_VALUE: " + resObj[8]);
            this.debugTrace("COIN_VALUE: " + resObj[9]);
            this.debugTrace("gemLocations: " + resObj[10]);
            this.debugTrace("treasureMap: " + resObj[11]);
            this.debugTrace("totalGemsFound: " + resObj[12]);
            this.debugTrace("totalCoinsFound: " + resObj[13]);
            this.debugTrace("superRareGemFound: " + resObj[14]);
            this.debugTrace("digRecordNames: " + resObj[15]);
            this.debugTrace("digRecordDirections: " + resObj[16]);
            this.debugTrace("digRecordNumbers: " + resObj[17]);
            _loc3.MAP_WIDTH = parseInt(resObj[3]);
            _loc3.MAP_HEIGHT = parseInt(resObj[4]);
            _loc3.COIN_NUM_HIDDEN = parseInt(resObj[5]);
            _loc3.GEM_NUM_HIDDEN = parseInt(resObj[6]);
            _loc3.NUM_TURNS = parseInt(resObj[7]);
            _loc3.GEM_VALUE = parseInt(resObj[8]);
            _loc3.COIN_VALUE = parseInt(resObj[9]);
            _loc3.gemLocations = resObj[10];
            _loc3.treasureMap = resObj[11];
            _loc3.totalGemsFound = resObj[12];
            _loc3.totalCoinsFound = resObj[13];
            _loc3.superRareGemFound = resObj[14];
            _loc3.digRecordNames = resObj[15];
            _loc3.digRecordDirections = resObj[16];
            _loc3.digRecordNumbers = resObj[17];
            gameEngine.spectateGame(_loc3);
        } // end else if
    } // End of the function
    function handleJoinGameMessage(resObj)
    {
        this.debugTrace("handleJoinGameMessage");
        this.debugTrace("smartRoomID: " + resObj[0]);
        this.debugTrace("seatID: " + resObj[1]);
        var _loc3 = parseInt(resObj[1]);
        gameEngine.updatePlayerSeatID(_loc3);
    } // End of the function
    function handleStartGameMessage(resObj)
    {
        this.debugTrace("handleStartGameMessage");
        this.debugTrace("smartRoomID: " + resObj[0]);
        this.debugTrace("player1Name: " + resObj[1]);
        this.debugTrace("player2Name: " + resObj[2]);
        this.debugTrace("MAP_WIDTH: " + resObj[3]);
        this.debugTrace("MAP_HEIGHT: " + resObj[4]);
        this.debugTrace("COIN_NUM_HIDDEN: " + resObj[5]);
        this.debugTrace("GEM_NUM_HIDDEN: " + resObj[6]);
        this.debugTrace("NUM_TURNS: " + resObj[7]);
        this.debugTrace("GEM_VALUE: " + resObj[8]);
        this.debugTrace("COIN_VALUE: " + resObj[9]);
        this.debugTrace("gemLocations: " + resObj[10]);
        this.debugTrace("treasureMap: " + resObj[11]);
        var _loc3 = new Object();
        _loc3.player1Name = resObj[1];
        _loc3.player2Name = resObj[2];
        _loc3.MAP_WIDTH = parseInt(resObj[3]);
        _loc3.MAP_HEIGHT = parseInt(resObj[4]);
        _loc3.COIN_NUM_HIDDEN = parseInt(resObj[5]);
        _loc3.GEM_NUM_HIDDEN = parseInt(resObj[6]);
        _loc3.NUM_TURNS = parseInt(resObj[7]);
        _loc3.GEM_VALUE = parseInt(resObj[8]);
        _loc3.COIN_VALUE = parseInt(resObj[9]);
        _loc3.gemLocations = resObj[10];
        _loc3.treasureMap = resObj[11];
        gameEngine.initMultiplayer(_loc3);
    } // End of the function
    function handleUpdateGameMessage(resObj)
    {
        this.debugTrace("handleUpdateGameMessage");
        this.debugTrace("smartRoomID: " + resObj[0]);
        this.debugTrace("seatID: " + resObj[1]);
        this.debugTrace("nickname: " + resObj[2]);
        var _loc3 = parseInt(resObj[1]);
        var _loc4 = resObj[2];
        gameEngine.updatePlayerNames(_loc3, _loc4);
    } // End of the function
    function handlePlayerDigMessage(resObj)
    {
        this.debugTrace("handlePlayerDigMessage");
        this.debugTrace("smartRoomID: " + resObj[0]);
        this.debugTrace("buttonName: " + resObj[1]);
        this.debugTrace("buttonDir: " + resObj[2]);
        this.debugTrace("buttonNum: " + resObj[3]);
        var _loc5 = resObj[1];
        var _loc3 = resObj[2];
        var _loc4 = parseInt(resObj[3]);
        gameEngine.onDigButtonClick(_loc5, _loc3, _loc4);
    } // End of the function
    function handleCloseGameMessage(resObj)
    {
        this.debugTrace("handleCloseGameMessage");
        gameEngine.showGameOver();
    } // End of the function
    function handleAbortGameMessage(resObj)
    {
        this.debugTrace("handleAbortGameMessage");
        this.debugTrace("smartRoomID: " + resObj[0]);
        this.debugTrace("nickname: " + resObj[1]);
        var _loc3 = resObj[1] == undefined ? ("") : (resObj[1]);
        gameEngine.showGameAborted(_loc3);
    } // End of the function
    function handleGameOverMessage(resObj)
    {
        this.debugTrace("handleGameOverMessage");
        this.debugTrace("smartRoomID: " + resObj[0]);
        this.debugTrace("totalCoinsFound: " + resObj[1]);
        this.debugTrace("totalGemsFound: " + resObj[2]);
        this.debugTrace("totalScore: " + resObj[3]);
        var _loc3 = parseInt(resObj[1]);
        var _loc5 = parseInt(resObj[2]);
        var _loc4 = parseInt(resObj[3]);
        clearInterval(gameOverDelay);
        gameOverDelay = setInterval(gameEngine, "showGameOver", 3000);
    } // End of the function
    function debugTrace(msg)
    {
        if (com.clubpenguin.games.treasure.net.TreasureHuntClient.DEBUG)
        {
        } // end if
    } // End of the function
    static var DEBUG = true;
    static var MESSAGE_GET_GAME = "gz";
    static var MESSAGE_JOIN_GAME = "jz";
    static var MESSAGE_LEAVE_GAME = "lz";
    static var MESSAGE_PLAYER_DIG = "zm";
    static var MESSAGE_START_GAME = "sz";
    static var MESSAGE_UPDATE_PLAYERLIST = "uz";
    static var MESSAGE_ABORT_GAME = "cz";
    static var MESSAGE_GAME_OVER = "zo";
    static var SERVER_SIDE_EXTENSION_NAME = "z";
    static var SERVER_SIDE_MESSAGE_TYPE = "str";
} // End of Class
