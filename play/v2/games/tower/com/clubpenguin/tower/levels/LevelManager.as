class com.clubpenguin.tower.levels.LevelManager extends com.clubpenguin.tower.util.EventDispatcher
{
    var _enemyManager, _stage, _waveManager, _levelFactory, __elapsedPauseTime, __pauseStart, __pauseWave, __updateMe, _level, updateListeners, __startTime, removeAllListeners, __get__isPlaceable;
    function LevelManager(stage, enemyManager)
    {
        super();
        _enemyManager = enemyManager;
        _stage = stage;
        _waveManager = new com.clubpenguin.tower.display.types.WaveManager(_stage);
        _levelFactory = new com.clubpenguin.tower.levels.LevelFactory();
        __elapsedPauseTime = 0;
        __pauseStart = 0;
        __pauseWave = false;
        __updateMe = true;
    } // End of the function
    function loadLevel(levelID)
    {
        _levelFactory = new com.clubpenguin.tower.levels.LevelFactory();
        _level = _levelFactory.create(_stage, levelID);
        _level.addEventListener(com.clubpenguin.tower.levels.types.AbstractLevel.DROP_ZONES_SET, handleNewDropZones, this);
        _level.addEventListener(com.clubpenguin.tower.levels.types.AbstractLevel.ENEMY_HIT_CPU, handleEnemyHitCPU, this);
        _level.addEventListener(com.clubpenguin.tower.levels.types.AbstractLevel.CPU_DESTROYED, handleCpuDestroyed, this);
        _level.addEventListener(com.clubpenguin.tower.levels.types.AbstractLevel.GAME_OVER, handleGameOver, this);
        _level.init();
        this.updateListeners(com.clubpenguin.tower.levels.LevelManager.LEVEL_LOAD_COMPLETE);
        _waveManager.load(_level.getElements(), com.clubpenguin.tower.GameEngine.getInstance().currentLevel != 6);
    } // End of the function
    function get isPlaceable()
    {
        //return (_level.isPlaceable());
    } // End of the function
    function checkCPU(targets)
    {
        _level.checkCPU(targets);
    } // End of the function
    function handleEnemyHitCPU(target)
    {
        this.updateListeners(com.clubpenguin.tower.levels.LevelManager.ENEMY_HIT_CPU, target);
        ++cpuHitCount;
    } // End of the function
    function handleGameOver()
    {
        this.updateListeners(com.clubpenguin.tower.levels.LevelManager.GAME_OVER);
    } // End of the function
    function setDropZonesNormal()
    {
        _level.setDropZonesNormal();
    } // End of the function
    function handleCpuDestroyed()
    {
        this.updateListeners(com.clubpenguin.tower.levels.LevelManager.CPU_DESTROYED);
    } // End of the function
    function pauseWave(_bool)
    {
    } // End of the function
    function update()
    {
        var _loc2;
        _loc2 = getTimer() - (__startTime + __elapsedPauseTime);
        if (__updateMe)
        {
            _level.update();
            _waveManager.update(_loc2);
        } // end if
    } // End of the function
    function startLevel()
    {
        __startTime = getTimer();
        _level.startElement(0);
    } // End of the function
    function handleNewDropZones(_dropZones)
    {
        this.updateListeners(com.clubpenguin.tower.levels.LevelManager.DROP_ZONES_SET, _dropZones);
    } // End of the function
    function waveComplete()
    {
        __updateMe = false;
    } // End of the function
    function cleanUp()
    {
        _level.cleanUp();
        _level = null;
        _levelFactory = null;
        _waveManager.cleanUp();
        _waveManager = null;
        _enemyManager = null;
        __startTime = null;
        this.removeAllListeners();
    } // End of the function
    static var DROP_ZONES_SET = "d rop ZonesSetLevelManager";
    static var LEVEL_LOAD_COMPLETE = "levelLoadComplete";
    var uniqueID = 0;
    var cpuHitCount = 0;
    static var TOWER_CLICKED = "towerClicked";
    static var ENEMY_HIT_CPU = "enemyHitCPU";
    static var CPU_DESTROYED = "cpuDestoyed";
    static var GAME_OVER = "levelManagerGameOver";
} // End of Class
