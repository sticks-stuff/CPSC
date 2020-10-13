class com.clubpenguin.tower.enemies.EnemyFactory
{
    var __uid, __msg, __enemyPools;
    static var $_instance;
    function EnemyFactory()
    {
        __uid = $_id = ++com.clubpenguin.tower.enemies.EnemyFactory.$_id;
        if (com.clubpenguin.tower.enemies.EnemyFactory.$_instance != null)
        {
            throw "ERROR: ATTEMPTING TO INSTANCIATE ANOTHER ENEMY FACTORY";
        } // end if
        $_instance = this;
        __msg = "";
    } // End of the function
    function initializeEnemyPools()
    {
        __enemyPools = new Array();
        for (var _loc2 = 0; _loc2 < __types.length; ++_loc2)
        {
            __enemyPools[__types[_loc2]] = new Array();
        } // end of for
    } // End of the function
    static function initialize(_scope, _count)
    {
        if (com.clubpenguin.tower.enemies.EnemyFactory.$_instance == null)
        {
            new com.clubpenguin.tower.enemies.EnemyFactory();
        } // end if
        com.clubpenguin.tower.enemies.EnemyFactory.$_instance.initializeEnemies(_scope, _count);
    } // End of the function
    function initializeEnemies(_scope, _count)
    {
        this.initializeEnemyPools();
        var _loc4;
        var _loc6;
        var _loc9;
        var _loc5;
        _loc4 = new Array();
        _loc9 = __types.length;
        for (var _loc3 = 0; _loc3 < _loc9; ++_loc3)
        {
            _loc6 = __types[_loc3];
            _loc5 = new com.clubpenguin.tower.enemies.EnemyData(_loc6, 0, 0);
            _loc5.__set__dropUpgrade(false);
            for (var _loc2 = 0; _loc2 < _count; ++_loc2)
            {
                _loc4.push(this.createEnemy(_scope, new flash.geom.Point(250, 250), null, _loc5));
            } // end of for
        } // end of for
        while (_loc4.length > 0)
        {
            com.clubpenguin.tower.enemies.EnemyFactory.checkInEnemy((com.clubpenguin.tower.enemies.types.AbstractEnemy)(_loc4.shift()));
        } // end while
    } // End of the function
    static function getEnemy(scope, position, waypoints, _enemyData)
    {
        if (com.clubpenguin.tower.enemies.EnemyFactory.$_instance == null)
        {
            new com.clubpenguin.tower.enemies.EnemyFactory();
        } // end if
        return (com.clubpenguin.tower.enemies.EnemyFactory.$_instance.getNext(scope, position, waypoints, _enemyData));
    } // End of the function
    function getNext(scope, position, waypoints, _enemyData)
    {
        var _loc3;
        var _loc4;
        _loc4 = __enemyPools[_enemyData.__get__type()];
        if (_loc4.length == 0)
        {
            _loc3 = this.createEnemy(scope, position, waypoints, _enemyData);
        }
        else
        {
            _loc3 = (com.clubpenguin.tower.enemies.types.AbstractEnemy)(_loc4.shift());
            _loc3.reset(position, waypoints, _enemyData.__get__health(), _enemyData.__get__speed(), _enemyData.__get__dropUpgrade());
        } // end else if
        return (_loc3);
    } // End of the function
    function createEnemy(scope, position, waypoints, _enemyData)
    {
        var _loc2;
        switch (_enemyData.__get__type())
        {
            case com.clubpenguin.tower.enemies.EnemyFactory.YELLOW_ENEMY:
            {
                _loc2 = new com.clubpenguin.tower.enemies.types.YellowEnemy(scope, position, waypoints, _enemyData.__get__health(), _enemyData.__get__speed(), _enemyData.__get__dropUpgrade());
                break;
            } 
            case com.clubpenguin.tower.enemies.EnemyFactory.PURPLE_ENEMY:
            {
                _loc2 = new com.clubpenguin.tower.enemies.types.PurpleEnemy(scope, position, waypoints, _enemyData.__get__health(), _enemyData.__get__speed(), _enemyData.__get__dropUpgrade());
                break;
            } 
            case com.clubpenguin.tower.enemies.EnemyFactory.RED_ENEMY:
            {
                _loc2 = new com.clubpenguin.tower.enemies.types.RedEnemy(scope, position, waypoints, _enemyData.__get__health(), _enemyData.__get__speed(), _enemyData.__get__dropUpgrade());
                break;
            } 
            case com.clubpenguin.tower.enemies.EnemyFactory.YELLOW_BOSS:
            {
                _loc2 = new com.clubpenguin.tower.enemies.types.YellowBoss(scope, position, waypoints, _enemyData.__get__health(), _enemyData.__get__speed(), _enemyData.__get__dropUpgrade());
                break;
            } 
            case com.clubpenguin.tower.enemies.EnemyFactory.PURPLE_BOSS:
            {
                _loc2 = new com.clubpenguin.tower.enemies.types.PurpleBoss(scope, position, waypoints, _enemyData.__get__health(), _enemyData.__get__speed(), _enemyData.__get__dropUpgrade());
                break;
            } 
            case com.clubpenguin.tower.enemies.EnemyFactory.RED_BOSS:
            {
                _loc2 = new com.clubpenguin.tower.enemies.types.RedBoss(scope, position, waypoints, _enemyData.__get__health(), _enemyData.__get__speed(), _enemyData.__get__dropUpgrade());
                break;
            } 
            default:
            {
                throw new Error("Not a recognized type of enemy requested!");
                break;
            } 
        } // End of switch
        _loc2.__set__type(_enemyData.type);
        return (_loc2);
    } // End of the function
    static function checkInEnemy(_enemy)
    {
        com.clubpenguin.tower.enemies.EnemyFactory.$_instance.returnEnemy(_enemy);
    } // End of the function
    function returnEnemy(_enemy)
    {
        var _loc2;
        _enemy.disable();
        _loc2 = __enemyPools[_enemy.__get__type()];
        _loc2.push(_enemy);
        this.addMsg("[EnemyFactory] Returned " + _enemy.__get__type() + ":" + _loc2.length + "\n");
    } // End of the function
    function addMsg(_str)
    {
    } // End of the function
    static function dispose()
    {
        com.clubpenguin.tower.enemies.EnemyFactory.$_instance.disposeEnemyPool();
    } // End of the function
    function disposeEnemyPool()
    {
        var _loc3;
        var _loc4;
        for (var _loc5 = 0; _loc5 < __types.length; ++_loc5)
        {
            _loc4 = __enemyPools[__types[_loc5]];
            for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
            {
                _loc3 = _loc4[_loc2];
                _loc3.cleanUp();
                _loc3 = null;
            } // end of for
            _loc4 = null;
        } // end of for
        __enemyPools = null;
    } // End of the function
    function toString()
    {
        return ("[EnemyFactory" + __uid + "]");
    } // End of the function
    static var $_id = -1;
    static var YELLOW_ENEMY = "yellowEnemy";
    static var PURPLE_ENEMY = "purpleEnemy";
    static var RED_ENEMY = "redEnemy";
    static var PURPLE_BOSS = "purpleBoss";
    static var YELLOW_BOSS = "yellowBoss";
    static var RED_BOSS = "redBoss";
    var __types = [com.clubpenguin.tower.enemies.EnemyFactory.YELLOW_ENEMY, com.clubpenguin.tower.enemies.EnemyFactory.PURPLE_ENEMY, com.clubpenguin.tower.enemies.EnemyFactory.RED_ENEMY, com.clubpenguin.tower.enemies.EnemyFactory.YELLOW_BOSS, com.clubpenguin.tower.enemies.EnemyFactory.PURPLE_BOSS, com.clubpenguin.tower.enemies.EnemyFactory.RED_BOSS];
} // End of Class
