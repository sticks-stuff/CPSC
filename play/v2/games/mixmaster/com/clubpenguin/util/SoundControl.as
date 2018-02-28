class com.clubpenguin.util.SoundControl
{
    var sounds, soundData, overallVolume, soundInstance, parentClip, sequenceLinkage;
    static var eventSource;
    function SoundControl(movieClip, volumeLevel)
    {
        com.clubpenguin.util.SoundControl.debugTrace("new SoundControl object in movieclip " + movieClip);
        sounds = new Object();
        soundData = movieClip.createEmptyMovieClip("soundData", movieClip.getNextHighestDepth());
        overallVolume = volumeLevel == undefined ? (100) : (volumeLevel);
        com.clubpenguin.util.SoundControl.debugTrace("soundData added to depth: " + soundData.getDepth() + " - overall volume is " + overallVolume);
    } // End of the function
    function handleSequenceEnd($sequenceName)
    {
        com.clubpenguin.util.SoundControl.debugTrace("sequence " + $sequenceName + " has ended - callback function called!");
        var _loc7 = new Object();
        _loc7.target = null;
        _loc7.type = com.clubpenguin.util.SoundControl.EVENT_SEQUENCE_ENDS;
        _loc7.sequenceName = $sequenceName;
        com.clubpenguin.util.SoundControl.eventSource.dispatchEvent(_loc7);
    } // End of the function
    function handleDelayedLoad($sequenceNumber)
    {
        com.clubpenguin.util.SoundControl.debugTrace("loading phase " + $sequenceNumber + " has ended - callback function called!");
        var _loc7 = new Object();
        _loc7.target = null;
        _loc7.type = com.clubpenguin.util.SoundControl.EVENT_DELAYED_LOAD;
        _loc7.sequenceNumber = $sequenceNumber;
        com.clubpenguin.util.SoundControl.eventSource.dispatchEvent(_loc7);
    } // End of the function
    function handlePlayStarted($linkageName)
    {
        com.clubpenguin.util.SoundControl.debugTrace("play sound " + $linkageName + " has attempted to start - callback function called!");
        var _loc7 = new Object();
        _loc7.target = null;
        _loc7.type = com.clubpenguin.util.SoundControl.EVENT_PLAY_SOUND_STARTED;
        _loc7.soundName = $linkageName;
        com.clubpenguin.util.SoundControl.eventSource.dispatchEvent(_loc7);
    } // End of the function
    static function addEventListener($event, $listener)
    {
        com.clubpenguin.util.SoundControl.debugTrace("addEventListener for event " + $event);
        if (com.clubpenguin.util.SoundControl.eventSource == undefined)
        {
            com.clubpenguin.util.SoundControl.debugTrace("addEventListener called on an undefined eventSource - initialise the source!");
            eventSource = new Object();
            mx.events.EventDispatcher.initialize(com.clubpenguin.util.SoundControl.eventSource);
        } // end if
        com.clubpenguin.util.SoundControl.eventSource.addEventListener($event, $listener);
    } // End of the function
    static function removeEventListener($event, $listener)
    {
        com.clubpenguin.util.SoundControl.debugTrace("removeEventListener for event " + $event);
        com.clubpenguin.util.SoundControl.eventSource.removeEventListener($event, $listener);
    } // End of the function
    function playSound(linkageName, soundInstance, soundVolume, offset, loops, allowMultiple, startNow, isSequence, sequenceArray, sequenceIndex, sequenceName)
    {
        this.handlePlayStarted(linkageName);
        if (startNow == undefined)
        {
            startNow = true;
        } // end if
        if (soundVolume == undefined)
        {
            soundVolume = 100;
        } // end if
        if (offset == undefined)
        {
            offset = 0;
        } // end if
        if (loops == undefined)
        {
            loops = 1;
        } // end if
        com.clubpenguin.util.SoundControl.debugTrace("play " + this.soundInstance + " from library: " + linkageName + " (vol: " + soundVolume + " offset:" + offset + ", loop:" + loops + ")");
        if ((allowMultiple == undefined || !allowMultiple) && soundData[this.soundInstance] != undefined)
        {
            com.clubpenguin.util.SoundControl.debugTrace("a sound with this instance name already exists!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return;
        } // end if
        soundData.createEmptyMovieClip(this.soundInstance, soundData.getNextHighestDepth());
        sounds[this.soundInstance] = new Sound(soundData[this.soundInstance]);
        sounds[this.soundInstance].attachSound(linkageName);
        if (startNow)
        {
            sounds[this.soundInstance].start(offset, loops);
        } // end if
        soundData[this.soundInstance].soundInstance = this.soundInstance;
        soundData[this.soundInstance].parentClip = this;
        sounds[this.soundInstance].soundInstance = this.soundInstance;
        sounds[this.soundInstance].parentClip = this;
        if (!isSequence)
        {
            sounds[this.soundInstance].setVolume(soundVolume * (overallVolume / 100));
            sounds[this.soundInstance].soundVolume = soundVolume;
            sounds[this.soundInstance].onSoundComplete = function ()
            {
                parentClip.debugTrace("sound " + this.soundInstance + " has finished");
                parentClip.stopSound(this.soundInstance);
            };
        }
        else
        {
            sounds[this.soundInstance].sequenceVolume = soundVolume;
            sounds[this.soundInstance].sequenceName = sequenceName;
            if (sequenceIndex == 0)
            {
                sounds[this.soundInstance].currentLoopIndex = 0;
                sounds[this.soundInstance].sequenceArray = sequenceArray;
                sounds[this.soundInstance].lastPosition = 0;
                soundData[this.soundInstance].onEnterFrame = function ()
                {
                    var _loc3 = parentClip.sounds[this.soundInstance];
                    if (_loc3.position < _loc3.lastPosition)
                    {
                        parentClip.debugTrace("current track is " + _loc3.currentLoopIndex + ". loop to next track in sequence");
                        parentClip.setSoundVolume(parentClip.sequenceLinkage[_loc3.currentLoopIndex].name, 0);
                        parentClip.setSoundVolume(parentClip.sequenceLinkage[_loc3.currentLoopIndex + 1].name, _loc3.sequenceVolume);
                        ++_loc3.currentLoopIndex;
                        if (_loc3.currentLoopIndex >= parentClip.sequenceLinkage.length)
                        {
                            parentClip.debugTrace("this was the last track in the sequence!");
                            _loc3.currentLoopIndex = 0;
                            parentClip.handleSequenceEnd(_loc3.sequenceName);
                        } // end if
                        if (_loc3.currentLoopIndex < parentClip.uniqueSoundCount / com.clubpenguin.util.SoundControl.CONCURRENT_SOUND_START)
                        {
                            parentClip.handleDelayedLoad(_loc3.currentLoopIndex);
                            var _loc4 = _loc3.currentLoopIndex * com.clubpenguin.util.SoundControl.CONCURRENT_SOUND_START;
                            var _loc2 = 0;
                            while (_loc2 < com.clubpenguin.util.SoundControl.CONCURRENT_SOUND_START)
                            {
                                parentClip.sounds[_loc3.sequenceName + "_" + (_loc4 + _loc2)].start(0, 1000);
                                parentClip.debugTrace("started sound \'" + _loc3.sequenceName + "_" + (_loc4 + _loc2) + "\'");
                                ++_loc2;
                            } // end while
                        } // end if
                    } // end if
                    _loc3.lastPosition = _loc3.position;
                };
            } // end if
        } // end else if
    } // End of the function
    function stopSound(instanceName)
    {
        com.clubpenguin.util.SoundControl.debugTrace("stop sound \'" + instanceName + "\'");
        sounds[instanceName].stop();
        soundData[instanceName].removeMovieClip();
        delete sounds[instanceName];
    } // End of the function
    function playSequence(sequenceArray, sequenceName, sequenceVolume, allowMultiple)
    {
        com.clubpenguin.util.SoundControl.debugTrace("play sequence \'" + sequenceName + "\' using array:\n" + sequenceArray);
        this.handlePlayStarted(sequenceName);
        if (sequenceVolume == undefined)
        {
            sequenceVolume = 100;
        } // end if
        sequenceLinkage = new Array();
        uniqueSoundCount = 0;
        for (var _loc10 = 0; _loc10 < sequenceArray.length; ++_loc10)
        {
            var _loc9;
            for (var _loc8 in sequenceLinkage)
            {
                if (sequenceArray[_loc10] == sequenceLinkage[_loc8].linkage)
                {
                    _loc9 = sequenceLinkage[_loc8].name;
                    break;
                } // end if
            } // end of for...in
            if (_loc9 == undefined)
            {
                sequenceLinkage[_loc10] = new Object();
                sequenceLinkage[_loc10].linkage = sequenceArray[_loc10];
                sequenceLinkage[_loc10].name = sequenceName + "_" + uniqueSoundCount;
                ++uniqueSoundCount;
                this.playSound(sequenceLinkage[_loc10].linkage, sequenceLinkage[_loc10].name, sequenceVolume, 0, 1000, allowMultiple, false, true, sequenceArray, _loc10, sequenceName);
                nextFrame ();
                this.setSoundVolume((_loc10 == 0 ? (0) : (null)).sequenceLinkage[_loc10].name, null);
                continue;
            } // end if
            sequenceLinkage[_loc10] = new Object();
            sequenceLinkage[_loc10].linkage = sequenceArray[_loc10];
            sequenceLinkage[_loc10].name = _loc9;
        } // end of for
        for (var _loc10 = 0; _loc10 < com.clubpenguin.util.SoundControl.CONCURRENT_SOUND_START; ++_loc10)
        {
            sounds[sequenceName + "_" + _loc10].start(0, 1000);
            com.clubpenguin.util.SoundControl.debugTrace("started sound \'" + sequenceName + "_" + _loc10 + "\'");
        } // end of for
    } // End of the function
    function stopSequence(sequenceName)
    {
        com.clubpenguin.util.SoundControl.debugTrace("stop sequence " + sequenceName);
        var _loc9 = sequenceName + "_" + 0;
        var _loc8 = sounds[_loc9].sequenceArray;
        for (var _loc7 = 0; _loc7 < _loc8.length; ++_loc7)
        {
            _loc9 = sequenceName + "_" + _loc7;
            this.stopSound(_loc9);
        } // end of for
    } // End of the function
    function setOverallVolume(newVolume)
    {
        com.clubpenguin.util.SoundControl.debugTrace("set overall volume to " + newVolume);
        var _loc8 = newVolume / 100;
        overallVolume = newVolume;
        for (var _loc7 in sounds)
        {
            sounds[_loc7].setVolume(sounds[_loc7].soundVolume * _loc8);
        } // end of for...in
    } // End of the function
    function setSoundVolume(soundInstance, newVolume)
    {
        com.clubpenguin.util.SoundControl.debugTrace("set sound \'" + soundInstance + "\' volume to " + newVolume + " (adjusted: " + newVolume * overallVolume / 100 + ")");
        sounds[soundInstance].setVolume(newVolume * overallVolume / 100);
        sounds[soundInstance].volume = newVolume;
        sounds[soundInstance].soundVolume = newVolume;
    } // End of the function
    function setSequenceVolume(instance, newVolume)
    {
        com.clubpenguin.util.SoundControl.debugTrace("set sequence \'" + instance + "\' volume to " + newVolume);
        var _loc9 = sounds[instance + "_0"].sequenceArray;
        var _loc8 = overallVolume / 100;
        for (var _loc7 = 0; _loc7 < _loc9.length; ++_loc7)
        {
            if (sounds[instance + "_" + _loc7].soundVolume != 0)
            {
                sounds[instance + "_" + _loc7].setVolume(newVolume * _loc8);
                sounds[instance + "_" + _loc7].soundVolume = newVolume;
            } // end if
            sounds[instance + "_" + _loc7].volume = newVolume;
        } // end of for
    } // End of the function
    function getDuration(soundInstance)
    {
        if (sounds[soundInstance] == undefined)
        {
            com.clubpenguin.util.SoundControl.debugTrace("sound " + soundInstance + " does not exist getting duration", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        } // end if
        return (sounds[soundInstance].duration);
    } // End of the function
    function getPosition(soundInstance)
    {
        if (sounds[soundInstance] == undefined)
        {
            com.clubpenguin.util.SoundControl.debugTrace("sound " + soundInstance + " does not exist getting position", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        } // end if
        return (sounds[soundInstance].position);
    } // End of the function
    function getOverallVolume()
    {
        return (overallVolume);
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG_SOUNDS)
        {
            com.clubpenguin.util.Reporting.debugTrace("(SoundControl) " + message, priority);
        } // end if
    } // End of the function
    static var CONCURRENT_SOUND_START = 5;
    static var EVENT_SEQUENCE_ENDS = "onSequenceEnd";
    static var EVENT_DELAYED_LOAD = "onDelayedLoad";
    static var EVENT_PLAY_SOUND_STARTED = "onPlaySoundStarted";
    var uniqueSoundCount = 0;
} // End of Class
