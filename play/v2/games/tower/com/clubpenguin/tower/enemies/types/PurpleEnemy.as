class com.clubpenguin.tower.enemies.types.PurpleEnemy extends com.clubpenguin.tower.enemies.types.AbstractEnemy
{
    var getID, setView;
    function PurpleEnemy(scope, position, waypoints, $health, $speed, $dropsUpgrade)
    {
        super(position, waypoints, $health, $speed, $dropsUpgrade);
        this.setView(new com.clubpenguin.tower.enemies.views.PurpleEnemyView(scope, this.getID()));
    } // End of the function
    var MOVE_DISTANCE = 4;
} // End of Class
