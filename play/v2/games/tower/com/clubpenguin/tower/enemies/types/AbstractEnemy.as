class com.clubpenguin.tower.enemies.types.AbstractEnemy implements com.clubpenguin.tower.enemies.interfaces.IEnemy
{
    var _id, _position, _waypoints, lastWaypoint, currWaypoint, _atWaypoint, _initialHealth, dropsUpgrade, _view, _enemyDirection, dist, angle, updateListeners, __type, __get__type, __set__type;
    function AbstractEnemy(position, waypoints, $health, $speed, $dropsUpgrade)
    {
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        _id = $_id = ++com.clubpenguin.tower.enemies.types.AbstractEnemy.$_id;
        _position = new flash.geom.Point();
        _waypoints = waypoints.concat();
        lastWaypoint = (flash.geom.Point)(_waypoints[0]);
        currWaypoint = (flash.geom.Point)(_waypoints.shift());
        this.setPosition(position.x, position.y);
        _atWaypoint = true;
        needsInit = false;
        _health = $health;
        MOVE_DISTANCE = $speed;
        _initialHealth = _health;
        dropsUpgrade = $dropsUpgrade;
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function removeEventListener()
    {
    } // End of the function
    function setView(view)
    {
        _view = view;
    } // End of the function
    function reset(position, waypoints, $health, $speed, $dropsUpgrade)
    {
        _position = new flash.geom.Point();
        _waypoints = waypoints.concat();
        lastWaypoint = (flash.geom.Point)(_waypoints[0]);
        currWaypoint = (flash.geom.Point)(_waypoints.shift());
        this.setPosition(position.x, position.y);
        _atWaypoint = true;
        needsInit = false;
        _health = $health;
        MOVE_DISTANCE = $speed;
        _initialHealth = _health;
        dropsUpgrade = $dropsUpgrade;
        _view.setHealth(_health, _initialHealth);
        _view.show();
    } // End of the function
    function move()
    {
        if (needsInit)
        {
            return;
        } // end if
        if (enemyMoving == false)
        {
            if (lastWaypoint.x > currWaypoint.x && Math.abs(lastWaypoint.y - currWaypoint.y) < 2)
            {
                _view.animateLeft();
                enemyMoving = true;
                _enemyDirection = "left";
            } // end if
            if (lastWaypoint.y > currWaypoint.y && Math.abs(lastWaypoint.x - currWaypoint.x) < 2)
            {
                _view.animateBack();
                enemyMoving = true;
                _enemyDirection = "back";
            } // end if
            if (lastWaypoint.x < currWaypoint.x && Math.abs(lastWaypoint.y - currWaypoint.y) < 2)
            {
                _view.animateRight();
                enemyMoving = true;
                _enemyDirection = "right";
            } // end if
            if (lastWaypoint.y < currWaypoint.y && Math.abs(lastWaypoint.x - currWaypoint.x) < 2)
            {
                _view.animateForward();
                enemyMoving = true;
                _enemyDirection = "forward";
            } // end if
        } // end if
        if (_atWaypoint)
        {
            enemyMoving = false;
            lastWaypoint = currWaypoint;
            this.setPosition(currWaypoint.x, currWaypoint.y);
            currWaypoint = (flash.geom.Point)(_waypoints.shift());
            if (currWaypoint == null)
            {
                _view.cleanUp();
            } // end if
            _atWaypoint = false;
        } // end if
        dist = currWaypoint.subtract(_position);
        if (dist.length < 7)
        {
            _atWaypoint = true;
            ++point_to_reach;
        } // end if
        angle = Math.atan2(dist.y, dist.x);
        var _loc2 = this.getPosition();
        _loc2.x = _loc2.x + MOVE_DISTANCE * Math.cos(angle);
        _loc2.y = _loc2.y + MOVE_DISTANCE * Math.sin(angle);
        this.setPosition(_loc2.x, _loc2.y);
    } // End of the function
    function getPosition()
    {
        return (_position.clone());
    } // End of the function
    function onHit(damage)
    {
        this.decreaseHealth(damage);
    } // End of the function
    function getID()
    {
        return (_id);
    } // End of the function
    function decreaseHealth(amount)
    {
        _health = _health - amount;
        if (_health <= 0)
        {
            if (dropsUpgrade == true)
            {
                this.updateListeners(com.clubpenguin.tower.enemies.types.AbstractEnemy.SINGLE_UPGRADE, {pos: this.getPosition()});
            } // end if
            this.handleEnemyDead();
        } // end if
        _view.setHealth(_health, _initialHealth);
    } // End of the function
    function handleEnemyDead()
    {
        this.updateListeners(com.clubpenguin.tower.enemies.types.AbstractEnemy.DESTROYED, this);
        _health = 0;
        this.handleLoot();
    } // End of the function
    function handleLoot()
    {
        var _loc3 = 100;
        var _loc2 = Math.ceil(Math.random() * _loc3);
        if (_loc2 >= com.clubpenguin.tower.enemies.types.AbstractEnemy.energyUpgradeFullChanceLow && _loc2 <= com.clubpenguin.tower.enemies.types.AbstractEnemy.energyUpgradeFullChanceHigh)
        {
            this.updateListeners(com.clubpenguin.tower.enemies.types.AbstractEnemy.ENERGY_UPGRADE, {pos: this.getPosition(), amount: com.clubpenguin.tower.enemies.types.AbstractEnemy.energyUpgradeFull});
            energyUpgradeFullChanceHigh = 0;
            return;
        } // end if
        if (_loc2 >= com.clubpenguin.tower.enemies.types.AbstractEnemy.ENERGY_UPGRADE_CHANCE_LOW && _loc2 < com.clubpenguin.tower.enemies.types.AbstractEnemy.ENERGY_UPGRADE_CHANCE_HIGH)
        {
            this.updateListeners(com.clubpenguin.tower.enemies.types.AbstractEnemy.ENERGY_UPGRADE, {pos: this.getPosition(), amount: null});
            energyUpgradeFullChanceHigh = com.clubpenguin.tower.enemies.types.AbstractEnemy.energyUpgradeFullChanceHigh + 5;
        } // end if
        return;
    } // End of the function
    function setPosition(x, y)
    {
        _position.x = x;
        _position.y = y;
        _view.setPosition(_position.x, _position.y);
    } // End of the function
    function cleanUp()
    {
        _view.dispose();
    } // End of the function
    function get type()
    {
        return (__type);
    } // End of the function
    function set type(_str)
    {
        __type = _str;
        //return (this.type());
        null;
    } // End of the function
    function disable()
    {
        _view.handleEnemyExplode(_enemyDirection);
    } // End of the function
    static function resetAll()
    {
        $_id = -1;
    } // End of the function
    static var DESTROYED = "destroyed";
    static var DOUBLE_UPGRADE = "doubleUpgrade";
    static var SINGLE_UPGRADE = "singleUpgrade";
    static var ENERGY_UPGRADE = "energyUpgrade";
    static var ENERGY_UPGRADE_CHANCE_LOW = 50;
    static var ENERGY_UPGRADE_CHANCE_HIGH = 55;
    static var DOUBLE_UPGRADE_CHANCE = -99;
    static var energyUpgradeFullChanceLow = 0;
    static var energyUpgradeFullChanceHigh = 0;
    static var energyUpgradeFull = 50;
    var _health = 100;
    var MOVE_DISTANCE = 10;
    var point_to_reach = 0;
    var needsInit = true;
    var enemyMoving = false;
    static var $_id = -1;
} // End of Class
