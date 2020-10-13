class com.clubpenguin.tower.display.types.Wave
{
    var __targetTime, __entityType, _stage, __targetPosition, __totalDistance, _view, __currentPosition, __get__position, __get__type;
    function Wave(_targetTime, _entityType, scope, _preview)
    {
        __targetTime = _targetTime;
        __entityType = _entityType;
        _stage = scope;
        __targetPosition = com.clubpenguin.tower.display.types.WaveManager.TARGET_POSITION;
        __totalDistance = com.clubpenguin.tower.display.types.WaveManager.START_POSITION - __targetPosition;
        if (_preview)
        {
            _view = new com.clubpenguin.tower.display.views.WaveView(scope, __entityType);
        } // end if
    } // End of the function
    function get position()
    {
        return (__currentPosition);
    } // End of the function
    function get type()
    {
        return (__entityType);
    } // End of the function
    function update(_currentTimeMillis)
    {
        __currentPosition = __targetPosition + this.getDistanceFromTarget(_currentTimeMillis);
        if (_view != null)
        {
            _view.update(__currentPosition);
        } // end if
    } // End of the function
    function getDistanceFromTarget(_currentTimeMillis)
    {
        var _loc2 = (__targetTime - _currentTimeMillis) / com.clubpenguin.tower.display.types.WaveManager.TIME_ON_SCREEN;
        return (__totalDistance * _loc2);
    } // End of the function
    var __alertOn = false;
    var updateMe = true;
} // End of Class
