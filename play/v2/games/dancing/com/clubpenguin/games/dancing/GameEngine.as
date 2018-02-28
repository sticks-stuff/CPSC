class com.clubpenguin.games.dancing.GameEngine extends com.clubpenguin.games.generic.GenericGameEngine
{
    var gameFilename, isMember, musicPlayer, keyListener, timeOnScreenMillis, movie, animationEngine, noteManager, netClient, menuSystem, isPlayingGame, isDancing, statsNoteBreakdown, soundData, cheerSound, startTimeMillis, currentTimeMillis, elapsedTimeMillis, keyPresses, multiplayerScores;
    static var instance, SHELL;
    function GameEngine($movieClip, $gameFilename)
    {
        super($movieClip);
        if (com.clubpenguin.games.dancing.GameEngine.instance != undefined)
        {
            com.clubpenguin.games.dancing.GameEngine.debugTrace("there is already an active instance of GameEngine. overwriting it!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        } // end if
        SHELL = _global.getCurrentShell();
        instance = this;
        gameFilename = $gameFilename;
        qualityFrameTicks = 0;
        qualityFrameTicksLast = 0;
        setInterval(this, "updateQualityMode", 1000);
    } // End of the function
    function init()
    {
        com.clubpenguin.games.dancing.GameEngine.debugTrace("init function started");
        _global.dls_dance.startDancingContest();
        loadedSongs = 3;
        if (com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK && this.isMember())
        {
            loadedSongs = 0;
        } // end if
        musicPlayer = new Array();
        var _loc5 = gameFilename.split("/");
        var _loc4 = "";
        for (var _loc3 = 0; _loc3 < _loc5.length - 1; ++_loc3)
        {
            _loc4 = _loc4 + (_loc5[_loc3] + "/");
        } // end of for
        com.clubpenguin.games.dancing.GameEngine.debugTrace("game root directory is \'" + _loc4 + "\'");
        this.loadSong(_loc4 + com.clubpenguin.games.dancing.GameEngine.SONG_ONE_DATA, com.clubpenguin.games.dancing.GameEngine.SONG_ONE);
        this.loadSong(_loc4 + com.clubpenguin.games.dancing.GameEngine.SONG_TWO_DATA, com.clubpenguin.games.dancing.GameEngine.SONG_TWO);
        this.loadSong(_loc4 + com.clubpenguin.games.dancing.GameEngine.SONG_THREE_DATA, com.clubpenguin.games.dancing.GameEngine.SONG_THREE);
        if (com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK && this.isMember())
        {
            this.loadSong(_loc4 + com.clubpenguin.games.dancing.GameEngine.SONG_FOUR_DATA, com.clubpenguin.games.dancing.GameEngine.SONG_FOUR);
            this.loadSong(_loc4 + com.clubpenguin.games.dancing.GameEngine.SONG_FIVE_DATA, com.clubpenguin.games.dancing.GameEngine.SONG_FIVE);
            this.loadSong(_loc4 + com.clubpenguin.games.dancing.GameEngine.SONG_SIX_DATA, com.clubpenguin.games.dancing.GameEngine.SONG_SIX);
        } // end if
        this.initApplause();
        keyListener = new Object();
        keyListener.onKeyDown = com.clubpenguin.util.Delegate.create(this, handleKeyDown);
        keyListener.onKeyUp = com.clubpenguin.util.Delegate.create(this, handleKeyUp);
        Key.addListener(keyListener);
        timeOnScreenMillis = new Array();
        timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY] = 4000;
        timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM] = 2500;
        timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD] = 1750;
        timeOnScreenMillis[com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT] = 1500;
        animationEngine = new com.clubpenguin.games.dancing.AnimationEngine(this, movie);
        noteManager = new com.clubpenguin.games.dancing.NoteManager(movie[com.clubpenguin.games.dancing.AnimationEngine.ARROWS_MOVIECLIP]);
        netClient = new com.clubpenguin.games.dancing.DanceNetClient(this);
        menuSystem = new com.clubpenguin.games.dancing.MenuSystem(this, movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP]);
        currentDifficulty = com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM;
        isPlayingGame = false;
        isDancing = false;
    } // End of the function
    function destroy()
    {
        _global.dls_dance.stopDancingContest();
        this.leaveMultiplayerServer();
        Key.removeListener(keyListener);
        keyListener = undefined;
        var _loc5 = _global.getCurrentEngine();
        _loc5.sendGameOver(totalScore);
        var _loc4 = statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
        var _loc3 = Math.round(statsNotesHit / _loc4 * 1000) / 10;
        _global.dls_dance.sendLearnerScore(Math.round(_loc3), true);
        _global.dls_dance.sendGameScore(currentScore, Math.round(_loc3), true);
        totalScore = 0;
    } // End of the function
    function loadSong($songLocation, $songID)
    {
        var _loc2 = new Object();
        var _loc3 = new MovieClipLoader();
        musicPlayer[$songID] = movie.createEmptyMovieClip("songData" + $songID, movie.getNextHighestDepth());
        _loc2.onLoadInit = com.clubpenguin.util.Delegate.create(this, handleSongLoadComplete);
        _loc2.onLoadError = com.clubpenguin.util.Delegate.create(this, handleSongLoadError);
        _loc3.addListener(_loc2);
        _loc3.loadClip($songLocation, musicPlayer[$songID]);
    } // End of the function
    function handleSongLoadComplete()
    {
        if (loadedSongs < 0)
        {
            return;
        } // end if
        ++loadedSongs;
        if (this.allSongsLoaded() == com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK)
        {
            if (this.getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO)
            {
                menuSystem.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
            } // end if
        } // end if
    } // End of the function
    function handleSongLoadError()
    {
        loadedSongs = -1;
        if (this.getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO)
        {
            menuSystem.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
        } // end if
    } // End of the function
    function handleSoundComplete()
    {
        if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
        {
            this.endSong();
        } // end if
    } // End of the function
    function allSongsLoaded()
    {
        if (loadedSongs < 0)
        {
            return (com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR);
        } // end if
        if (loadedSongs >= com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS)
        {
            return (com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK);
        } // end if
        return (com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS);
    } // End of the function
    function initApplause()
    {
        soundData = movie.createEmptyMovieClip("soundData", 100);
        cheerSound = new Sound(soundData);
        cheerSound.attachSound("applause");
        cheerSound.setVolume(33);
    } // End of the function
    function playApplause()
    {
        cheerSound.start();
    } // End of the function
    function setDifficulty($difficulty)
    {
        currentDifficulty = $difficulty;
        if (netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
        {
            this.setMultiplayerDifficulty();
        } // end if
    } // End of the function
    function setSong($song)
    {
        currentSong = $song;
        _global.dls_dance.setSong($song);
    } // End of the function
    function startTimer()
    {
        startTimeMillis = getTimer();
        currentTimeMillis = startTimeMillis;
        elapsedTimeMillis = 0;
    } // End of the function
    function startSong()
    {
        _global.dls_dance.startSong();
        if (netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED && netClient.currentState != com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
        {
            com.clubpenguin.games.dancing.GameEngine.debugTrace("startSong called when in an unknown net state: " + netClient.currentState);
            return;
        } // end if
        if (isPlayingGame)
        {
            com.clubpenguin.games.dancing.GameEngine.debugTrace("startSong called when song already started!");
            return;
        } // end if
        noteManager.destroy();
        var _loc5;
        if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
        {
            var _loc3 = com.clubpenguin.games.dancing.data.SongData.getSongData(currentSong, currentDifficulty);
            noteManager.init(_loc3[0], _loc3[1], _loc3[2], timeOnScreenMillis[currentDifficulty]);
            _loc5 = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(currentSong) / com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES;
        }
        else
        {
            noteManager.init(netClient.songData[0], netClient.songData[1], netClient.songData[2], timeOnScreenMillis[currentDifficulty]);
            _loc5 = netClient.millisPerBar / com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES;
        } // end else if
        keyPresses = new Array();
        if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
        {
            netClient.keyPressIDs = new Array();
        } // end if
        animationEngine.startSong(_loc5);
        this.startTimer();
        var _loc6 = netClient.millisPerBar;
        if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
        {
            _loc6 = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(currentSong);
        } // end if
        var _loc4 = _loc6 / 4;
        if (currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_SIX)
        {
            startTimeMillis = startTimeMillis + _loc4 / 24;
        }
        else if (currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_FOUR)
        {
            startTimeMillis = startTimeMillis + _loc4 / 16;
        }
        else if (currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_FIVE)
        {
            startTimeMillis = startTimeMillis + _loc4 / 16;
        } // end else if
        currentRating = com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 2;
        consecutiveNotes = 0;
        currentMultiplier = 1;
        currentScore = 0;
        statsLongestChain = 0;
        statsNotesHit = 0;
        statsNoteBreakdown = [0, 0, 0, 0, 0, 0];
        statsTotalNotes = _loc3[0].length;
        if (com.clubpenguin.games.dancing.GameEngine.SHELL == undefined)
        {
            SHELL = _global.getCurrentShell();
        } // end if
        com.clubpenguin.games.dancing.GameEngine.SHELL.stopMusic();
        musicPlayer[currentSong].playSound();
        this.handleScoreUpdate(Number.MAX_VALUE);
        isPlayingGame = true;
        isDancing = true;
    } // End of the function
    function endSong()
    {
        com.clubpenguin.games.dancing.GameEngine.debugTrace("song ends");
        totalScore = totalScore + this.getCoinsWon(currentScore);
        if (com.clubpenguin.games.dancing.GameEngine.SHELL == undefined)
        {
            SHELL = _global.getCurrentShell();
        } // end if
        com.clubpenguin.games.dancing.GameEngine.SHELL.startMusicById(com.clubpenguin.games.dancing.GameEngine.MUSIC_ID_NIGHTCLUB);
        this.playApplause();
        animationEngine.endSong();
        noteManager.hide();
        musicPlayer.stopSequence("music");
        var _loc3;
        if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
        {
            _loc3 = com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_INTRO;
        }
        else
        {
            _loc3 = com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_INTRO;
        } // end else if
        menuSystem.loadMenu(_loc3);
        isPlayingGame = false;
    } // End of the function
    function update()
    {
        com.clubpenguin.games.dancing.GameEngine.debugTrace("update function started", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
        currentTimeMillis = getTimer();
        elapsedTimeMillis = currentTimeMillis - startTimeMillis;
        com.clubpenguin.games.dancing.GameEngine.debugTrace("elapsed time = " + elapsedTimeMillis, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
        ++qualityFrameTicks;
        if (isDancing)
        {
            if (isPlayingGame)
            {
                var _loc3 = noteManager.update(elapsedTimeMillis);
                if (_loc3.length > 0)
                {
                    com.clubpenguin.games.dancing.GameEngine.debugTrace(_loc3.length + " notes missed", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                    for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
                    {
                        this.handleScoreUpdate(com.clubpenguin.games.dancing.Note.RESULT_MISS);
                    } // end of for
                } // end if
            } // end if
            var _loc4 = Math.floor(currentRating / (com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 3));
            animationEngine.updateDancer(_loc4);
            animationEngine.updateBackground();
            if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
            {
                netClient.updateKeyPresses(keyPresses);
            } // end if
        }
        else
        {
            this.updateMenus();
        } // end else if
        animationEngine.updateDancefloor();
        animationEngine.updateHUD();
    } // End of the function
    function updateMenus()
    {
        if (menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME || menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_PRE_QUEUE)
        {
            startTimeMillis = currentTimeMillis;
            netClient.timeToNextSong = netClient.timeToNextSong - elapsedTimeMillis;
            this.loadMenu(menuSystem.getCurrentMenu());
        } // end if
        if (menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY || menuSystem.getCurrentMenu() == com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME)
        {
            if (netClient.timeToNextSong <= 0 && menuSystem.getCurrentMenu() != com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG)
            {
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG);
            } // end if
        } // end if
    } // End of the function
    function handleScoreUpdate($noteResult)
    {
        var _loc3 = false;
        var _loc2 = 0;
        switch ($noteResult)
        {
            case com.clubpenguin.games.dancing.Note.RESULT_PERFECT:
            {
                _loc2 = 10;
                currentRating = currentRating + 1;
                ++consecutiveNotes;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_GREAT:
            {
                _loc2 = 5;
                currentRating = currentRating + 1;
                ++consecutiveNotes;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_GOOD:
            {
                _loc2 = 2;
                ++consecutiveNotes;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_ALMOST:
            {
                if (consecutiveNotes > 50)
                {
                    _loc3 = true;
                } // end if
                _loc2 = 1;
                currentRating = currentRating - 2;
                consecutiveNotes = 0;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_MISS:
            {
                if (consecutiveNotes > 50)
                {
                    _loc3 = true;
                } // end if
                _loc2 = 0;
                currentRating = currentRating - 5;
                consecutiveNotes = 0;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_BOO:
            {
                if (consecutiveNotes > 50)
                {
                    _loc3 = true;
                } // end if
                _loc2 = 0;
                currentRating = currentRating - 5;
                consecutiveNotes = 0;
                break;
            } 
            default:
            {
                com.clubpenguin.games.dancing.GameEngine.debugTrace("incorrect note result " + $noteResult + " in handleScoreUpdate", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                return;
            } 
        } // End of switch
        ++statsNoteBreakdown[$noteResult];
        if (consecutiveNotes > statsLongestChain)
        {
            statsLongestChain = consecutiveNotes;
        } // end if
        if (consecutiveNotes > 0)
        {
            ++statsNotesHit;
        } // end if
        if (currentRating >= com.clubpenguin.games.dancing.GameEngine.MAX_RATING)
        {
            currentRating = com.clubpenguin.games.dancing.GameEngine.MAX_RATING - 1;
        } // end if
        if (currentRating < 0)
        {
            currentRating = 0;
        } // end if
        com.clubpenguin.games.dancing.GameEngine.debugTrace("current rating updated to " + currentRating + ", absolute rating is " + Math.floor(currentRating / (com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 3)), com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
        switch (Math.floor(consecutiveNotes / com.clubpenguin.games.dancing.GameEngine.MULTIPLIER_LIMIT))
        {
            case 0:
            {
                currentMultiplier = 1;
                break;
            } 
            case 1:
            {
                currentMultiplier = 2;
                break;
            } 
            case 2:
            {
                currentMultiplier = 3;
                break;
            } 
            case 3:
            {
                currentMultiplier = 4;
                break;
            } 
            case 4:
            {
                currentMultiplier = 5;
                break;
            } 
            case 5:
            {
                currentMultiplier = 6;
                break;
            } 
            case 6:
            {
                currentMultiplier = 8;
                break;
            } 
            case 7:
            {
                currentMultiplier = 10;
                break;
            } 
            default:
            {
                currentMultiplier = 10;
                break;
            } 
        } // End of switch
        _loc2 = _loc2 * currentMultiplier;
        if (currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT)
        {
            _loc2 = _loc2 * 2;
        } // end if
        currentScore = currentScore + _loc2;
        var _loc5 = Math.floor(currentRating / (com.clubpenguin.games.dancing.GameEngine.MAX_RATING / 3));
        animationEngine.updateNoteCombo($noteResult, consecutiveNotes, _loc3, currentScore, _loc5);
    } // End of the function
    function handleKeyDown()
    {
        if (isPlayingGame)
        {
            var _loc4;
            var _loc3 = com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN;
            var _loc2;
            if (Key.getCode() == 37 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_LEFT)
            {
                _loc2 = com.clubpenguin.games.dancing.Note.TYPE_LEFT;
                KEY_PRESSED_LEFT = true;
            } // end if
            if (Key.getCode() == 39 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_RIGHT)
            {
                _loc2 = com.clubpenguin.games.dancing.Note.TYPE_RIGHT;
                KEY_PRESSED_RIGHT = true;
            } // end if
            if (Key.getCode() == 38 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_UP)
            {
                _loc2 = com.clubpenguin.games.dancing.Note.TYPE_UP;
                KEY_PRESSED_UP = true;
            } // end if
            if (Key.getCode() == 40 && !com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_DOWN)
            {
                _loc2 = com.clubpenguin.games.dancing.Note.TYPE_DOWN;
                KEY_PRESSED_DOWN = true;
            } // end if
            com.clubpenguin.games.dancing.GameEngine.debugTrace("keyDown event, noteType = " + _loc2);
            _loc4 = noteManager.getClosestValidNote(_loc2, elapsedTimeMillis);
            _loc3 = noteManager.handleNotePress(_loc2, elapsedTimeMillis, _loc4);
            if (_loc3 != com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN)
            {
                com.clubpenguin.games.dancing.GameEngine.debugTrace("note was pressed at " + elapsedTimeMillis + ", the result is " + _loc3, com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                var _loc6 = keyPresses.push(_loc4);
                if (netClient.currentState == com.clubpenguin.games.dancing.DanceNetClient.STATE_IN_GAME)
                {
                    netClient.keyPressIDs.push(_loc6 - 1);
                } // end if
                this.handleScoreUpdate(_loc3);
            } // end if
        }
        else
        {
            switch (menuSystem.getCurrentMenu())
            {
                case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING_KEYPRESS:
                case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS:
                case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_KEYPRESS:
                case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_DOWN:
                case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT:
                case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT:
                {
                    var _loc5 = Key.getCode();
                    switch (_loc5)
                    {
                        case 37:
                        {
                            menuSystem.handleClick(37);
                            break;
                        } 
                        case 39:
                        {
                            menuSystem.handleClick(39);
                            break;
                        } 
                        case 38:
                        {
                            menuSystem.handleClick(38);
                            break;
                        } 
                        case 40:
                        {
                            menuSystem.handleClick(40);
                            break;
                        } 
                    } // End of switch
                    break;
                } 
            } // End of switch
        } // end else if
    } // End of the function
    function handleKeyUp()
    {
        if (isPlayingGame)
        {
            var _loc4;
            if (Key.getCode() == 37 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_LEFT)
            {
                _loc4 = com.clubpenguin.games.dancing.Note.TYPE_LEFT;
                KEY_PRESSED_LEFT = false;
            } // end if
            if (Key.getCode() == 39 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_RIGHT)
            {
                _loc4 = com.clubpenguin.games.dancing.Note.TYPE_RIGHT;
                KEY_PRESSED_RIGHT = false;
            } // end if
            if (Key.getCode() == 38 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_UP)
            {
                _loc4 = com.clubpenguin.games.dancing.Note.TYPE_UP;
                KEY_PRESSED_UP = false;
            } // end if
            if (Key.getCode() == 40 && com.clubpenguin.games.dancing.GameEngine.KEY_PRESSED_DOWN)
            {
                _loc4 = com.clubpenguin.games.dancing.Note.TYPE_DOWN;
                KEY_PRESSED_DOWN = false;
            } // end if
            com.clubpenguin.games.dancing.GameEngine.debugTrace("keyUp event, noteType = " + _loc4);
            if (_loc4 != undefined)
            {
                for (var _loc2 = keyPresses.length - 1; _loc2 > 0; --_loc2)
                {
                    if (keyPresses[_loc2].noteType == _loc4)
                    {
                        var _loc3 = false;
                        if (keyPresses[_loc2].autoReleased)
                        {
                            _loc3 = true;
                            keyPresses[_loc2].autoReleased = false;
                        } // end if
                        if (keyPresses[_loc2].getNoteReleaseResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED && keyPresses[_loc2].noteDuration > 0)
                        {
                            _loc3 = true;
                        } // end if
                        if (_loc3)
                        {
                            keyPresses[_loc2].handleNoteReleaseEvent(elapsedTimeMillis);
                            this.handleHoldBonus(keyPresses[_loc2].noteType, keyPresses[_loc2].getNotePressResult(), keyPresses[_loc2].getNoteHoldLength());
                            com.clubpenguin.games.dancing.GameEngine.debugTrace("note was released at " + elapsedTimeMillis + " with length " + keyPresses[_loc2].getNoteHoldLength(), com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                            break;
                        } // end if
                    } // end if
                } // end of for
            } // end if
        } // end if
    } // End of the function
    function handleHoldBonus($noteType, $noteResult, $noteLength)
    {
        if ($noteLength <= 0)
        {
            return;
        } // end if
        var _loc2 = 0;
        switch ($noteResult)
        {
            case com.clubpenguin.games.dancing.Note.RESULT_PERFECT:
            {
                _loc2 = 10;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_GREAT:
            {
                _loc2 = 5;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_GOOD:
            {
                _loc2 = 2;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_ALMOST:
            {
                _loc2 = 1;
                break;
            } 
            default:
            {
                return;
            } 
        } // End of switch
        _loc2 = _loc2 * currentMultiplier;
        _loc2 = _loc2 * ($noteLength / 500);
        _loc2 = Math.round(_loc2);
        if (currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT)
        {
            _loc2 = _loc2 * 2;
        } // end if
        if (_loc2 > 0)
        {
            currentScore = currentScore + _loc2;
            animationEngine.updateNoteBonus($noteType, _loc2, currentScore);
        } // end if
    } // End of the function
    function getPostGameStatsSpeechBubble()
    {
        var _loc2 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating") + "\n";
        var _loc3 = statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
        var _loc4 = Math.round(statsNotesHit / _loc3 * 1000) / 10 + "%";
        _loc2 = _loc2 + (com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame_score", [currentScore]) + "\n");
        _loc2 = _loc2 + (com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_rating_note_percent", [_loc4]) + "\n");
        _loc2 = _loc2 + com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_rating_biggest_combo", [statsLongestChain + ""]);
        return (_loc2);
    } // End of the function
    function getNoteHitPercentage()
    {
        var _loc2 = statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
        var _loc3 = Math.round(statsNotesHit / _loc2 * 1000) / 10;
        return (_loc3);
    } // End of the function
    function getPostGameStatsBreakdown()
    {
        var _loc5 = statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
        var _loc4 = Math.round(statsNotesHit / _loc5 * 1000) / 10;
        var _loc2 = new Array();
        _loc2[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] = com.clubpenguin.util.LocaleText.getText("game_note_perfect") + ": " + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT];
        _loc2[com.clubpenguin.games.dancing.Note.RESULT_GREAT] = com.clubpenguin.util.LocaleText.getText("game_note_great") + ": " + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT];
        _loc2[com.clubpenguin.games.dancing.Note.RESULT_GOOD] = com.clubpenguin.util.LocaleText.getText("game_note_good") + ": " + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD];
        _loc2[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] = com.clubpenguin.util.LocaleText.getText("game_note_almost") + ": " + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST];
        _loc2[com.clubpenguin.games.dancing.Note.RESULT_BOO] = com.clubpenguin.util.LocaleText.getText("game_note_boo") + ": " + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO];
        _loc2[com.clubpenguin.games.dancing.Note.RESULT_MISS] = com.clubpenguin.util.LocaleText.getText("game_note_miss") + ": " + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
        if (_loc4 < 50)
        {
            _loc2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_D") + "\n";
        }
        else if (_loc4 < 75)
        {
            _loc2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_C") + "\n";
        }
        else if (_loc4 < 100)
        {
            _loc2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_B") + "\n";
        }
        else if (statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] == statsTotalNotes)
        {
            _loc2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_AAA") + "\n";
        }
        else if (statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] == statsTotalNotes)
        {
            _loc2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_AA") + "\n";
        }
        else
        {
            _loc2[6] = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_rating_A") + "\n";
        } // end else if
        for (var _loc3 in _loc2)
        {
            _loc2[_loc3] = _loc2[_loc3].toUpperCase();
        } // end of for...in
        return (_loc2);
    } // End of the function
    function getCoinsWon($totalScore)
    {
        var _loc2 = currentScore;
        if ($totalScore != undefined)
        {
            _loc2 = $totalScore;
        } // end if
        var _loc3 = 0;
        if (_loc2 <= 10000)
        {
            _loc3 = Math.round(_loc2 / 25);
        }
        else
        {
            _loc3 = 400 + Math.round((_loc2 - 10000) / 100);
        } // end else if
        return (_loc3);
    } // End of the function
    function getJudgesOpinion()
    {
        var _loc3 = "";
        var _loc4 = "";
        var _loc6 = statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_PERFECT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GREAT] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_GOOD] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_ALMOST] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_BOO] + statsNoteBreakdown[com.clubpenguin.games.dancing.Note.RESULT_MISS];
        var _loc5 = Math.round(statsNotesHit / _loc6 * 1000) / 10;
        _global.dls_dance.sendLearnerScore(Math.round(_loc5), false);
        _global.dls_dance.sendGameScore(currentScore, Math.round(_loc5), false);
        if (_loc5 < 66)
        {
            _loc3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_bad");
        }
        else if (_loc5 < 85)
        {
            _loc3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_OK");
        }
        else if (_loc5 < 95)
        {
            _loc3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_great");
            if (currentDifficulty != com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT && currentDifficulty != com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD)
            {
                _loc4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up");
            } // end if
        }
        else
        {
            _loc3 = com.clubpenguin.util.LocaleText.getText("menu_singleplayer_result_awesome");
            if (currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD)
            {
                _loc4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up_hard");
            }
            else if (currentDifficulty == com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT)
            {
                _loc4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up_expert");
            }
            else
            {
                _loc4 = " " + com.clubpenguin.util.LocaleText.getText("menu_singleplayer_level_up");
            } // end else if
        } // end else if
        _loc3 = _loc3 + (" " + com.clubpenguin.util.LocaleText.getTextReplaced("menu_singleplayer_coinswon", [this.getCoinsWon()]) + _loc4);
        return (_loc3);
    } // End of the function
    function handleButtonClick($menuOption)
    {
        menuSystem.handleClick($menuOption);
    } // End of the function
    function loadMenu($menu)
    {
        menuSystem.loadMenu($menu);
    } // End of the function
    function getCurrentMenu()
    {
        return (menuSystem.getCurrentMenu());
    } // End of the function
    function updateQualityMode()
    {
        if (!isPlayingGame || !com.clubpenguin.games.dancing.GameEngine.AUTO_QUALITY_MODE)
        {
            return;
        } // end if
        var _loc4 = qualityFrameTicks - qualityFrameTicksLast;
        var _loc3 = _loc4;
        for (var _loc2 = 1; _loc2 < averageFPS.length; ++_loc2)
        {
            averageFPS[_loc2] = averageFPS[_loc2 - 1];
            _loc3 = _loc3 + averageFPS[_loc2];
        } // end of for
        averageFPS[0] = _loc4;
        _loc3 = _loc3 / averageFPS.length;
        com.clubpenguin.games.dancing.GameEngine.debugTrace("fps: " + _loc4 + ", average: " + _loc3);
        if (_loc3 < com.clubpenguin.games.dancing.GameEngine.LOW_FPS_LIMIT)
        {
            this.setQualityMode(com.clubpenguin.games.dancing.AnimationEngine.QUALITY_MEDIUM);
            movie.qualityBtn.gotoAndStop("fadeIn");
        } // end if
        qualityFrameTicksLast = qualityFrameTicks;
    } // End of the function
    function setQualityMode($quality)
    {
        animationEngine.setQualityMode($quality);
    } // End of the function
    function getQualityMode()
    {
        return (animationEngine.getQualityMode());
    } // End of the function
    function hideDancer()
    {
        animationEngine.hideDancer();
    } // End of the function
    function handleSongSelect($direction)
    {
        if ($direction == com.clubpenguin.games.dancing.AnimationEngine.DIRECTION_LEFT)
        {
            --currentSong;
            if (currentSong < 0)
            {
                currentSong = com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS - 1;
            } // end if
        }
        else if ($direction == com.clubpenguin.games.dancing.AnimationEngine.DIRECTION_RIGHT)
        {
            ++currentSong;
            if (currentSong >= com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS)
            {
                currentSong = 0;
            } // end if
        } // end else if
        this.setSong(currentSong);
        animationEngine.handleSongSelect($direction);
    } // End of the function
    function getCurrentDifficulty()
    {
        switch (currentDifficulty)
        {
            case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
            {
                return (com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_easy"));
            } 
            case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
            {
                return (com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_medium"));
            } 
            case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
            {
                return (com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_hard"));
            } 
            case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
            {
                return (com.clubpenguin.util.LocaleText.getText("menu_difficulty_current_expert"));
            } 
        } // End of switch
    } // End of the function
    function getRandomTipText($random)
    {
        var _loc2 = ["menu_tip_multiplier", "menu_tip_longnotes", "menu_tip_dances", "menu_tip_lights", "menu_tip_multiplier_light", "menu_tip_practice", "menu_tip_expert_mode", "menu_tip_note_combos"];
        if ($random || randomTip == undefined)
        {
            randomTip = Math.floor(Math.random() * _loc2.length);
        } // end if
        return (com.clubpenguin.util.LocaleText.getText(_loc2[randomTip]));
    } // End of the function
    function joinMultiplayerServer()
    {
        netClient.init(this);
        netClient.sendGetGameMessage();
    } // End of the function
    function rejoinMultiplayerServer()
    {
        netClient.sendGetGameAgainMessage();
    } // End of the function
    function joinMultiplayerGame()
    {
        netClient.sendJoinGameMessage();
        this.setMultiplayerDifficulty();
    } // End of the function
    function setMultiplayerDifficulty()
    {
        netClient.sendDifficultyLevelMessage(currentDifficulty);
    } // End of the function
    function leaveMultiplayerServer()
    {
        netClient.sendAbortGameMessage();
        netClient.destroy();
    } // End of the function
    function getNetClientState()
    {
        return (netClient.currentState);
    } // End of the function
    function getTimeToNextSong()
    {
        return (netClient.timeToNextSong);
    } // End of the function
    function updateMultiplayerScores(playerScores)
    {
        if (playerScores != null)
        {
            multiplayerScores = playerScores;
        } // end if
        animationEngine.updateMultiplayerScores(playerScores);
    } // End of the function
    function setMultiplayerScoreVisibility($visible)
    {
        animationEngine.setMultiplayerScoreVisibility($visible);
    } // End of the function
    function getJoinGameSpeechBubble()
    {
        var _loc2 = "";
        var _loc3 = this.formatTimeApproximate(netClient.timeToNextSong);
        _loc2 = com.clubpenguin.util.LocaleText.getText("menu_multiplayer_inprogress") + " ";
        _loc2 = _loc2 + com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_progress", [_loc3]);
        return (_loc2);
    } // End of the function
    function getWaitingSpeechBubble()
    {
        var _loc2 = "";
        var _loc3 = Math.round(netClient.timeToNextSong / 1000);
        var _loc4 = this.formatTimeApproximate(netClient.timeToNextSong);
        var _loc5 = Math.round(_loc3 / 10);
        if (_loc3 < 32 || _loc5 % 2 == 0)
        {
            _loc2 = com.clubpenguin.util.LocaleText.getText("menu_multiplayer_joingame") + " ";
            _loc2 = _loc2 + com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting", [netClient.songName, _loc4]);
            randomTip = undefined;
        }
        else
        {
            _loc2 = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting", [netClient.songName, _loc4]);
            _loc2 = _loc2 + (" " + this.getRandomTipText(false));
        } // end else if
        return (_loc2);
    } // End of the function
    function getMultiplayerCoinsWon()
    {
        var _loc6;
        var _loc7;
        var _loc4;
        if (multiplayerScores != null)
        {
            if (com.clubpenguin.games.dancing.GameEngine.SHELL == undefined)
            {
                SHELL = _global.getCurrentShell();
            } // end if
            var _loc3 = com.clubpenguin.games.dancing.GameEngine.SHELL.getMyPlayerNickname();
            if (multiplayerScores[0].name == _loc3)
            {
                _loc7 = com.clubpenguin.util.LocaleText.getText("menu_multiplayer_postgame_you");
                _loc4 = "";
            }
            else
            {
                _loc7 = multiplayerScores[0].name;
                for (var _loc5 in multiplayerScores)
                {
                    if (multiplayerScores[_loc5].name == _loc3)
                    {
                        _loc4 = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame_score", [multiplayerScores[_loc5].score]);
                        break;
                    } // end if
                } // end of for...in
            } // end else if
            _loc6 = com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_postgame", [_loc7, multiplayerScores[0].score]);
            _loc6 = _loc6 + (" " + _loc4);
        }
        else
        {
            _loc6 = this.getJudgesOpinion();
        } // end else if
        return (_loc6);
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace("(GameEngine) " + message, priority);
        } // end if
    } // End of the function
    function formatTime($timeInSeconds)
    {
        var _loc1 = "";
        var _loc3 = Math.floor($timeInSeconds / 60);
        var _loc2 = $timeInSeconds % 60;
        _loc1 = _loc2 < 10 ? ("0" + _loc2) : (_loc2);
        if (_loc3 > 0)
        {
            _loc1 = _loc3 + ":" + _loc1;
        } // end if
        return (_loc1);
    } // End of the function
    function formatTimeApproximate($timeInMillis)
    {
        var _loc5 = 5000;
        var _loc3 = 30000;
        var _loc2 = 60000;
        var _loc4 = 2 * _loc2;
        if ($timeInMillis <= _loc5)
        {
            return (com.clubpenguin.util.LocaleText.getText("menu_multiplayer_waiting_now"));
        }
        else if ($timeInMillis >= _loc4 + _loc3)
        {
            return (com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_mins", ["2½ "]));
        }
        else if ($timeInMillis >= _loc4)
        {
            return (com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_mins", ["2"]));
        }
        else if ($timeInMillis >= _loc2 + _loc3)
        {
            return (com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_mins", ["1½ "]));
        }
        else if ($timeInMillis >= _loc2)
        {
            return (com.clubpenguin.util.LocaleText.getText("menu_multiplayer_waiting_one_minute"));
        }
        else
        {
            var _loc6 = Math.round($timeInMillis / 1000);
            return (com.clubpenguin.util.LocaleText.getTextReplaced("menu_multiplayer_waiting_about_n_secs", [_loc6]));
        } // end else if
    } // End of the function
    static var MEMBER_ONLY_CHECK = true;
    static var DIFFICULTY_EASY = 0;
    static var DIFFICULTY_MEDIUM = 1;
    static var DIFFICULTY_HARD = 2;
    static var DIFFICULTY_EXPERT = 3;
    static var SPECIAL_NONE = 0;
    static var SPECIAL_RIVERDANCE = 1;
    static var SPECIAL_WORM = 2;
    static var SPECIAL_BREAKDANCE = 3;
    static var SPECIAL_PUFFLESPIN = 4;
    static var SONG_ONE = 0;
    static var SONG_TWO = 1;
    static var SONG_THREE = 2;
    static var SONG_FOUR = 3;
    static var SONG_FIVE = 4;
    static var SONG_SIX = 5;
    static var SONG_ONE_DATA = "songs/songData1.swf";
    static var SONG_TWO_DATA = "songs/songData2.swf";
    static var SONG_THREE_DATA = "songs/songData3.swf";
    static var SONG_FOUR_DATA = "songs/songData4.swf";
    static var SONG_FIVE_DATA = "songs/songData5.swf";
    static var SONG_SIX_DATA = "songs/songData6.swf";
    static var TOTAL_SONGS = 6;
    static var SONG_LOAD_OK = 0;
    static var SONG_LOAD_ERROR = 1;
    static var SONG_LOAD_IN_PROGRESS = 2;
    static var ERROR_CODE_ROOM_FULL = 210;
    static var ERROR_CODE_MULTIPLE_CONNECTIONS = 120;
    static var KEY_PRESSED_LEFT = false;
    static var KEY_PRESSED_RIGHT = false;
    static var KEY_PRESSED_UP = false;
    static var KEY_PRESSED_DOWN = false;
    static var LOW_FPS_LIMIT = 8;
    static var MULTIPLIER_LIMIT = 10;
    static var MAX_RATING = 30;
    static var AUTO_QUALITY_MODE = true;
    static var MUSIC_ID_NIGHTCLUB = 5;
    static var MUSIC_ID_LOUNGE = 6;
    var currentRating = 0;
    var consecutiveNotes = 0;
    var currentMultiplier = 1;
    var currentScore = 0;
    var totalScore = 0;
    var qualityFrameTicks = 0;
    var qualityFrameTicksLast = 0;
    var averageFPS = [com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS, com.clubpenguin.games.generic.GenericGameEngine.DEFAULT_FPS];
    var statsLongestChain = 0;
    var statsNotesHit = 0;
    var statsTotalNotes = 0;
    var currentSong = 1;
    var currentDifficulty = 1;
    var randomTip = 1;
    var loadedSongs = 0;
    var hasPurplePuffle = false;
} // End of Class
