class com.clubpenguin.tower.upgrades.types.EnergyUpgrade extends com.clubpenguin.tower.upgrades.types.AbstractUpgrade
{
    var _view, _energyAmount, updateListeners;
    function EnergyUpgrade(scope, event, fullEnergyUpgrade, id)
    {
        super(event, id, new com.clubpenguin.tower.upgrades.views.EnergyUpgradeView(scope, id));
        _fullEnergyUpgrade = fullEnergyUpgrade;
    } // End of the function
    function attachListeners()
    {
        _view.addEventListener(com.clubpenguin.tower.upgrades.views.AbstractUpgradeView.ENERGY_UPGRADE_EVENT, handleEnergyUpgrade, this);
    } // End of the function
    function handleEnergyUpgrade()
    {
        if (_fullEnergyUpgrade == true)
        {
            _energyAmount = 100;
        }
        else
        {
            _energyAmount = Math.floor(Math.random() * com.clubpenguin.tower.GameSettings.MAX_ENERGY_DROP);
            _energyAmount = Math.round(_energyAmount / 5) * 5;
            if (_energyAmount == 0)
            {
                _energyAmount = _energyAmount + 5;
            } // end if
        } // end else if
        this.updateListeners(com.clubpenguin.tower.upgrades.types.EnergyUpgrade.ENERGY_UPGRADE_EVENT, {energy: _energyAmount});
        _view.setEnergyUpgradeText(_energyAmount);
    } // End of the function
    static var ENERGY_UPGRADE_EVENT = "energyUpgradeEvent";
    var _fullEnergyUpgrade = false;
} // End of Class
