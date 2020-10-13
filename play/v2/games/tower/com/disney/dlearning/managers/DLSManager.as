class com.disney.dlearning.managers.DLSManager
{
    var __localConnection;
    static var __learnerID, __host, __developerID, __instance, __get__learnerID, __get__host, __set__host, __get__instance, __set__learnerID;
    function DLSManager()
    {
        __localConnection = new com.disney.dlearning.debug.DLSLocalConnectionProducer();
    } // End of the function
    static function init(learnerId, host, developerId)
    {
        __learnerID = learnerId;
        if (host == null)
        {
            __host = "k.api.dlsnetwork.com";
        }
        else
        {
            __host = host;
        } // end else if
        if (learnerId == null)
        {
            __learnerID = "-1";
        }
        else
        {
            __learnerID = learnerId;
        } // end else if
        if (developerId == null)
        {
            __developerID = "ClubPenguin.v1";
        }
        else
        {
            __developerID = learnerId;
        } // end else if
    } // End of the function
    static function get instance()
    {
        if (com.disney.dlearning.managers.DLSManager.__instance == null)
        {
            __instance = new com.disney.dlearning.managers.DLSManager();
        } // end if
        return (com.disney.dlearning.managers.DLSManager.__instance);
    } // End of the function
    static function set learnerID(id)
    {
        __learnerID = id;
        //return (com.disney.dlearning.managers.DLSManager.learnerID());
        null;
    } // End of the function
    static function get learnerID()
    {
        return (com.disney.dlearning.managers.DLSManager.__learnerID);
    } // End of the function
    static function set host(host)
    {
        __host = host;
        //return (com.disney.dlearning.managers.DLSManager.host());
        null;
    } // End of the function
    static function get host()
    {
        return (com.disney.dlearning.managers.DLSManager.__host);
    } // End of the function
    function pushOpcode2(opcode, guid, callback, register1)
    {
    } // End of the function
    function pushOpcode2Params(opcode, guid, callback, register1, register2)
    {
        var _loc5 = new Date();
        var _loc3 = Math.round(_loc5.getTime() / 1000);
        var _loc4;
        var _loc8 = __URLLoaderCookieId++;
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "")
        {
            __learnerID = "-1";
        } // end if
        if (opcode == "")
        {
            opcode = "no_opcode_given";
        } // end if
        _loc4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + _loc3 + "/" + guid + "/" + register1 + "/" + register2 + "/";
        var _loc6 = this.encryptURL(_loc4, _loc3.toString(), com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(_loc3.toString());
        var _loc2 = new LoadVars();
        _loc2.callback = callback;
        this.configureListeners(_loc2);
        _loc2.addRequestHeader("DLSNetwork-Developer-ID", com.disney.dlearning.managers.DLSManager.__developerID);
        _loc2.addRequestHeader("DLSNetwork-Request-Key", _loc6);
        _loc2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
        try
        {
            _loc2.sendAndLoad(_loc4, _loc2, "POST");
        } // End of try
        catch ()
        {
        } // End of catch
        return (_loc8);
    } // End of the function
    function pushOpcode(opcode, guid, callback, register1, register2, register3)
    {
        var _loc5 = new Date();
        var _loc4 = Math.round(_loc5.getTime() / 1000);
        var _loc3;
        var _loc8 = __URLLoaderCookieId++;
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "")
        {
            __learnerID = "-1";
        } // end if
        if (opcode == "")
        {
            opcode = "no_opcode_given";
        } // end if
        _loc3 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + _loc4 + "/" + guid + "/" + register1 + "/" + register2 + "/" + register3 + "/";
        var _loc6 = this.encryptURL(_loc3, _loc4.toString(), com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(_loc4.toString());
        var _loc2 = new LoadVars();
        _loc2.callback = callback;
        this.configureListeners(_loc2);
        _loc2.addRequestHeader("DLSNetwork-Developer-ID", com.disney.dlearning.managers.DLSManager.__developerID);
        _loc2.addRequestHeader("DLSNetwork-Request-Key", _loc6);
        _loc2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "-1")
        {
            __localConnection.sendMessage("API", _loc3);
        } // end if
        try
        {
            _loc2.sendAndLoad(_loc3, _loc2, "POST");
        } // End of try
        catch ()
        {
        } // End of catch
        return (_loc8);
    } // End of the function
    function pushOpcodeToHost(host, opcode, guid, callback, register1, register2, register3)
    {
        var _loc5 = new Date();
        var _loc4 = Math.round(_loc5.getTime() / 1000);
        var _loc3;
        var _loc8 = __URLLoaderCookieId++;
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "")
        {
            __learnerID = "-1";
        } // end if
        if (opcode == "")
        {
            opcode = "no_opcode_given";
        } // end if
        if (host == "")
        {
            host = "k.api.dlsnetwork.com";
        } // end if
        _loc3 = "http://" + host + "/v1/opcode/pushOpcode/" + opcode + "/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + _loc4 + "/" + guid + "/" + register1 + "/" + register2 + "/" + register3 + "/";
        var _loc6 = this.encryptURL(_loc3, _loc4.toString(), com.disney.dlearning.managers.DLSManager.__developerID) + "|" + this.encryptTime(_loc4.toString());
        var _loc2 = new LoadVars();
        _loc2.callback = callback;
        this.configureListeners(_loc2);
        _loc2.addRequestHeader("DLSNetwork-Developer-ID", com.disney.dlearning.managers.DLSManager.__developerID);
        _loc2.addRequestHeader("DLSNetwork-Request-Key", _loc6);
        _loc2.addRequestHeader("DLSNetwork-Sequence-ID", String(__sequenceID++));
        if (com.disney.dlearning.managers.DLSManager.__learnerID == "-1")
        {
            __localConnection.sendMessage("API", _loc3);
        } // end if
        try
        {
            _loc2.sendAndLoad(_loc3, _loc2, "POST");
        } // End of try
        catch ()
        {
        } // End of catch
        return (_loc8);
    } // End of the function
    function getAvailableContent(callback, sortingOrder)
    {
        var _loc3 = __URLLoaderCookieId++;
        __URLCallbacks[_loc3] = callback;
        var _loc4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/reports/getAvailableContent/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + sortingOrder + "/";
        var _loc2 = new LoadVars();
        _loc2.callback = callback;
        this.configureListeners(_loc2);
        try
        {
            _loc2.load(_loc4);
        } // End of try
        catch ()
        {
        } // End of catch
        return (_loc3);
    } // End of the function
    function getLearnerScores(callback)
    {
        var _loc2 = __URLLoaderCookieId++;
        __URLCallbacks[_loc2] = callback;
        var _loc4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/reports/getLearnerScores/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/";
        var _loc3 = new LoadVars();
        _loc3.callback = callback;
        try
        {
            _loc3.load(_loc4);
        } // End of try
        catch ()
        {
        } // End of catch
        return (_loc2);
    } // End of the function
    function getLearnerScoreByNode(guid, callback)
    {
        var _loc3 = __URLLoaderCookieId++;
        __URLCallbacks[_loc3] = callback;
        var _loc4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/reports/getLearnerScoreByNode/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + guid + "/";
        var _loc2 = new LoadVars();
        _loc2.callback = callback;
        this.configureListeners(_loc2);
        _loc2.learner = com.disney.dlearning.managers.DLSManager.__learnerID;
        try
        {
            _loc2.load(_loc4);
        } // End of try
        catch ()
        {
        } // End of catch
        return (_loc3);
    } // End of the function
    function isContentUnlocked(guid, callback)
    {
        var _loc3 = __URLLoaderCookieId++;
        __URLCallbacks[_loc3] = callback;
        var _loc4 = "http://" + com.disney.dlearning.managers.DLSManager.__host + "/v1/content/getAvailableContent/" + com.disney.dlearning.managers.DLSManager.__learnerID + "/" + guid + "/";
        var _loc2 = new LoadVars();
        _loc2.callback = callback;
        this.configureListeners(_loc2);
        try
        {
            _loc2.load(_loc4);
        } // End of try
        catch ()
        {
        } // End of catch
        return (_loc3);
    } // End of the function
    function callback()
    {
    } // End of the function
    function configureListeners(target)
    {
        target.hostThis = this;
    } // End of the function
    function encryptURL(url, timestamp, developerId)
    {
        var _loc2 = new com.disney.dlearning.security.Md5();
        var _loc1 = url + timestamp + developerId + "_Salt";
        var _loc3 = _loc2.hash(_loc1);
        return (_loc3);
    } // End of the function
    function encryptTime(time)
    {
        return (time);
    } // End of the function
    var __URLLoaderCookieId = 0;
    var __URLCallbacks = new Array();
    var __sequenceID = 0;
} // End of Class
