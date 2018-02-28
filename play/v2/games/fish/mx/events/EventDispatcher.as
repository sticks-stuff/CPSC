class mx.events.EventDispatcher
{
    var _loc7;
    function EventDispatcher()
    {
    } // End of the function
    static function _removeEventListener(queue, event, handler)
    {
        if (queue != undefined)
        {
            var _loc10 = queue.length;
            var _loc9;
            for (var _loc9 = 0; _loc9 < _loc10; ++_loc9)
            {
                var _loc7 = queue[_loc9];
                if (_loc7 == handler)
                {
                    queue.splice(_loc9, 1);
                    return;
                } // end if
            } // end of for
        } // end if
    } // End of the function
    static function initialize(object)
    {
        if (mx.events.EventDispatcher._fEventDispatcher == undefined)
        {
            _fEventDispatcher = new mx.events.EventDispatcher();
        } // end if
        object.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
        object.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
        object.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
        object.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
    } // End of the function
    function dispatchQueue(queueObj, eventObj)
    {
        var _loc12 = "__q_" + eventObj.type;
        var _loc11 = queueObj[_loc12];
        if (_loc11 != undefined)
        {
            var _loc10;
            for (var _loc10 in _loc11)
            {
                var _loc8 = _loc11[_loc10];
                var _loc7 = typeof(_loc8);
                if (_loc7 == "object" || _loc7 == "movieclip")
                {
                    if (_loc8.handleEvent != undefined)
                    {
                        _loc8.handleEvent(eventObj);
                    } // end if
                    if (_loc8[eventObj.type] != undefined)
                    {
                        if (mx.events.EventDispatcher.exceptions[eventObj.type] == undefined)
                        {
                            _loc8[eventObj.type](eventObj);
                        } // end if
                    } // end if
                    continue;
                } // end if
                _loc8.apply(queueObj, [eventObj]);
            } // end of for...in
        } // end if
    } // End of the function
    function dispatchEvent(eventObj)
    {
        if (eventObj.target == undefined)
        {
            eventObj.target = this;
        } // end if
        this[eventObj.type + "Handler"](eventObj);
        this.dispatchQueue(this, eventObj);
    } // End of the function
    function addEventListener(event, handler)
    {
        var _loc7 = "__q_" + event;
        if (this[_loc7] == undefined)
        {
            this[_loc7] = new Array();
        } // end if
        _global.ASSetPropFlags(this, _loc7, 1);
        mx.events.EventDispatcher._removeEventListener(this[_loc7], event, handler);
        this[_loc7].push(handler);
    } // End of the function
    function removeEventListener(event, handler)
    {
        var _loc7 = "__q_" + event;
        mx.events.EventDispatcher._removeEventListener(this[_loc7], event, handler);
    } // End of the function
    static var _fEventDispatcher = undefined;
    static var exceptions = {load: 1, draw: 1, move: 1};
} // End of Class
