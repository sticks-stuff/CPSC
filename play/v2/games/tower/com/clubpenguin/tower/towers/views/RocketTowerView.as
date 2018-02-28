class com.clubpenguin.tower.towers.views.RocketTowerView extends com.clubpenguin.tower.towers.views.AbstractTowerView
{
    var cost, _mc, _stage;
    function RocketTowerView(scope, id, towersArray)
    {
        super(scope, id, towersArray);
        cost = com.clubpenguin.tower.GameSettings.ROCKET_TOWER_COST;
    } // End of the function
    function shoot(target)
    {
        _mc.tower.shoot.gotoAndPlay(1);
        _mc.tower.shoot2.gotoAndPlay(1);
        _mc.tower.shoot3.gotoAndPlay(1);
        _stage.createEmptyMovieClip("rocketTowerShootHolder", _stage.getNextHighestDepth());
        var _loc2 = new Sound(_stage.rocketTowerShootHolder);
        _loc2.attachSound("RocketLauncherShoot");
        _loc2.start();
    } // End of the function
    var LINKAGE_ID = "com.clubpenguin.tower.towers.views.RocketTowerView";
    var NAME = "RocketTower";
} // End of Class
