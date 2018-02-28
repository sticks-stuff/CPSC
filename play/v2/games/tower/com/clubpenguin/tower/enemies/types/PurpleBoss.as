class com.clubpenguin.tower.enemies.types.PurpleBoss extends com.clubpenguin.tower.enemies.types.AbstractEnemy
{
    var getID, setView;
    function PurpleBoss(scope, position, waypoints, $health, $speed, $dropsUpgrade)
    {
        super(position, waypoints, $health, $speed, $dropsUpgrade);
        this.setView(new com.clubpenguin.tower.enemies.views.PurpleBossView(scope, this.getID()));
    } // End of the function
    var MOVE_DISTANCE = 4;
} // End of Class
