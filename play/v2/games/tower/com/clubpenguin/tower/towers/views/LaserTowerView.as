class com.clubpenguin.tower.towers.views.LaserTowerView extends com.clubpenguin.tower.towers.views.AbstractTowerView
{
    var cost, _mc, _stage;
    function LaserTowerView(scope, id, towersArray)
    {
        super(scope, id, towersArray);
        cost = com.clubpenguin.tower.GameSettings.LASER_TOWER_COST;
    } // End of the function
    function shoot(target)
    {
        _mc.tower.shoot.gotoAndPlay(1);
        _mc.tower.shoot1.gotoAndPlay(1);
        _mc.tower.shoot2.gotoAndPlay(1);
        _stage.createEmptyMovieClip("laserTowerShootHolder", _stage.getNextHighestDepth());
        var _loc2 = new Sound(_stage.laserTowerShootHolder);
        _loc2.attachSound("laserTowerShoot");
        _loc2.start();
    } // End of the function
    var LINKAGE_ID = "com.clubpenguin.tower.towers.views.LaserTowerView";
    var NAME = "LaserTower";
} // End of Class
