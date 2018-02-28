class com.clubpenguin.missions.loading.LoadMovieItem
{
    var _id, _url, _container, _listener, _mcl, dispatchEvent, __get__id, __get__percentLoaded;
    function LoadMovieItem($id, $url, $container)
    {
        _id = $id;
        _url = $url;
        _container = $container;
        mx.events.EventDispatcher.initialize(this);
        _listener = {};
        _listener.onLoadInit = com.clubpenguin.util.Delegate.create(this, onLoadInit);
        _listener.onLoadProgress = com.clubpenguin.util.Delegate.create(this, onLoadProgress);
        _mcl = new MovieClipLoader();
        _mcl.addListener(_listener);
    } // End of the function
    function start()
    {
        _mcl.loadClip(_url, _container);
    } // End of the function
    function onLoadInit($target)
    {
        this.dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieItemEvent(com.clubpenguin.missions.loading.LoadMovieItemEvent.COMPLETE, this));
    } // End of the function
    function onLoadProgress($target, $bytesLoaded, $bytesTotal)
    {
        _loaded = $bytesLoaded;
        _total = $bytesTotal;
        this.dispatchEvent(new com.clubpenguin.missions.loading.LoadMovieItemEvent(com.clubpenguin.missions.loading.LoadMovieItemEvent.PROGRESS, this));
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function get percentLoaded()
    {
        var _loc2 = _loaded / _total;
        if (_loc2)
        {
            return (_loc2);
        }
        else
        {
            return (0);
        } // end else if
    } // End of the function
    var _loaded = 0;
    var _total = 0;
} // End of Class
