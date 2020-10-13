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
        var _loc8 = com.clubpenguin.util.LocaleText.getGameDirectory(movieClip._url);
        com.clubpenguin.util.LocaleText.init(movieClip, undefined, _loc8, undefined, false);
        if (com.clubpenguin.util.Reporting.DEBUG_FPS)
        {
            var _loc7 = new TextFormat();
            _loc7.size = 10;
            movie.createTextField("debugText", 10, 10, 10, 200, 20);
            debugText.setTextFormat(_loc7);
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
        var _loc7 = _global.getCurrentShell();
        _loc7.hideLoading();
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
        var _loc8 = 11193582;
        var _loc7 = _global.getCurrentShell();
        if (_loc7.getMyPlayerHex != undefined)
        {
            _loc8 = _loc7.getMyPlayerHex();
        } // end if
        return (_loc8);
    } // End of the function
    function isMember()
    {
        var _loc8 = false;
        var _loc7 = _global.getCurrentShell();
        if (_loc7.isMyPlayerMember != undefined)
        {
            _loc8 = _loc7.isMyPlayerMember();
        } // end if
        return (_loc8);
    } // End of the function
    function updateFPS()
    {
        var _loc8 = debugFrameTicks - debugFrameTicksLast;
        var _loc7 = "fps: " + _loc8 + " (target = " + com.clubpenguin.games.generic.GenericGameEngine.fpsTarget + ") - FPS ";
        _loc7 = _loc7 + (_loc8 > com.clubpenguin.games.generic.GenericGameEngine.fpsTarget ? ("OK") : ("WARNING!"));
        movie.debugText.text = _loc7;
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
