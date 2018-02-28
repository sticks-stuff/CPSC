class com.clubpenguin.tower.upgrades.types.SingleUpgrade extends com.clubpenguin.tower.upgrades.types.AbstractUpgrade
{
    var _towers, _fromMenu, _view, updateListeners;
    function SingleUpgrade(scope, pos, __towers, fromMenu, id)
    {
        super(pos, id, new com.clubpenguin.tower.upgrades.views.SingleUpgradeView(scope, pos, fromMenu, id), fromMenu);
        _towers = __towers;
        _fromMenu = fromMenu;
    } // End of the function
    function attachListeners()
    {
        _view.addEventListener(com.clubpenguin.tower.upgrades.views.SingleUpgradeView.UPGRADE_CLICK, onUpgradeClicked, this);
        _view.addEventListener(com.clubpenguin.tower.upgrades.views.SingleUpgradeView.UPGRADE_ACTIVE, onUpgradeActive, this);
    } // End of the function
    function onUpgradeClicked(event)
    {
        var _loc5 = event.x;
        var _loc4 = event.y;
        for (var _loc2 = 0; _loc2 < _towers.length; ++_loc2)
        {
            if (_loc5 == _towers[_loc2]._xPosition && _loc4 == _towers[_loc2]._yPosition)
            {
                if (_towers[_loc2]._upgradeCount <= 1)
                {
                    this.updateListeners(com.clubpenguin.tower.upgrades.types.AbstractUpgrade.SINGLE_UPGRADE_EVENT, {id: _towers[_loc2]._id});
                    this.updateListeners(com.clubpenguin.tower.upgrades.types.SingleUpgrade.UPGRADE_INACTIVE);
                    _view.removeUpgrade();
                    continue;
                } // end if
                if (_towers[_loc2]._upgradeCount >= 2)
                {
                    return;
                } // end if
            } // end if
        } // end of for
        this.updateListeners(com.clubpenguin.tower.upgrades.types.SingleUpgrade.UPGRADE_DELETED);
        _view.removeUpgrade();
    } // End of the function
    function onUpgradeActive()
    {
        this.updateListeners(com.clubpenguin.tower.upgrades.types.SingleUpgrade.UPGRADE_ACTIVE);
    } // End of the function
    static var UPGRADE_ACTIVE = "upgradeActive";
    static var UPGRADE_INACTIVE = "upgradeInactive";
    static var UPGRADE_DELETED = "upgradeDeleted";
} // End of Class
