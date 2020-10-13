class com.clubpenguin.games.dancing.MenuSystem
{
    var movie, gameEngine, keyPressTest;
    function MenuSystem($parent, $movie)
    {
        movie = $movie;
        gameEngine = $parent;
        movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_LOADING]._visible = false;
        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO);
    } // End of the function
    function getCurrentMenu()
    {
        return (currentMenu);
    } // End of the function
    function loadMenu($menuID)
    {
        if ($menuID == undefined)
        {
            ++currentMenu;
        }
        else
        {
            currentMenu = $menuID;
        } // end else if
        switch (currentMenu)
        {
            case com.clubpenguin.games.dancing.MenuSystem.MENU_NONE:
            {
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_START_SONG:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_START_MULTIPLAYER_SONG:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_OFF);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_ON);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].nextMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                switch (gameEngine.allSongsLoaded())
                {
                    case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK:
                    {
                        this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_welcome_intro"));
                        break;
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR:
                    {
                        this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_loading_songs_error"));
                        break;
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS:
                    {
                        this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_loading_songs"));
                        break;
                    } 
                } // End of switch
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                var _loc6 = com.clubpenguin.util.LocaleText.getText("menu_welcome_item_multiplayer");
                if (com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK)
                {
                    _loc6 = "    " + _loc6;
                    movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                    movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_MEMBERS_ONLY_ICON);
                } // end if
                var _loc3 = new Array();
                _loc3.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_singleplayer"));
                _loc3.push(_loc6);
                _loc3.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_howtoplay"));
                _loc3.push(com.clubpenguin.util.LocaleText.getText("menu_welcome_item_quit"));
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_welcome_choice"));
                this.showMenuOptions(_loc3);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_INTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_intro") + "\n" + gameEngine.getRandomTipText(true));
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_song_choice"));
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_PREGAME_CHOOSE_SONG);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                var _loc2 = new Array();
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_easy"));
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_medium"));
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_hard"));
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_song_item_back"));
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice"));
                this.showMenuOptions(_loc2);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_SECRET_DIFFICULTY);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY_SECRET:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                _loc2 = new Array();
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_confirm_secret"));
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_change"));
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice_secret"));
                this.showMenuOptions(_loc2);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_pregame"));
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_INTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_ON);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].nextMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_COINSWON;
                gameEngine.playApplause();
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_COINSWON:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(gameEngine.getJudgesOpinion());
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                var _loc4 = new Array();
                _loc4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_viewstats"));
                _loc4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_playagain"));
                _loc4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_newsong"));
                _loc4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_mainmenu"));
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_postgame"));
                this.showMenuOptions(_loc4);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_STATS:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                this.showSpeechBubble(gameEngine.getPostGameStatsSpeechBubble());
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_POSTGAME_STATS);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO_WALK:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_ON);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_intro"));
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING_ANIM:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_HITNOTE);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_timing"));
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_ANIM:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_TWOATONCE);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_multiple"));
                this.hideMenuOptions();
                keyPressTest = [false, false];
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_ANIM:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_HOLDNOTE);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_hold"));
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_ANIM:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HOWTOPLAY_COMBO);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_multiplier"));
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].animation.play();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_TALK);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_howtoplay_outro"));
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO_WALK:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_HELP_OFF);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_CONNECTING:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOINING:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkFinish");
                this.hideSpeechBubble();
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_PRE_QUEUE:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(gameEngine.getJoinGameSpeechBubble());
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(gameEngine.getWaitingSpeechBubble());
                var _loc7 = new Array();
                var _loc5 = com.clubpenguin.util.LocaleText.getText("menu_difficulty_change");
                _loc5 = _loc5.substring(0, _loc5.length - 1);
                _loc7.push(_loc5 + " " + gameEngine.getCurrentDifficulty());
                _loc7.push(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_response_mainmenu"));
                this.showMenuOptions(_loc7);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_multiplayer_serverfull"));
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_INTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                _loc2 = new Array();
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_easy"));
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_medium"));
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_hard"));
                _loc2.push(com.clubpenguin.util.LocaleText.getText("menu_difficulty_item_expert"));
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_difficulty_choice"));
                this.showMenuOptions(_loc2);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_INTRO:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WALK_ON);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].nextMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_COINSWON;
                this.hideSpeechBubble();
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_COINSWON:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(gameEngine.getMultiplayerCoinsWon());
                this.hideMenuOptions();
                gameEngine.setMultiplayerScoreVisibility(false);
                gameEngine.hideDancer();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_WAIT);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].animation.movie.gotoAndPlay("talkStart");
                _loc4 = new Array();
                _loc4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_viewstats"));
                _loc4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_joinqueue"));
                _loc4.push(com.clubpenguin.util.LocaleText.getText("menu_postgame_mainmenu"));
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("menu_singleplayer_postgame"));
                this.showMenuOptions(_loc4);
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = false;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(1);
                gameEngine.setMultiplayerScoreVisibility(false);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_STATS:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(gameEngine.getPostGameStatsSpeechBubble());
                this.hideMenuOptions();
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM]._visible = true;
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOW_TO_PLAY_ANIM].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_POSTGAME_STATS);
                gameEngine.setMultiplayerScoreVisibility(true);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_ROOM_FULL:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("error_message_room_full"));
                this.hideMenuOptions();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_MULTIPLE_CONNECTIONS:
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_HOST_COMPERE].gotoAndStop(com.clubpenguin.games.dancing.MenuSystem.ANIM_FRAME_TALK);
                this.showSpeechBubble(com.clubpenguin.util.LocaleText.getText("error_message_multiple_connections"));
                this.hideMenuOptions();
                break;
            } 
            default:
            {
                com.clubpenguin.games.dancing.MenuSystem.debugTrace("unknown menu id entered: " + currentMenu, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                break;
            } 
        } // End of switch
    } // End of the function
    function handleClick($buttonID)
    {
        var _loc5 = _global.getCurrentShell();
        var _loc4 = _global.getCurrentInterface();
        switch (currentMenu)
        {
            case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_INTRO:
            {
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME:
            {
                switch (gameEngine.allSongsLoaded())
                {
                    case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_OK:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                        break;
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_ERROR:
                    {
                        gameEngine.destroy();
                        break;
                    } 
                    case com.clubpenguin.games.dancing.GameEngine.SONG_LOAD_IN_PROGRESS:
                    {
                        break;
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS:
            {
                _global.dls_dance._seenInstructions = false;
                switch ($buttonID)
                {
                    case 1:
                    {
                        _global.dls_dance.setGameType(false);
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_INTRO);
                        break;
                    } 
                    case 2:
                    {
                        if (!com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK || gameEngine.isMember())
                        {
                            _global.dls_dance.setGameType(true);
                            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_INTRO);
                        }
                        else
                        {
                            _loc4.showContent(com.clubpenguin.games.dancing.MenuSystem.OOPS_SCREEN_ID_MULTIPLAYER);
                        } // end else if
                        break;
                    } 
                    case 3:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO_WALK);
                        break;
                    } 
                    case 4:
                    {
                        gameEngine.destroy();
                        break;
                    } 
                    default:
                    {
                        return;
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_INTRO:
            {
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG:
            {
                if ($buttonID == 1)
                {
                    if (gameEngine.currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_FOUR || gameEngine.currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_FIVE || gameEngine.currentSong == com.clubpenguin.games.dancing.GameEngine.SONG_SIX)
                    {
                        if (!com.clubpenguin.games.dancing.GameEngine.MEMBER_ONLY_CHECK || gameEngine.isMember())
                        {
                            this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY);
                        }
                        else
                        {
                            _loc4.showContent(com.clubpenguin.games.dancing.MenuSystem.OOPS_SCREEN_ID_SONGS);
                        } // end else if
                    }
                    else
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY);
                    } // end if
                } // end else if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY:
            {
                switch ($buttonID)
                {
                    case 1:
                    {
                        _global.dls_dance.setSongLevel(0);
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                        break;
                    } 
                    case 2:
                    {
                        _global.dls_dance.setSongLevel(1);
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                        break;
                    } 
                    case 3:
                    {
                        _global.dls_dance.setSongLevel(2);
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                        break;
                    } 
                    case 4:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                        return;
                    } 
                    case 5:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY_SECRET);
                        return;
                    } 
                    default:
                    {
                        return;
                    } 
                } // End of switch
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY_SECRET:
            {
                switch ($buttonID)
                {
                    case 1:
                    {
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME);
                        return;
                    } 
                    case 2:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY);
                        return;
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_PREGAME:
            {
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_START_SONG);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_COINSWON:
            {
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME);
                gameEngine.hideDancer();
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME:
            {
                switch ($buttonID)
                {
                    case 1:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_STATS);
                        break;
                    } 
                    case 2:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_DIFFICULTY);
                        break;
                    } 
                    case 3:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_SONG);
                        break;
                    } 
                    case 4:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                        break;
                    } 
                    default:
                    {
                        return;
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME_STATS:
            {
                if ($buttonID == 1)
                {
                    _global.dls_dance.startDancingStats();
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_SINGLEPLAYER_POSTGAME);
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO:
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO:
            {
                _global.dls_dance.startDancingHelp();
                this.loadMenu(currentMenu + 1);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_TIMING_KEYPRESS:
            {
                if ($buttonID == 40)
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_ANIM);
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS:
            {
                if ($buttonID == 37)
                {
                    keyPressTest[0] = true;
                    if (keyPressTest[1])
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_ANIM);
                        break;
                    } // end if
                } // end if
                if ($buttonID == 39)
                {
                    keyPressTest[1] = true;
                    if (keyPressTest[0])
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_ANIM);
                        break;
                    } // end if
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_HOLD_KEYPRESS:
            {
                if ($buttonID == 40)
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_ANIM);
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_DOWN:
            {
                if ($buttonID == 40)
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM);
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_LEFT:
            {
                if ($buttonID == 37)
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM);
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT:
            {
                if ($buttonID == 39)
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO);
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_INTRO:
            {
                switch ($buttonID)
                {
                    case 1:
                    {
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                        break;
                    } 
                    case 2:
                    {
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                        break;
                    } 
                    case 3:
                    {
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                        break;
                    } 
                    case 4:
                    {
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                        break;
                    } 
                    default:
                    {
                        return;
                    } 
                } // End of switch
                gameEngine.joinMultiplayerServer();
                gameEngine.setMultiplayerDifficulty();
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_CONNECTING);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_PRE_QUEUE:
            {
                if ($buttonID == undefined)
                {
                    return;
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME:
            {
                switch ($buttonID)
                {
                    case 1:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY);
                        break;
                    } 
                    case 2:
                    {
                        gameEngine.leaveMultiplayerServer();
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                        break;
                    } 
                    default:
                    {
                        return;
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL:
            {
                gameEngine.leaveMultiplayerServer();
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_DIFFICULTY:
            {
                switch ($buttonID)
                {
                    case 1:
                    {
                        _global.dls_dance.setSongLevel(0);
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY);
                        break;
                    } 
                    case 2:
                    {
                        _global.dls_dance.setSongLevel(1);
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM);
                        break;
                    } 
                    case 3:
                    {
                        _global.dls_dance.setSongLevel(2);
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD);
                        break;
                    } 
                    case 4:
                    {
                        _global.dls_dance.setSongLevel(3);
                        gameEngine.setDifficulty(com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT);
                        break;
                    } 
                    default:
                    {
                        return;
                    } 
                } // End of switch
                if (gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_QUEUEING)
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOIN_GAME);
                }
                else if (gameEngine.getNetClientState() == com.clubpenguin.games.dancing.DanceNetClient.STATE_DISCONNECTED)
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_SERVERFULL);
                }
                else
                {
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_JOINING);
                } // end else if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_COINSWON:
            {
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME);
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME:
            {
                switch ($buttonID)
                {
                    case 1:
                    {
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_STATS);
                        break;
                    } 
                    case 2:
                    {
                        gameEngine.rejoinMultiplayerServer();
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_CONNECTING);
                        break;
                    } 
                    case 3:
                    {
                        gameEngine.leaveMultiplayerServer();
                        this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                        break;
                    } 
                    default:
                    {
                        return;
                    } 
                } // End of switch
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME_STATS:
            {
                if ($buttonID == 1)
                {
                    _global.dls_dance.startDancingStats();
                    this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_MULTIPLAYER_POSTGAME);
                } // end if
                break;
            } 
            case com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_ROOM_FULL:
            case com.clubpenguin.games.dancing.MenuSystem.ERROR_CODE_MULTIPLE_CONNECTIONS:
            {
                this.loadMenu(com.clubpenguin.games.dancing.MenuSystem.MENU_WELCOME_OPTIONS);
                break;
            } 
        } // End of switch
    } // End of the function
    function showSpeechBubble($text)
    {
        movie.speech.message.text = $text;
        this.updateSpeechBubble();
        movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._visible = true;
        if (currentMenu >= com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_INTRO_WALK && currentMenu <= com.clubpenguin.games.dancing.MenuSystem.MENU_HOW_TO_PLAY_OUTRO_WALK)
        {
            movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._x = com.clubpenguin.games.dancing.MenuSystem.SPEECH_HELPANIM_XPOSITION;
        }
        else
        {
            movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._x = com.clubpenguin.games.dancing.MenuSystem.SPEECH_NORMAL_XPOSITION;
        } // end else if
    } // End of the function
    function hideSpeechBubble()
    {
        movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE]._visible = false;
    } // End of the function
    function updateSpeechBubble()
    {
        var _loc5 = 80;
        var _loc3 = 24;
        var _loc6 = _loc3 / 2;
        var _loc4 = 5;
        for (var _loc2 = 1; _loc2 <= _loc4; ++_loc2)
        {
            if (movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE].message.textHeight < _loc2 * _loc3 + _loc6)
            {
                movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_SPEECH_BUBBLE].bubble._height = _loc5 + _loc2 * _loc3;
                break;
            } // end if
        } // end of for
    } // End of the function
    function showMenuOptions($menuOptions)
    {
        var _loc4 = 27;
        var _loc5 = 14;
        var _loc6 = 3.500000E+000;
        movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_BACKGROUND]._height = $menuOptions.length * _loc4 + ($menuOptions.length - 1) * _loc6 + _loc5;
        var _loc2 = 0;
        while (_loc2++ < 5)
        {
            movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_ITEM + _loc2]._visible = false;
        } // end while
        for (var _loc2 = 0; _loc2 < $menuOptions.length; ++_loc2)
        {
            movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_ITEM + (_loc2 + 1)].label.text = $menuOptions[_loc2];
            movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU][com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_ITEM + (_loc2 + 1)]._visible = true;
        } // end of for
        movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU]._visible = true;
        talking = false;
    } // End of the function
    function hideMenuOptions()
    {
        movie[com.clubpenguin.games.dancing.MenuSystem.MOVIE_OPTIONS_MENU]._visible = false;
        talking = true;
    } // End of the function
    function isTalking()
    {
        return (talking);
    } // End of the function
    static function debugTrace(message, priority)
    {
        if (priority == undefined)
        {
            priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
        } // end if
        if (com.clubpenguin.util.Reporting.DEBUG)
        {
            com.clubpenguin.util.Reporting.debugTrace("(MenuSystem) " + message, priority);
        } // end if
    } // End of the function
    static var OOPS_SCREEN_ID_MULTIPLAYER = "oops_game_dance";
    static var OOPS_SCREEN_ID_SONGS = "oops_game_dance";
    static var MENU_START_MULTIPLAYER_SONG = -300;
    static var MENU_START_SONG = -200;
    static var MENU_NONE = -100;
    static var MENU_WELCOME_INTRO = 100;
    static var MENU_WELCOME = 101;
    static var MENU_WELCOME_OPTIONS = 102;
    static var MENU_SINGLEPLAYER_INTRO = 103;
    static var MENU_SINGLEPLAYER_SONG = 104;
    static var MENU_SINGLEPLAYER_DIFFICULTY = 105;
    static var MENU_SINGLEPLAYER_PREGAME = 106;
    static var MENU_SINGLEPLAYER_POSTGAME_INTRO = 107;
    static var MENU_SINGLEPLAYER_COINSWON = 108;
    static var MENU_SINGLEPLAYER_POSTGAME = 109;
    static var MENU_SINGLEPLAYER_POSTGAME_STATS = 110;
    static var MENU_SINGLEPLAYER_DIFFICULTY_SECRET = 111;
    static var MENU_HOW_TO_PLAY_INTRO_WALK = 200;
    static var MENU_HOW_TO_PLAY_INTRO = 201;
    static var MENU_HOW_TO_PLAY_TIMING_ANIM = 202;
    static var MENU_HOW_TO_PLAY_TIMING = 203;
    static var MENU_HOW_TO_PLAY_TIMING_KEYPRESS = 204;
    static var MENU_HOW_TO_PLAY_MULTIPLE_ANIM = 205;
    static var MENU_HOW_TO_PLAY_MULTIPLE = 206;
    static var MENU_HOW_TO_PLAY_MULTIPLE_KEYPRESS = 207;
    static var MENU_HOW_TO_PLAY_HOLD_ANIM = 208;
    static var MENU_HOW_TO_PLAY_HOLD = 209;
    static var MENU_HOW_TO_PLAY_HOLD_KEYPRESS = 210;
    static var MENU_HOW_TO_PLAY_HOLD_OUTRO = 211;
    static var MENU_HOW_TO_PLAY_MULTIPLIER_ANIM = 212;
    static var MENU_HOW_TO_PLAY_MULTIPLIER = 213;
    static var MENU_HOW_TO_PLAY_MULTIPLIER_DOWN = 214;
    static var MENU_HOW_TO_PLAY_MULTIPLIER_LEFT_ANIM = 215;
    static var MENU_HOW_TO_PLAY_MULTIPLIER_LEFT = 216;
    static var MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT_ANIM = 217;
    static var MENU_HOW_TO_PLAY_MULTIPLIER_RIGHT = 218;
    static var MENU_HOW_TO_PLAY_MULTIPLIER_OUTRO = 219;
    static var MENU_HOW_TO_PLAY_OUTRO = 220;
    static var MENU_HOW_TO_PLAY_OUTRO_WALK = 221;
    static var MENU_MULTIPLAYER_CONNECTING = 300;
    static var MENU_MULTIPLAYER_PRE_QUEUE = 301;
    static var MENU_MULTIPLAYER_JOINING = 302;
    static var MENU_MULTIPLAYER_JOIN_GAME = 303;
    static var MENU_MULTIPLAYER_SERVERFULL = 304;
    static var MENU_MULTIPLAYER_DIFFICULTY = 305;
    static var MENU_MULTIPLAYER_POSTGAME_INTRO = 306;
    static var MENU_MULTIPLAYER_COINSWON = 307;
    static var MENU_MULTIPLAYER_POSTGAME = 308;
    static var MENU_MULTIPLAYER_POSTGAME_STATS = 309;
    static var MENU_MULTIPLAYER_INTRO = 310;
    static var ERROR_CODE_ROOM_FULL = 401;
    static var ERROR_CODE_MULTIPLE_CONNECTIONS = 402;
    static var MOVIE_HOST_COMPERE = "host";
    static var MOVIE_SPEECH_BUBBLE = "speech";
    static var MOVIE_OPTIONS_MENU = "options";
    static var MOVIE_OPTIONS_BACKGROUND = "background";
    static var MOVIE_OPTIONS_ITEM = "item";
    static var MOVIE_OPTIONS_LOADING = "loading";
    static var MOVIE_HOW_TO_PLAY_ANIM = "howtoplay";
    static var ANIM_FRAME_WALK_ON = "enter";
    static var ANIM_FRAME_TALK = "talk";
    static var ANIM_FRAME_WAIT = "wait";
    static var ANIM_FRAME_WALK_OFF = "exit";
    static var ANIM_FRAME_HELP_ON = "help_on";
    static var ANIM_FRAME_HELP_OFF = "help_off";
    static var ANIM_FRAME_HELP_TALK = "help_talk";
    static var ANIM_FRAME_HELP_WAIT = "help_wait";
    static var ANIM_FRAME_HOWTOPLAY_HITNOTE = "howtoplay_hitnote";
    static var ANIM_FRAME_HOWTOPLAY_TWOATONCE = "howtoplay_twoatonce";
    static var ANIM_FRAME_HOWTOPLAY_HOLDNOTE = "howtoplay_holdnote";
    static var ANIM_FRAME_HOWTOPLAY_COMBO = "howtoplay_combo";
    static var ANIM_FRAME_SECRET_DIFFICULTY = "secret_difficulty";
    static var ANIM_FRAME_POSTGAME_STATS = "postgame_stats";
    static var ANIM_FRAME_PREGAME_CHOOSE_SONG = "pregame_song";
    static var ANIM_FRAME_MEMBERS_ONLY_ICON = "members_only";
    static var SPEECH_NORMAL_XPOSITION = 7.250000E+001;
    static var SPEECH_HELPANIM_XPOSITION = 180;
    var menuData = new Array();
    var currentMenu = com.clubpenguin.games.dancing.MenuSystem.MENU_NONE;
    var talking = false;
} // End of Class
