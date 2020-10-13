class com.clubpenguin.tower.levels.types.TutorialLevel extends com.clubpenguin.tower.levels.types.AbstractLevel
{
    var _view, elements, __currPath, paths, waypoints, dropZones, setDroppableSpots, updateListeners;
    function TutorialLevel(scope, levelNum)
    {
        super(scope, new com.clubpenguin.tower.levels.views.TutorialLevelView(scope), levelNum);
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
                com.clubpenguin.tower.GameEngine.getInstance()._tutorial.buildScenario(__currPath, elements, this);
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
        waypoints.push(new flash.geom.Point(7.565000E+002, 2.684500E+002));
        waypoints.push(new flash.geom.Point(6.085000E+002, 2.684500E+002));
        waypoints.push(new flash.geom.Point(6.085000E+002, 1.414500E+002));
        waypoints.push(new flash.geom.Point(3.555000E+002, 1.414500E+002));
        waypoints.push(new flash.geom.Point(3.555000E+002, 2.654500E+002));
        waypoints.push(new flash.geom.Point(1.515000E+002, 2.654500E+002));
        paths.push(waypoints);
        var _loc2 = paths.shift();
        __currPath = _loc2.concat();
    } // End of the function
    function setDroppableGrid()
    {
        dropZones.push(new flash.geom.Point(6.305000E+002, 294));
        dropZones.push(new flash.geom.Point(420, 168));
        dropZones.push(new flash.geom.Point(546, 168));
        dropZones.push(new flash.geom.Point(504, 168));
        dropZones.push(new flash.geom.Point(462, 168));
        dropZones.push(new flash.geom.Point(378, 168));
        dropZones.push(new flash.geom.Point(588, 294));
        dropZones.push(new flash.geom.Point(210, 210));
        dropZones.push(new flash.geom.Point(294, 210));
        dropZones.push(new flash.geom.Point(252, 210));
        dropZones.push(new flash.geom.Point(168, 210));
        dropZones.push(new flash.geom.Point(336, 84));
        dropZones.push(new flash.geom.Point(420, 294));
        dropZones.push(new flash.geom.Point(252, 294));
        dropZones.push(new flash.geom.Point(378, 294));
        dropZones.push(new flash.geom.Point(336, 294));
        dropZones.push(new flash.geom.Point(294, 294));
        dropZones.push(new flash.geom.Point(210, 294));
        dropZones.push(new flash.geom.Point(420, 84));
        dropZones.push(new flash.geom.Point(546, 84));
        dropZones.push(new flash.geom.Point(504, 84));
        dropZones.push(new flash.geom.Point(462, 84));
        dropZones.push(new flash.geom.Point(378, 84));
        this.setDroppableSpots();
        this.updateListeners(com.clubpenguin.tower.levels.types.AbstractLevel.DROP_ZONES_SET, dropZones);
    } // End of the function
} // End of Class
