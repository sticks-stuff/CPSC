class com.clubpenguin.tower.towers.views.AbstractTowerView extends com.clubpenguin.tower.util.EventDispatcher implements com.clubpenguin.tower.towers.interfaces.ITowerView
{
    var _id, _towerDepth, _towerGlow, _mc, _stage, _towerArray, _range, _upgradeCount, timeOut, _rangeMC, __origin, updateListeners, _isPlaceable, mouseListener, _xpos, _ypos, sendInterval, removeAllListeners;
    static var __instance;
    function AbstractTowerView(scope, id, towerArray)
    {
        super();
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        var _loc4 = 0;
        if (LINKAGE_ID == "" || NAME == "")
        {
            throw new Error("LINKAGE_ID and NAME must be overridden by subclass");
        } // end if
        __instance = this;
        _id = id;
        _towerDepth = scope.towers.getNextHighestDepth();
        _towerGlow = scope.towers.glow.attachMovie("upgradeGlow", "upgradeGlow", scope.towers.glow.getNextHighestDepth());
        _mc = scope.towers.attachMovie(LINKAGE_ID, NAME + "_" + id, scope.towers.getNextHighestDepth());
        _mc._x = -100;
        _mc._y = -100;
        _stage = scope;
        _towerArray = towerArray;
        _mc.tower.stop();
        this.attachEvents();
    } // End of the function
    function shoot(target)
    {
        throw new Error("shoot() must be overridden by subclass");
    } // End of the function
    function drawRange(range)
    {
        _range = range;
    } // End of the function
    function setActive(value)
    {
        if (value)
        {
            _mc.gotoAndStop(ACTIVE_FRAME);
            return;
        } // end if
        _mc.gotoAndStop(PARK_FRAME);
    } // End of the function
    function handleActiveUpgrade()
    {
        if (_upgradeCount == 2)
        {
            return;
        } // end if
        _towerGlow.fadeIn();
    } // End of the function
    function handleInactiveUpgrade()
    {
        if (_upgradeCount == 2)
        {
            return;
        } // end if
        _towerGlow.fadeOut();
    } // End of the function
    function attachEvents()
    {
        timeOut = getTimer();
        _mc.onMouseUp = com.clubpenguin.tower.util.Delegate.create(this, onTowerRelease);
        _rangeMC.onMouseUp = com.clubpenguin.tower.util.Delegate.create(this, onTowerRelease);
    } // End of the function
    function onTowerRelease()
    {
        var _loc3;
        var _loc2;
        var _loc4;
        _loc3 = getTimer();
        _loc2 = _mc.hitTest(_stage._xmouse, _stage._ymouse);
        _loc4 = _rangeMC.hitTest(_stage._xmouse, _stage._ymouse);
        if (_loc2 || _loc4)
        {
            if (!__origin.hitTest(_stage._xmouse, _stage._ymouse))
            {
                if (_loc3 - timeOut > 500)
                {
                    this.updateListeners(com.clubpenguin.tower.towers.views.AbstractTowerView.CLICK, {x: _mc._x, y: _mc._y});
                } // end if
            } // end if
        } // end if
    } // End of the function
    function setPosition()
    {
        _mc.onEnterFrame = com.clubpenguin.tower.util.Delegate.create(this, updatePosition);
        _mc._x = _stage._xmouse;
        _mc._y = _stage._ymouse;
    } // End of the function
    function setPositionsForDrops(isPlaceable)
    {
        _isPlaceable = isPlaceable;
    } // End of the function
    function updatePosition()
    {
        _mc._x = Math.round((_stage._xmouse - com.clubpenguin.tower.towers.views.AbstractTowerView.HALF_GRID_WIDTH) / com.clubpenguin.tower.towers.views.AbstractTowerView.GRID_NUM) * com.clubpenguin.tower.towers.views.AbstractTowerView.GRID_NUM + com.clubpenguin.tower.towers.views.AbstractTowerView.HALF_GRID_WIDTH;
        _mc._y = Math.round((_stage._ymouse - com.clubpenguin.tower.towers.views.AbstractTowerView.HALF_GRID_HEIGHT) / com.clubpenguin.tower.towers.views.AbstractTowerView.GRID_NUM) * com.clubpenguin.tower.towers.views.AbstractTowerView.GRID_NUM + com.clubpenguin.tower.towers.views.AbstractTowerView.HALF_GRID_HEIGHT;
        _rangeMC._x = _mc._x;
        _rangeMC._y = _mc._y;
        if (!_isPlaceable.getit(_mc._x, _mc._y))
        {
            _rangeMC.rangeBox.gotoAndStop("noDrop");
        }
        else
        {
            _rangeMC.rangeBox.gotoAndStop("droppable");
        } // end else if
    } // End of the function
    function setOrigin(target)
    {
        __origin = (MovieClip)(target);
    } // End of the function
    function dropTower()
    {
        delete _mc.onMouseUp;
        delete _rangeMC.onMouseUp;
        _rangeMC.rangeBox._visible = false;
        Mouse.removeListener(mouseListener);
        Mouse.show();
        _stage.createEmptyMovieClip("dropTowerHolder", _stage.getNextHighestDepth());
        var _loc2 = new Sound(_stage.dropTowerHolder);
        _loc2.attachSound("towerDropped");
        _loc2.start();
        _xpos = _mc._x;
        _ypos = _mc._y;
        _towerGlow.setPosition(_xpos, _ypos);
        delete _mc.onEnterFrame;
        _mc.tower.play();
        this.hideRange();
        if (cost == null)
        {
            throw new Error("cost must be defined in sub-class");
        } // end if
        this.updateListeners(com.clubpenguin.tower.towers.views.AbstractTowerView.TOWER_COST, {target: this, cost: cost});
        this.updateListeners(com.clubpenguin.tower.towers.views.AbstractTowerView.TOWER_DROP, this);
        _mc.onRelease = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOver);
        _mc.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut);
        _mc.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut);
        sendInterval = setInterval(this, "sendEvent", 1900);
    } // End of the function
    function sendEvent()
    {
        clearInterval(sendInterval);
        this.updateListeners(com.clubpenguin.tower.towers.views.AbstractTowerView.DELAY_TOWER, this);
    } // End of the function
    function rotate(target)
    {
        var _loc7 = 50;
        var _loc6 = 1;
        var _loc3;
        var _loc5 = target.getPosition();
        var _loc2 = Math.atan2(_loc5.x - _mc._x, _loc5.y - _mc._y) * 180 / 3.141593E+000;
        _loc2 = _loc2 - 90;
        if (_loc2 < 0)
        {
            _loc2 = _loc2 + 360;
        } // end if
        _loc3 = _loc2 / 2.250000E+001;
        _loc3 = _loc3 % 16;
        var _loc4 = Math.round(_loc7 + _loc6 * _loc3);
        _mc.setAim(_loc4);
        _mc.tower.gotoAndStop(_loc4);
    } // End of the function
    function onTowerRollOver()
    {
        if (!clicked)
        {
            _rangeMC._visible = true;
            clicked = true;
        }
        else
        {
            _rangeMC._visible = false;
            clicked = false;
        } // end else if
    } // End of the function
    function onTowerRollOut()
    {
        _rangeMC._visible = false;
        clicked = false;
    } // End of the function
    function handleUpgrade(upgradeCount)
    {
        _upgradeCount = upgradeCount;
        switch (upgradeCount)
        {
            case 1:
            {
                this.handleFirstUpgrade(upgradeCount);
                break;
            } 
            case 2:
            {
                this.handleSecondUpgrade(upgradeCount);
                break;
            } 
        } // End of switch
        _rangeMC._width = _range * 2;
        _rangeMC._height = _range * 2;
    } // End of the function
    function upgradeTower(_towerLevel)
    {
        _mc.upgradeTower(_towerLevel);
    } // End of the function
    function handleFirstUpgrade(upgradeCount)
    {
        _mc.removeMovieClip();
        _mc = _stage.towers.attachMovie(LINKAGE_ID + upgradeCount, NAME + "_" + _id, _stage.towers.getNextHighestDepth());
        _mc._x = _xpos;
        _mc._y = _ypos;
        _mc.onPress = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOver);
        _mc.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut);
        _mc.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut);
        _rangeMC._visible = false;
    } // End of the function
    function handleSecondUpgrade(upgradeCount)
    {
        _mc.removeMovieClip();
        _mc = _stage.towers.attachMovie(LINKAGE_ID + upgradeCount, NAME + "_" + _id, _stage.towers.getNextHighestDepth());
        _towerGlow.fadeOut();
        _mc._x = _xpos;
        _mc._y = _ypos;
        _mc.onPress = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOver);
        _mc.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut);
        _mc.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut);
        _rangeMC._visible = false;
    } // End of the function
    function setRangeRolloverFalse()
    {
        _mc.onRollOver.enabled = false;
        _mc.onRollOut.enabled = false;
    } // End of the function
    function setRangeRolloverTrue()
    {
        _mc.onRollOver.enabled = true;
        _mc.onRollOut.enabled = true;
    } // End of the function
    function drawCircle(range)
    {
        _rangeMC = _stage.attachMovie("rangeIndicator", "rangeIndicator" + _id, _stage.towers.getNextHighestDepth(), {_x: _mc._x, _y: _mc._y});
        _rangeMC.range._width = range * 2;
        _rangeMC.range._height = range * 2;
    } // End of the function
    function hide()
    {
        delete _mc.onMouseUp;
        delete _rangeMC.onMouseUp;
        _rangeMC._visible = false;
        _mc._visible = false;
        Mouse.removeListener(mouseListener);
        Mouse.show();
        this.removeAllListeners();
    } // End of the function
    function show()
    {
        _mc._visible = true;
        _rangeMC._visible = true;
        this.attachEvents();
    } // End of the function
    function hideRange()
    {
        _rangeMC._visible = false;
    } // End of the function
    function cleanUp()
    {
        Mouse.removeListener(mouseListener);
        Mouse.show();
        _mc.removeMovieClip();
        _rangeMC.removeMovieClip();
        this.removeAllListeners();
    } // End of the function
    static var CLICK = "click";
    static var TOWER_DROP = "towerDropped";
    static var TOWER_COST = "towerCost";
    static var DELAY_TOWER = "delayTower";
    static var TOWER_DROPPED = "tower_dropped";
    var LINKAGE_ID = "";
    var NAME = "";
    var PARK_FRAME = 1;
    var ACTIVE_FRAME = 2;
    var cost = null;
    var clicked = false;
    var num = 0;
    static var HALF_GRID_WIDTH = 21;
    static var HALF_GRID_HEIGHT = 21;
    static var GRID_NUM = 42;
} // End of Class
