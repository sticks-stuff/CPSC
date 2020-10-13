class com.clubpenguin.missions.loading.LoadMovieQueue extends Array
{
    var _loadingItems, _loadedItems, length, shift, dispatchEvent, __get__complete, __get__loading, __get__percentLoaded;
    function LoadMovieQueue()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        _loadingItems = {};
        _loadedItems = {};
    } // End of the function
    function push($url, $container)
    {
        if ($url == "" && $url == null)
        {
        } // end if
        if (!$container)
        {
        } // end if
        var _loc4 = new com.clubpenguin.missions.loading.LoadMovieItem(length + 1, $url, $container);
        super.push(_loc4);
        ++_totalItems;
    } // End of the function
    function start()
    {
        if (!_loading)
        {
            if (length >= com.clubpenguin.missions.loading.LoadMovieQueue.THREAD_AMOUNT)
            {
                while (_activeItems < com.clubpenguin.missions.loading.LoadMovieQueue.THREAD_AMOUNT)
                {
                    this.startNext();
                } // end while
            }
            else
            {
                for (var _loc2 = 0; _loc2 < length; ++_loc2)
                {
                    this.startNext();
                } // end of for
            } // end if
        } // end else if
    } // End of the function
    function get loading()
    {
        return (_loading);
    } // End of the function
    function get complete()
    {
        return (_complete);
    } // End of the function
    function get percentLoaded()
    {
        return (_loaded / _totalItems);
    } // End of the function
    function startNext()
    {
        _loading = true;
        var _loc2 = (com.clubpenguin.missions.loading.LoadMovieItem)(this.shift());
        _loc2.start();
        _loc2.addEventListener(com.clubpenguin.missions.loading.LoadMovieItemEvent.PROGRESS, mx.utils.Delegate.create(this, onLoadItemProgress));
        _loc2.addEventListener(com.clubpenguin.missions.loading.LoadMovieItemEvent.COMPLETE, mx.utils.Delegate.create(this, onLoadItemComplete));
        _loadingItems["item" + _loc2.__get__id()] = _loc2;
        ++_activeItems;
    } // End of the function
    function onLoadItemProgress($event)
    {
        _loaded = 0;
        var _loc2;
        for (var _loc2 in _loadingItems)
        {
            _loaded = _loaded + _loadingItems[_loc2].percentLoaded;
        } // end of for...in
        for (var _loc2 in _loadedItems)
        {
            _loaded = _loaded + 1;
        } // end of for...in
        this.dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieQueueEvent(com.clubpenguin.missions.loading.LoadMovieQueueEvent.PROGRESS, this));
    } // End of the function
    function onLoadItemComplete($event)
    {
        var _loc2 = $event.__get__target();
        --_activeItems;
        delete _loadingItems["item" + _loc2.__get__id()];
        _loadedItems["item" + _loc2.__get__id()] = _loc2;
        if (length > 0)
        {
            this.startNext();
        }
        else if (_activeItems == 0)
        {
            this.onQueueComplete();
        } // end else if
    } // End of the function
    function onQueueComplete()
    {
        _complete = true;
        _loading = false;
        _loaded = _totalItems;
        this.dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieQueueEvent(com.clubpenguin.missions.loading.LoadMovieQueueEvent.COMPLETE, this));
    } // End of the function
    static var THREAD_AMOUNT = 1;
    var _loading = false;
    var _complete = false;
    var _totalItems = 0;
    var _loaded = 0;
    var _activeItems = 0;
} // End of Class
