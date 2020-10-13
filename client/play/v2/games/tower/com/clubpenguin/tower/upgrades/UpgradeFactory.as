class com.clubpenguin.tower.upgrades.UpgradeFactory
{
    function UpgradeFactory()
    {
    } // End of the function
    function create(scope, upgradeType, event, __towers, fromMenu, fullEnergyUpgrade, id)
    {
        switch (upgradeType)
        {
            case SINGLE_UPGRADE:
            {
                return (new com.clubpenguin.tower.upgrades.types.SingleUpgrade(scope, event.pos, __towers, fromMenu, id));
            } 
            case ENERGY_UPGRADE:
            {
                return (new com.clubpenguin.tower.upgrades.types.EnergyUpgrade(scope, event, fullEnergyUpgrade, id));
            } 
        } // End of switch
        throw new Error("Not a recognized type of upgrade requested!");
        
    } // End of the function
    var SINGLE_UPGRADE = "singleUpgrade";
    var DOUBLE_UPGRADE = "doubleUpgrade";
    var ENERGY_UPGRADE = "energyUpgrade";
} // End of Class
