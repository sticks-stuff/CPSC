class com.clubpenguin.tower.upgrades.UpgradeManager extends com.clubpenguin.tower.util.EventDispatcher
{
    var _stage, _upgrades, _upgradeFactory, upgrade, updateListeners, removeAllListeners;
    static var __towers;
    function UpgradeManager(stage)
    {
        super();
        _stage = stage;
        _upgrades = new Array();
        __towers = com.clubpenguin.tower.towers.TowerManager.getTowers();
        _upgradeFactory = new com.clubpenguin.tower.upgrades.UpgradeFactory();
    } // End of the function
    function createUpgrade(upgradeType, event, fromMenu)
    {
        ++_id;
        if (event.amount == com.clubpenguin.tower.upgrades.UpgradeManager.FULL_ENERGY_AMOUNT)
        {
            fullEnergyUpgrade = true;
            upgrade = _upgradeFactory.create(_stage, upgradeType, event, com.clubpenguin.tower.upgrades.UpgradeManager.__towers, fromMenu, fullEnergyUpgrade, _id);
        }
        else
        {
            fullEnergyUpgrade = false;
            upgrade = _upgradeFactory.create(_stage, upgradeType, event, com.clubpenguin.tower.upgrades.UpgradeManager.__towers, fromMenu, fullEnergyUpgrade, _id);
        } // end else if
        upgrade.addEventListener(com.clubpenguin.tower.upgrades.types.AbstractUpgrade.ENERGY_UPGRADE_EVENT, handleEnergyUpgrade, this);
        upgrade.addEventListener(com.clubpenguin.tower.upgrades.types.AbstractUpgrade.SINGLE_UPGRADE_EVENT, handleSingleUpgrade, this);
        upgrade.addEventListener(com.clubpenguin.tower.upgrades.types.SingleUpgrade.UPGRADE_ACTIVE, handleActiveUpgrade, this);
        upgrade.addEventListener(com.clubpenguin.tower.upgrades.types.SingleUpgrade.UPGRADE_INACTIVE, handleInactiveUpgrade, this);
        upgrade.addEventListener(com.clubpenguin.tower.upgrades.types.SingleUpgrade.UPGRADE_DELETED, handleDeletedUpgrade, this);
        _upgrades.push(upgrade);
    } // End of the function
    function handleEnergyUpgrade(eventInfo)
    {
        this.updateListeners(com.clubpenguin.tower.upgrades.UpgradeManager.ENERGY_UPGRADE_EVENT, eventInfo);
    } // End of the function
    function handleSingleUpgrade(eventInfo)
    {
        this.updateListeners(com.clubpenguin.tower.upgrades.UpgradeManager.SINGLE_UPGRADE_EVENT, eventInfo);
    } // End of the function
    function handleActiveUpgrade()
    {
        this.updateListeners(com.clubpenguin.tower.upgrades.UpgradeManager.UPGRADE_ACTIVE);
    } // End of the function
    function handleInactiveUpgrade()
    {
        this.updateListeners(com.clubpenguin.tower.upgrades.UpgradeManager.UPGRADE_INACTIVE);
    } // End of the function
    function handleDeletedUpgrade()
    {
        this.updateListeners(com.clubpenguin.tower.upgrades.UpgradeManager.UPGRADE_DELETED);
    } // End of the function
    function cleanUp()
    {
        for (var _loc2 = 0; _loc2 < _upgrades.length; ++_loc2)
        {
            _upgrades[_loc2].cleanUp;
        } // end of for
        this.removeAllListeners();
        _upgrades.length = 0;
    } // End of the function
    static var ENERGY_UPGRADE_EVENT = "energyUpgradeEvent";
    static var DOUBLE_UPGRADE_EVENT = "doubleUpgradeEvent";
    static var SINGLE_UPGRADE_EVENT = "singleUpgradeEvent";
    static var UPGRADE_ACTIVE = "upgradeActive";
    static var UPGRADE_INACTIVE = "upgradeInactive";
    static var UPGRADE_DELETED = "upgradeDeleted";
    static var FULL_ENERGY_AMOUNT = 100;
    var fullEnergyUpgrade = false;
    var _id = 0;
} // End of Class
