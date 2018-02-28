class com.clubpenguin.games.beatbox.GameEngine extends com.clubpenguin.games.generic.GenericGameEngine
{
    var movie, startTimeMillis, beatboxListener, input;
    static var instance, BAR_LENGTH, beatbox;
    function GameEngine(movieClip)
    {
        super(movieClip);
        instance = this;
        if (_global.dlearning_learner_id == undefined)
        {
            var _loc7 = _global.getCurrentShell();
            _global.dlearning_learner_id = _loc7.getMyPlayerId();
        } // end if
        _global.dlsMixMaster = new com.disney.dlearning.games.mixmaster.DlsMixMaster(_global.dlearning_learner_id.toString());
    } // End of the function
    function init()
    {
        com.clubpenguin.games.beatbox.GameEngine.debugTrace("init function started");
        var _loc7 = ["drumLoopBongos", "drumLoopBongos", "drumLoopBongos", "drumLoopBongos", "drumLoopBongos", "drumLoopBongos", "drumLoopHihatMinimal", "drumLoopBongos", "drumLoopHiHats", "drumLoopFlatBeats", "drumLoopFunkyHouse", "drumLoopDeepHouse", "melodyTrumpet", "melodyGuitarWahwah", "melodyGuitar", "melodyRhodesLowpitch", "melodyRhodesHighpitch", "bassLineLive", "bassLineFilter", "bassLineSynth"];
        BAR_LENGTH = 889;
        beatbox = new com.clubpenguin.util.SoundControlBeatbox(movie);
        com.clubpenguin.games.beatbox.GameEngine.beatbox.loadBeatbox(_loc7, "beatbox_sequence");
        startTimeMillis = getTimer();
        beatboxListener = new Object();
        beatboxListener.onDelayedLoad = com.clubpenguin.util.Delegate.create(this, handleDelayedLoad);
        com.clubpenguin.util.SoundControl.addEventListener(com.clubpenguin.util.SoundControl.EVENT_DELAYED_LOAD, beatboxListener);
        this.refreshAllButtons(com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
        this.refreshAllButtons(com.clubpenguin.games.beatbox.GameEngine.BASSLINE_LOOPS);
        this.refreshAnimatedElements();
        if (com.clubpenguin.games.beatbox.GameEngine.HID_ENABLED)
        {
            input = new com.clubpenguin.games.beatbox.UserInputBeatbox(movie);
        } // end if
        _global.dlsMixMaster.init();
    } // End of the function
    function setBarLength(barLength)
    {
        BAR_LENGTH = barLength;
    } // End of the function
    function destroy()
    {
        com.clubpenguin.games.beatbox.GameEngine.debugTrace("destroy function started");
        this.stopSounds();
        com.clubpenguin.games.beatbox.GameEngine.beatbox.stopBeatbox("beatbox_sequence");
        com.clubpenguin.util.SoundControl.removeEventListener(com.clubpenguin.util.SoundControl.EVENT_DELAYED_LOAD, beatboxListener);
        _global.dlsMixMaster.stopDJ3K();
    } // End of the function
    function update()
    {
        com.clubpenguin.games.beatbox.GameEngine.debugTrace("update function started", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
        var _loc12 = getTimer() - startTimeMillis;
        var _loc11 = _loc12 % com.clubpenguin.games.beatbox.GameEngine.BAR_LENGTH / com.clubpenguin.games.beatbox.GameEngine.BAR_LENGTH;
        var _loc10 = Math.round(movie.penguin.animation._totalframes * _loc11);
        movie.penguin.animation.gotoAndStop(_loc10);
        movie.speakers.animation.gotoAndStop(_loc10);
        movie.rackmountedDrumLoops.equaliser.animation.gotoAndStop(_loc10);
        movie.mixer.equaliser.animation.gotoAndStop(_loc10);
        for (var _loc9 = 1; _loc9 < 14; ++_loc9)
        {
            if (movie["noteKey" + _loc9]._currentframe <= 2)
            {
                movie["noteKey" + _loc9].gotoAndStop("off");
            } // end if
            var _loc8 = movie["note" + _loc9];
            if (_loc8._xmouse > 0)
            {
                if (_loc8._xmouse < _loc8._width)
                {
                    if (_loc8._ymouse > 0)
                    {
                        if (_loc8._ymouse < _loc8._height)
                        {
                            com.clubpenguin.games.beatbox.GameEngine.debugTrace("within bounds: " + _loc8, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                            var _loc7;
                            switch (_loc9)
                            {
                                case 1:
                                {
                                    _loc7 = "keyCLow";
                                    break;
                                } 
                                case 2:
                                {
                                    _loc7 = "keyCSharp";
                                    break;
                                } 
                                case 3:
                                {
                                    _loc7 = "keyD";
                                    break;
                                } 
                                case 4:
                                {
                                    _loc7 = "keyDSharp";
                                    break;
                                } 
                                case 5:
                                {
                                    _loc7 = "keyE";
                                    break;
                                } 
                                case 6:
                                {
                                    _loc7 = "keyF";
                                    break;
                                } 
                                case 7:
                                {
                                    _loc7 = "keyFSharp";
                                    break;
                                } 
                                case 8:
                                {
                                    _loc7 = "keyG";
                                    break;
                                } 
                                case 9:
                                {
                                    _loc7 = "keyGSharp";
                                    break;
                                } 
                                case 10:
                                {
                                    _loc7 = "keyA";
                                    break;
                                } 
                                case 11:
                                {
                                    _loc7 = "keyASharp";
                                    break;
                                } 
                                case 12:
                                {
                                    _loc7 = "keyB";
                                    break;
                                } 
                                case 13:
                                {
                                    _loc7 = "keyCHigh";
                                    break;
                                } 
                                default:
                                {
                                    break;
                                } 
                            } // End of switch
                            if (_loc7 != undefined)
                            {
                                movie["noteKey" + _loc9].gotoAndStop("on");
                                if (isMouseDown)
                                {
                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound(_loc7, "noteKey" + _loc9, 100, 0, 1, false);
                                } // end if
                            } // end if
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end of for
    } // End of the function
    function registerButton($buttonInstance, $soundID, $loopType)
    {
        var _loc7 = new Object();
        _loc7.movie = $buttonInstance;
        _loc7.sound = $soundID;
        loops[$loopType].push(_loc7);
    } // End of the function
    function refreshAllButtons($loopType)
    {
        for (var _loc7 in loops[$loopType])
        {
            this.buttonRollOut(loops[$loopType][_loc7].movie, loops[$loopType][_loc7].sound);
        } // end of for...in
    } // End of the function
    function refreshAnimatedElements()
    {
        var _loc8 = 0;
        for (var _loc7 = 5; _loc7 < 20; ++_loc7)
        {
            if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", _loc7))
            {
                com.clubpenguin.games.beatbox.GameEngine.debugTrace(_loc7 + " is unmuted");
                ++_loc8;
                if (_loc7 == 8 || _loc7 == 9 || _loc7 == 10)
                {
                    ++_loc8;
                } // end if
                if (_loc7 == 11)
                {
                    _loc8 = _loc8 + 3;
                } // end if
            } // end if
        } // end of for
        if (_loc8 <= 4)
        {
            if (_loc8 <= 2)
            {
                if (_loc8 <= 0)
                {
                    movie.penguin.gotoAndStop("off");
                }
                else
                {
                    movie.penguin.gotoAndStop("low");
                } // end else if
            }
            else
            {
                movie.penguin.gotoAndStop("on");
            } // end else if
        }
        else
        {
            movie.penguin.gotoAndStop("high");
        } // end else if
        if (_loc8 <= 0)
        {
            movie.rackmountedDrumLoops.equaliser.gotoAndStop("off");
            movie.mixer.equaliser.gotoAndStop("off");
            movie.speakers.gotoAndStop("off");
            movie.leftTurntable.gotoAndStop("off");
            movie.rightTurntable.gotoAndStop("off");
        }
        else
        {
            movie.rackmountedDrumLoops.equaliser.gotoAndStop("on");
            movie.mixer.equaliser.gotoAndStop("on");
            movie.speakers.gotoAndStop("on");
            movie.leftTurntable.gotoAndStop("on");
            movie.rightTurntable.gotoAndStop("on");
        } // end else if
    } // End of the function
    function handleDelayedLoad($event)
    {
        var _loc7 = $event.sequenceNumber;
        com.clubpenguin.games.beatbox.GameEngine.debugTrace("handle event for sequence number " + _loc7);
        switch (_loc7)
        {
            case 1:
            {
                movie.rackmountedDrumLoops.gotoAndStop("on");
                break;
            } 
            case 2:
            {
                movie.rackmountedBassLines.gotoAndStop("on");
                break;
            } 
            case 3:
            {
                movie.rackmountedMelodyLoops.gotoAndStop("on");
                break;
            } 
        } // End of switch
    } // End of the function
    function stopSounds()
    {
        for (var _loc7 = 6; _loc7 < 20; ++_loc7)
        {
            com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", _loc7);
        } // end of for
        this.refreshAllButtons(com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
        this.refreshAllButtons(com.clubpenguin.games.beatbox.GameEngine.BASSLINE_LOOPS);
        movie.rackmountedMelodyLoops.slider1.gotoAndStop("off");
        movie.rackmountedMelodyLoops.slider2.gotoAndStop("off");
        movie.rackmountedMelodyLoops.slider3.gotoAndStop("off");
        movie.rackmountedMelodyLoops.slider4.gotoAndStop("off");
        movie.rackmountedMelodyLoops.slider5.gotoAndStop("off");
        this.refreshAnimatedElements();
    } // End of the function
    function buttonRollOver($buttonInstance, $soundID)
    {
        $buttonInstance.gotoAndStop("over");
    } // End of the function
    function buttonRollOut($buttonInstance, $soundID)
    {
        if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", $soundID))
        {
            $buttonInstance.gotoAndStop("on");
        }
        else
        {
            $buttonInstance.gotoAndStop("off");
        } // end else if
    } // End of the function
    function buttonRelease($buttonInstance, $soundID, $loopType)
    {
        _global.dlsMixMaster.playedSong("rackButton" + $soundID);
        if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", $soundID))
        {
            com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", $soundID);
        }
        else
        {
            for (var _loc8 in loops[$loopType])
            {
                com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", loops[$loopType][_loc8].sound);
            } // end of for...in
            var _loc7 = com.clubpenguin.games.beatbox.GameEngine.beatbox.unmuteBeatboxSound("beatbox_sequence", $soundID);
            if (!_loc7)
            {
                com.clubpenguin.games.beatbox.GameEngine.debugTrace("sound " + $soundID + " not ready to be unmuted");
            } // end if
        } // end else if
        this.buttonRollOut($buttonInstance, $soundID);
        this.refreshAllButtons($loopType);
    } // End of the function
    static function debugTrace($message, $priority)
    {
        if ($priority == undefined)
        {
            $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace("(GameEngine) " + $message, $priority);
        } // end if
    } // End of the function
    static var HID_ENABLED = true;
    static var DRUM_LOOPS = 0;
    static var BASSLINE_LOOPS = 1;
    var isMouseDown = false;
    var loops = [[], []];
} // End of Class
