class com.clubpenguin.game.engine.GenericGameEngine extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __paused, __running, __elements, __keys, onKeyDown, onKeyUp, createTextField, debugText, onEnterFrame, __carryOverTime, __get__engineRunning, __get__paused;
    static var $_updateCounter, $_lastTime;
    function GenericGameEngine()
    {
        super();
        __paused = false;
        __running = false;
        this.setupLocaleBeforeStartup();
    } // End of the function
    function setupLocaleBeforeStartup()
    {
        com.clubpenguin.lib.event.EventManager.addEventListener(com.clubpenguin.lib.event.LocaleTextEvent.LOAD_COMPLETE, localeLoadHandler, this);
        com.clubpenguin.ProjectGlobals.initGlobals(this);
    } // End of the function
    function localeLoadHandler()
    {
        com.clubpenguin.lib.event.EventManager.removeEventListener(com.clubpenguin.lib.event.LocaleTextEvent.LOAD_COMPLETE, localeLoadHandler, this);
        this.setupDeterministicTimer();
    } // End of the function
    function setupDeterministicTimer()
    {
        $_updateCounter = 0;
        __elements = new Array();
        __keys = new Array();
        this.setupKeyboardListeners();
    } // End of the function
    function setupKeyboardListeners()
    {
        Key.addListener(this);
        onKeyDown = keyDownHandler;
        onKeyUp = keyUpHandler;
        this.configCompleteLaunchGame();
    } // End of the function
    function configCompleteLaunchGame()
    {
        this.hideShellLoader();
        this.init();
    } // End of the function
    function init()
    {
    } // End of the function
    function hideShellLoader()
    {
        com.clubpenguin.ProjectGlobals.__get__shell().hideLoading();
    } // End of the function
    function update()
    {
    } // End of the function
    function enterFrameHandler()
    {
        if (com.clubpenguin.util.Reporting.DEBUG_FPS)
        {
            ++debugFrameTicks;
        } // end if
        if (getTimer() > frameTimer + com.clubpenguin.game.engine.GenericGameEngine.fpsFrameTime)
        {
            frameTimer = frameTimer + com.clubpenguin.game.engine.GenericGameEngine.fpsFrameTime;
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
    function setupDebug()
    {
        if (com.clubpenguin.util.Reporting.DEBUG_FPS)
        {
            var _loc2 = new TextFormat();
            _loc2.size = 10;
            this.createTextField("debugText", 10, 10, 10, 200, 20);
            debugText.setTextFormat(_loc2);
            frameTimer = getTimer();
            debugFrameTicks = 0;
            debugFrameTicksLast = 0;
            setInterval(this, "updateFPS", 1000);
        } // end if
    } // End of the function
    function updateFPS()
    {
        var _loc2 = debugFrameTicks - debugFrameTicksLast;
        var _loc3 = "fps: " + _loc2 + " (target = " + com.clubpenguin.game.engine.GenericGameEngine.fpsTarget + ") - FPS ";
        _loc3 = _loc3 + (_loc2 > com.clubpenguin.game.engine.GenericGameEngine.fpsTarget ? ("OK") : ("WARNING!"));
        debugText.text = _loc3;
        debugFrameTicksLast = debugFrameTicks;
    } // End of the function
    function setFPS(newFPS)
    {
        fpsTarget = newFPS;
        fpsFrameTime = 1000 / com.clubpenguin.game.engine.GenericGameEngine.fpsTarget;
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace(message, priority);
        } // end if
    } // End of the function
    function keyDownHandler()
    {
        var _loc3;
        var _loc2;
        var _loc4;
        _loc2 = Key.getCode();
        _loc4 = Key.getAscii();
        if (__keys[_loc2] == null || __keys[_loc2] == com.clubpenguin.lib.event.KeyEvent.RELEASED)
        {
            __keys[_loc2] = com.clubpenguin.lib.event.KeyEvent.PRESSED;
            _loc3 = new com.clubpenguin.lib.event.KeyEvent(this, com.clubpenguin.lib.event.KeyEvent.PRESSED, _loc2);
            _loc3.__set__ascii(_loc4);
            _loc3.__set__code(_loc2);
            com.clubpenguin.lib.event.EventManager.dispatchEvent(_loc3);
        } // end if
    } // End of the function
    function keyUpHandler()
    {
        var _loc3;
        var _loc2;
        var _loc4;
        _loc2 = Key.getCode();
        _loc4 = Key.getAscii();
        if (__keys[_loc2] == com.clubpenguin.lib.event.KeyEvent.PRESSED)
        {
            __keys[_loc2] = com.clubpenguin.lib.event.KeyEvent.RELEASED;
            _loc3 = new com.clubpenguin.lib.event.KeyEvent(this, com.clubpenguin.lib.event.KeyEvent.RELEASED, _loc2);
            _loc3.__set__ascii(_loc4);
            _loc3.__set__code(_loc2);
            com.clubpenguin.lib.event.EventManager.dispatchEvent(_loc3);
        } // end if
    } // End of the function
    function startEngine()
    {
        if (!__running)
        {
            $_lastTime = getTimer() - com.clubpenguin.game.engine.GenericGameEngine.$_updateFrequency;
            __running = true;
            onEnterFrame = updateEngine;
        } // end if
    } // End of the function
    function pauseEngine()
    {
        __paused = true;
        __running = false;
        this.stopEngine();
    } // End of the function
    function unpauseEngine()
    {
        __paused = false;
        __running = true;
        $_lastTime = getTimer() - (com.clubpenguin.game.engine.GenericGameEngine.$_updateFrequency - __carryOverTime);
        onEnterFrame = updateEngine;
    } // End of the function
    function stopEngine()
    {
        __running = false;
        delete this.onEnterFrame;
    } // End of the function
    function get engineRunning()
    {
        return (__running);
    } // End of the function
    function updateEngine(_overrideElapsed)
    {
        var _loc2;
        var _loc3;
        _loc2 = getTimer();
        _loc3 = _loc2 - com.clubpenguin.game.engine.GenericGameEngine.$_lastTime;
        if (!isNaN(_overrideElapsed))
        {
            _loc3 = _overrideElapsed;
        } // end if
        this.updateRegisteredElements(_loc3);
        $_lastTime = _loc2;
    } // End of the function
    function updateRegisteredElements(_tick)
    {
        var _loc2;
        var _loc3;
        for (var _loc2 = 0; _loc2 < __elements.length; ++_loc2)
        {
            _loc3 = __elements[_loc2];
            _loc3.update(_tick);
        } // end of for
    } // End of the function
    function register(_element, _frequency)
    {
        var _loc2;
        var _loc3;
        _loc2 = false;
        _loc3 = new com.clubpenguin.game.engine.UpdateableElement(_element, _frequency);
        __elements.push(_loc3);
        return (_loc2);
    } // End of the function
    function unregister(_element)
    {
        var _loc5;
        var _loc2;
        var _loc3;
        for (var _loc2 = 0; _loc2 < __elements.length; ++_loc2)
        {
            _loc3 = __elements[_loc2];
            if (_loc3.matches(_element))
            {
                __elements.splice(_loc2, 1);
                _loc3.dispose();
                _loc3 = null;
                continue;
                continue;
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
    function getUniqueName()
    {
        return ("GenericGameEngine");
    } // End of the function
    function get paused()
    {
        return (__paused);
    } // End of the function
    static var DEFAULT_FPS = 20;
    static var fpsTarget = com.clubpenguin.game.engine.GenericGameEngine.DEFAULT_FPS;
    static var fpsFrameTime = 1000 / com.clubpenguin.game.engine.GenericGameEngine.fpsTarget;
    var frameTimer = 0;
    var debugFrameTicks = 0;
    var debugFrameTicksLast = 0;
    static var $_updateFrequency = 42;
} // End of Class
