class com.clubpenguin.tower.levels.types.AbstractLevel extends com.clubpenguin.tower.util.EventDispatcher implements com.clubpenguin.tower.levels.interfaces.ILevel
{
    var __uName, _view, levelNum, elements, dropZones, updateListeners, removeAllListeners, __get__isPlaceable;
    function AbstractLevel(scope, view, levelNum)
    {
        super();
        __uName = "AL";
        _view = view;
        this.attachListeners();
        _view.setPosition();
        this.levelNum = levelNum;
        elements = new Array();
    } // End of the function
    function init()
    {
        dropZones = new Array();
        this.setDroppableGrid();
        this.buildLevelPaths();
        this.buildLevelWaves();
    } // End of the function
    function buildLevelPaths()
    {
        throw new Error("buildLevelPaths Method must be overridden in subclass");
    } // End of the function
    function setDroppableGrid()
    {
        throw new Error("setDroppableGrid Method must be overridden in subclass");
    } // End of the function
    function buildLevelWaves()
    {
        throw new Error("buildLevelWaves Method must be overridden in subclass");
    } // End of the function
    function getLevelNum()
    {
        return (levelNum);
    } // End of the function
    function attachListeners()
    {
        _view.addEventListener(com.clubpenguin.tower.levels.views.AbstractLevelView.ON_ENEMY_HIT_CPU, onEnemyHitCPU, this);
        _view.addEventListener(com.clubpenguin.tower.levels.views.AbstractLevelView.ON_CPU_DESTROYED, onCpuDestroyed, this);
    } // End of the function
    function getWaveData(waveNumber)
    {
        return ((com.clubpenguin.tower.levels.interfaces.IStoryElement)(elements[waveNumber]));
    } // End of the function
    function getElements()
    {
        return (elements);
    } // End of the function
    function startElement($elementID)
    {
        (com.clubpenguin.tower.levels.interfaces.IStoryElement)(elements[$elementID]).start();
    } // End of the function
    function update()
    {
        var _loc2;
        for (var _loc2 = 0; _loc2 < elements.length; ++_loc2)
        {
            (com.clubpenguin.tower.levels.interfaces.IStoryElement)(elements[_loc2]).update();
        } // end of for
    } // End of the function
    function onEnemyHitCPU(target)
    {
        this.updateListeners(com.clubpenguin.tower.levels.types.AbstractLevel.ENEMY_HIT_CPU, target);
    } // End of the function
    function setDropZonesNormal()
    {
        _view.setDropZonesNormal();
    } // End of the function
    function onCpuDestroyed()
    {
        this.updateListeners(com.clubpenguin.tower.levels.types.AbstractLevel.CPU_DESTROYED);
    } // End of the function
    function checkCPU(targets)
    {
        throw new Error("checkCPU Method must be overridden in subclass");
    } // End of the function
    function cleanUp()
    {
        this.removeAllListeners();
        _view.cleanUp();
        __elementIDS = 0;
        $_isPlaceable = null;
    } // End of the function
    function handleStartNextElement(eventData)
    {
        elements[eventData.id + 1].start();
        if (elements[eventData.id + 1] == "GameOver")
        {
            this.updateListeners(com.clubpenguin.tower.levels.types.AbstractLevel.GAME_OVER);
        } // end if
    } // End of the function
    function get isPlaceable()
    {
        return (com.clubpenguin.tower.levels.types.AbstractLevel.$_isPlaceable);
    } // End of the function
    function setDroppableSpots()
    {
        $_isPlaceable = new com.clubpenguin.tower.util.Array2D();
        for (var _loc2 = 0; _loc2 < dropZones.length; ++_loc2)
        {
            var _loc4 = Math.round(dropZones[_loc2].x / com.clubpenguin.tower.levels.types.AbstractLevel.GRID_NUM) * com.clubpenguin.tower.levels.types.AbstractLevel.GRID_NUM + 21;
            var _loc3 = Math.round(dropZones[_loc2].y / com.clubpenguin.tower.levels.types.AbstractLevel.GRID_NUM) * com.clubpenguin.tower.levels.types.AbstractLevel.GRID_NUM + 21;
            com.clubpenguin.tower.levels.types.AbstractLevel.$_isPlaceable.setit(_loc4, _loc3, true);
        } // end of for
    } // End of the function
    static var $_isPlaceable = null;
    static var GRID_NUM = 42;
    static var DROP_ZONES_SET = "dropZonesSet";
    static var ENEMY_HIT_CPU = "enemyHitCPU";
    static var CPU_DESTROYED = "cpuDestroyed";
    static var GAME_OVER = "AbstractLevelgameOverComplete";
    static var EVENT_START_NEXT_ELEMENT = "startNextElement";
    static var __elementIDS = 0;
} // End of Class
