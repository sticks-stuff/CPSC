class com.clubpenguin.util.Loader
{
    static var eventSource;
    function Loader()
    {
    } // End of the function
    static function loadAllMovies($parent, $movieLocations, $initLocaleText)
    {
        if (com.clubpenguin.util.Loader.eventSource == undefined)
        {
            eventSource = new Object();
            mx.events.EventDispatcher.initialize(com.clubpenguin.util.Loader.eventSource);
        } // end if
        submovieProgress = new Array();
        loadedMovies = 0;
        if ($initLocaleText == undefined)
        {
            $initLocaleText = true;
        } // end if
        if ($movieLocations != undefined)
        {
            var _loc12 = $movieLocations[0].split("/");
            var _loc11 = "";
            for (var _loc10 = 0; _loc10 < _loc12.length - 1; ++_loc10)
            {
                _loc11 = _loc11 + (_loc12[_loc10] + "/");
            } // end of for
            com.clubpenguin.util.Loader.debugTrace("root directory is \'" + _loc11 + "\'");
            var _loc9 = com.clubpenguin.util.Loader.localeOverride == undefined ? (com.clubpenguin.util.LocaleText.LANG_ID_EN) : (com.clubpenguin.util.Loader.localeOverride);
            var _loc8 = com.clubpenguin.util.Loader.localeVersion == undefined ? (com.clubpenguin.util.Loader.localeVersion) : (com.clubpenguin.util.Loader.localeVersion);
            if ($initLocaleText)
            {
                com.clubpenguin.util.LocaleText.init($parent, _loc9, _loc11, _loc8, true);
            } // end if
        }
        else
        {
            com.clubpenguin.util.Loader.debugTrace("no movieLocations array given!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
        } // end else if
        for (var _loc10 = 0; _loc10 < $movieLocations.length; ++_loc10)
        {
            com.clubpenguin.util.Loader.loadSubmovie($parent, $movieLocations[_loc10], _loc10);
        } // end of for
    } // End of the function
    static function loadSubmovie($parent, $movieLocation, $movieNum)
    {
        com.clubpenguin.util.Loader.debugTrace("load submovie");
        if ($parent == undefined)
        {
            com.clubpenguin.util.Loader.debugTrace("cannot load movie, parent movie is undefined!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            return;
        } // end if
        if ($movieLocation == undefined)
        {
            com.clubpenguin.util.Loader.debugTrace("cannot load movie, movie location is undefined!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            return;
        } // end if
        var _loc3 = $parent.createEmptyMovieClip("loadDataMC" + $movieNum, $parent.getNextHighestDepth());
        var _loc1 = new Object();
        var _loc2 = new MovieClipLoader();
        _loc1.onLoadInit = function ($targetMC)
        {
            com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
        };
        _loc1.onLoadProgress = function ($targetMC, $loadProgress, $loadTotal)
        {
            com.clubpenguin.util.Loader.handleLoadProgress($targetMC, $loadProgress, $loadTotal);
        };
        _loc1.onLoadError = function ($targetMC, $errorMessage)
        {
            com.clubpenguin.util.Loader.debugTrace("error loading submovie: " + $errorMessage, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
        };
        _loc2.addListener(_loc1);
        _loc2.loadClip($movieLocation, _loc3);
        com.clubpenguin.util.Loader.addProgressObject(_loc2.getProgress(_loc3));
    } // End of the function
    static function handleLoadProgress($mainMovie, $loadProgress, $loadTotal)
    {
        var _loc10 = 0;
        var _loc9 = 0;
        for (var _loc8 = 0; _loc8 < com.clubpenguin.util.Loader.submovieProgress.length; ++_loc8)
        {
            if (com.clubpenguin.util.Loader.submovieProgress[_loc8].movieClip == $mainMovie)
            {
                com.clubpenguin.util.Loader.submovieProgress[_loc8].bytesLoaded = $loadProgress;
                com.clubpenguin.util.Loader.submovieProgress[_loc8].bytesTotal = $loadTotal;
            } // end if
            _loc9 = _loc9 + com.clubpenguin.util.Loader.submovieProgress[_loc8].bytesLoaded;
            _loc10 = _loc10 + com.clubpenguin.util.Loader.submovieProgress[_loc8].bytesTotal;
        } // end of for
        var _loc7 = _loc9 / _loc10 * 100;
        com.clubpenguin.util.Loader.debugTrace("updated load progress. movie is now " + Math.round(_loc7) + "% loaded");
    } // End of the function
    static function handleLoadComplete($mainMovie)
    {
        com.clubpenguin.util.Loader.debugTrace("submovie loaded OK! are all loaded?");
        if ($mainMovie._name != "loadDataMC0")
        {
            $mainMovie.removeMovieClip();
        } // end if
        loadedMovies = ++com.clubpenguin.util.Loader.loadedMovies;
        loadedMovies = com.clubpenguin.util.Loader.loadedMovies;
        if (com.clubpenguin.util.Loader.loadedMovies >= com.clubpenguin.util.Loader.submovieProgress.length)
        {
            com.clubpenguin.util.Loader.debugTrace("all movies loaded OK!");
            var _loc7 = new Object();
            _loc7.target = com.clubpenguin.util.Loader;
            _loc7.type = com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED;
            com.clubpenguin.util.Loader.eventSource.dispatchEvent(_loc7);
            com.clubpenguin.util.Loader.debugTrace("dispatched LOAD_COMPLETED event");
        } // end if
    } // End of the function
    static function addEventListener($listener)
    {
        if (com.clubpenguin.util.Loader.eventSource == undefined)
        {
            eventSource = new Object();
            mx.events.EventDispatcher.initialize(com.clubpenguin.util.Loader.eventSource);
        } // end if
        com.clubpenguin.util.Loader.eventSource.addEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED, $listener);
    } // End of the function
    static function removeEventListener($listener)
    {
        com.clubpenguin.util.Loader.eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED, $listener);
    } // End of the function
    static function setLocale($locale)
    {
        localeOverride = $locale;
    } // End of the function
    static function setLocaleVersion($localeVersion)
    {
        localeVersion = $localeVersion;
    } // End of the function
    static function addProgressObject($progress)
    {
        com.clubpenguin.util.Loader.submovieProgress.push($progress);
    } // End of the function
    static function debugTrace($message, $priority)
    {
        if ($priority == undefined)
        {
            $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG_LOCALE)
        {
            com.clubpenguin.util.Reporting.debugTrace("(Loader) " + $message, $priority);
        } // end if
    } // End of the function
    static var EVENT_LOAD_COMPLETED = "onLoadComplete";
    static var EVENT_LOAD_IN_PROGRESS = "onLoadProgress";
    static var loadedMovies = 0;
    static var submovieProgress = new Array();
    static var localeVersion = undefined;
    static var localeOverride = undefined;
} // End of Class
