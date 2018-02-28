class com.clubpenguin.games.dancing.NoteManager
{
    var movie, noteData;
    function NoteManager(movieClip)
    {
        movie = movieClip;
        movie._visible = false;
    } // End of the function
    function init($noteTypes, $noteTimes, $noteLengths, $timeOnScreen)
    {
        if ($timeOnScreen != undefined)
        {
            TIME_ON_SCREEN = $timeOnScreen;
        } // end if
        if ($noteTypes.length != $noteTimes.length)
        {
            com.clubpenguin.games.dancing.NoteManager.debugTrace("note manager data arrays are different sizes!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            return;
        } // end if
        noteData = new Array();
        var _loc2;
        for (var _loc6 in $noteTypes)
        {
            _loc2 = Math.floor($noteTimes[_loc6] / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS);
            if (noteData[_loc2] == undefined)
            {
                noteData[_loc2] = new Array();
            } // end if
            com.clubpenguin.games.dancing.NoteManager.debugTrace("add new note to subarray " + _loc2, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            noteData[_loc2].push(new com.clubpenguin.games.dancing.Note(movie, $noteTypes[_loc6], $noteTimes[_loc6], $noteLengths[_loc6]));
        } // end of for...in
        movie._visible = true;
    } // End of the function
    function update(elapsedTime)
    {
        var _loc4 = new Array();
        var _loc5 = Math.floor(elapsedTime / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
        var _loc8 = 3;
        var _loc9;
        for (var _loc2 = _loc5; _loc2 < _loc5 + _loc8; ++_loc2)
        {
            com.clubpenguin.games.dancing.NoteManager.debugTrace("update subarray " + _loc2, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            for (var _loc7 in noteData[_loc2])
            {
                var _loc3 = noteData[_loc2][_loc7].update(elapsedTime);
                if (_loc3 == false)
                {
                    _loc4.push(noteData[_loc2][_loc7]);
                } // end if
            } // end of for...in
        } // end of for
        return (_loc4);
    } // End of the function
    function destroy()
    {
        for (var _loc3 in noteData)
        {
            for (var _loc2 in noteData[_loc3])
            {
                noteData[_loc3][_loc2].destroy();
            } // end of for...in
        } // end of for...in
    } // End of the function
    function hide()
    {
        movie._visible = false;
    } // End of the function
    function getClosestValidNote(noteType, elapsedTime)
    {
        var _loc7 = Math.floor(elapsedTime / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
        var _loc10 = 3;
        var _loc3;
        var _loc5;
        var _loc4;
        for (var _loc2 = _loc7; _loc2 < _loc7 + _loc10; ++_loc2)
        {
            for (var _loc9 in noteData[_loc2])
            {
                if (noteData[_loc2][_loc9].noteType == noteType)
                {
                    if (noteData[_loc2][_loc9].getNotePressResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
                    {
                        _loc4 = Math.abs(noteData[_loc2][_loc9].getDistanceFromTarget(elapsedTime));
                        com.clubpenguin.games.dancing.NoteManager.debugTrace("current note is noteData[" + _loc2 + "][" + _loc9 + "], " + "distance is " + _loc4, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                        if (_loc3 == undefined || _loc4 < _loc5)
                        {
                            com.clubpenguin.games.dancing.NoteManager.debugTrace("new closest note found!", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                            _loc3 = noteData[_loc2][_loc9];
                            _loc5 = Math.abs(_loc3.getDistanceFromTarget(elapsedTime));
                        } // end if
                    } // end if
                } // end if
            } // end of for...in
        } // end of for
        return (_loc3);
    } // End of the function
    function handleNotePress($noteType, $elapsedTime, $closestNote)
    {
        var _loc2;
        if ($closestNote == undefined)
        {
            _loc2 = this.getClosestValidNote($noteType, $elapsedTime);
        }
        else
        {
            _loc2 = $closestNote;
        } // end else if
        if (_loc2 == undefined)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN);
        }
        else
        {
            var _loc3 = Math.abs(_loc2.getDistanceFromTarget($elapsedTime));
            if (_loc3 < com.clubpenguin.games.dancing.NoteManager.MAX_DISTANCE_FROM_TARGET)
            {
                return (_loc2.handleNotePressEvent($elapsedTime));
            }
            else
            {
                com.clubpenguin.games.dancing.NoteManager.debugTrace("note was missed! distance = " + _loc3);
                return (com.clubpenguin.games.dancing.Note.RESULT_MISS);
            } // end else if
        } // end else if
    } // End of the function
    function handleNoteRelease(noteType, elapsedTime)
    {
        var _loc7 = Math.floor(elapsedTime / com.clubpenguin.games.dancing.NoteManager.NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
        var _loc10 = 3;
        var _loc3;
        var _loc5;
        var _loc4;
        for (var _loc2 = _loc7; _loc2 < _loc7 + _loc10; ++_loc2)
        {
            for (var _loc9 in noteData[_loc2])
            {
                if (noteData[_loc2][_loc9].noteType == noteType)
                {
                    if (noteData[_loc2][_loc9].getDuration() > 0 && noteData[_loc2][_loc9].getNotePressResult() != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED && noteData[_loc2][_loc9].getNoteReleaseResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)
                    {
                        _loc4 = Math.abs(noteData[_loc2][_loc9].getReleaseDistanceFromTarget(elapsedTime));
                        com.clubpenguin.games.dancing.NoteManager.debugTrace("current note is noteData[" + _loc2 + "][" + _loc9 + "], " + "distance is " + _loc4, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                        if (_loc3 == undefined || _loc4 < _loc5)
                        {
                            com.clubpenguin.games.dancing.NoteManager.debugTrace("new closest note found!", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                            _loc3 = noteData[_loc2][_loc9];
                            _loc5 = Math.abs(_loc3.getReleaseDistanceFromTarget(elapsedTime));
                        } // end if
                    } // end if
                } // end if
            } // end of for...in
        } // end of for
        if (_loc3 == undefined)
        {
            return (com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN);
        }
        else if (_loc5 < com.clubpenguin.games.dancing.NoteManager.MAX_DISTANCE_FROM_TARGET)
        {
            return (_loc3.handleNoteReleaseEvent(elapsedTime));
        }
        else
        {
            com.clubpenguin.games.dancing.NoteManager.debugTrace("note release was missed! distance = " + _loc5);
            return (com.clubpenguin.games.dancing.Note.RESULT_MISS);
        } // end else if
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace("(NoteManager) " + message, priority);
        } // end if
    } // End of the function
    static var NOTE_ARRAY_SUBDIVISION_MILLIS = 10000;
    static var TIME_ON_SCREEN = 3500;
    static var MAX_DISTANCE_FROM_TARGET = 100;
} // End of Class
