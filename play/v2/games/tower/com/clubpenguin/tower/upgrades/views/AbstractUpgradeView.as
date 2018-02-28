class com.clubpenguin.tower.upgrades.views.AbstractUpgradeView extends com.clubpenguin.tower.util.EventDispatcher implements com.clubpenguin.tower.upgrades.interfaces.IUpgradeView
{
    var _stage, _fromMenu, _id, _mc, _upgradeInHand, removeAllListeners;
    function AbstractUpgradeView(scope, fromMenu, id)
    {
        super();
        _stage = scope;
        _fromMenu = fromMenu;
        _id = id;
        if (LINKAGE_ID == "" || NAME == "")
        {
            throw new Error("LINKAGE_ID and NAME must be overidden by subclass");
        } // end if
        _mc = scope.upgrades.attachMovie(LINKAGE_ID, NAME + "_" + id, scope.upgrades.getNextHighestDepth());
        this.attachEvents();
    } // End of the function
    function attachEvents()
    {
        _mc.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleUpgradeClicked);
    } // End of the function
    function handleUpgradeClicked()
    {
        throw new Error("MUST BE DEFINED IN SUB CLASS VIEW");
    } // End of the function
    function setEnergyUpgradeText()
    {
    } // End of the function
    function setUpgradePosition(xPos, yPos)
    {
        if (_fromMenu == true)
        {
            _mc._x = _stage._xmouse;
            _mc._y = _stage._ymouse;
            _upgradeInHand = true;
            return;
        } // end if
        _mc._x = xPos;
        _mc._y = yPos;
        _upgradeInHand = true;
    } // End of the function
    function removeUpgrade()
    {
        _stage.upgrades[NAME + "_" + _id].removeMovieClip();
        delete _mc.onRelease;
    } // End of the function
    function cleanUp()
    {
        _mc.removeMovieClip();
        this.removeAllListeners();
    } // End of the function
    static var ENERGY_UPGRADE_EVENT = "energyUpgradeEvent";
    static var DOUBLE_UPGRADE_EVENT = "doubleUpgradeEvent";
    static var SINGLE_UPGRADE_EVENT = "singleUpgradeEvent";
    var LINKAGE_ID = "";
    var NAME = "";
} // End of Class
