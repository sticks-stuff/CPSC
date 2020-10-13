class com.clubpenguin.tower.towers.views.SnowballTowerView extends com.clubpenguin.tower.towers.views.AbstractTowerView
{
    var cost, _mc, _stage;
    function SnowballTowerView(scope, id, towersArray)
    {
        super(scope, id, towersArray);
        cost = com.clubpenguin.tower.GameSettings.SNOWBALL_TOWER_COST;
    } // End of the function
    function shoot(target)
    {
        _mc.tower.shoot.play();
        _mc.tower.shoot1.play();
        _mc.tower.shoot2.play();
        _mc.tower.shoot3.play();
        _mc.tower.shoot4.play();
        _stage.createEmptyMovieClip("snowballTowerShootHolder", _stage.getNextHighestDepth());
        var _loc2 = new Sound(_stage.snowballTowerShootHolder);
        _loc2.attachSound("PurpleGunShoot");
        _loc2.start();
    } // End of the function
    var LINKAGE_ID = "com.clubpenguin.tower.towers.views.SnowballTowerView";
    var NAME = "SnowballTower";
} // End of Class
