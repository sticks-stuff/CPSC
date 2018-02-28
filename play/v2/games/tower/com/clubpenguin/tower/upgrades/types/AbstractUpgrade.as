class com.clubpenguin.tower.upgrades.types.AbstractUpgrade extends com.clubpenguin.tower.util.EventDispatcher implements com.clubpenguin.tower.upgrades.interfaces.IUpgrade
{
    var _view, _position, removeAllListeners;
    function AbstractUpgrade(event, id, view, _fromMenu)
    {
        super();
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        _view = view;
        _position = event.pos;
        this.setUpgradePosition();
        this.attachListeners();
    } // End of the function
    function setUpgradePosition()
    {
        var _loc3 = _position.x;
        var _loc2 = _position.y;
        _view.setUpgradePosition(_loc3, _loc2);
    } // End of the function
    function attachListeners()
    {
    } // End of the function
    function cleanUp()
    {
        _view.cleanUp;
        this.removeAllListeners();
    } // End of the function
    static var ENERGY_UPGRADE_EVENT = "energyUpgradeEvent";
    static var DOUBLE_UPGRADE_EVENT = "doubleUpgradeEvent";
    static var SINGLE_UPGRADE_EVENT = "singleUpgradeEvent";
} // End of Class
