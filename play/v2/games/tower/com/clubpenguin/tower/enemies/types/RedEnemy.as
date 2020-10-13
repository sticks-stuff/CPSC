class com.clubpenguin.tower.enemies.types.RedEnemy extends com.clubpenguin.tower.enemies.types.AbstractEnemy
{
    var getID, setView;
    function RedEnemy(scope, position, waypoints, $health, $speed, $dropsUpgrade)
    {
        super(position, waypoints, $health, $speed, $dropsUpgrade);
        this.setView(new com.clubpenguin.tower.enemies.views.RedEnemyView(scope, this.getID()));
    } // End of the function
    var MOVE_DISTANCE = 3;
} // End of Class
