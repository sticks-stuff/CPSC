class com.clubpenguin.games.generic.GenericGameEngine
{
    var movie, localeTextListener, debugText;
    function GenericGameEngine(movieClip)
    {
        movie = movieClip;
        if (movieClip == undefined)
        {
            com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) no movieclip passed to constructor", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
        } // end if
        com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) about to create localeText listener, is currently set as " + localeTextListener);
        localeTextListener = new Object();
        localeTextListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, localeLoadHandler);
        com.clubpenguin.util.LocaleText.addEventListener(localeTextListener);
        var _loc4 = com.clubpenguin.util.LocaleText.getGameDirectory(movieClip._url);
        com.clubpenguin.util.LocaleText.init(movieClip, undefined, _loc4, undefined, false);
        if (com.clubpenguin.util.Reporting.DEBUG_FPS)
        {
            var _loc2 = new TextFormat();
            _loc2.size = 10;
            movie.createTextField("debugText", 10, 10, 10, 200, 20);
            debugText.setTextFormat(_loc2);
            frameTimer = getTimer();
            debugFrameTicks = 0;
            debugFrameTicksLast = 0;
            setInterval(this, "updateFPS", 1000);
        } // end if
    } // End of the function
    function init()
    {
    } // End of the function
    function update()
    {
    } // End of the function
    function localeLoadHandler()
    {
        com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) load complete handler called");
        com.clubpenguin.util.LocaleText.removeEventListener(localeTextListener);
        localeTextListener = undefined;
        com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) localeText listener removed");
        var _loc3 = _global.getCurrentShell();
        _loc3.hideLoading();
        com.clubpenguin.games.generic.GenericGameEngine.debugTrace("(GenericGameEngine) load screen removed");
        this.init();
    } // End of the function
    function enterFrameHandler()
    {
        if (com.clubpenguin.util.Reporting.DEBUG_FPS)
        {
            ++debugFrameTicks;
        } // end if
        if (getTimer() > frameTimer + com.clubpenguin.games.generic.GenericGameEngine.fpsFrameTime)
        {
            frameTimer = frameTimer + com.clubpenguin.games.generic.GenericGameEngine.fpsFrameTime;
            this.update();
        } // end if
    } // End of the function
    function getPenguinColour()
    {
        var _loc3 = 11193582;
        var _loc2 = _global.getCurrentShell();
        if (_loc2.getMyPlayerHex != undefined)
        {
            _loc3 = _loc2.getMyPlayerHex();
        } // end if
        return (_loc3);
    } // End of the function
    function isMember()
    {
        var _loc2 = false;
        var _loc3 = _global.getCurrentShell();
        if (_loc3.isMyPlayerMember != undefined)
        {
            _loc2 = _loc3.isMyPlayerMember();
        } // end if
        return (_loc2);
    } // End of the function
    function updateFPS()
    {
        var _loc2 = debugFrameTicks - debugFrameTicksLast;
        var _loc3 = "fps: " + _loc2 + " (target = " + com.clubpenguin.games.generic.GenericGameEngine.fpsTarget + ") - FPS ";
        _loc3 = _loc3 + (_loc2 > com.clubpenguin.games.generic.GenericGameEngine.fpsTarget ? ("OK") : ("WARNING!"));
        movie.debugText.text = _loc3;
        debugFrameTicksLast = debugFrameTicks;
    } // End of the function
    function setFPS(newFPS)
    {
        fpsTarget = newFPS;
        fpsFrameTime = 1000 / com.clubpenguin.games.generic.GenericGameEngine.fpsTarget;
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace(message, priority);
        } // end if
    } // End of the function
    static var DEFAULT_FPS = 20;
    static var fpsTarget = com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS;
    static var fpsFrameTime = 1000 / com.clubpenguin.games.generic.GenericGameEngine.fpsTarget;
    var frameTimer = 0;
    var debugFrameTicks = 0;
    var debugFrameTicksLast = 0;
} // End of Class
