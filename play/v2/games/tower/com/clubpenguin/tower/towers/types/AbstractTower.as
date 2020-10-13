class com.clubpenguin.tower.towers.types.AbstractTower extends com.clubpenguin.tower.util.EventDispatcher implements com.clubpenguin.tower.towers.interfaces.ITower
{
    var _stage, _id, _view, _position, _dropZones, _towerArray, _shotCount, __isPlaceable, _xPosition, _yPosition, updateListeners, damages, ranges, rates, _eventInterval, _lastTime, _currentTime, _diff, removeAllListeners;
    function AbstractTower(stage, position, id, dropZones, towersArray, view, isPlaceable)
    {
        super();
        _stage = stage;
        _id = id;
        _view = view;
        _position = position;
        _dropZones = dropZones;
        _towerArray = towersArray;
        _shotCount = com.clubpenguin.tower.towers.types.AbstractTower.DEFAULT_SHOT_COUNT;
        __isPlaceable = isPlaceable;
        _view.setPositionsForDrops(__isPlaceable);
    } // End of the function
    function attachListeners()
    {
        _view.addEventListener(com.clubpenguin.tower.towers.views.AbstractTowerView.CLICK, onTowerRelease, this);
        _view.addEventListener(com.clubpenguin.tower.towers.views.AbstractTowerView.TOWER_COST, handleTowerCost, this);
        _view.addEventListener(com.clubpenguin.tower.towers.views.AbstractTowerView.TOWER_DROP, onTowerDrop, this);
        _view.addEventListener(com.clubpenguin.tower.towers.views.AbstractTowerView.DELAY_TOWER, towerDelay, this);
    } // End of the function
    function onTowerDrop(target)
    {
        _xPosition = target._xpos;
        _yPosition = target._ypos;
        _position = new flash.geom.Point(_xPosition, _yPosition);
    } // End of the function
    function towerDelay(target)
    {
        _dropped = true;
        this.updateListeners(com.clubpenguin.tower.towers.types.AbstractTower.TOWER_DROPPED, target);
    } // End of the function
    function setOrigin(target)
    {
        _view.setOrigin(target);
    } // End of the function
    function setDroppableGrid()
    {
    } // End of the function
    function handleTowerCost(target)
    {
        this.updateListeners(com.clubpenguin.tower.towers.types.AbstractTower.TOWER_COST, target);
    } // End of the function
    function handleUpgradeActive()
    {
        _view.setRangeRolloverFalse();
    } // End of the function
    function onTowerRelease(event)
    {
        var _loc3 = event.x;
        var _loc2 = event.y;
        var _loc7;
        if (!__isPlaceable.getit(_loc3, _loc2))
        {
            this.updateListeners(com.clubpenguin.tower.towers.types.AbstractTower.TOWER_COST, {target: this, cost: 0});
            _view.hide();
            com.clubpenguin.tower.towers.TowerManager.__instance.cleanUpTower(this);
            return;
        } // end if
        _view.dropTower();
        __isPlaceable.setit(_position.x, _position.y);
    } // End of the function
    function handleUpgrade()
    {
        _dropped = false;
        ++_upgradeCount;
        _damage = damages[_upgradeCount];
        _range = ranges[_upgradeCount];
        _delay = rates[_upgradeCount];
        _view.drawRange(_range);
        _view.handleUpgrade(_upgradeCount);
        _eventInterval = setInterval(this, "resumeShooting", 1900);
    } // End of the function
    function resumeShooting()
    {
        _dropped = true;
        clearInterval(_eventInterval);
    } // End of the function
    function checkForRange(targets)
    {
        var _loc5 = null;
        if (_dropped == true)
        {
            var _loc3;
            for (var _loc2 = 0; _loc2 < targets.length; ++_loc2)
            {
                _loc3 = flash.geom.Point.distance(_position, targets[_loc2].getPosition());
                if (isNaN(_loc3))
                {
                    return;
                    continue;
                } // end if
                if (_loc3 <= _range)
                {
                    _loc5 = (com.clubpenguin.tower.enemies.interfaces.IEnemy)(targets[_loc2]);
                    break;
                } // end if
            } // end of for
        } // end if
        if (_loc5 != null)
        {
            _view.rotate(_loc5);
        } // end if
        return (_loc5);
    } // End of the function
    function shoot(target)
    {
        var _loc2;
        if (isNaN(_lastTime))
        {
            _lastTime = getTimer() - this.getDelay();
        } // end if
        _currentTime = getTimer();
        _diff = _currentTime - _lastTime;
        if (_diff >= this.getDelay())
        {
            for (var _loc2 = 0; _loc2 < _shotCount; ++_loc2)
            {
                this.updateListeners(com.clubpenguin.tower.towers.types.AbstractTower.SHOOT_ENEMY, new com.clubpenguin.tower.towers.ShotData(this, target));
                _lastTime = _currentTime;
                _view.rotate(target);
                _view.shoot();
            } // end of for
        } // end if
    } // End of the function
    function handleActiveUpgrade()
    {
        _view.handleActiveUpgrade();
    } // End of the function
    function handleInactiveUpgrade()
    {
        _view.handleInactiveUpgrade();
    } // End of the function
    function getPosition()
    {
        return (_position);
    } // End of the function
    function getDamage()
    {
        if (_damage == -1)
        {
            throw new Error("_damage must be overwritten by subclass!");
        } // end if
        return (_damage);
    } // End of the function
    function getDelay()
    {
        if (_delay == -1)
        {
            throw new Error("_delay must be overwritten by subclass!");
        } // end if
        return (_delay);
    } // End of the function
    function getID()
    {
        return (_id);
    } // End of the function
    function checkForUpgrades()
    {
        if (_upgradeCount > 0)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function getTowerType()
    {
        if (_type == "")
        {
            throw new Error("_type must be overwritten by subclass!");
        } // end if
        return (_type);
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "AbstractTower\n";
        _loc2 = _loc2 + ("id: " + _id);
        _loc2 = _loc2 + ("_xPosition: " + _xPosition);
        _loc2 = _loc2 + ("_yPosition: " + _yPosition);
        _loc2 = _loc2 + ("_upgradeCount: " + _upgradeCount);
        return (_loc2);
    } // End of the function
    function hide()
    {
        _view.hide();
    } // End of the function
    function show()
    {
        this.attachListeners();
        _view.setPosition();
        _view.show();
    } // End of the function
    function cleanUp()
    {
        _view.cleanUp();
        _dropZones = null;
        if (__isPlaceable != null)
        {
            __isPlaceable.clean();
        } // end if
        __isPlaceable = null;
        this.removeAllListeners();
    } // End of the function
    static var SHOOT_ENEMY = "shootEnemy";
    static var TOWER_DROPPED = "towerDropped";
    static var TOWER_COST = "towerCost";
    static var DEFAULT_SHOT_COUNT = 1;
    var _upgradeCount = 0;
    var _range = -1;
    var _type = "";
    var _damage = -1;
    var _dropped = false;
    var _delay = -1;
} // End of Class
