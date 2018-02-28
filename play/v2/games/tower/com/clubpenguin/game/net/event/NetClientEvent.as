class com.clubpenguin.game.net.event.NetClientEvent extends com.clubpenguin.lib.event.Event
{
    var __netMessage, __eventData, __eventType, __eventDispatcher, __get__message;
    function NetClientEvent(_source, _type, _message, _data)
    {
        super(_source, _type, _data);
        __netMessage = _message;
    } // End of the function
    function clone()
    {
        var _loc2;
        _loc2 = this.createEvent();
        return (_loc2);
    } // End of the function
    function createEvent()
    {
        return (new com.clubpenguin.game.net.event.NetClientEvent(__eventDispatcher, __eventType, __netMessage, __eventData));
    } // End of the function
    function get message()
    {
        return (__netMessage);
    } // End of the function
    static var NET_REQUEST = "netClientRequest";
    static var NET_RECEIVE = "netClientReceive";
    static var REQ_GAME_CONNECT = "ncRequestGameConnect";
    static var REC_GAME_CONNECT = "ncReceiveGameConnect";
    static var REQ_GAME_JOIN = "ncRequestGameJoin";
    static var REC_GAME_JOIN = "ncReceiveGameJoin";
    static var REQ_GAME_LEAVE = "ncRequestGameLeave";
    static var REC_GAME_LEAVE = "ncReceiveGameLeave";
    static var REQ_GAME_PLAYERS = "ncRequestGamePlayers";
    static var REC_GAME_PLAYERS = "ncReceiveGamePlayers";
    static var REQ_GAME_START = "ncRequestGameStart";
    static var REC_GAME_START = "ncReceiveGameStart";
    static var REQ_GAME_ABORT = "ncRequestGameAbort";
    static var REC_GAME_ABORT = "ncReceiveGameAbort";
    static var REQ_GAME_ACTION = "ncRequestGameAction";
    static var REC_GAME_ACTION = "ncReceiveGameAction";
    static var REQ_GAME_OVER = "ncRequestGameOver";
    static var REC_GAME_OVER = "ncReceiveGameOver";
    static var REQ_GAME_ERROR = "ncRequestGameError";
    static var REC_GAME_ERROR = "ncReceiveGameError";
    static var REC_STAMP_INFORMATION = "ncStampInfo";
} // End of Class
