class com.clubpenguin.games.dancing.data.SongData
{
    function SongData()
    {
    } // End of the function
    static function getSongData($song, $difficulty)
    {
        var _loc2 = com.clubpenguin.games.dancing.data.SongData.getSongLength($song);
        var _loc4 = com.clubpenguin.games.dancing.data.SongData.getMillisPerBar($song);
        var _loc1 = _loc4 / com.clubpenguin.games.dancing.data.SongData.BEATS_PER_BAR;
        switch ($song)
        {
            case com.clubpenguin.games.dancing.GameEngine.SONG_ONE:
            {
                switch ($difficulty)
                {
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                    {
                        return (com.clubpenguin.games.dancing.data.Song1Easy.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                    {
                        return (com.clubpenguin.games.dancing.data.Song1Medium.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                    {
                        return (com.clubpenguin.games.dancing.data.Song1Hard.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                    {
                        return (com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1, _loc2));
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_TWO:
            {
                switch ($difficulty)
                {
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                    {
                        return (com.clubpenguin.games.dancing.data.Song2Easy.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                    {
                        return (com.clubpenguin.games.dancing.data.Song2Medium.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                    {
                        return (com.clubpenguin.games.dancing.data.Song2Hard.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                    {
                        return (com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1, _loc2));
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_THREE:
            {
                switch ($difficulty)
                {
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                    {
                        return (com.clubpenguin.games.dancing.data.Song3Easy.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                    {
                        return (com.clubpenguin.games.dancing.data.Song3Medium.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                    {
                        return (com.clubpenguin.games.dancing.data.Song3Hard.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                    {
                        return (com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1, _loc2));
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR:
            {
                switch ($difficulty)
                {
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                    {
                        return (com.clubpenguin.games.dancing.data.Song4Easy.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                    {
                        return (com.clubpenguin.games.dancing.data.Song4Medium.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                    {
                        return (com.clubpenguin.games.dancing.data.Song4Hard.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                    {
                        return (com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1, _loc2));
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE:
            {
                switch ($difficulty)
                {
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                    {
                        return (com.clubpenguin.games.dancing.data.Song5Easy.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                    {
                        return (com.clubpenguin.games.dancing.data.Song5Medium.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                    {
                        return (com.clubpenguin.games.dancing.data.Song5Hard.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                    {
                        return (com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1, _loc2));
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_SIX:
            {
                switch ($difficulty)
                {
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY:
                    {
                        return (com.clubpenguin.games.dancing.data.Song6Easy.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM:
                    {
                        return (com.clubpenguin.games.dancing.data.Song6Medium.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD:
                    {
                        return (com.clubpenguin.games.dancing.data.Song6Hard.getSongData(_loc1));
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT:
                    {
                        return (com.clubpenguin.games.dancing.data.SongData.getExpertSongData(_loc1, _loc2));
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
        return;
    } // End of the function
    static function getMillisPerBar($song)
    {
        switch ($song)
        {
            case com.clubpenguin.games.dancing.GameEngine.SONG_ONE:
            {
                return (2000);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_TWO:
            {
                return (2070);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_THREE:
            {
                return (2666);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR:
            {
                return (1714);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE:
            {
                return (2181);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_SIX:
            {
                return (2790);
            } 
        } // End of switch
        return;
    } // End of the function
    static function getSongLength($song)
    {
        switch ($song)
        {
            case com.clubpenguin.games.dancing.GameEngine.SONG_ONE:
            {
                return (241);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_TWO:
            {
                return (221);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_THREE:
            {
                return (176);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR:
            {
                return (288);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE:
            {
                return (248);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_SIX:
            {
                return (168);
            } 
        } // End of switch
        return;
    } // End of the function
    static function getSongLengthMillis($song)
    {
        switch ($song)
        {
            case com.clubpenguin.games.dancing.GameEngine.SONG_ONE:
            {
                return (123000);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_TWO:
            {
                return (117000);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_THREE:
            {
                return (124000);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR:
            {
                return (130000);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE:
            {
                return (139000);
            } 
            case com.clubpenguin.games.dancing.GameEngine.SONG_SIX:
            {
                return (118000);
            } 
        } // End of switch
        return;
    } // End of the function
    static function getExpertSongData($millisPerBeat, $songLength)
    {
        var _loc4 = new Array();
        var _loc3 = new Array();
        var _loc2 = new Array();
        var _loc5 = new Array(0, 0, 0, 0);
        for (var _loc1 = 4; _loc1 < $songLength; ++_loc1)
        {
            if (_loc1 % 8 == 0)
            {
                com.clubpenguin.games.dancing.data.SongData.addNote(_loc1, 4, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
                if (Math.floor(Math.random() * 2) == 0)
                {
                    com.clubpenguin.games.dancing.data.SongData.addNote(_loc1, 0, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
                } // end if
                continue;
            } // end if
            if (_loc1 % 4 == 0)
            {
                com.clubpenguin.games.dancing.data.SongData.addNote(_loc1, 4, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
                if (Math.floor(Math.random() * 4) == 0)
                {
                    com.clubpenguin.games.dancing.data.SongData.addNote(_loc1, 0, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
                } // end if
                continue;
            } // end if
            if (_loc1 % 2 == 0)
            {
                com.clubpenguin.games.dancing.data.SongData.addNote(_loc1, 2, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
                continue;
            } // end if
            if (Math.floor(Math.random() * 4) > 0)
            {
                com.clubpenguin.games.dancing.data.SongData.addNote(_loc1, 0, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
                if (Math.floor(Math.random() * 4) == 0)
                {
                    com.clubpenguin.games.dancing.data.SongData.addNote(_loc1 + 5.000000E-001, 0, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
                } // end if
            } // end if
        } // end of for
        com.clubpenguin.games.dancing.data.SongData.addNote($songLength, 0, _loc5, $millisPerBeat, _loc2, _loc3, _loc4);
        return (new Array(_loc2, _loc3, _loc4));
    } // End of the function
    static function addNote($beatTime, $maxBeatLength, $lastNoteTimes, $millisPerBeat, $noteTypes, $noteTimes, $noteLengths)
    {
        var _loc3 = Math.floor(Math.random() * $maxBeatLength) * $millisPerBeat;
        var _loc2 = $beatTime * $millisPerBeat;
        var _loc1 = Math.floor(Math.random() * 4);
        if (_loc2 > $lastNoteTimes[_loc1])
        {
            $noteTypes.push(_loc1);
            $noteTimes.push(_loc2);
            $noteLengths.push(_loc3);
            $lastNoteTimes[_loc1] = _loc2 + _loc3;
        } // end if
    } // End of the function
    static var BEATS_PER_BAR = 4;
} // End of Class
