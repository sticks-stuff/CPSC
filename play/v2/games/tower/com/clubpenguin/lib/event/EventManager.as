class com.clubpenguin.lib.event.EventManager implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, __listenerObjects;
    static var $_instance, __get__instance;
    function EventManager()
    {
        $_instanceCount = ++com.clubpenguin.lib.event.EventManager.$_instanceCount;
        __uid = com.clubpenguin.lib.event.EventManager.$_instanceCount;
        __listenerObjects = new Array();
    } // End of the function
    static function get instance()
    {
        if (com.clubpenguin.lib.event.EventManager.$_instance == null)
        {
            $_instance = new com.clubpenguin.lib.event.EventManager();
        } // end if
        return (com.clubpenguin.lib.event.EventManager.$_instance);
    } // End of the function
    static function addEventListener(_eventType, _handler, _scope, _context)
    {
        var _loc1;
        _loc1 = com.clubpenguin.lib.event.EventManager.__get__instance().addInternalEventListener(_eventType, _handler, _scope, _context);
        return (_loc1);
    } // End of the function
    function addInternalEventListener(_eventType, _handler, _scope, _context)
    {
        var _loc2;
        _loc2 = false;
        if (!_eventType.length)
        {
        } // end if
        if (!(_handler instanceof Function))
        {
        } // end if
        var _loc3;
        var _loc7;
        var _loc5;
        if (_context == null)
        {
            _loc5 = this;
        }
        else
        {
            _loc5 = _context;
        } // end else if
        _loc3 = com.clubpenguin.lib.event.EventManager.getListenersArray(_loc5, _eventType);
        _loc7 = com.clubpenguin.lib.event.EventManager.getListenerIndex(_loc3, _handler, _scope);
        if (_loc7 == -1)
        {
            _loc3.push(new com.clubpenguin.lib.event.EventListener(_handler, _scope));
            _loc2 = true;
        } // end if
        return (_loc2);
    } // End of the function
    static function removeEventListener(_eventType, _handler, _scope)
    {
        var _loc1;
        _loc1 = com.clubpenguin.lib.event.EventManager.__get__instance().removeInternalEventListener(_eventType, _handler, _scope);
        return (_loc1);
    } // End of the function
    function removeInternalEventListener(_eventType, _handler, _scope)
    {
        var _loc2;
        _loc2 = false;
        if (!_eventType.length)
        {
        } // end if
        if (!(_handler instanceof Function))
        {
        } // end if
        var _loc3;
        var _loc5;
        _loc3 = com.clubpenguin.lib.event.EventManager.getListenersArray(this, _eventType);
        _loc5 = com.clubpenguin.lib.event.EventManager.getListenerIndex(_loc3, _handler, _scope);
        if (_loc5 != -1)
        {
            _loc3.splice(_loc5, 1);
            _loc2 = true;
        } // end if
        return (_loc2);
    } // End of the function
    static function dispatchEvent(_event)
    {
        var _loc1;
        _loc1 = com.clubpenguin.lib.event.EventManager.__get__instance().dispatchInternalEvent(_event);
        return (_loc1);
    } // End of the function
    function dispatchInternalEvent(_event)
    {
        var _loc8;
        var _loc7;
        _loc8 = false;
        if (!_event.__get__type().length)
        {
        } // end if
        _loc7 = _event.__get__target().getUniqueName();
        if (_loc7 == undefined || _loc7 == "")
        {
            _event.__set__target(this);
        } // end if
        var _loc6;
        var _loc5;
        var _loc9;
        var _loc3;
        var _loc2;
        _loc6 = com.clubpenguin.lib.event.EventManager.getListenersArray(this, _event.__get__type()).concat();
        if (_event.__get__target().getUniqueName() == this.getUniqueName())
        {
            _loc5 = new Array();
        }
        else
        {
            _loc5 = com.clubpenguin.lib.event.EventManager.getListenersArray(_event.__get__target(), _event.__get__type()).concat();
        } // end else if
        _loc9 = _loc6.length + _loc5.length;
        if (_loc9 > 0)
        {
            _loc8 = true;
            for (var _loc3 = 0; _loc3 < _loc6.length; ++_loc3)
            {
                _loc2 = _loc6[_loc3];
                _loc2.scope ? (_loc2.handler.call(_loc2.scope, _event)) : (_loc2.handler(_event));
            } // end of for
            for (var _loc3 = 0; _loc3 < _loc5.length; ++_loc3)
            {
                _loc2 = _loc5[_loc3];
                _loc2.scope ? (_loc2.handler.call(_loc2.scope, _event)) : (_loc2.handler(_event));
            } // end of for
        } // end if
        return (_loc8);
    } // End of the function
    static function getListenerIndex(_listeners, _handler, _scope)
    {
        var _loc5 = _listeners.length;
        var _loc1 = 0;
        var _loc2;
        var _loc4;
        _loc4 = -1;
        for (var _loc1 = 0; _loc1 < _loc5; ++_loc1)
        {
            _loc2 = _listeners[_loc1];
            if (_loc2.handler == _handler && (_scope == undefined || _loc2.scope == _scope))
            {
                _loc4 = _loc1;
                continue;
            } // end if
        } // end of for
        return (_loc4);
    } // End of the function
    static function getListenersArray(_eventSource, _eventType)
    {
        var _loc1;
        _loc1 = com.clubpenguin.lib.event.EventManager.__get__instance().listenerObject(_eventSource.getUniqueName());
        if (!_loc1[_eventType])
        {
            _loc1[_eventType] = new Array();
        } // end if
        return (_loc1[_eventType]);
    } // End of the function
    function listenerObject(_context)
    {
        if (__listenerObjects[_context] == null)
        {
            __listenerObjects[_context] = new Array();
        } // end if
        return (__listenerObjects[_context]);
    } // End of the function
    function getUniqueName()
    {
        return ("[EventManager<" + __uid + ">]");
    } // End of the function
    static function dispose()
    {
        com.clubpenguin.lib.event.EventManager.__get__instance().__listenerObjects = new Array();
        com.clubpenguin.lib.event.EventManager.__get__instance().dispatchInternalEvent(new com.clubpenguin.game.net.event.NetClientEvent(new com.clubpenguin.lib.event.IEventDispatcher(), com.clubpenguin.game.net.event.NetClientEvent.NET_REQUEST));
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
