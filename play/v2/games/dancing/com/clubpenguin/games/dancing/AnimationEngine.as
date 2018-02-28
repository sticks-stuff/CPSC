class com.clubpenguin.games.dancing.AnimationEngine
{
    var gameEngine, movie, dancingPenguin, backgroundLightBuffer, hideHUDTimeMillis, timePerFrameMillis, animationTimeMillis;
    function AnimationEngine($gameEngine, $movie)
    {
        gameEngine = $gameEngine;
        movie = $movie;
        var _loc3 = _global.getCurrentShell();
        hasPurplePuffle = _loc3.isItemOnMyPlayer(com.clubpenguin.games.dancing.AnimationEngine.ITEM_ID_PURPLE_PUFFLE);
        if (movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP] == undefined)
        {
            com.clubpenguin.games.dancing.AnimationEngine.debugTrace("cannot find the dancer movieclip!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        } // end if
        if (movie[com.clubpenguin.games.dancing.AnimationEngine.ARROWS_MOVIECLIP] == undefined)
        {
            com.clubpenguin.games.dancing.AnimationEngine.debugTrace("cannot find the arrows movieclip!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
        } // end if
        movie.closeBtn.onRelease = com.clubpenguin.util.Delegate.create(gameEngine, gameEngine.destroy);
        dancingPenguin = movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP];
        backgroundLightBuffer = new flash.display.BitmapData(movie._width, movie._height, true, 0);
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplier.gotoAndStop("inactive");
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop("inactive");
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.text = "";
        this.setMultiplayerScoreVisibility(false);
        showHUD = true;
        hideHUDTimeMillis = getTimer() + (com.clubpenguin.games.dancing.AnimationEngine.HUD_SHOW_TIME + com.clubpenguin.games.dancing.AnimationEngine.HUD_SHOW_TIME);
    } // End of the function
    function setQualityMode($quality)
    {
        qualityMode = $quality;
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights._visible = qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_HIGH;
    } // End of the function
    function getQualityMode()
    {
        return (qualityMode);
    } // End of the function
    function handleSongSelect($direction)
    {
        var _loc8 = gameEngine.currentSong;
        var _loc6 = [255, 255, 255, 16711680, 16711680, 16711680];
        var _loc5 = [movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk1_mc.label_mc, movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk2_mc.label_mc, movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk3_mc.label_mc, movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk4_mc.label_mc];
        var _loc7 = movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.badge;
        var _loc3 = _loc8 + 2;
        var _loc4 = new Array();
        if ($direction == com.clubpenguin.games.dancing.AnimationEngine.DIRECTION_LEFT)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.chooser.gotoAndPlay("animateLeft");
        }
        else if ($direction == com.clubpenguin.games.dancing.AnimationEngine.DIRECTION_RIGHT)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.chooser.gotoAndPlay("animateRight");
        } // end else if
        for (var _loc2 = _loc5.length - 1; _loc2 >= 0; --_loc2)
        {
            if (_loc3 >= com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS)
            {
                _loc3 = _loc3 - com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS;
            } // end if
            _loc4[_loc2] = new Color(_loc5[_loc2]);
            _loc4[_loc2].setRGB(_loc6[_loc3]);
            ++_loc3;
        } // end of for
        movie[com.clubpenguin.games.dancing.AnimationEngine.MENUS_MOVIECLIP].howtoplay.song.songLabel.text = com.clubpenguin.util.LocaleText.getText("menu_song_item_" + _loc8);
        _loc7._visible = false;
        if (!gameEngine.isMember() && _loc8 >= 3)
        {
            _loc7._visible = true;
        } // end if
        trace ("memberBadge = " + _loc7 + " visibility = " + _loc7._visible);
    } // End of the function
    function startSong($timePerFrameMillis)
    {
        timePerFrameMillis = $timePerFrameMillis;
        animationTimeMillis = 0;
        specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE;
        this.updateCurrentRating(com.clubpenguin.games.dancing.AnimationEngine.RATING_OK, 0);
    } // End of the function
    function endSong()
    {
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].crowd.gotoAndStop(1);
        if (movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].discoBall._currentframe != 1)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].discoBall.gotoAndPlay("NoteStreakLost");
        } // end if
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplier.gotoAndStop("inactive");
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop("inactive");
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.text = "";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndStop("inactive");
        this.setMultiplayerScoreVisibility(false);
        for (var _loc2 = 1; _loc2 <= 10; ++_loc2)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].combo["light" + _loc2].gotoAndStop(1);
        } // end of for
        var _loc3 = new flash.geom.ColorTransform();
        var _loc4;
        _loc4 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.ambience);
        _loc3.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
        _loc4.colorTransform = _loc3;
        _loc4 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light1);
        _loc3.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
        _loc4.colorTransform = _loc3;
        _loc4 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light2);
        _loc3.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
        _loc4.colorTransform = _loc3;
        _loc4 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light3);
        _loc3.rgb = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
        _loc4.colorTransform = _loc3;
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop("inactive");
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop("inactive");
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop("inactive");
    } // End of the function
    function updateHUD()
    {
        var _loc2 = getTimer();
        if (movie._ymouse < 50)
        {
            if (!showHUD)
            {
                showHUD = true;
                movie.qualityBtn.gotoAndStop("fadeIn");
            } // end if
            hideHUDTimeMillis = _loc2 + com.clubpenguin.games.dancing.AnimationEngine.HUD_SHOW_TIME;
        } // end if
        if (showHUD)
        {
            if (_loc2 > hideHUDTimeMillis)
            {
                showHUD = false;
                movie.qualityBtn.gotoAndStop("fadeOut");
            } // end if
        } // end if
    } // End of the function
    function updateBackground()
    {
        var _loc9 = gameEngine.elapsedTimeMillis;
        var _loc8 = gameEngine.currentSong;
        var _loc10 = gameEngine.currentMultiplier;
        if (qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_MEDIUM || qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_LOW)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights._visible = false;
            return;
        } // end if
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights._visible = true;
        var _loc15 = _loc9 % (com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8) / 2) / com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8) * 2;
        var _loc12 = Math.round(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.animation._totalframes * _loc15);
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.animation.gotoAndStop(_loc12);
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.animation.gotoAndStop(_loc12);
        _loc15 = _loc9 % (com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8) * 2) / com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc8) / 2;
        _loc12 = Math.round(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation._totalframes * _loc15);
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.gotoAndStop(_loc12);
        var _loc5;
        var _loc3;
        var _loc6;
        switch (_loc10)
        {
            case 1:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_OFF_WHITE;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_OFF_WHITE;
                break;
            } 
            case 2:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_GREEN;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
                break;
            } 
            case 3:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_GREEN;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
                break;
            } 
            case 4:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
                break;
            } 
            case 5:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
                break;
            } 
            case 6:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
                break;
            } 
            case 8:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_MAGENTA;
                break;
            } 
            case 10:
            {
                _loc5 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_MAGENTA;
                _loc3 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_PURPLE;
                _loc6 = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARKBLUE;
                break;
            } 
            default:
            {
                com.clubpenguin.games.dancing.AnimationEngine.debugTrace("unknown multiplier! multiplier set to " + _loc10, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                break;
            } 
        } // End of switch
        var _loc4 = new flash.geom.ColorTransform();
        var _loc7;
        _loc7 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.ambience);
        _loc4.rgb = _loc3;
        _loc7.colorTransform = _loc4;
        _loc7 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light1);
        _loc4.rgb = _loc3;
        _loc7.colorTransform = _loc4;
        _loc7 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light2);
        _loc4.rgb = _loc6;
        _loc7.colorTransform = _loc4;
        _loc7 = new flash.geom.Transform(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation.light3);
        _loc4.rgb = _loc5;
        _loc7.colorTransform = _loc4;
        var _loc11 = new flash.geom.ColorTransform();
        _loc11.alphaMultiplier = 4.500000E-001;
        backgroundLightBuffer.draw(movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.animation, new flash.geom.Matrix(), _loc11);
        var _loc2 = new Array();
        var _loc13 = 9.500000E-001;
        _loc2 = _loc2.concat([1, 0, 0, 0, 0]);
        _loc2 = _loc2.concat([0, 1, 0, 0, 0]);
        _loc2 = _loc2.concat([0, 0, 1, 0, 0]);
        _loc2 = _loc2.concat([0, 0, 0, _loc13, 0]);
        var _loc14 = new flash.filters.ColorMatrixFilter(_loc2);
        backgroundLightBuffer.applyFilter(backgroundLightBuffer, backgroundLightBuffer.rectangle, new flash.geom.Point(0, 0), _loc14);
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.createEmptyMovieClip("buffer", 100);
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.buffer.attachBitmap(backgroundLightBuffer, 1, "auto", true);
    } // End of the function
    function updateDancefloor()
    {
        var _loc9 = gameEngine.currentTimeMillis;
        var _loc8 = gameEngine.currentMultiplier;
        var _loc10 = gameEngine.isDancing;
        var _loc2 = Math.round(_loc9 / 500) % 3;
        if (qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_MEDIUM || qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_LOW)
        {
            _loc2 = Math.round(_loc9 / 2000) % 3;
        } // end if
        if (_loc2 != lastColour)
        {
            lastColour = _loc2;
            var _loc7 = _loc8 < 6 ? (_loc8) : (6);
            var _loc4 = new Array();
            if (!_loc10)
            {
                _loc7 = 6;
            } // end if
            if (_loc7 < 6)
            {
                _loc4[0] = _loc8;
                _loc4[1] = _loc8 + 1;
                _loc4[2] = _loc8 + 2;
            }
            else
            {
                for (var _loc6 = 0; _loc6 < _loc7; ++_loc6)
                {
                    _loc4[_loc6] = Math.round(Math.random() * 1000) % _loc7 + 2;
                } // end of for
            } // end else if
            for (var _loc6 = 0; _loc6 < 6; ++_loc6)
            {
                for (var _loc3 = 0; _loc3 < 5; ++_loc3)
                {
                    _loc2 = _loc2 > _loc4.length ? (0) : (_loc2 + 1);
                    var _loc5 = Math.floor(Math.random() * 10) % 4 == 0;
                    if (_loc5)
                    {
                        _loc2 = _loc2 > _loc4.length ? (0) : (_loc2 + 1);
                    } // end if
                    movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].dancefloor["light" + _loc3 + _loc6].gotoAndStop(_loc4[_loc2]);
                } // end of for
            } // end of for
        } // end if
    } // End of the function
    function updateDancer($normalisedRating)
    {
        var _loc6 = gameEngine.currentSong;
        var _loc5 = gameEngine.elapsedTimeMillis;
        var _loc11 = gameEngine.isPlayingGame;
        if (_loc5 >= com.clubpenguin.games.dancing.data.SongData.getSongLengthMillis(_loc6))
        {
            return;
        } // end if
        if (dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP] == undefined)
        {
            var _loc3 = String(Math.ceil(Math.random() * 4));
            dancingPenguin.attachMovie(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK + _loc3, com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP, 1);
            dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(1);
            if (hasPurplePuffle)
            {
                if (dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP] == undefined)
                {
                    dancingPenguin.attachMovie(com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP, com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP, 2);
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].gotoAndStop(1);
                } // end if
                dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = true;
            } // end if
            var _loc13 = dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._totalframes / 4;
            dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(_loc13 + 1);
            loopAgain = true;
        } // end if
        if (_loc5 > animationTimeMillis + timePerFrameMillis)
        {
            animationTimeMillis = animationTimeMillis + timePerFrameMillis;
            if (dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._currentframe < dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._totalframes)
            {
                this.updateDancerFrame(dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP]._currentframe);
            }
            else
            {
                if (loopAgain)
                {
                    loopAgain = false;
                    this.updateDancerFrame(0);
                    return;
                } // end if
                loopAgain = true;
                dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].removeMovieClip();
                if (!_loc11)
                {
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = false;
                    gameEngine.isDancing = false;
                    return;
                } // end if
                _loc3 = String(Math.ceil(Math.random() * 4));
                var _loc9 = Math.floor(Math.random() * 10) % 2 == 0;
                var _loc2;
                var _loc8;
                switch ($normalisedRating)
                {
                    case com.clubpenguin.games.dancing.AnimationEngine.RATING_BAD:
                    {
                        if (_loc9)
                        {
                            _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_TERRIBLE + (_loc3 % 2 + 1);
                        }
                        else
                        {
                            _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD + _loc3;
                        } // end else if
                        _loc8 = Math.floor(Math.random() * 2) + 1;
                        break;
                    } 
                    case com.clubpenguin.games.dancing.AnimationEngine.RATING_OK:
                    {
                        if (_loc9)
                        {
                            _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD + _loc3;
                        }
                        else
                        {
                            _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK + _loc3;
                        } // end else if
                        _loc8 = Math.floor(Math.random() * 3) + 1;
                        break;
                    } 
                    case com.clubpenguin.games.dancing.AnimationEngine.RATING_GREAT:
                    {
                        if (_loc9)
                        {
                            _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK + _loc3;
                        }
                        else
                        {
                            _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT + _loc3;
                        } // end else if
                        _loc8 = Math.floor(Math.random() * 4) + 2;
                        break;
                    } 
                    default:
                    {
                        com.clubpenguin.games.dancing.AnimationEngine.debugTrace("normalised current rating (" + $normalisedRating + ") is out of range, unable to do new dance move!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                        break;
                    } 
                } // End of switch
                if (hasPurplePuffle)
                {
                    if (!dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible)
                    {
                        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = true;
                    } // end if
                } // end if
                if (specialMove != com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE)
                {
                    _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_SPECIAL + specialMove;
                    if (specialMove == com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_COMBO_LOST)
                    {
                        _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_TERRIBLE + (_loc3 % 2 + 1);
                    } // end if
                } // end if
                var _loc12 = com.clubpenguin.games.dancing.data.SongData.getSongLengthMillis(_loc6) - com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_loc6) * 2;
                if (_loc5 >= _loc12)
                {
                    var _loc7 = gameEngine.getNoteHitPercentage();
                    if (_loc7 < 50)
                    {
                        _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_ENDING + "4";
                    }
                    else if (_loc7 < 75)
                    {
                        _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_ENDING + "3";
                    }
                    else if (_loc7 <= 99)
                    {
                        _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_ENDING + "2";
                    }
                    else
                    {
                        _loc2 = com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_ENDING + "1";
                    } // end else if
                } // end else if
                dancingPenguin.attachMovie(_loc2, com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP, 1);
                dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(1);
                if (specialMove != com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE)
                {
                    if (specialMove == com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_PUFFLESPIN)
                    {
                        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = false;
                        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].puffleBonus.label.puffleBonus.text = "+100";
                        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].puffleBonus.gotoAndPlay(1);
                        gameEngine.currentScore = gameEngine.currentScore + 100;
                    }
                    else if (hasPurplePuffle)
                    {
                        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.PUFFLEDANCE_SPECIAL);
                        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffleBonus.label.puffleBonus.text = "+50";
                        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffleBonus.gotoAndPlay(1);
                        gameEngine.currentScore = gameEngine.currentScore + 50;
                    } // end else if
                    specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE;
                }
                else if (hasPurplePuffle)
                {
                    var _loc4 = 1;
                    switch ($normalisedRating)
                    {
                        case com.clubpenguin.games.dancing.AnimationEngine.RATING_BAD:
                        {
                            _loc4 = 1;
                            break;
                        } 
                        case com.clubpenguin.games.dancing.AnimationEngine.RATING_OK:
                        {
                            _loc4 = 2;
                            break;
                        } 
                        case com.clubpenguin.games.dancing.AnimationEngine.RATING_GREAT:
                        {
                            _loc4 = 5;
                            break;
                        } 
                    } // End of switch
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffleBonus.label.puffleBonus.text = "+" + _loc4;
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffleBonus.gotoAndPlay(1);
                    gameEngine.currentScore = gameEngine.currentScore + _loc4;
                } // end else if
                if (hasPurplePuffle)
                {
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].gotoAndStop(_loc8);
                } // end if
                com.clubpenguin.games.dancing.AnimationEngine.debugTrace("add new dancer mc! animation name is " + _loc2, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            } // end else if
            this.updateDancer($normalisedRating);
        } // end if
    } // End of the function
    function updateDancerFrame($targetFrame)
    {
        var _loc2 = $targetFrame + 1;
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.eyes_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.beak_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.face_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.frontArm_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.frontArmLines_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.backArm_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.backArmLines_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.body_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.bodyLines_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.shadow_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.feet_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.rightFoot_mc.gotoAndStop(_loc2);
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.leftFoot_mc.gotoAndStop(_loc2);
        if (hasPurplePuffle)
        {
            if (_loc2 == 1)
            {
                if (dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc._totalframes > com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES)
                {
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES + 1);
                }
                else
                {
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(_loc2);
                } // end else if
            }
            else
            {
                var _loc3 = dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc._currentframe;
                if (_loc3 > com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES)
                {
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.TOTAL_DANCE_FRAMES + _loc2);
                }
                else
                {
                    dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(_loc2);
                } // end else if
            } // end else if
            dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].penguin_mc.puffle_mc.gotoAndStop(_loc2);
        } // end if
    } // End of the function
    function hideDancer()
    {
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP].removeMovieClip();
        dancingPenguin[com.clubpenguin.games.dancing.AnimationEngine.PUFFLE_MOVIECLIP]._visible = false;
        gameEngine.isDancing = false;
    } // End of the function
    function updateNoteBonus($noteType, $noteValue, $currentScore)
    {
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.HOLD_POPUP_MOVIECLIP + $noteType].gotoAndPlay(2);
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP][com.clubpenguin.games.dancing.AnimationEngine.HOLD_POPUP_MOVIECLIP + $noteType].bonus.text = "+" + $noteValue;
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = com.clubpenguin.util.LocaleText.getText("ui_score") + ":";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = $currentScore;
    } // End of the function
    function updateNoteCombo($noteResult, $consecutiveNotes, $comboLost, $currentScore, $normalisedRating)
    {
        switch ($noteResult)
        {
            case com.clubpenguin.games.dancing.Note.RESULT_PERFECT:
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_PERFECT);
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_GREAT:
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_GREAT);
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_GOOD:
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_OK);
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_ALMOST:
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_ALMOST);
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_MISS:
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_MISS);
                break;
            } 
            case com.clubpenguin.games.dancing.Note.RESULT_BOO:
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].notePopup.gotoAndPlay(com.clubpenguin.games.dancing.AnimationEngine.POPUPANIM_BOO);
                break;
            } 
        } // End of switch
        if ($consecutiveNotes / 100 >= 1 && $consecutiveNotes % 100 == 0 || $consecutiveNotes == 25 || $consecutiveNotes == 50 || $consecutiveNotes == 75)
        {
            switch ($consecutiveNotes)
            {
                case 25:
                {
                    specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_RIVERDANCE;
                    movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
                    var _loc7 = Math.round(Math.random() * 100) % 2 == 0;
                    if (_loc7)
                    {
                        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("25NoteStreak1");
                    }
                    else
                    {
                        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("25NoteStreak2");
                    } // end else if
                    break;
                } 
                case 50:
                {
                    specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_WORM;
                    movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
                    movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("50NoteStreak");
                    break;
                } 
                case 75:
                {
                    if (hasPurplePuffle)
                    {
                        specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_PUFFLESPIN;
                    } // end if
                    if (qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_HIGH)
                    {
                        if (movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].discoBall._currentframe == 1)
                        {
                            movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].discoBall.gotoAndPlay("75NoteStreak");
                        } // end if
                        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndStop(1);
                    } // end if
                    break;
                } 
                default:
                {
                    specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_BREAKDANCE;
                    movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
                    movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("100NoteStreak");
                    break;
                } 
            } // End of switch
            if ($consecutiveNotes != 75)
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.tween.message.text = com.clubpenguin.util.LocaleText.getTextReplaced("ui_noteCombo", [$consecutiveNotes]).toUpperCase();
            } // end if
        } // end if
        if ($comboLost)
        {
            specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_COMBO_LOST;
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("NoteStreakLost");
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.tween.message.text = com.clubpenguin.util.LocaleText.getText("ui_noteComboLost").toUpperCase();
        } // end if
        var _loc3 = 1;
        var _loc4 = new TextFormat();
        _loc4.bold = true;
        switch (Math.floor($consecutiveNotes / com.clubpenguin.games.dancing.AnimationEngine.MULTIPLIER_LIMIT))
        {
            case 0:
            {
                _loc3 = 1;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_WHITE;
                break;
            } 
            case 1:
            {
                _loc3 = 2;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_GREEN;
                break;
            } 
            case 2:
            {
                _loc3 = 3;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_YELLOW;
                break;
            } 
            case 3:
            {
                _loc3 = 4;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_LIGHT_ORANGE;
                break;
            } 
            case 4:
            {
                _loc3 = 5;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_DARK_ORANGE;
                break;
            } 
            case 5:
            {
                _loc3 = 6;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_RED;
                break;
            } 
            case 6:
            {
                _loc3 = 7;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_MAGENTA;
                break;
            } 
            case 7:
            {
                _loc3 = 8;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_PURPLE;
                break;
            } 
            default:
            {
                _loc3 = 8;
                _loc4.color = com.clubpenguin.games.dancing.AnimationEngine.COLOUR_PURPLE;
                break;
            } 
        } // End of switch
        if ($consecutiveNotes < 10)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = "";
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = "";
        }
        else
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.text = com.clubpenguin.util.LocaleText.getText("ui_combo").toUpperCase();
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.text = $consecutiveNotes;
        } // end else if
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplier.gotoAndStop(_loc3);
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakLabel.setTextFormat(_loc4);
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakValue.setTextFormat(_loc4);
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].score.text = com.clubpenguin.util.LocaleText.getText("ui_score") + ":";
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].scoreValue.text = $currentScore;
        var _loc6 = $consecutiveNotes % com.clubpenguin.games.dancing.AnimationEngine.MULTIPLIER_LIMIT;
        for (var _loc2 = 1; _loc2 <= 10; ++_loc2)
        {
            if (_loc2 <= _loc6)
            {
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].combo["light" + _loc2].gotoAndStop(_loc3 + 1);
                continue;
            } // end if
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].combo["light" + _loc2].gotoAndStop(_loc3);
        } // end of for
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.speedLines._visible = false;
        if (qualityMode == com.clubpenguin.games.dancing.AnimationEngine.QUALITY_HIGH)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].streakPopup.cadence.speedLines._visible = true;
        } // end if
        this.updateCurrentRating($normalisedRating, $consecutiveNotes);
    } // End of the function
    function updateCurrentRating($normalisedRating, $consecutiveNotes)
    {
        var _loc3 = "";
        switch ($normalisedRating)
        {
            case com.clubpenguin.games.dancing.AnimationEngine.RATING_BAD:
            {
                _loc3 = com.clubpenguin.util.LocaleText.getText("ui_ratingBad");
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_BAD);
                break;
            } 
            case com.clubpenguin.games.dancing.AnimationEngine.RATING_OK:
            {
                _loc3 = com.clubpenguin.util.LocaleText.getText("ui_ratingOK");
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_OK);
                break;
            } 
            case com.clubpenguin.games.dancing.AnimationEngine.RATING_GREAT:
            {
                _loc3 = com.clubpenguin.util.LocaleText.getText("ui_ratingGreat");
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
                movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].lights.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
                movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].rating.gotoAndStop(com.clubpenguin.games.dancing.AnimationEngine.DANCER_MOVIECLIP_GREAT);
                break;
            } 
        } // End of switch
        var _loc2 = 1;
        if ($consecutiveNotes > 15)
        {
            _loc2 = 2;
        } // end if
        if ($consecutiveNotes > 35)
        {
            _loc2 = 3;
        } // end if
        movie[com.clubpenguin.games.dancing.AnimationEngine.BACKGROUND_MOVIECLIP].crowd.gotoAndStop(_loc2);
    } // End of the function
    function setMultiplayerScoreVisibility($visible)
    {
        if ($visible)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerLabel.text = com.clubpenguin.util.LocaleText.getText("ui_allScores");
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames._visible = true;
        }
        else
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerLabel.text = "";
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames._visible = false;
        } // end else if
    } // End of the function
    function updateMultiplayerScores(playerScores)
    {
        this.setMultiplayerScoreVisibility(true);
        movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames.background._height = playerScores.length * 3.125000E+001 + 1.250000E+001;
        for (var _loc5 = 1; _loc5 <= 15; ++_loc5)
        {
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + _loc5].label.text = "";
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + _loc5]._visible = false;
        } // end of for
        for (var _loc11 in playerScores)
        {
            var _loc4 = parseInt(_loc11);
            if (_loc4 >= 15)
            {
                break;
            } // end if
            var _loc6 = playerScores[_loc11].name.substring(0, 12);
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + (_loc4 + 1)]._visible = true;
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + (_loc4 + 1)].label.text = _loc6 + ": " + playerScores[_loc11].score;
            if (playerScores[_loc11].name.substring(0, 6).toLowerCase() == "pengui")
            {
                var _loc8 = playerScores[_loc11].name.substring(8, playerScores[_loc11].name.length);
                if (parseInt(_loc8) != Number.NaN)
                {
                    movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + (_loc4 + 1)].label.text = _loc6.substring(0, 10) + ": " + playerScores[_loc11].score;
                } // end if
            } // end if
            var _loc9 = _global.getCurrentShell();
            var _loc10 = _loc9.getMyPlayerNickname();
            var _loc7 = 1;
            if (playerScores[_loc11].name == _loc10)
            {
                _loc7 = 2;
            } // end if
            movie[com.clubpenguin.games.dancing.AnimationEngine.SCORE_MOVIECLIP].multiplayerNames["item" + (_loc4 + 1)].gotoAndStop(_loc7);
        } // end of for...in
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace("(AnimationEngine) " + message, priority);
        } // end if
    } // End of the function
    static var COLOUR_WHITE = 15724527;
    static var COLOUR_OFF_WHITE = 14277081;
    static var COLOUR_GREEN = 13434675;
    static var COLOUR_YELLOW = 16776960;
    static var COLOUR_LIGHT_ORANGE = 16763904;
    static var COLOUR_DARK_ORANGE = 16746512;
    static var COLOUR_RED = 16730931;
    static var COLOUR_MAGENTA = 14287066;
    static var COLOUR_PURPLE = 8026836;
    static var COLOUR_DARKBLUE = 5932468;
    static var QUALITY_LOW = 0;
    static var QUALITY_MEDIUM = 1;
    static var QUALITY_HIGH = 2;
    static var RATING_BAD = 0;
    static var RATING_OK = 1;
    static var RATING_GREAT = 2;
    static var SPECIAL_NONE = 0;
    static var SPECIAL_RIVERDANCE = 1;
    static var SPECIAL_WORM = 2;
    static var SPECIAL_BREAKDANCE = 3;
    static var SPECIAL_PUFFLESPIN = 4;
    static var SPECIAL_COMBO_LOST = 5;
    static var DIRECTION_LEFT = 0;
    static var DIRECTION_RIGHT = 1;
    static var ARROWS_MOVIECLIP = "arrows";
    static var DANCER_MOVIECLIP = "dancer";
    static var PUFFLE_MOVIECLIP = "puffle";
    static var SCORE_MOVIECLIP = "score";
    static var MENUS_MOVIECLIP = "menus";
    static var BACKGROUND_MOVIECLIP = "background";
    static var HOLD_POPUP_MOVIECLIP = "noteHoldPopup";
    static var DANCER_MOVIECLIP_TERRIBLE = "danceTerrible";
    static var DANCER_MOVIECLIP_BAD = "danceBad";
    static var DANCER_MOVIECLIP_OK = "danceOK";
    static var DANCER_MOVIECLIP_GREAT = "danceGreat";
    static var DANCER_MOVIECLIP_SPECIAL = "danceSpecial";
    static var DANCER_MOVIECLIP_ENDING = "danceEnd";
    static var PUFFLEDANCE_SMALLHOP = 1;
    static var PUFFLEDANCE_BIGHOP = 2;
    static var PUFFLEDANCE_GROOVIN = 3;
    static var PUFFLEDANCE_SOMERSAULT = 4;
    static var PUFFLEDANCE_SPECIAL = 5;
    static var POPUPANIM_PERFECT = "perfectPopup";
    static var POPUPANIM_GREAT = "greatPopup";
    static var POPUPANIM_OK = "okPopup";
    static var POPUPANIM_ALMOST = "almostPopup";
    static var POPUPANIM_BOO = "booPopup";
    static var POPUPANIM_MISS = "missPopup";
    static var MULTIPLIER_LIMIT = com.clubpenguin.games.dancing.GameEngine.MULTIPLIER_LIMIT;
    static var MAX_RATING = com.clubpenguin.games.dancing.GameEngine.MAX_RATING;
    static var ITEM_ID_PURPLE_PUFFLE = 754;
    static var HUD_SHOW_TIME = 2500;
    static var TOTAL_DANCE_FRAMES = 48;
    var specialMove = com.clubpenguin.games.dancing.AnimationEngine.SPECIAL_NONE;
    var lastColour = 1;
    var loopAgain = false;
    var showHUD = false;
    var hasPurplePuffle = false;
    var qualityMode = com.clubpenguin.games.dancing.AnimationEngine.QUALITY_HIGH;
} // End of Class
