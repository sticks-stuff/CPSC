class com.clubpenguin.tower.enemies.EnemyData
{
    var __set__type, __set__speed, __health, __dropsUpgrade, __waypoints, __type, __get__type, __speed, __get__speed, __get__dropUpgrade, __set__dropUpgrade, __get__health, __get__waypoints;
    function EnemyData(_type, _health, _speed)
    {
        this.__set__type(_type);
        this.__set__speed(_speed);
        __health = _health;
        __dropsUpgrade = false;
    } // End of the function
    function get waypoints()
    {
        return (__waypoints);
    } // End of the function
    function set type(_val)
    {
        if (_val == null || _val == undefined)
        {
            __type = this.getRandomEnemyType();
        }
        else
        {
            __type = _val;
        } // end else if
        //return (this.type());
        null;
    } // End of the function
    function set speed(_val)
    {
        __speed = _val;
        //return (this.speed());
        null;
    } // End of the function
    function set dropUpgrade(_dropUpgrade)
    {
        __dropsUpgrade = _dropUpgrade;
        //return (this.dropUpgrade());
        null;
    } // End of the function
    function get dropUpgrade()
    {
        return (__dropsUpgrade);
    } // End of the function
    function get type()
    {
        return (__type);
    } // End of the function
    function get speed()
    {
        return (__speed);
    } // End of the function
    function get health()
    {
        return (__health);
    } // End of the function
    function getRandomEnemyType()
    {
        var _loc1 = new Array(com.clubpenguin.tower.enemies.EnemyFactory.YELLOW_ENEMY, com.clubpenguin.tower.enemies.EnemyFactory.PURPLE_ENEMY, com.clubpenguin.tower.enemies.EnemyFactory.RED_ENEMY);
        var _loc2;
        _loc2 = com.clubpenguin.tower.util.MathHelper.getRandomNumberInRange(0, _loc1.length);
        return (_loc1[_loc2]);
    } // End of the function
    function toString()
    {
        var _loc2;
        _loc2 = "[EnemyData]{t:" + __type + ", s:" + __speed + ", h:" + __health + ", u: " + __dropsUpgrade + "}";
        return (_loc2);
    } // End of the function
} // End of Class
