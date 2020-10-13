class com.clubpenguin.tower.enemies.types.YellowEnemy extends com.clubpenguin.tower.enemies.types.AbstractEnemy
{
    var getID, setView;
    function YellowEnemy(scope, position, waypoints, $health, $speed, $dropsUpgrade)
    {
        super(position, waypoints, $health, $speed, $dropsUpgrade);
        this.setView(new com.clubpenguin.tower.enemies.views.YellowEnemyView(scope, this.getID()));
    } // End of the function
    var MOVE_DISTANCE = 6;
} // End of Class
