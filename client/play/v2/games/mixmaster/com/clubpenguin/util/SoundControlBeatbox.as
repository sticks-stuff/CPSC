class com.clubpenguin.util.SoundControlBeatbox extends com.clubpenguin.util.SoundControl
{
    var overallVolume, beatboxReady, sounds, soundLoadDelay, handleDelayedLoad, setSoundVolume, stopSound;
    function SoundControlBeatbox(movieClip, volumeLevel)
    {
        super(movieClip, overallVolume);
        beatboxReady = new Array();
    } // End of the function
    function playSound(linkageName, soundInstance, soundVolume, offset, loops, allowMultiple, startNow, isSequence, sequenceArray, sequenceIndex, sequenceName, isBeatbox)
    {
        super.playSound(linkageName, soundInstance, soundVolume, offset, loops, allowMultiple, startNow, isSequence, sequenceArray, sequenceIndex, sequenceName);
        if (isBeatbox == undefined)
        {
            isBeatbox = false;
        } // end if
        if (isBeatbox && !isSequence)
        {
            sounds[soundInstance].soundVolume = 0;
            sounds[soundInstance].beatboxVolume = soundVolume;
            sounds[soundInstance].beatboxName = sequenceName;
            if (sequenceIndex == 0)
            {
                sounds[soundInstance].currentLoopIndex = -1;
                sounds[soundInstance].beatboxArray = sequenceArray;
                sounds[soundInstance].lastPosition = 0;
            } // end if
        } // end if
    } // End of the function
    function performDelayedLoad($soundInstance)
    {
        this.debugTrace("play queued beatbox tracks! time: " + getTimer());
        ++sounds[$soundInstance].currentLoopIndex;
        if (sounds[$soundInstance].currentLoopIndex >= sounds[$soundInstance].beatboxArray.length / CONCURRENT_SOUND_START)
        {
            clearInterval(soundLoadDelay);
        }
        else
        {
            this.handleDelayedLoad(sounds[$soundInstance].currentLoopIndex);
            var _loc8 = sounds[$soundInstance].currentLoopIndex * CONCURRENT_SOUND_START;
            for (var _loc7 = 0; _loc7 < CONCURRENT_SOUND_START; ++_loc7)
            {
                beatboxReady[sounds[$soundInstance].beatboxName][_loc8 + _loc7] = true;
                this.debugTrace("sound \'" + sounds[$soundInstance].beatboxName + "_" + (_loc8 + _loc7) + "\' is ready");
            } // end of for
        } // end else if
    } // End of the function
    function loadBeatbox(beatboxArray, beatboxName, beatboxVolume, allowMultiple)
    {
        this.debugTrace("load beatbox \'" + beatboxName + "\' using array:\n" + beatboxArray);
        if (beatboxVolume == undefined)
        {
            beatboxVolume = 100;
        } // end if
        beatboxReady[beatboxName] = new Array();
        for (var _loc8 = 0; _loc8 < beatboxArray.length; ++_loc8)
        {
            this.playSound(beatboxArray[_loc8], beatboxName + "_" + _loc8, beatboxVolume, 0, 100000, allowMultiple, false, false, beatboxArray, _loc8, beatboxName, true);
            this.setSoundVolume(beatboxName + "_" + _loc8, 0);
            beatboxReady[beatboxName][_loc8] = false;
        } // end of for
        for (var _loc8 = 0; _loc8 < beatboxArray.length; ++_loc8)
        {
            sounds[beatboxName + "_" + _loc8].start(0, 10000);
        } // end of for
        clearInterval(soundLoadDelay);
        soundLoadDelay = setInterval(this, "performDelayedLoad", 100, beatboxName + "_0");
    } // End of the function
    function stopBeatbox(beatboxName)
    {
        this.debugTrace("stop beatbox sequence " + beatboxName);
        var _loc9 = beatboxName + "_" + 0;
        var _loc8 = sounds[_loc9].beatboxArray;
        for (var _loc7 = 0; _loc7 < _loc8.length; ++_loc7)
        {
            _loc9 = beatboxName + "_" + _loc7;
            this.stopSound(_loc9);
        } // end of for
    } // End of the function
    function setBeatboxVolume(instance, newVolume)
    {
        this.debugTrace("set beatbox \'" + instance + "\' volume to " + newVolume);
        var _loc9 = sounds[instance + "_0"].beatboxArray;
        var _loc8 = overallVolume / 100;
        for (var _loc7 = 0; _loc7 < _loc9.length; ++_loc7)
        {
            if (sounds[instance + "_" + _loc7].soundVolume != 0)
            {
                sounds[instance + "_" + _loc7].setVolume(newVolume * _loc8);
                sounds[instance + "_" + _loc7].soundVolume = newVolume;
            } // end if
            sounds[instance + "_" + _loc7].volume = newVolume;
            sounds[instance + "_" + _loc7].beatboxVolume = newVolume;
        } // end of for
    } // End of the function
    function muteBeatboxSound(beatboxName, soundID)
    {
        this.setSoundVolume(beatboxName + "_" + soundID, 0);
    } // End of the function
    function unmuteBeatboxSound(beatboxName, soundID)
    {
        if (beatboxReady[beatboxName][soundID] == true)
        {
            var _loc7 = beatboxName + "_" + soundID;
            this.setSoundVolume(_loc7, sounds[_loc7].beatboxVolume);
        } // end if
        return (beatboxReady[beatboxName][soundID]);
    } // End of the function
    function isBeatboxMuted(beatboxName, soundID)
    {
        return (sounds[beatboxName + "_" + soundID].soundVolume == 0);
    } // End of the function
    function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG_SOUNDS)
        {
            com.clubpenguin.util.Reporting.debugTrace("(SoundControlBeatbox) " + message, priority);
        } // end if
    } // End of the function
    var CONCURRENT_SOUND_START = 5;
} // End of Class
