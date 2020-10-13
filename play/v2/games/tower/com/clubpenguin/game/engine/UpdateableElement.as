class com.clubpenguin.game.engine.UpdateableElement implements com.clubpenguin.game.engine.IEngineUpdateable
{
    var __element, __frequency, __carryOverTime, __totalUpdates;
    function UpdateableElement(_element, _frequency)
    {
        __element = _element;
        __frequency = _frequency;
        __carryOverTime = 0;
        __totalUpdates = 0;
    } // End of the function
    function update(_tick, _currUpdate)
    {
        var _loc4;
        var _loc3;
        var _loc2;
        _loc4 = _tick + __carryOverTime;
        if (__frequency == 1)
        {
            __carryOverTime = _loc4;
            _loc3 = 1;
        }
        else
        {
            __carryOverTime = _loc4 % __frequency;
            _loc3 = (_loc4 - __carryOverTime) / __frequency;
        } // end else if
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            __element.update(__carryOverTime, _loc3 - _loc2);
        } // end of for
        __totalUpdates = __totalUpdates + _loc3;
    } // End of the function
    function matches(_element)
    {
        var _loc2;
        _loc2 = false;
        if (__element == _element)
        {
            _loc2 = true;
        } // end if
        return (_loc2);
    } // End of the function
    function dispose()
    {
        __element = null;
        __frequency = 0;
        __carryOverTime = 0;
        __totalUpdates = 0;
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "[UpdateableElement] _element:" + __element + ", _frequency:" + __frequency;
        return (_loc2);
    } // End of the function
} // End of Class
