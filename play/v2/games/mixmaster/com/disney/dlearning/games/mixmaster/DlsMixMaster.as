class com.disney.dlearning.games.mixmaster.DlsMixMaster
{
    function DlsMixMaster(learnerID)
    {
        com.disney.dlearning.managers.DLSManager.init(learnerID, "k.api.dlsnetwork.com");
    } // End of the function
    function init()
    {
        var _loc7 = new Object();
        _loc7.onPlaySoundStarted = com.clubpenguin.util.Delegate.create(this, onPlaySoundStarted);
        com.clubpenguin.util.SoundControl.addEventListener(com.clubpenguin.util.SoundControl.EVENT_PLAY_SOUND_STARTED, _loc7);
        this.selectSong();
        this.startDJ3K();
    } // End of the function
    function startDJ3K()
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("start", __DJ3K, callbackFunc, null);
    } // End of the function
    function stopDJ3K()
    {
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("stop", __DJ3K, callbackFunc, null);
    } // End of the function
    function selectSong()
    {
        var _loc7 = "";
        switch (_global.dls_mixmaster_song)
        {
            case "brazil":
            {
                _loc7 = __Festival_Sound_Pack;
                break;
            } 
            case "south_asian":
            {
                _loc7 = __Desibel_South_Asian_Sound_Pack;
                break;
            } 
            case "default":
            {
                _loc7 = __Classic_Default_Sound_Pack;
                break;
            } 
            case "drum_n_bass":
            {
                _loc7 = __Jungle_Song_Sound_Pack;
                break;
            } 
            case "funk":
            {
                _loc7 = __Funky_Sound_Pack;
                break;
            } 
            case "oldschool":
            {
                _loc7 = __House_Blend_Old_Skool_Sound_Pack;
                break;
            } 
            case "reggae":
            {
                _loc7 = __Reggae_Sound_Pack;
                break;
            } 
        } // End of switch
        if (_loc7 != "")
        {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", _loc7, callbackFunc, null);
        } // end if
    } // End of the function
    function onPlaySoundStarted(obj)
    {
        this.playedSong(obj.soundName);
    } // End of the function
    function playedSong(songName)
    {
        var _loc7 = "";
        switch (songName)
        {
            case "rackButton17":
            case "rackButton18":
            case "rackButton19":
            {
                _loc7 = __Bassline_Tape_Decks_Buttons;
                break;
            } 
            case "effectRewindDeck5":
            case "effectRewindDeck3":
            case "effectRewindDeck11":
            case "effectRewindDeck1":
            case "effectRewindDeck7":
            case "effectRewindDeck2":
            case "effectRewindDeck4":
            case "effectRewindDeck6":
            case "effectRewindDeck8":
            {
                _loc7 = __Mixer_Buttons;
                break;
            } 
            case "rackButton6":
            case "rackButton7":
            case "rackButton8":
            case "rackButton9":
            case "rackButton10":
            case "rackButton11":
            {
                _loc7 = __Drum_Loop_Rack_Buttons;
                break;
            } 
            case "keyCLow":
            case "keyCSharp":
            case "keyD":
            case "keyDSharp":
            case "keyE":
            case "keyF":
            case "keyFSharp":
            case "keyG":
            case "keyGSharp":
            case "keyA":
            case "keyASharp":
            case "keyB":
            case "keyCHigh":
            {
                if (_lastKeyboardKey != songName)
                {
                    _lastKeyboardKey = songName;
                    _loc7 = __Keyboard_Keys;
                } // end if
                break;
            } 
            case "rackSlider":
            {
                _loc7 = __Music_Loop_Volume_Controls_Buttons;
                break;
            } 
            case "effectRewindDeck9":
            case "effectRewindDeck10":
            {
                _loc7 = __Turntables_Buttons;
                break;
            } 
            case "effectKlaxon":
            case "effectCowbell":
            case "effectCops":
            case "effectEep":
            case "effectWhistle":
            {
                _loc7 = __Right_Speaker_Buttons;
                break;
            } 
            case "effectChopDmShort":
            case "effectWahDmShort":
            case "effectChopAmShort":
            case "effectRideReverse":
            case "effectRide":
            case "effectWahAm7Long":
            case "effectWahDm7Long":
            case "effectJungleBird":
            {
                _loc7 = __Top_Left_Rack_Buttons;
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
        if (_loc7 != "")
        {
            com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode("selected", _loc7, callbackFunc, null);
        } // end if
    } // End of the function
    function callbackFunc(obj)
    {
    } // End of the function
    var __DJ3K = "7BCB9DC5-0513-69D6-7060-CE92C05E6A3B";
    var __Classic_Default_Sound_Pack = "F6C61C3C-52C7-2E10-7744-EA7EBCB4F0CB";
    var __Jungle_Song_Sound_Pack = "B1B0DBF6-45FE-85A9-B490-6123AF5669CD";
    var __Funky_Sound_Pack = "08BA2C9F-D396-F68C-54AD-F785820A4C25";
    var __Festival_Sound_Pack = "69E38B81-C57B-3D1B-0B9A-150E70F823D1";
    var __Desibel_South_Asian_Sound_Pack = "5C3805BD-3519-ED8D-6C8D-086D246B2922";
    var __House_Blend_Old_Skool_Sound_Pack = "714475DF-B6B2-56B3-0D80-40DCBF30E1CF";
    var __Reggae_Sound_Pack = "981E3887-7E73-D97B-7CC7-2DD041B91B54";
    var __Top_Left_Rack_Buttons = "D7C75D84-A0E7-9395-6446-5291EA9A82D6";
    var __Bassline_Tape_Decks_Buttons = "65AD9BC5-CAE2-5F51-BF88-68FD9B6CEABB";
    var __Drum_Loop_Rack_Buttons = "13CB904D-519D-A8E5-E786-EF7A659FE5D1";
    var __Music_Loop_Volume_Controls_Buttons = "F309C86B-15A4-CF27-1119-3190A0D113C5";
    var __Turntables_Buttons = "1A2C99E9-8BFD-A887-C261-1B739C78ECE3";
    var __Mixer_Buttons = "ACA3FAC2-0045-1A5D-1685-19E676ED1882";
    var __Right_Speaker_Buttons = "CFABC6C4-8BE1-62BB-C5D9-36B639D95D9A";
    var __Keyboard_Keys = "0E84420A-C01E-A402-00B1-7224A2BD8F0E";
    var dls = com.disney.dlearning.managers.DLSManager;
    var _lastKeyboardKey = "";
} // End of Class
