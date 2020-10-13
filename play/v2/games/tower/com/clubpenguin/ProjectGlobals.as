class com.clubpenguin.ProjectGlobals implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, __debugMode, __host, __localeID, __get__debug, __shell, __interface, __get__currInterface, __set__debug, __get__worldShell;
    static var $_instance, __get__instance, __get__debugMode, __set__debugMode, __get__host, __get__shell, __get__worldInterface;
    function ProjectGlobals()
    {
        $_instanceCount = ++com.clubpenguin.ProjectGlobals.$_instanceCount;
        __uid = com.clubpenguin.ProjectGlobals.$_instanceCount;
        __debugMode = com.clubpenguin.ProjectGlobals.DEBUG_MODE;
        com.clubpenguin.util.Reporting.DEBUG_FPS = false;
    } // End of the function
    function getUniqueName()
    {
        return ("[ProjectGlobals<" + __uid + ">]");
    } // End of the function
    static function get instance()
    {
        if (com.clubpenguin.ProjectGlobals.$_instance == null)
        {
            $_instance = new com.clubpenguin.ProjectGlobals();
        } // end if
        return (com.clubpenguin.ProjectGlobals.$_instance);
    } // End of the function
    static function initGlobals(_host)
    {
        com.clubpenguin.ProjectGlobals.__get__instance().init(_host);
    } // End of the function
    function init(_host)
    {
        var _loc2;
        if (__host != null)
        {
            __host = null;
        } // end if
        __host = _host;
        this.setupSecurity();
        this.setupShell();
        this.setupLocale();
        _loc2 = com.clubpenguin.lib.locale.LocaleText.getGameDirectory(__host._url);
        com.clubpenguin.lib.locale.LocaleText.init(__host, __localeID, _loc2, undefined, false);
    } // End of the function
    static function set debugMode(_val)
    {
        com.clubpenguin.ProjectGlobals.$_instance.__set__debug(_val);
        //return (com.clubpenguin.ProjectGlobals.debugMode());
        null;
    } // End of the function
    static function get debugMode()
    {
        //return (com.clubpenguin.ProjectGlobals.$_instance.debug());
    } // End of the function
    function set debug(_val)
    {
        __debugMode = _val;
        //return (this.debug());
        null;
    } // End of the function
    function get debug()
    {
        return (__debugMode);
    } // End of the function
    function setupSecurity()
    {
        if (!com.clubpenguin.ProjectGlobals.__get__debugMode())
        {
            com.clubpenguin.security.Security.doSecurityCheck(__host._url, __host._parent);
        } // end if
    } // End of the function
    static function get host()
    {
        //return (com.clubpenguin.ProjectGlobals.instance().__host);
    } // End of the function
    function setupShell()
    {
        if (__shell != null)
        {
            __shell = null;
        } // end if
        __shell = _global.getCurrentShell();
    } // End of the function
    function setupLocale()
    {
        if (__shell != null && __shell.getLocalizedFrame != undefined)
        {
            __localeID = __shell.getLocalizedFrame();
        } // end if
        if (__localeID == undefined || isNaN(__localeID))
        {
            __localeID = com.clubpenguin.lib.locale.LocaleText.LANG_ID_DEFAULT;
        } // end if
    } // End of the function
    static function get shell()
    {
        //return (com.clubpenguin.ProjectGlobals.instance().__get__worldShell());
    } // End of the function
    function get worldShell()
    {
        __shell = _global.getCurrentShell();
        if (__shell == null)
        {
            __shell = new Object();
        } // end if
        return (__shell);
    } // End of the function
    static function get worldInterface()
    {
        //return (com.clubpenguin.ProjectGlobals.instance().__get__currInterface());
    } // End of the function
    function get currInterface()
    {
        __interface = _global.getCurrentInterface();
        return (__interface);
    } // End of the function
    function dTrace(_msg, _override)
    {
        if (__debugMode || _override)
        {
        } // end if
    } // End of the function
    function toString()
    {
        var _loc1;
        _loc1 = "[ProjectGlobals]";
        return (_loc1);
    } // End of the function
    static var DEBUG_MODE = true;
    static var $_instanceCount = 0;
} // End of Class
