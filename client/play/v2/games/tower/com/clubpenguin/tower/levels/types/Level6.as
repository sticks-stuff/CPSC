class com.clubpenguin.tower.levels.types.Level6 extends com.clubpenguin.tower.levels.types.AbstractLevel
{
    var _view, elements, __currPath, paths, waypoints, dropZones, setDroppableSpots, updateListeners;
    function Level6(scope, levelNum)
    {
        super(scope, new com.clubpenguin.tower.levels.views.Level6View(scope), levelNum);
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
        waypoints.push(new flash.geom.Point(7.452500E+002, 3.571000E+002));
        waypoints.push(new flash.geom.Point(5.662500E+002, 3.571000E+002));
        waypoints.push(new flash.geom.Point(5.662500E+002, 3.171000E+002));
        waypoints.push(new flash.geom.Point(4.402500E+002, 3.171000E+002));
        waypoints.push(new flash.geom.Point(4.402500E+002, 3.571000E+002));
        waypoints.push(new flash.geom.Point(3.122500E+002, 3.571000E+002));
        waypoints.push(new flash.geom.Point(3.122500E+002, 3.161000E+002));
        waypoints.push(new flash.geom.Point(1.863000E+002, 3.161000E+002));
        waypoints.push(new flash.geom.Point(1.863000E+002, 3.161000E+002));
        waypoints.push(new flash.geom.Point(1.863000E+002, 3.161000E+002));
        waypoints.push(new flash.geom.Point(1.863000E+002, 3.571000E+002));
        waypoints.push(new flash.geom.Point(1.048000E+002, 3.571000E+002));
        waypoints.push(new flash.geom.Point(1.048000E+002, 1.481000E+002));
        waypoints.push(new flash.geom.Point(1.863000E+002, 1.481000E+002));
        waypoints.push(new flash.geom.Point(1.863000E+002, 1.911000E+002));
        waypoints.push(new flash.geom.Point(3.162500E+002, 1.911000E+002));
        waypoints.push(new flash.geom.Point(3.162500E+002, 1.481000E+002));
        waypoints.push(new flash.geom.Point(4.402500E+002, 1.481000E+002));
        waypoints.push(new flash.geom.Point(4.402500E+002, 1.911000E+002));
        waypoints.push(new flash.geom.Point(6.177500E+002, 1.911000E+002));
        paths.push(waypoints);
        var _loc2 = paths.shift();
        __currPath = _loc2.concat();
    } // End of the function
    function setDroppableGrid()
    {
        dropZones.push(new flash.geom.Point(6.388500E+002, 2.982000E+002));
        dropZones.push(new flash.geom.Point(6.808500E+002, 2.982000E+002));
        dropZones.push(new flash.geom.Point(9.285000E+001, 3.822000E+002));
        dropZones.push(new flash.geom.Point(1.768500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(5.548500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(4.288500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(4.288500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(3.868500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(3.868500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(2.608500E+002, 1.302000E+002));
        dropZones.push(new flash.geom.Point(3.448500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(5.128500E+002, 1.302000E+002));
        dropZones.push(new flash.geom.Point(5.128500E+002, 3.402000E+002));
        dropZones.push(new flash.geom.Point(4.708500E+002, 3.402000E+002));
        dropZones.push(new flash.geom.Point(2.608500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(2.608500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(1.768500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(2.188500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(3.023500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(1.348500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(1.348500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(1.768500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(2.188500E+002, 1.302000E+002));
        dropZones.push(new flash.geom.Point(2.608500E+002, 8.820000E+001));
        dropZones.push(new flash.geom.Point(3.443500E+002, 3.827000E+002));
        dropZones.push(new flash.geom.Point(3.443500E+002, 8.820000E+001));
        dropZones.push(new flash.geom.Point(6.388500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(6.808500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(5.968500E+002, 2.982000E+002));
        dropZones.push(new flash.geom.Point(4.708500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(5.968500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(3.868500E+002, 1.722000E+002));
        dropZones.push(new flash.geom.Point(5.085000E+001, 2.562000E+002));
        dropZones.push(new flash.geom.Point(1.348500E+002, 2.982000E+002));
        dropZones.push(new flash.geom.Point(1.348500E+002, 1.722000E+002));
        dropZones.push(new flash.geom.Point(9.285000E+001, 8.820000E+001));
        dropZones.push(new flash.geom.Point(6.388500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(6.808500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(5.548500E+002, 1.302000E+002));
        dropZones.push(new flash.geom.Point(5.548500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(3.023500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(3.868500E+002, 3.827000E+002));
        dropZones.push(new flash.geom.Point(4.288500E+002, 3.827000E+002));
        dropZones.push(new flash.geom.Point(3.448500E+002, 2.982000E+002));
        dropZones.push(new flash.geom.Point(3.868500E+002, 2.982000E+002));
        dropZones.push(new flash.geom.Point(5.128500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(4.708500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(5.968500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(3.448500E+002, 1.722000E+002));
        dropZones.push(new flash.geom.Point(3.023500E+002, 8.820000E+001));
        dropZones.push(new flash.geom.Point(3.868500E+002, 8.820000E+001));
        dropZones.push(new flash.geom.Point(4.288500E+002, 8.820000E+001));
        dropZones.push(new flash.geom.Point(3.448500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(5.548500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(5.128500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(5.128500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(1.348500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(4.708500E+002, 1.302000E+002));
        dropZones.push(new flash.geom.Point(5.085000E+001, 3.402000E+002));
        dropZones.push(new flash.geom.Point(2.188500E+002, 3.402000E+002));
        dropZones.push(new flash.geom.Point(2.188500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(2.608500E+002, 3.402000E+002));
        dropZones.push(new flash.geom.Point(2.608500E+002, 3.822000E+002));
        dropZones.push(new flash.geom.Point(5.085000E+001, 2.982000E+002));
        dropZones.push(new flash.geom.Point(5.085000E+001, 2.142000E+002));
        dropZones.push(new flash.geom.Point(5.085000E+001, 1.722000E+002));
        dropZones.push(new flash.geom.Point(4.708500E+002, 2.142000E+002));
        dropZones.push(new flash.geom.Point(1.768500E+002, 8.820000E+001));
        dropZones.push(new flash.geom.Point(2.188500E+002, 2.562000E+002));
        dropZones.push(new flash.geom.Point(1.348500E+002, 8.820000E+001));
        dropZones.push(new flash.geom.Point(3.023500E+002, 2.562000E+002));
        this.setDroppableSpots();
        this.updateListeners(com.clubpenguin.tower.levels.types.AbstractLevel.DROP_ZONES_SET, dropZones);
    } // End of the function
} // End of Class
