class com.clubpenguin.util.Delegate
{
    function Delegate()
    {
    } // End of the function
    static function create(target, handler)
    {
        var _loc2 = function ()
        {
            var _loc2 = arguments.callee;
            var _loc3 = arguments.concat(_loc2.initArgs);
            return (_loc2.handler.apply(_loc2.target, _loc3));
        };
        _loc2.target = target;
        _loc2.handler = handler;
        _loc2.initArgs = arguments.slice(2);
        return (_loc2);
    } // End of the function
} // End of Class
