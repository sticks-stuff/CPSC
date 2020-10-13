class com.clubpenguin.games.dancing.Note
{
    var parentMovie, noteType, noteTime, noteDuration, sentToServer, autoReleased, noteHeight, noteYPos, noteXPos, pressTime, releaseTime, movie;
    function Note(parentMovieClip, type, time, duration)
    {
        com.clubpenguin.games.dancing.Note.debugTrace("make new note: " + type + " at " + time + " for " + duration + "ms", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
        if (duration == undefined)
        {
            duration = 0;
        } // end if
        parentMovie = parentMovieClip;
        noteType = type;
        noteTime = time;
        noteDuration = duration;
        sentToServer = false;
        autoReleased = false;
        var _loc3 = parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y - parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y;
        noteHeight = _loc3 * noteDuration / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
        noteYPos = parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y;
        switch (noteType)
        {
            case com.clubpenguin.games.dancing.Note.TYPE_LEFT:
            {
                noteXPos = parentMovie[com.clubpenguin.games.dancing.Note.LEFT_TARGET_MOVIECLIP]._x;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.TYPE_RIGHT:
            {
                noteXPos = parentMovie[com.clubpenguin.games.dancing.Note.RIGHT_TARGET_MOVIECLIP]._x;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.TYPE_UP:
            {
                noteXPos = parentMovie[com.clubpenguin.games.dancing.Note.UP_TARGET_MOVIECLIP]._x;
                break;
            } 
            case com.clubpenguin.games.dancing.Note.TYPE_DOWN:
            {
                noteXPos = parentMovie[com.clubpenguin.games.dancing.Note.DOWN_TARGET_MOVIECLIP]._x;
                break;
            } 
            default:
            {
                com.clubpenguin.games.dancing.Note.debugTrace("note type " + noteType + " is unknown!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                break;
            } 
        } // End of switch
        pressTime = com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED;
        releaseTime = com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED;
    } // End of the function
    function update(currentTimeMillis)
    {
        this.setNotePosition(currentTimeMillis);
        if (noteYPos + noteHeight > parentMovie[com.clubpenguin.games.dancing.Note.END_MOVIECLIP]._y && noteYPos < parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y)
        {
            if (movie == undefined)
            {
                this.addNote();
            } // end if
            if (this.getNotePressResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
            {
                this.updateNote();
            }
            else if (noteDuration > 0)
            {
                this.resizeNote(currentTimeMillis);
            } // end else if
        }
        else if (this.getNotePressResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED && movie != undefined)
        {
            this.destroy();
            return (false);
        }
        else
        {
            this.destroy();
        } // end else if
        return (true);
    } // End of the function
    function addNote()
    {
        var _loc6 = "note_" + noteType + "_" + Math.round(noteTime);
        var _loc5 = parentMovie.getNextHighestDepth();
        var _loc2;
        if (noteDuration > 0)
        {
            movie = parentMovie.createEmptyMovieClip(_loc6, _loc5);
            var _loc3;
            var _loc4;
            switch (noteType)
            {
                case com.clubpenguin.games.dancing.Note.TYPE_LEFT:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.LEFT_NOTE_MOVIECLIP;
                    _loc3 = com.clubpenguin.games.dancing.Note.LEFT_BASE_MOVIECLIP;
                    _loc4 = com.clubpenguin.games.dancing.Note.LEFT_STEM_MOVIECLIP;
                    break;
                } 
                case com.clubpenguin.games.dancing.Note.TYPE_RIGHT:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.RIGHT_NOTE_MOVIECLIP;
                    _loc3 = com.clubpenguin.games.dancing.Note.RIGHT_BASE_MOVIECLIP;
                    _loc4 = com.clubpenguin.games.dancing.Note.RIGHT_STEM_MOVIECLIP;
                    break;
                } 
                case com.clubpenguin.games.dancing.Note.TYPE_UP:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.UP_NOTE_MOVIECLIP;
                    _loc3 = com.clubpenguin.games.dancing.Note.UP_BASE_MOVIECLIP;
                    _loc4 = com.clubpenguin.games.dancing.Note.UP_STEM_MOVIECLIP;
                    break;
                } 
                case com.clubpenguin.games.dancing.Note.TYPE_DOWN:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.DOWN_NOTE_MOVIECLIP;
                    _loc3 = com.clubpenguin.games.dancing.Note.DOWN_BASE_MOVIECLIP;
                    _loc4 = com.clubpenguin.games.dancing.Note.DOWN_STEM_MOVIECLIP;
                    break;
                } 
                default:
                {
                    com.clubpenguin.games.dancing.Note.debugTrace("note type " + noteType + " is unknown!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                    break;
                } 
            } // End of switch
            movie.attachMovie(_loc3, com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP, 1);
            movie.attachMovie(_loc4, com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP, 2);
            movie.attachMovie(_loc2, com.clubpenguin.games.dancing.Note.TOP_MOVIECLIP, 3);
            movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = noteHeight;
            movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._y = noteHeight;
            if (noteType == com.clubpenguin.games.dancing.Note.TYPE_DOWN)
            {
                movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height - com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT;
                movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._y = movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._y + com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT;
            } // end if
        }
        else
        {
            switch (noteType)
            {
                case com.clubpenguin.games.dancing.Note.TYPE_LEFT:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.LEFT_NOTE_MOVIECLIP;
                    break;
                } 
                case com.clubpenguin.games.dancing.Note.TYPE_RIGHT:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.RIGHT_NOTE_MOVIECLIP;
                    break;
                } 
                case com.clubpenguin.games.dancing.Note.TYPE_UP:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.UP_NOTE_MOVIECLIP;
                    break;
                } 
                case com.clubpenguin.games.dancing.Note.TYPE_DOWN:
                {
                    _loc2 = com.clubpenguin.games.dancing.Note.DOWN_NOTE_MOVIECLIP;
                    break;
                } 
                default:
                {
                    com.clubpenguin.games.dancing.Note.debugTrace("note type " + noteType + " is unknown!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                    break;
                } 
            } // End of switch
            movie = parentMovie.attachMovie(_loc2, _loc6, _loc5);
            com.clubpenguin.games.dancing.Note.debugTrace("make new note movie: " + parentMovie + " attach " + _loc2 + " as " + _loc6 + " at " + _loc5, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
        } // end else if
    } // End of the function
    function resizeNote(currentTimeMillis)
    {
        if (this.getNoteReleaseResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
        {
            var _loc4 = parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y - parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y;
            var _loc3 = noteDuration + pressTime - currentTimeMillis;
            var _loc2 = _loc4 * _loc3 / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
            if (_loc2 >= 0)
            {
                movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = _loc2;
                if (noteType == com.clubpenguin.games.dancing.Note.TYPE_DOWN)
                {
                    movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height = movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height - com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT;
                    if (movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._height <= com.clubpenguin.games.dancing.Note.DOWN_ARROW_YSHIFT)
                    {
                        movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._visible = false;
                        movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._visible = false;
                    } // end if
                } // end if
                movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._y = _loc2;
            }
            else
            {
                movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP]._visible = false;
                movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP]._visible = false;
                this.handleNoteReleaseEvent(currentTimeMillis);
                autoReleased = true;
            } // end if
        } // end else if
    } // End of the function
    function updateNote()
    {
        movie._x = noteXPos;
        movie._y = noteYPos;
    } // End of the function
    function destroy()
    {
        if (movie != undefined)
        {
            movie.removeMovieClip();
            movie = undefined;
        } // end if
    } // End of the function
    function setNotePosition(currentTimeMillis)
    {
        noteYPos = parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y + this.getDistanceFromTarget(currentTimeMillis);
    } // End of the function
    function handleNotePressEvent(timePressedMillis)
    {
        if (pressTime != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_ALREADY_PRESSED);
        }
        else
        {
            pressTime = timePressedMillis;
            if (movie == undefined)
            {
                com.clubpenguin.games.dancing.Note.debugTrace("note is undefined on note press event!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            }
            else if (noteDuration == 0)
            {
                movie.gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HIT);
            }
            else
            {
                movie[com.clubpenguin.games.dancing.Note.TOP_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HOLD);
                movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HOLD);
                movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_HOLD);
            } // end else if
            com.clubpenguin.games.dancing.Note.debugTrace("press distance from target is " + this.getDistanceFromTarget());
            return (this.getNotePressResult());
        } // end else if
    } // End of the function
    function getNotePressResult()
    {
        if (pressTime == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED);
        } // end if
        var _loc2 = Math.abs(this.getDistanceFromTarget(pressTime));
        if (_loc2 < 5)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_PERFECT);
        }
        else if (_loc2 < 10)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_GREAT);
        }
        else if (_loc2 < 25)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_GOOD);
        }
        else if (_loc2 < 50)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_ALMOST);
        }
        else
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_BOO);
        } // end else if
    } // End of the function
    function handleNoteReleaseEvent(timeReleasedMillis)
    {
        if (releaseTime != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_ALREADY_PRESSED);
        }
        else if (pressTime == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
        {
            com.clubpenguin.games.dancing.Note.debugTrace("note not pressed yet - attempting to release on unpressed note!");
            return (com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED);
        }
        else
        {
            releaseTime = timeReleasedMillis;
            if (movie == undefined)
            {
                com.clubpenguin.games.dancing.Note.debugTrace("note is undefined on note release event!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            }
            else if (noteDuration > 0)
            {
                movie[com.clubpenguin.games.dancing.Note.BASE_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_FADE);
                movie[com.clubpenguin.games.dancing.Note.STEM_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_FADE);
                movie[com.clubpenguin.games.dancing.Note.TOP_MOVIECLIP].gotoAndPlay(com.clubpenguin.games.dancing.Note.ANIMATION_FADE);
            } // end else if
            com.clubpenguin.games.dancing.Note.debugTrace("release distance from target is " + this.getReleaseDistanceFromTarget());
            com.clubpenguin.games.dancing.Note.debugTrace("note hold length is " + this.getNoteHoldLength());
            return (this.getNoteHoldLength());
        } // end else if
    } // End of the function
    function getNoteReleaseResult()
    {
        if (releaseTime == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED);
        } // end if
        var _loc2 = Math.abs(this.getReleaseDistanceFromTarget(releaseTime));
        if (_loc2 < 5)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_PERFECT);
        }
        else if (_loc2 < 10)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_GREAT);
        }
        else if (_loc2 < 25)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_GOOD);
        }
        else if (_loc2 < 50)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_ALMOST);
        }
        else
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_BOO);
        } // end else if
    } // End of the function
    function getNoteHoldLength()
    {
        var _loc2 = releaseTime - pressTime;
        if (_loc2 > noteDuration)
        {
            _loc2 = noteDuration;
        } // end if
        return (_loc2);
    } // End of the function
    function getDistanceFromTarget(currentTimeMillis)
    {
        if (currentTimeMillis == undefined)
        {
            currentTimeMillis = pressTime;
        } // end if
        var _loc2 = parentMovie[com.clubpenguin.games.dancing.Note.START_MOVIECLIP]._y - parentMovie[com.clubpenguin.games.dancing.Note.TARGET_MOVIECLIP]._y;
        var _loc4 = (noteTime - currentTimeMillis) / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
        return (_loc2 * _loc4);
    } // End of the function
    function getReleaseDistanceFromTarget(currentTimeMillis)
    {
        if (currentTimeMillis == undefined)
        {
            currentTimeMillis = releaseTime;
        } // end if
        return (this.getDistanceFromTarget(currentTimeMillis - noteDuration));
    } // End of the function
    function getDuration()
    {
        return (noteDuration);
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace("(Note) " + message, priority);
        } // end if
    } // End of the function
    static var TYPE_LEFT = 0;
    static var TYPE_RIGHT = 1;
    static var TYPE_UP = 2;
    static var TYPE_DOWN = 3;
    static var RESULT_PERFECT = 0;
    static var RESULT_GREAT = 1;
    static var RESULT_GOOD = 2;
    static var RESULT_ALMOST = 3;
    static var RESULT_BOO = 4;
    static var RESULT_MISS = 5;
    static var RESULT_NOT_PRESSED = -1;
    static var RESULT_ALREADY_PRESSED = -2;
    static var RESULT_UNKNOWN = -3;
    static var LEFT_NOTE_MOVIECLIP = "notePressLeft";
    static var RIGHT_NOTE_MOVIECLIP = "notePressRight";
    static var UP_NOTE_MOVIECLIP = "notePressUp";
    static var DOWN_NOTE_MOVIECLIP = "notePressDown";
    static var LEFT_BASE_MOVIECLIP = "noteBaseLeft";
    static var RIGHT_BASE_MOVIECLIP = "noteBaseRight";
    static var UP_BASE_MOVIECLIP = "noteBaseUp";
    static var DOWN_BASE_MOVIECLIP = "noteBaseDown";
    static var LEFT_STEM_MOVIECLIP = "noteStemLeft";
    static var RIGHT_STEM_MOVIECLIP = "noteStemRight";
    static var UP_STEM_MOVIECLIP = "noteStemUp";
    static var DOWN_STEM_MOVIECLIP = "noteStemDown";
    static var BASE_MOVIECLIP = "noteBase";
    static var STEM_MOVIECLIP = "noteStem";
    static var TOP_MOVIECLIP = "noteTop";
    static var ANIMATION_HIT = "hit";
    static var ANIMATION_HOLD = "hold";
    static var ANIMATION_FADE = "fade";
    static var LEFT_TARGET_MOVIECLIP = "noteTargetLeft";
    static var RIGHT_TARGET_MOVIECLIP = "noteTargetRight";
    static var UP_TARGET_MOVIECLIP = "noteTargetUp";
    static var DOWN_TARGET_MOVIECLIP = "noteTargetDown";
    static var START_MOVIECLIP = "noteStart";
    static var TARGET_MOVIECLIP = "noteTarget";
    static var END_MOVIECLIP = "noteFade";
    static var DOWN_ARROW_YSHIFT = 6;
} // End of Class
