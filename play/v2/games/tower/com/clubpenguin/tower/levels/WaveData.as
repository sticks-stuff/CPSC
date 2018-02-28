class com.clubpenguin.tower.levels.WaveData extends com.clubpenguin.tower.util.EventDispatcher implements com.clubpenguin.tower.levels.interfaces.IStoryElement
{
    var __id, __enemies, __path, __lastTime, __updateMe, __spawned, __nextElementEvent, __nextElementEventData, __checkSpawnNextElement, __delay, dispatchEvent, __spawnedNextElement, __currTime, __endDelay, __startDelay, __get__delay, __currEnemy, __set__delay, __get__enemies, __get__id, __get__nextWaveDelay, __get__type;
    function WaveData(_path, _nextElementEvent, _nextElementEventData)
    {
        super();
        __id = com.clubpenguin.tower.levels.types.AbstractLevel.__elementIDS++;
        __enemies = new Array();
        __path = _path.concat();
        __lastTime = 0;
        __updateMe = false;
        __spawned = 0;
        __nextElementEvent = _nextElementEvent;
        __nextElementEventData = _nextElementEventData;
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        switch (_nextElementEvent)
        {
            case com.clubpenguin.tower.levels.WaveData.EVENT_DELAY_START:
            {
                __checkSpawnNextElement = checkDelayStart;
                break;
            } 
            case com.clubpenguin.tower.levels.WaveData.EVENT_DELAY_END:
            {
                __checkSpawnNextElement = checkDelayEnd;
                break;
            } 
            case com.clubpenguin.tower.levels.WaveData.EVENT_ON_ALL_SPAWN:
            {
                __checkSpawnNextElement = checkAllSpawn;
                break;
            } 
            case com.clubpenguin.tower.levels.WaveData.EVENT_ON_X_SPAWN:
            {
                __checkSpawnNextElement = checkXSpawn;
                break;
            } 
        } // End of switch
    } // End of the function
    function get nextWaveDelay()
    {
        var _loc2;
        switch (__nextElementEvent)
        {
            case com.clubpenguin.tower.levels.WaveData.EVENT_DELAY_START:
            {
                _loc2 = Number(__nextElementEventData);
                break;
            } 
            case com.clubpenguin.tower.levels.WaveData.EVENT_DELAY_END:
            {
                _loc2 = __enemies.length * __delay + Number(__nextElementEventData);
                break;
            } 
            case com.clubpenguin.tower.levels.WaveData.EVENT_ON_ALL_SPAWN:
            {
                _loc2 = __enemies.length * __delay;
                break;
            } 
            case com.clubpenguin.tower.levels.WaveData.EVENT_ON_X_SPAWN:
            {
                _loc2 = Number(__nextElementEventData) * __delay;
                break;
            } 
        } // End of switch
        return (_loc2);
    } // End of the function
    function get type()
    {
        return (com.clubpenguin.tower.levels.WaveData.TYPE);
    } // End of the function
    function checkSpawnNextElement()
    {
        this.__checkSpawnNextElement();
    } // End of the function
    function checkXSpawn()
    {
        if (__spawned == Number(__nextElementEventData))
        {
            this.dispatchEvent({type: com.clubpenguin.tower.levels.types.AbstractLevel.EVENT_START_NEXT_ELEMENT, target: this, id: __id});
            __spawnedNextElement = true;
        } // end if
    } // End of the function
    function checkAllSpawn()
    {
        if (__enemies.length == 0)
        {
            this.dispatchEvent({type: com.clubpenguin.tower.levels.types.AbstractLevel.EVENT_START_NEXT_ELEMENT, target: this, id: __id});
            __spawnedNextElement = true;
        } // end if
    } // End of the function
    function checkDelayEnd()
    {
        if (__enemies.length == 0 && __currTime >= __endDelay + Number(__nextElementEventData))
        {
            this.dispatchEvent({type: com.clubpenguin.tower.levels.types.AbstractLevel.EVENT_START_NEXT_ELEMENT, target: this, id: __id});
            __spawnedNextElement = true;
        } // end if
    } // End of the function
    function checkDelayStart()
    {
        if (__currTime >= __startDelay + Number(__nextElementEventData))
        {
            this.dispatchEvent({type: com.clubpenguin.tower.levels.types.AbstractLevel.EVENT_START_NEXT_ELEMENT, target: this, id: __id});
            __spawnedNextElement = true;
        } // end if
    } // End of the function
    function start()
    {
        __lastTime = getTimer() - __delay;
        __startDelay = getTimer();
        __updateMe = true;
    } // End of the function
    function thisWaveDropsUpgrade()
    {
        var _loc2;
        _loc2 = __enemies[__enemies.length - 1];
        _loc2.__set__dropUpgrade(true);
    } // End of the function
    function complete()
    {
        __updateMe = false;
    } // End of the function
    function update()
    {
        if (__updateMe)
        {
            __currTime = getTimer();
            if (__currTime > __lastTime + __delay)
            {
                if (__enemies != null && __enemies.length > 0)
                {
                    this.spawnNextEnemy();
                    if (__enemies.length == 0)
                    {
                        __endDelay = getTimer();
                    } // end if
                } // end if
                __lastTime = __currTime;
            } // end if
            if (!__spawnedNextElement)
            {
                this.checkSpawnNextElement();
            } // end if
            if (__enemies.length == 0 && __spawnedNextElement == true)
            {
                __updateMe = false;
            } // end if
        } // end if
    } // End of the function
    function get id()
    {
        return (__id);
    } // End of the function
    function get delay()
    {
        return (__delay);
    } // End of the function
    function get enemies()
    {
        return (__enemies);
    } // End of the function
    function set delay(_val)
    {
        __delay = _val;
        //return (this.delay());
        null;
    } // End of the function
    function addEnemy(_enemy)
    {
        __enemies.push(_enemy);
    } // End of the function
    function addEnemies(_newEnemies)
    {
        __enemies = __enemies.concat(_newEnemies);
    } // End of the function
    function spawnNextEnemy()
    {
        __currEnemy = (com.clubpenguin.tower.enemies.EnemyData)(__enemies.shift());
        com.clubpenguin.tower.enemies.EnemyManager.createEnemy(__currEnemy, __path);
        ++__spawned;
    } // End of the function
    function dispose()
    {
        __enemies.length = 0;
        __path = null;
        __lastTime = 0;
        __updateMe = false;
        __spawned = 0;
        __nextElementEvent = null;
        __nextElementEventData = null;
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "WaveData\n";
        _loc2 = _loc2 + ("\tdelay : " + __delay + "\n");
        _loc2 = _loc2 + ("\tenemies : " + __enemies.length + "\n");
        return (_loc2);
    } // End of the function
    function getType()
    {
        return (com.clubpenguin.tower.levels.WaveData.TYPE);
    } // End of the function
    static var EVENT_DELAY_START = "EVENT_DELAY_START";
    static var EVENT_DELAY_END = "EVENT_DELAY_END";
    static var EVENT_ON_ALL_SPAWN = "EVENT_ON_ALL_SPAWN";
    static var EVENT_ON_X_SPAWN = "EVENT_ON_X_SPAWN";
    static var TYPE = "WAVE_DATA";
    var num = 0;
} // End of Class
