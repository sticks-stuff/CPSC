class com.clubpenguin.tower.display.DisplayFactory
{
    function DisplayFactory()
    {
    } // End of the function
    function create(scope, type, uniqueID, startingEnergy, LASER_TOWER_COST, SNOWBALL_TOWER_COST, ROCKET_TOWER_COST, UPGRADE_TOWER_COST)
    {
        switch (type)
        {
            case com.clubpenguin.tower.display.DisplayFactory.DISPLAY:
            {
                return (new com.clubpenguin.tower.display.types.Display(scope, uniqueID, startingEnergy, LASER_TOWER_COST, SNOWBALL_TOWER_COST, ROCKET_TOWER_COST, UPGRADE_TOWER_COST));
            } 
        } // End of switch
        throw new Error("Not a recognized type of display requested!");
        
    } // End of the function
    static var DISPLAY = "display";
} // End of Class
