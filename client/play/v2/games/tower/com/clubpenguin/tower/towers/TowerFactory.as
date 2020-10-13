class com.clubpenguin.tower.towers.TowerFactory
{
    var __towerPools;
    function TowerFactory()
    {
        this.initializeTowerPools();
    } // End of the function
    function initializeTowerPools()
    {
        __towerPools = new Array();
        for (var _loc2 = 0; _loc2 < __types.length; ++_loc2)
        {
            __towerPools[__types[_loc2]] = new Array();
        } // end of for
    } // End of the function
    function create(scope, type, position, dropZones, uniqueID, towersArray, _isPlaceable)
    {
        switch (type)
        {
            case com.clubpenguin.tower.towers.TowerFactory.LASER_TOWER:
            {
                return (new com.clubpenguin.tower.towers.types.LaserTower(scope, position, uniqueID, dropZones, towersArray, _isPlaceable));
                break;
            } 
            case com.clubpenguin.tower.towers.TowerFactory.SNOWBALL_TOWER:
            {
                return (new com.clubpenguin.tower.towers.types.SnowballTower(scope, position, uniqueID, dropZones, towersArray, _isPlaceable));
                break;
            } 
            case com.clubpenguin.tower.towers.TowerFactory.ROCKET_TOWER:
            {
                return (new com.clubpenguin.tower.towers.types.RocketTower(scope, position, uniqueID, dropZones, towersArray, _isPlaceable));
                break;
            } 
            default:
            {
                throw new Error("Not a recognized type of tower requested!");
                break;
            } 
        } // End of switch
    } // End of the function
    function generateTowers(amount, scope, dropZones, towersArray, _isPlaceable)
    {
        var _loc5 = 0;
        var _loc4;
        for (var _loc2 = 0; _loc2 < __types.length; ++_loc2)
        {
            for (var _loc3 = 0; _loc3 < amount; ++_loc3)
            {
                _loc4 = this.create(scope, __types[_loc2], new flash.geom.Point(-50, -50), dropZones, _loc5, towersArray, _isPlaceable);
                __towerPools[__types[_loc2]].push(_loc4);
                _loc4.hide();
                ++_loc5;
            } // end of for
        } // end of for
    } // End of the function
    function returnTower(tower)
    {
        var _loc4;
        _loc4 = tower.getTowerType();
        switch (_loc4)
        {
            case "LaserTower":
            {
                var _loc2;
                _loc2 = com.clubpenguin.tower.towers.TowerFactory.LASER_TOWER;
                break;
            } 
            case "SnowballTower":
            {
                _loc2 = com.clubpenguin.tower.towers.TowerFactory.SNOWBALL_TOWER;
                break;
            } 
            case "RocketTower":
            {
                _loc2 = com.clubpenguin.tower.towers.TowerFactory.ROCKET_TOWER;
                break;
            } 
        } // End of switch
        __towerPools[_loc2].push(tower);
    } // End of the function
    function getTowerByType(type)
    {
        var _loc3;
        var _loc2;
        _loc2 = __towerPools[type];
        if (_loc2.length == 0)
        {
        }
        else
        {
            _loc3 = (com.clubpenguin.tower.towers.types.AbstractTower)(_loc2.shift());
        } // end else if
        return (_loc3);
    } // End of the function
    static var LASER_TOWER = "LASER_TOWER";
    static var SNOWBALL_TOWER = "SNOWBALL_TOWER";
    static var ROCKET_TOWER = "ROCKET_TOWER";
    var __types = [com.clubpenguin.tower.towers.TowerFactory.LASER_TOWER, com.clubpenguin.tower.towers.TowerFactory.SNOWBALL_TOWER, com.clubpenguin.tower.towers.TowerFactory.ROCKET_TOWER];
} // End of Class
