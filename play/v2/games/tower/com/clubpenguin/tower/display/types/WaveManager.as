class com.clubpenguin.tower.display.types.WaveManager
{
    var _stage, __waveData, __elements;
    function WaveManager(scope)
    {
        _stage = scope;
        __waveData = new Array();
    } // End of the function
    function load(_elements, _preview)
    {
        var _loc2;
        _loc2 = this.getWaveInformationFromScenario(_elements);
        this.loadData(_loc2[0], _loc2[1], _preview);
    } // End of the function
    function update(_currentTimeMillis)
    {
        var _loc3 = Math.floor(_currentTimeMillis / com.clubpenguin.tower.display.types.WaveManager.DATA_ARRAY_SUBDIVISION_MILLIS) - 1;
        var _loc6 = 3;
        for (var _loc2 = _loc3; _loc2 < _loc3 + _loc6; ++_loc2)
        {
            if (__waveData[_loc2] == null)
            {
                continue;
            } // end if
            for (var _loc5 in __waveData[_loc2])
            {
                __waveData[_loc2][_loc5].update(_currentTimeMillis);
            } // end of for...in
        } // end of for
    } // End of the function
    function loadData(_waveTimes, _waveTypes, _preview)
    {
        var _loc2;
        for (var _loc6 in _waveTimes)
        {
            _loc2 = Math.floor(_waveTimes[_loc6] / com.clubpenguin.tower.display.types.WaveManager.DATA_ARRAY_SUBDIVISION_MILLIS);
            if (__waveData[_loc2] == undefined)
            {
                __waveData[_loc2] = new Array();
            } // end if
            __waveData[_loc2].push(new com.clubpenguin.tower.display.types.Wave(_waveTimes[_loc6], _waveTypes[_loc6], _stage, _preview));
        } // end of for...in
    } // End of the function
    function getWaveInformationFromScenario(_elements)
    {
        __elements = _elements;
        var _loc13 = new Array();
        var _loc14 = new Array();
        var _loc7 = 0;
        var _loc16;
        var _loc15;
        var _loc11;
        _loc16 = _elements.length;
        for (var _loc3 = 0; _loc3 < _loc16; ++_loc3)
        {
            _loc15 = _elements[_loc3];
            _loc11 = _loc15.getType();
            if (_loc11 == com.clubpenguin.tower.levels.DialogueData.TYPE)
            {
                var _loc12 = _elements[_loc3];
                _loc7 = _loc7 + _loc12.nextWaveDelay;
                continue;
            } // end if
            if (_loc11 == com.clubpenguin.tower.levels.WaveData.TYPE)
            {
                var _loc6 = _elements[_loc3];
                var _loc9 = _loc6.__get__delay();
                var _loc4 = _loc6.__get__enemies();
                var _loc5;
                var _loc2;
                var _loc8;
                _loc8 = _loc4.length;
                for (var _loc2 = 0; _loc2 < _loc8; ++_loc2)
                {
                    _loc5 = _loc4[_loc2];
                    _loc13.push(_loc7 + _loc9 * _loc2);
                    _loc14.push(_loc5.__get__type());
                } // end of for
                _loc7 = _loc7 + _loc6.nextWaveDelay;
            } // end if
        } // end of for
        var _loc17 = new Array();
        _loc17.push(_loc13);
        _loc17.push(_loc14);
        return (_loc17);
    } // End of the function
    function cleanUp()
    {
        __waveData = null;
        __elements = null;
    } // End of the function
    static var DATA_ARRAY_SUBDIVISION_MILLIS = 10000;
    static var TIME_ON_SCREEN = 10000;
    static var START_POSITION = 260;
    static var TARGET_POSITION = 700;
} // End of Class
