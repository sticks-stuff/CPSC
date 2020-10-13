class com.clubpenguin.tower.upgrades.views.SingleUpgradeView extends com.clubpenguin.tower.upgrades.views.AbstractUpgradeView
{
    var _stage, _mc, _towerArray, updateListeners;
    function SingleUpgradeView(scope, pos, _fromMenu, id)
    {
        super(scope, _fromMenu, id);
        _stage = scope;
        _mc._x = pos.x;
        _mc._y = pos.y;
        _towerArray = com.clubpenguin.tower.towers.TowerManager.getTowers();
        _mc.noDrop._visible = false;
        if (_fromMenu == true)
        {
            _mc.onEnterFrame = com.clubpenguin.tower.util.Delegate.create(this, updatePosition);
            _mc.gotoAndStop("clicked");
            _isActive = true;
            this.updateListeners(com.clubpenguin.tower.upgrades.views.SingleUpgradeView.UPGRADE_ACTIVE);
            _mc.noDrop._visible = true;
        } // end if
    } // End of the function
    function handleUpgradeClicked()
    {
        if (_isActive == false)
        {
            _mc.onEnterFrame = com.clubpenguin.tower.util.Delegate.create(this, updatePosition);
            _mc.gotoAndStop("clicked");
            _isActive = true;
            this.updateListeners(com.clubpenguin.tower.upgrades.views.SingleUpgradeView.UPGRADE_ACTIVE);
        }
        else
        {
            this.updateListeners(com.clubpenguin.tower.upgrades.views.SingleUpgradeView.UPGRADE_CLICK, {x: _mc._x, y: _mc._y});
        } // end else if
    } // End of the function
    function updatePosition()
    {
        var _loc5 = Math.round((_stage._xmouse - com.clubpenguin.tower.upgrades.views.SingleUpgradeView.HALF_GRID_WIDTH) / com.clubpenguin.tower.upgrades.views.SingleUpgradeView.GRID_NUM) * com.clubpenguin.tower.upgrades.views.SingleUpgradeView.GRID_NUM + com.clubpenguin.tower.upgrades.views.SingleUpgradeView.HALF_GRID_WIDTH;
        var _loc6 = Math.round((_stage._ymouse - com.clubpenguin.tower.upgrades.views.SingleUpgradeView.HALF_GRID_HEIGHT) / com.clubpenguin.tower.upgrades.views.SingleUpgradeView.GRID_NUM) * com.clubpenguin.tower.upgrades.views.SingleUpgradeView.GRID_NUM + com.clubpenguin.tower.upgrades.views.SingleUpgradeView.HALF_GRID_HEIGHT;
        var _loc4 = false;
        if (_mc._x != _loc5 || _mc._y != _loc6)
        {
            _mc._x = _loc5;
            _mc._y = _loc6;
            var _loc3;
            for (var _loc2 = 0; _loc2 < _towerArray.length; ++_loc2)
            {
                _loc3 = _towerArray[_loc2];
                if (_loc3._xPosition == _mc._x && _loc3._yPosition == _mc._y && _loc3._upgradeCount < 2)
                {
                    _loc4 = true;
                } // end if
            } // end of for
            _mc.noDrop._visible = !_loc4;
        } // end if
    } // End of the function
    var LINKAGE_ID = "com.clubpenguin.tower.upgrades.views.SingleUpgradeView";
    var NAME = "SingleUpgradeView";
    var _isActive = false;
    static var HALF_GRID_WIDTH = 21;
    static var HALF_GRID_HEIGHT = 21;
    static var GRID_NUM = 42;
    static var UPGRADE_CLICK = "upgradeClick";
    static var UPGRADE_ACTIVE = "upgradeActive";
} // End of Class
