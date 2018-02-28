class com.clubpenguin.tower.display.types.Display extends com.clubpenguin.tower.display.types.AbstractDisplay
{
    function Display(scope, id, startingEnergy, LASER_TOWER_COST, SNOWBALL_TOWER_COST, ROCKET_TOWER_COST, UPGRADE_TOWER_COST)
    {
        super(id, startingEnergy, LASER_TOWER_COST, SNOWBALL_TOWER_COST, ROCKET_TOWER_COST, UPGRADE_TOWER_COST, new com.clubpenguin.tower.display.views.DisplayView(scope, id, startingEnergy));
    } // End of the function
} // End of Class
