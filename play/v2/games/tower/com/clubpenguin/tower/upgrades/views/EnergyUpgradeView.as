class com.clubpenguin.tower.upgrades.views.EnergyUpgradeView extends com.clubpenguin.tower.upgrades.views.AbstractUpgradeView
{
    var _mc, updateListeners;
    function EnergyUpgradeView(scope, id)
    {
        super(scope, null, id);
        _mc.amountText._visible = false;
    } // End of the function
    function handleUpgradeClicked()
    {
        this.updateListeners(com.clubpenguin.tower.upgrades.views.AbstractUpgradeView.ENERGY_UPGRADE_EVENT);
        delete _mc.onRelease;
        _mc.gotoAndPlay("animation");
    } // End of the function
    function setEnergyUpgradeText(energyAmount)
    {
        _mc.amountText._visible = true;
        _mc.amountText.energyAmount.text = "+" + energyAmount;
        _mc.amountText.energyAmountShadow.text = "+" + energyAmount;
    } // End of the function
    var LINKAGE_ID = "com.clubpenguin.tower.upgrades.views.EnergyUpgradeView";
    var NAME = "EnergyUpgradeView";
} // End of Class
