class com.clubpenguin.lib.event.EventListener
{
    var handler, scope;
    function EventListener(_handler, _scope)
    {
        handler = _handler;
        scope = _scope;
    } // End of the function
    function toString()
    {
        return ("EventListener with scope (" + scope + ")");
    } // End of the function
} // End of Class
