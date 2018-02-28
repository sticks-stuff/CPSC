class com.clubpenguin.tower.levels.types.Level1 extends com.clubpenguin.tower.levels.types.AbstractLevel
{
    var _view, elements, __currPath, paths, waypoints, dropZones, setDroppableSpots, updateListeners;
    function Level1(scope, levelNum)
    {
        super(scope, new com.clubpenguin.tower.levels.views.Level1View(scope), levelNum);
        com.clubpenguin.tower.levels.types.AbstractLevel.CPU_MIN_X = 425;
        com.clubpenguin.tower.levels.types.AbstractLevel.CPU_MAX_X = 570;
        com.clubpenguin.tower.levels.types.AbstractLevel.CPU_MAX_Y = 190;
        com.clubpenguin.tower.levels.types.AbstractLevel.CPU_MIN_Y = 67;
    } // End of the function
    function checkCPU(targets)
    {
        for (var _loc2 = 0; _loc2 < targets.length; ++_loc2)
        {
            if (targets[_loc2].currWaypoint == null)
            {
                _view.onCPUHit(targets[_loc2]);
            } // end if
        } // end of for
    } // End of the function
    function buildLevelWaves()
    {
        switch (com.clubpenguin.tower.GameEngine.getInstance().__get___mode())
        {
            case com.clubpenguin.tower.GameEngine.MODE_SCENARIO:
            {
                com.clubpenguin.tower.GameEngine.getInstance().__get___scenario().buildScenario(__currPath, elements, this);
                break;
            } 
            case com.clubpenguin.tower.GameEngine.MODE_TUTORIAL:
            {
                com.clubpenguin.tower.GameEngine.getInstance().levelScenario.buildScenario(__currPath, elements, this);
                break;
            } 
            case com.clubpenguin.tower.GameEngine.MODE_SURVIVAL:
            {
                com.clubpenguin.tower.GameEngine.getInstance().levelScenario.buildScenario(__currPath, elements, this);
                break;
            } 
        } // End of switch
    } // End of the function
    function buildLevelPaths()
    {
        paths = new Array();
        waypoints = new Array();
        waypoints.push(new flash.geom.Point(7.564500E+002, 3.514500E+002));
        waypoints.push(new flash.geom.Point(5.664500E+002, 3.514500E+002));
        waypoints.push(new flash.geom.Point(5.664500E+002, 3.114500E+002));
        waypoints.push(new flash.geom.Point(4.404500E+002, 3.114500E+002));
        waypoints.push(new flash.geom.Point(4.404500E+002, 3.514500E+002));
        waypoints.push(new flash.geom.Point(3.134500E+002, 3.514500E+002));
        waypoints.push(new flash.geom.Point(3.134500E+002, 3.114500E+002));
        waypoints.push(new flash.geom.Point(1.884500E+002, 3.114500E+002));
        waypoints.push(new flash.geom.Point(1.884500E+002, 3.484500E+002));
        waypoints.push(new flash.geom.Point(1.054500E+002, 3.484500E+002));
        waypoints.push(new flash.geom.Point(1.054500E+002, 1.404500E+002));
        waypoints.push(new flash.geom.Point(1.894500E+002, 1.404500E+002));
        waypoints.push(new flash.geom.Point(1.894500E+002, 1.814500E+002));
        waypoints.push(new flash.geom.Point(3.144500E+002, 1.814500E+002));
        waypoints.push(new flash.geom.Point(3.144500E+002, 1.414500E+002));
        waypoints.push(new flash.geom.Point(4.394500E+002, 1.414500E+002));
        waypoints.push(new flash.geom.Point(4.394500E+002, 1.834500E+002));
        waypoints.push(new flash.geom.Point(6.164500E+002, 1.834500E+002));
        paths.push(waypoints);
        var _loc2 = paths.shift();
        __currPath = _loc2.concat();
    } // End of the function
    function setDroppableGrid()
    {
        dropZones.push(new flash.geom.Point(3.918000E+002, 1.776000E+002));
        dropZones.push(new flash.geom.Point(1.396500E+002, 2.607000E+002));
        dropZones.push(new flash.geom.Point(1.385000E+002, 306));
        dropZones.push(new flash.geom.Point(1.377500E+002, 1.776000E+002));
        dropZones.push(new flash.geom.Point(9.585000E+001, 3.894500E+002));
        dropZones.push(new flash.geom.Point(6.434500E+002, 3.885000E+002));
        dropZones.push(new flash.geom.Point(6.835500E+002, 3.886000E+002));
        dropZones.push(new flash.geom.Point(5.594000E+002, 1.381000E+002));
        dropZones.push(new flash.geom.Point(5.596500E+002, 3.894500E+002));
        dropZones.push(new flash.geom.Point(3.522000E+002, 3.898500E+002));
        dropZones.push(new flash.geom.Point(3.952500E+002, 3.898500E+002));
        dropZones.push(new flash.geom.Point(4.362000E+002, 3.898500E+002));
        dropZones.push(new flash.geom.Point(3.492000E+002, 3.037500E+002));
        dropZones.push(new flash.geom.Point(3.901500E+002, 3.037500E+002));
        dropZones.push(new flash.geom.Point(5.169000E+002, 3.474500E+002));
        dropZones.push(new flash.geom.Point(4.747500E+002, 3.474500E+002));
        dropZones.push(new flash.geom.Point(6.024000E+002, 3.047000E+002));
        dropZones.push(new flash.geom.Point(3.493500E+002, 1.776000E+002));
        dropZones.push(new flash.geom.Point(3.488000E+002, 9.810000E+001));
        dropZones.push(new flash.geom.Point(3.918000E+002, 9.735000E+001));
        dropZones.push(new flash.geom.Point(4.342500E+002, 2.196500E+002));
        dropZones.push(new flash.geom.Point(435, 2.634000E+002));
        dropZones.push(new flash.geom.Point(5.586000E+002, 2.189000E+002));
        dropZones.push(new flash.geom.Point(5.183500E+002, 2.196500E+002));
        dropZones.push(new flash.geom.Point(5.191000E+002, 2.634000E+002));
        dropZones.push(new flash.geom.Point(1.829500E+002, 2.209000E+002));
        dropZones.push(new flash.geom.Point(5.161000E+002, 1.373500E+002));
        dropZones.push(new flash.geom.Point(5.535000E+001, 3.478500E+002));
        dropZones.push(new flash.geom.Point(2.237500E+002, 3.471000E+002));
        dropZones.push(new flash.geom.Point(226, 3.898500E+002));
        dropZones.push(new flash.geom.Point(2.647000E+002, 3.471000E+002));
        dropZones.push(new flash.geom.Point(2.669500E+002, 3.898500E+002));
        dropZones.push(new flash.geom.Point(5.545000E+001, 3.037500E+002));
        dropZones.push(new flash.geom.Point(5.535000E+001, 2.211500E+002));
        dropZones.push(new flash.geom.Point(5.535000E+001, 1.776000E+002));
        dropZones.push(new flash.geom.Point(477, 2.634000E+002));
        dropZones.push(new flash.geom.Point(1.829500E+002, 9.615000E+001));
        dropZones.push(new flash.geom.Point(223, 1.383500E+002));
        dropZones.push(new flash.geom.Point(1.408000E+002, 9.615000E+001));
        dropZones.push(new flash.geom.Point(2.639500E+002, 1.383500E+002));
        this.setDroppableSpots();
        this.updateListeners(com.clubpenguin.tower.levels.types.AbstractLevel.DROP_ZONES_SET, dropZones);
    } // End of the function
} // End of Class
