class com.clubpenguin.tower.enemies.EnemyManager extends com.clubpenguin.tower.util.EventDispatcher
{
    var __uid, enemyKilledCount, _enemies, activeEnemies, updateListeners, removeAllListeners;
    static var __instance;
    function EnemyManager()
    {
        super();
        __uid = $_id = ++com.clubpenguin.tower.enemies.EnemyManager.$_id;
        enemyKilledCount = 0;
        _enemies = new Array();
        activeEnemies = new Array();
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.tower.enemies.EnemyManager.__instance == null)
        {
            __instance = new com.clubpenguin.tower.enemies.EnemyManager();
        } // end if
        com.clubpenguin.tower.enemies.EnemyFactory.initialize(com.clubpenguin.tower.GameEngine.getInstance(), 50);
        return (com.clubpenguin.tower.enemies.EnemyManager.__instance);
    } // End of the function
    static function createEnemy(_enemy, _path)
    {
        var _loc1;
        _loc1 = com.clubpenguin.tower.enemies.EnemyFactory.getEnemy(com.clubpenguin.tower.GameEngine.getInstance(), new flash.geom.Point(), _path, _enemy);
        _loc1.addEventListener(com.clubpenguin.tower.enemies.types.AbstractEnemy.DESTROYED, com.clubpenguin.tower.enemies.EnemyManager.__instance.onEnemyDestroyed, com.clubpenguin.tower.enemies.EnemyManager.__instance);
        _loc1.addEventListener(com.clubpenguin.tower.enemies.types.AbstractEnemy.DOUBLE_UPGRADE, com.clubpenguin.tower.enemies.EnemyManager.__instance.handleDoubleUpgrade, com.clubpenguin.tower.enemies.EnemyManager.__instance);
        _loc1.addEventListener(com.clubpenguin.tower.enemies.types.AbstractEnemy.SINGLE_UPGRADE, com.clubpenguin.tower.enemies.EnemyManager.__instance.handleSingleUpgrade, com.clubpenguin.tower.enemies.EnemyManager.__instance);
        _loc1.addEventListener(com.clubpenguin.tower.enemies.types.AbstractEnemy.ENERGY_UPGRADE, com.clubpenguin.tower.enemies.EnemyManager.__instance.handleEnergyUpgrade, com.clubpenguin.tower.enemies.EnemyManager.__instance);
        com.clubpenguin.tower.enemies.EnemyManager.__instance.addEnemy(_loc1);
    } // End of the function
    function addEnemy(_enemy)
    {
        if (_enemies == null)
        {
            _enemies = new Array();
        } // end if
        _enemies.push(_enemy);
    } // End of the function
    function handleEnemyHitCPU(target)
    {
        for (var _loc2 = 0; _loc2 < _enemies.length; ++_loc2)
        {
            if (_enemies[_loc2].getID() == target.getID())
            {
                _enemies.splice(_loc2, 1);
                var _loc4;
                var _loc3 = new Sound(_loc4);
                _loc3.attachSound("enemyHitCPU");
                _loc3.start();
            } // end if
        } // end of for
    } // End of the function
    function onEnemyDestroyed(details)
    {
        for (var _loc2 = 0; _loc2 < _enemies.length; ++_loc2)
        {
            if (_enemies[_loc2].getID() == details.getID())
            {
                _enemies.removeEventListener(com.clubpenguin.tower.enemies.types.AbstractEnemy.DESTROYED, onEnemyDestroyed, this);
                this.updateListeners(com.clubpenguin.tower.enemies.EnemyManager.ENEMY_DESTROYED);
                com.clubpenguin.tower.enemies.EnemyFactory.checkInEnemy(_enemies.splice(_loc2, 1)[0]);
                ++enemyKilledCount;
            } // end if
        } // end of for
    } // End of the function
    function onEnemyHit(details)
    {
        for (var _loc2 = 0; _loc2 < _enemies.length; ++_loc2)
        {
            if (details.target.getPosition().equals(_enemies[_loc2].getPosition()))
            {
                _enemies[_loc2].onHit(details.tower._damage);
            } // end if
        } // end of for
    } // End of the function
    function handleDoubleUpgrade(pos)
    {
        this.updateListeners(com.clubpenguin.tower.enemies.EnemyManager.DOUBLE_UPGRADE, pos);
    } // End of the function
    function handleSingleUpgrade(pos)
    {
        this.updateListeners(com.clubpenguin.tower.enemies.EnemyManager.SINGLE_UPGRADE, pos);
    } // End of the function
    function handleEnergyUpgrade(event)
    {
        this.updateListeners(com.clubpenguin.tower.enemies.EnemyManager.ENERGY_UPGRADE, event);
    } // End of the function
    function moveEnemies()
    {
        var _loc2 = 0;
        var _loc3;
        while (_loc2 < _enemies.length)
        {
            _loc3 = _enemies[_loc2];
            _loc3.move();
            ++_loc2;
        } // end while
    } // End of the function
    function getEnemyPositions()
    {
        var _loc3 = new Array();
        for (var _loc2 = 0; _loc2 < _enemies.length; ++_loc2)
        {
            _loc3.push(_enemies[_loc2].getPosition());
        } // end of for
        return (_loc3);
    } // End of the function
    function getEnemies()
    {
        var _loc3 = new Array();
        for (var _loc2 = 0; _loc2 < _enemies.length; ++_loc2)
        {
            _loc3.push((com.clubpenguin.tower.enemies.interfaces.IEnemy)(_enemies[_loc2]));
        } // end of for
        return (_loc3);
    } // End of the function
    function getStartingEnemyPosition()
    {
        var _loc2 = com.clubpenguin.tower.util.MathHelper.getRandomNumberInRange(com.clubpenguin.tower.enemies.EnemyManager.MIN_ENEMY_X_POS, com.clubpenguin.tower.enemies.EnemyManager.MAX_ENEMY_X_POS);
        var _loc1 = com.clubpenguin.tower.util.MathHelper.getRandomNumberInRange(com.clubpenguin.tower.enemies.EnemyManager.MIN_ENEMY_Y_POS, com.clubpenguin.tower.enemies.EnemyManager.MAX_ENEMY_Y_POS);
        return (new flash.geom.Point(_loc2, _loc1));
    } // End of the function
    function cleanUp()
    {
        com.clubpenguin.tower.enemies.EnemyFactory.dispose();
        var _loc3;
        for (var _loc2 = 0; _loc2 < _enemies.length; ++_loc2)
        {
            _loc3 = _enemies[_loc2];
            _loc3.cleanUp();
            _loc3 = null;
        } // end of for
        this.removeAllListeners();
        _enemies = null;
        com.clubpenguin.tower.enemies.types.AbstractEnemy.resetAll();
    } // End of the function
    function toString()
    {
        return ("[EnemyManager" + __uid + "]");
    } // End of the function
    static var $_id = -1;
    static var MIN_ENEMY_X_POS = -10;
    static var MAX_ENEMY_X_POS = -300;
    static var MIN_ENEMY_Y_POS = 10;
    static var MAX_ENEMY_Y_POS = -300;
    static var ENEMY_DESTROYED = "enemyDestroyed";
    static var DOUBLE_UPGRADE = "doubleUpgrade";
    static var SINGLE_UPGRADE = "singleUpgrade";
    static var ENERGY_UPGRADE = "energyUpgrade";
} // End of Class
