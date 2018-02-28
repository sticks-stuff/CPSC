class com.clubpenguin.lib.locale.LocaleText implements com.clubpenguin.lib.event.IEventDispatcher
{
    static var locale, localeDataMC, dataArray, localeDirectoryURL;
    function LocaleText()
    {
    } // End of the function
    function getUniqueName()
    {
        return ("[LocaleText]");
    } // End of the function
    static function init($parent, $languageID, $movieLocation, $versionNumber, $useLoader)
    {
        ready = false;
        if ($useLoader == undefined)
        {
            $useLoader = false;
        } // end if
        if ($languageID == undefined)
        {
            $languageID = com.clubpenguin.lib.locale.LocaleText.getLocaleID();
        } // end if
        localeID = $languageID;
        var _loc1 = com.clubpenguin.lib.locale.LocaleText.getLocale(com.clubpenguin.lib.locale.LocaleText.localeID);
        locale = _loc1;
        if ($versionNumber == undefined)
        {
            if (com.clubpenguin.lib.locale.LocaleText.localeVersion == undefined)
            {
                _loc1 = com.clubpenguin.lib.locale.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1 + "/" + com.clubpenguin.lib.locale.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.lib.locale.LocaleText.LANG_LOC_FILETYPE;
            }
            else
            {
                _loc1 = com.clubpenguin.lib.locale.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1 + "/" + com.clubpenguin.lib.locale.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.lib.locale.LocaleText.localeVersion + com.clubpenguin.lib.locale.LocaleText.LANG_LOC_FILETYPE;
            } // end else if
        }
        else
        {
            _loc1 = com.clubpenguin.lib.locale.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1 + "/" + com.clubpenguin.lib.locale.LocaleText.LANG_LOC_FILENAME + $versionNumber + com.clubpenguin.lib.locale.LocaleText.LANG_LOC_FILETYPE;
        } // end else if
        localeDataMC = $parent.createEmptyMovieClip("localeDataMC", $parent.getNextHighestDepth());
        var _loc2 = new Object();
        var _loc3 = new MovieClipLoader();
        if ($languageID == com.clubpenguin.lib.locale.LocaleText.LANG_ID_LOADERROR)
        {
            _loc2.onLoadError = com.clubpenguin.lib.locale.LocaleText.onSecondLocaleLoadError;
        }
        else
        {
            _loc2.onLoadError = com.clubpenguin.lib.locale.LocaleText.onFirstLocaleLoadError;
        } // end else if
        if ($movieLocation != undefined)
        {
            _loc1 = $movieLocation + _loc1;
        } // end if
        if ($useLoader)
        {
            _loc2.onLoadProgress = com.clubpenguin.lib.locale.LocaleText.onLocaleLoaderLoadProgress;
            _loc2.onLoadInit = com.clubpenguin.lib.locale.LocaleText.onLoacaleLoaderLoadInit;
            _loc3.addListener(_loc2);
            _loc3.loadClip(_loc1, com.clubpenguin.lib.locale.LocaleText.localeDataMC);
        }
        else
        {
            _loc2.onLoadInit = com.clubpenguin.lib.locale.LocaleText.onLocaleLoadInit;
            _loc3.addListener(_loc2);
            _loc3.loadClip(_loc1, com.clubpenguin.lib.locale.LocaleText.localeDataMC);
        } // end else if
    } // End of the function
    static function onLocaleLoadInit($targetMC)
    {
        com.clubpenguin.lib.locale.LocaleText.handleLoadComplete($targetMC);
    } // End of the function
    static function onLoacaleLoaderLoadInit($targetMC)
    {
        com.clubpenguin.lib.locale.LocaleText.handleLoadComplete($targetMC);
    } // End of the function
    static function onLocaleLoaderLoadProgress($targetMC, $loadProgress, $loadTotal)
    {
    } // End of the function
    static function onFirstLocaleLoadError($targetMC)
    {
        com.clubpenguin.lib.locale.LocaleText.init($targetMC, com.clubpenguin.lib.locale.LocaleText.LANG_ID_LOADERROR);
    } // End of the function
    static function onSecondLocaleLoadError($targetMC, $errorMessage)
    {
        com.clubpenguin.lib.locale.LocaleText.debugTrace("load error: " + $errorMessage, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
        com.clubpenguin.lib.locale.LocaleText.handleLoadComplete($targetMC);
    } // End of the function
    static function handleLoadComplete($data)
    {
        dataArray = new Array();
        for (var _loc2 in $data.localeText)
        {
            com.clubpenguin.lib.locale.LocaleText.dataArray[$data.localeText[_loc2].id] = $data.localeText[_loc2].value;
            com.clubpenguin.lib.locale.LocaleText.debugTrace("dataArray[" + $data.localeText[_loc2].id + "] = " + $data.localeText[_loc2].value);
        } // end of for...in
        ready = true;
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.LocaleTextEvent(new com.clubpenguin.lib.locale.LocaleText(), com.clubpenguin.lib.event.LocaleTextEvent.LOAD_COMPLETE));
    } // End of the function
    static function getText($stringID)
    {
        if (!com.clubpenguin.lib.locale.LocaleText.ready)
        {
            com.clubpenguin.lib.locale.LocaleText.debugTrace("getText called when not ready", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return ("[id:" + $stringID + " not ready]");
        }
        else if (com.clubpenguin.lib.locale.LocaleText.dataArray[$stringID] == undefined)
        {
            com.clubpenguin.lib.locale.LocaleText.debugTrace("load error for string: " + $stringID, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            return ("[id:" + $stringID + " undefined]");
        } // end else if
        return (com.clubpenguin.lib.locale.LocaleText.dataArray[$stringID]);
    } // End of the function
    static function getTextReplaced($stringID, $replacements)
    {
        var _loc2 = com.clubpenguin.lib.locale.LocaleText.getText($stringID);
        var _loc3 = $replacements.length;
        for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
        {
            _loc2 = _loc2.split("%" + _loc1).join($replacements[_loc1]);
        } // end of for
        return (_loc2);
    } // End of the function
    static function getLocale($localeID)
    {
        switch ($localeID)
        {
            case com.clubpenguin.lib.locale.LocaleText.LANG_ID_EN:
            {
                return (com.clubpenguin.lib.locale.LocaleText.LANG_LOC_EN);
            } 
            case com.clubpenguin.lib.locale.LocaleText.LANG_ID_PT:
            {
                return (com.clubpenguin.lib.locale.LocaleText.LANG_LOC_PT);
            } 
            case com.clubpenguin.lib.locale.LocaleText.LANG_ID_FR:
            {
                return (com.clubpenguin.lib.locale.LocaleText.LANG_LOC_FR);
            } 
            case com.clubpenguin.lib.locale.LocaleText.LANG_ID_ES:
            {
                return (com.clubpenguin.lib.locale.LocaleText.LANG_LOC_ES);
            } 
            case com.clubpenguin.lib.locale.LocaleText.LANG_ID_LOADERROR:
            {
                return (com.clubpenguin.lib.locale.LocaleText.LANG_LOC_EN);
            } 
        } // End of switch
        return (com.clubpenguin.lib.locale.LocaleText.LANG_LOC_EN);
        return (com.clubpenguin.lib.locale.LocaleText.LANG_LOC_EN);
    } // End of the function
    static function setLocaleVersion($localeVersion)
    {
        localeVersion = $localeVersion;
    } // End of the function
    static function setLocaleID($localeID)
    {
        localeID = $localeID;
    } // End of the function
    static function getLocaleID()
    {
        return (com.clubpenguin.lib.locale.LocaleText.localeID);
    } // End of the function
    static function isReady()
    {
        return (com.clubpenguin.lib.locale.LocaleText.ready);
    } // End of the function
    static function attachLocaleClip($stringID, $target)
    {
        var _loc1 = com.clubpenguin.lib.locale.LocaleText.localeDataMC.attachMovie($stringID, $stringID + "_mc", com.clubpenguin.lib.locale.LocaleText.localeDataMC.getNextHighestDepth());
        var _loc2 = new flash.display.BitmapData(_loc1._width, _loc1._height, true, 0);
        _loc2.draw(_loc1, new flash.geom.Matrix(), new flash.geom.ColorTransform(), "normal");
        $target.attachBitmap(_loc2, $target.getNextHighestDepth());
        _loc1.removeMovieClip();
    } // End of the function
    static function getGameDirectory($url)
    {
        var _loc4;
        var _loc2;
        var _loc3;
        var _loc1;
        if ($url == undefined)
        {
            if (com.clubpenguin.lib.locale.LocaleText.localeDirectoryURL == undefined)
            {
                com.clubpenguin.lib.locale.LocaleText.debugTrace("using cached locale directory url that hasn\'t been set yet!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            } // end if
        }
        else
        {
            _loc2 = $url.split("/");
            _loc3 = "";
            for (var _loc1 = 0; _loc1 < _loc2.length - 1; ++_loc1)
            {
                _loc3 = _loc3 + (_loc2[_loc1] + "/");
            } // end of for
            localeDirectoryURL = _loc3;
        } // end else if
        _loc4 = com.clubpenguin.lib.locale.LocaleText.localeDirectoryURL;
        return (_loc4);
    } // End of the function
    static function debugTrace($message, $priority)
    {
        if ($priority == undefined)
        {
            $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG_LOCALE)
        {
            com.clubpenguin.util.Reporting.debugTrace("(LocaleText) " + $message, $priority);
        } // end if
    } // End of the function
    static var $_instanceCount = 0;
    static var EVENT_LOAD_COMPLETED = "onLoadComplete";
    static var LANG_ID_LOADERROR = 0;
    static var LANG_ID_EN = 1;
    static var LANG_ID_PT = 2;
    static var LANG_ID_FR = 3;
    static var LANG_ID_ES = 4;
    static var LANG_ID_DEFAULT = com.clubpenguin.lib.locale.LocaleText.LANG_ID_EN;
    static var LANG_LOC_FILENAME = "locale";
    static var LANG_LOC_FILETYPE = ".swf";
    static var LANG_LOC_DIRECTORY = "lang";
    static var LANG_LOC_EN = "en";
    static var LANG_LOC_PT = "pt";
    static var LANG_LOC_FR = "fr";
    static var LANG_LOC_ES = "es";
    static var localeVersion = undefined;
    static var localeID = 0;
    static var ready = false;
} // End of Class
