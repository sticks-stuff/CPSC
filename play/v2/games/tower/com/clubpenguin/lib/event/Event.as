class com.clubpenguin.lib.event.Event extends Object
{
    var __eventDispatcher, __eventType, __eventData, __get__target, __get__data, __get__type, __set__data, __set__target, __set__type;
    function Event(_source, _type, _data)
    {
        super();
        __eventDispatcher = _source;
        __eventType = _type;
        __eventData = _data;
    } // End of the function
    function get target()
    {
        return (__eventDispatcher);
    } // End of the function
    function set target(_val)
    {
        __eventDispatcher = _val;
        //return (this.target());
        null;
    } // End of the function
    function get data()
    {
        return (__eventData);
    } // End of the function
    function set data(_val)
    {
        __eventData = _val;
        //return (this.data());
        null;
    } // End of the function
    function get type()
    {
        return (__eventType);
    } // End of the function
    function set type(_val)
    {
        __eventType = _val;
        //return (this.type());
        null;
    } // End of the function
    function clone()
    {
        var _loc2;
        _loc2 = this.createEvent();
        return (_loc2);
    } // End of the function
    function createEvent()
    {
        return (new com.clubpenguin.lib.event.Event(__eventDispatcher, __eventType, __eventData));
    } // End of the function
    function toString()
    {
        var _loc1;
        _loc1 = "Event";
        return (_loc1);
    } // End of the function
} // End of Class
