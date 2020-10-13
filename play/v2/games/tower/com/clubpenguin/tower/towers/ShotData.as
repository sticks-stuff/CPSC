class com.clubpenguin.tower.towers.ShotData extends Object
{
    var __tower, __target, __get__target, __get__tower;
    function ShotData(_tower, _enemyTarget)
    {
        super();
        __tower = _tower;
        __target = _enemyTarget;
    } // End of the function
    function get tower()
    {
        return (__tower);
    } // End of the function
    function get target()
    {
        return (__target);
    } // End of the function
} // End of Class
