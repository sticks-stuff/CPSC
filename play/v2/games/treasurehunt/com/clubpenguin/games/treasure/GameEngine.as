class com.clubpenguin.games.treasure.GameEngine
{
    var movieClip, netClient, INTERFACE, ENGINE, SHELL, hackyHack, hackyHackNames, hackyHackDirections, hackyHackNumbers, superRareGemFound, treasureMap, gemLocations, playerDigMap;
    function GameEngine(gameMovie)
    {
        movieClip = gameMovie;
        this.init();
        netClient = new com.clubpenguin.games.treasure.net.TreasureHuntClient(this);
        netClient.init();
        netClient.sendGetGameMessage();
        INTERFACE = _global.getCurrentInterface();
        ENGINE = _global.getCurrentEngine();
        SHELL = _global.getCurrentShell();
    } // End of the function
    function updatePlayerSeatID(seatID)
    {
        netPlayerID = seatID;
    } // End of the function
    function updatePlayerNames(seatID, nickname)
    {
        if (seatID == com.clubpenguin.games.treasure.GameEngine.PLAYER_1)
        {
            player1Name = nickname;
        }
        else if (seatID == com.clubpenguin.games.treasure.GameEngine.PLAYER_2)
        {
            player2Name = nickname;
        } // end else if
        this.refreshPlayerNames();
    } // End of the function
    function spectateGame(multiplayerInfo)
    {
        this.initMultiplayer(multiplayerInfo);
        this.updatePlayerNames(com.clubpenguin.games.treasure.GameEngine.PLAYER_1, multiplayerInfo.player1Name);
        this.updatePlayerNames(com.clubpenguin.games.treasure.GameEngine.PLAYER_2, multiplayerInfo.player2Name);
        netPlayerID = com.clubpenguin.games.treasure.GameEngine.SPECTATOR;
        hackyHack = 0;
        hackyHackNames = multiplayerInfo.digRecordNames.split(",");
        hackyHackDirections = multiplayerInfo.digRecordDirections.split(",");
        hackyHackNumbers = multiplayerInfo.digRecordNumbers.split(",");
        this.executeCallback();
        for (var _loc3 in hackyHackNames)
        {
            this.onDigButtonClick(hackyHackNames[_loc3], hackyHackDirections[_loc3], parseInt(hackyHackNumbers[_loc3]), true);
        } // end of for...in
        totalGemsFound = parseInt(multiplayerInfo.totalGemsFound);
        totalCoinsFound = parseInt(multiplayerInfo.totalCoinsFound);
        superRareGemFound = multiplayerInfo.superRareGemFound == "true";
        var _loc4 = totalGemsFound * com.clubpenguin.games.treasure.GameEngine.GEM_VALUE + totalCoinsFound * com.clubpenguin.games.treasure.GameEngine.COIN_VALUE;
        if (superRareGemFound)
        {
            _loc4 = _loc4 + com.clubpenguin.games.treasure.GameEngine.GEM_VALUE * 3;
        } // end if
        movieClip.coinsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_coins", ["" + totalCoinsFound]);
        movieClip.gemsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_gems", ["" + totalGemsFound]);
        movieClip.totalFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_total", ["" + _loc4]);
    } // End of the function
    function initMultiplayer(multiplayerInfo)
    {
        PLAYING_MULTIPLAYER_GAME = true;
        MAP_WIDTH = multiplayerInfo.MAP_WIDTH;
        MAP_HEIGHT = multiplayerInfo.MAP_HEIGHT;
        COIN_NUM_HIDDEN = multiplayerInfo.COIN_NUM_HIDDEN;
        GEM_NUM_HIDDEN = multiplayerInfo.GEM_NUM_HIDDEN;
        NUM_TURNS = multiplayerInfo.NUM_TURNS;
        GEM_VALUE = parseInt(multiplayerInfo.GEM_VALUE);
        COIN_VALUE = parseInt(multiplayerInfo.COIN_VALUE);
        var _loc6 = multiplayerInfo.treasureMap.split(",");
        var _loc5 = multiplayerInfo.gemLocations.split(",");
        var _loc4;
        _loc4 = 0;
        treasureMap = new Array();
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc3)
        {
            treasureMap[_loc3] = new Array();
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
            {
                treasureMap[_loc3][_loc2] = parseInt(_loc6[_loc4]);
                ++_loc4;
            } // end of for
        } // end of for
        _loc4 = 0;
        gemLocations = new Array();
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.GEM_NUM_HIDDEN; ++_loc3)
        {
            gemLocations[_loc3] = new Array();
            gemLocations[_loc3][0] = parseInt(_loc5[_loc4++]);
            gemLocations[_loc3][1] = parseInt(_loc5[_loc4++]);
        } // end of for
        this.init();
    } // End of the function
    function init()
    {
        movieClip.player0_mc.anim.name_txt.text = com.clubpenguin.util.LocaleText.getText("ingame_waiting");
        movieClip.player1_mc.anim.name_txt.text = com.clubpenguin.util.LocaleText.getText("ingame_waiting");
        superRareGemFound = false;
        totalCoinsFound = 0;
        totalGemsFound = 0;
        currentPlayer = 0;
        currentTurn = 0;
        movieClip.coinsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_coins", ["" + totalCoinsFound]);
        movieClip.gemsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_gems", ["" + totalGemsFound]);
        movieClip.totalFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_total", ["0"]);
        this.createBG();
        if (!com.clubpenguin.games.treasure.GameEngine.PLAYING_MULTIPLAYER_GAME)
        {
            this.createBlankMap();
            this.addMapGems();
            this.addMapCoins();
        } // end if
        this.renderTiles();
        this.createPlayerMap();
        this.createDigButtons();
        this.createButtonCovers();
        this.createDigButtonClickHandlers();
        this.updateDigButtonStatus();
    } // End of the function
    function update()
    {
    } // End of the function
    function createBG()
    {
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc3)
        {
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
            {
                movieClip.placer.gems.attachMovie("mapsquare", "mapsquare" + _loc3 + _loc2 + "_mc", _loc3 * 100 + _loc2 * 10 + 10);
                var _loc4 = movieClip.placer.gems["mapsquare" + _loc3 + _loc2 + "_mc"];
                _loc4._y = com.clubpenguin.games.treasure.GameEngine.TILE_HEIGHT * _loc3;
                _loc4._x = com.clubpenguin.games.treasure.GameEngine.TILE_WIDTH * _loc2;
            } // end of for
        } // end of for
    } // End of the function
    function createBlankMap()
    {
        treasureMap = new Array();
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc3)
        {
            treasureMap[_loc3] = new Array();
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
            {
                treasureMap[_loc3][_loc2] = com.clubpenguin.games.treasure.GameEngine.TREASURE_NONE;
            } // end of for
        } // end of for
    } // End of the function
    function addMapGems()
    {
        gemLocations = new Array();
        var _loc3 = new Array();
        for (var _loc5 = 0; _loc5 < com.clubpenguin.games.treasure.GameEngine.GEM_NUM_HIDDEN; ++_loc5)
        {
            do
            {
                var coordGood = true;
                var _loc2 = [this.getRandom(com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT - 1), this.getRandom(com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH - 1)];
                for (var _loc4 = 0; _loc4 < _loc3.length; ++_loc4)
                {
                    if (_loc2[0] == _loc3[_loc4][0] && _loc2[1] == _loc3[_loc4][1])
                    {
                        coordGood = false;
                    } // end if
                } // end of for
            } while (coordGood == false)
            gemLocations.push([_loc2[0], _loc2[1]]);
            _loc3.push([_loc2[0] - 1, _loc2[1] - 1]);
            _loc3.push([_loc2[0], _loc2[1] - 1]);
            _loc3.push([_loc2[0] + 1, _loc2[1] - 1]);
            _loc3.push([_loc2[0] - 1, _loc2[1]]);
            _loc3.push([_loc2[0], _loc2[1]]);
            _loc3.push([_loc2[0] + 1, _loc2[1]]);
            _loc3.push([_loc2[0] - 1, _loc2[1] + 1]);
            _loc3.push([_loc2[0], _loc2[1] + 1]);
            _loc3.push([_loc2[0] + 1, _loc2[1] + 1]);
        } // end of for
        for (var _loc5 = 0; _loc5 < com.clubpenguin.games.treasure.GameEngine.GEM_NUM_HIDDEN; ++_loc5)
        {
            var _loc7 = gemLocations[_loc5][0];
            var _loc6 = gemLocations[_loc5][1];
            treasureMap[_loc7][_loc6] = com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM;
            treasureMap[_loc7][_loc6 + 1] = com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM_PIECE;
            treasureMap[_loc7 + 1][_loc6] = com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM_PIECE;
            treasureMap[_loc7 + 1][_loc6 + 1] = com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM_PIECE;
        } // end of for
    } // End of the function
    function addMapCoins()
    {
        for (var _loc4 = 0; _loc4 < com.clubpenguin.games.treasure.GameEngine.COIN_NUM_HIDDEN; ++_loc4)
        {
            var _loc2 = this.getRandom(com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT);
            var _loc3 = this.getRandom(com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH);
            if (treasureMap[_loc2][_loc3] == com.clubpenguin.games.treasure.GameEngine.TREASURE_NONE)
            {
                treasureMap[_loc2][_loc3] = com.clubpenguin.games.treasure.GameEngine.TREASURE_COIN;
            } // end if
        } // end of for
    } // End of the function
    function renderTiles()
    {
        var _loc4;
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc3)
        {
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
            {
                _loc4 = movieClip.placer.gems["mapsquare" + _loc3 + _loc2 + "_mc"];
                if (treasureMap[_loc3][_loc2] == com.clubpenguin.games.treasure.GameEngine.TREASURE_COIN)
                {
                    _loc4.gotoAndStop("coin");
                } // end if
            } // end of for
        } // end of for
    } // End of the function
    function createPlayerMap()
    {
        playerDigMap = new Array();
        var _loc4;
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc3)
        {
            playerDigMap[_loc3] = new Array();
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
            {
                playerDigMap[_loc3][_loc2] = 0;
                movieClip.placer.attachMovie("dirtsquare", "dirtsquare" + _loc3 + _loc2 + "_mc", 1000 + (_loc3 * 100 + _loc2));
                _loc4 = movieClip.placer["dirtsquare" + _loc3 + _loc2 + "_mc"];
                _loc4._y = com.clubpenguin.games.treasure.GameEngine.TILE_HEIGHT * _loc3;
                _loc4._x = com.clubpenguin.games.treasure.GameEngine.TILE_WIDTH * _loc2;
            } // end of for
        } // end of for
    } // End of the function
    function createDigButtons()
    {
        var _loc5;
        var _loc4;
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc3)
        {
            movieClip.placer.attachMovie("downbutton", "downbutton" + _loc3 + "_mc", 2000 + _loc3);
            _loc5 = movieClip.placer["downbutton" + _loc3 + "_mc"];
            _loc5._x = com.clubpenguin.games.treasure.GameEngine.TILE_WIDTH * _loc3;
            _loc5._y = _loc5._y - com.clubpenguin.games.treasure.GameEngine.TILE_HEIGHT;
        } // end of for
        for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc2)
        {
            movieClip.placer.attachMovie("rightbutton", "rightbutton" + _loc2 + "_mc", 2100 + _loc2);
            _loc4 = movieClip.placer["rightbutton" + _loc2 + "_mc"];
            _loc4._x = _loc4._x - com.clubpenguin.games.treasure.GameEngine.TILE_WIDTH;
            _loc4._y = com.clubpenguin.games.treasure.GameEngine.TILE_HEIGHT * _loc2;
        } // end of for
    } // End of the function
    function createButtonCovers()
    {
        for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
        {
            movieClip.placer["downbutton" + _loc2 + "_mc"]._visible = false;
        } // end of for
        for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc2)
        {
            movieClip.placer["rightbutton" + _loc2 + "_mc"]._visible = false;
        } // end of for
    } // End of the function
    function getRandom(maxValue)
    {
        return (Math.floor(Math.random() * maxValue));
    } // End of the function
    function updateForNextTurn(buttonDir, buttonNum)
    {
        var _loc3 = "spade" + (Math.floor(currentTurn / 2) + 1);
        if (currentTurn % 2 == 0)
        {
            movieClip.player1Spades[_loc3].gotoAndStop(2);
        }
        else
        {
            movieClip.player2Spades[_loc3].gotoAndStop(2);
        } // end else if
        ++currentTurn;
        movieClip.turnNum.text = currentTurn + "/" + com.clubpenguin.games.treasure.GameEngine.NUM_TURNS;
        currentPlayer = currentPlayer == 0 ? (1) : (0);
        movieClip.playerNum.text = "Player " + currentPlayer;
        this.refreshPlayerNames();
        this.updateDigButtonStatus();
        this.updateGemStatus();
        var _loc2 = totalGemsFound * com.clubpenguin.games.treasure.GameEngine.GEM_VALUE + totalCoinsFound * com.clubpenguin.games.treasure.GameEngine.COIN_VALUE;
        if (superRareGemFound)
        {
            _loc2 = _loc2 + com.clubpenguin.games.treasure.GameEngine.GEM_VALUE * 3;
        } // end if
        movieClip.coinsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_coins", ["" + totalCoinsFound]);
        movieClip.gemsFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_gems", ["" + totalGemsFound]);
        movieClip.totalFound.text = com.clubpenguin.util.LocaleText.getTextReplaced("ingame_total", ["" + _loc2]);
    } // End of the function
    function updateGemStatus()
    {
        totalGemsFound = 0;
        for (var _loc4 = 0; _loc4 < com.clubpenguin.games.treasure.GameEngine.GEM_NUM_HIDDEN; ++_loc4)
        {
            var _loc3 = gemLocations[_loc4][0];
            var _loc2 = gemLocations[_loc4][1];
            if (playerDigMap[_loc3][_loc2] == 2 || playerDigMap[_loc3 + 1][_loc2] == 2 || playerDigMap[_loc3][_loc2 + 1] == 2 || playerDigMap[_loc3 + 1][_loc2 + 1] == 2)
            {
                var _loc5 = movieClip.placer.gems["mapsquare" + _loc3 + _loc2 + "_mc"];
                if (treasureMap[_loc3][_loc2] == com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM)
                {
                    _loc5.gotoAndStop("gem");
                } // end if
                if (treasureMap[_loc3][_loc2] == com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM_PIECE)
                {
                    _loc5.gotoAndStop("gemspace");
                } // end if
                if (treasureMap[_loc3][_loc2] == com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM_RARE)
                {
                    _loc5.gotoAndStop("gemrare");
                } // end if
            } // end if
            if (playerDigMap[_loc3][_loc2] == 2)
            {
                if (playerDigMap[_loc3 + 1][_loc2] == 2)
                {
                    if (playerDigMap[_loc3][_loc2 + 1] == 2)
                    {
                        if (playerDigMap[_loc3 + 1][_loc2 + 1] == 2)
                        {
                            ++totalGemsFound;
                            if (!superRareGemFound)
                            {
                                if (treasureMap[_loc3][_loc2] == com.clubpenguin.games.treasure.GameEngine.TREASURE_GEM_RARE)
                                {
                                    superRareGemFound = true;
                                    movieClip.rareGemFound.gotoAndPlay(2);
                                } // end if
                            } // end if
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end of for
    } // End of the function
    function updateDigButtonStatus()
    {
        for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
        {
            if (movieClip.placer["downbutton" + _loc2 + "_mc"].active == false || movieClip.placer["downbutton" + _loc2 + "_mc"].active == undefined)
            {
                movieClip.placer["downbutton" + _loc2 + "_mc"]._visible = true;
            } // end if
        } // end of for
        for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc2)
        {
            if (movieClip.placer["rightbutton" + _loc2 + "_mc"].active == false || movieClip.placer["rightbutton" + _loc2 + "_mc"].active == undefined)
            {
                movieClip.placer["rightbutton" + _loc2 + "_mc"]._visible = true;
            } // end if
        } // end of for
        if (currentPlayer == com.clubpenguin.games.treasure.GameEngine.PLAYER_1)
        {
            if (com.clubpenguin.games.treasure.GameEngine.PLAYING_MULTIPLAYER_GAME)
            {
                if (netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_2 || netPlayerID == com.clubpenguin.games.treasure.GameEngine.SPECTATOR)
                {
                    for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc2)
                    {
                        movieClip.placer["rightbutton" + _loc2 + "_mc"]._visible = false;
                    } // end of for
                } // end if
            } // end if
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
            {
                movieClip.placer["downbutton" + _loc2 + "_mc"]._visible = false;
            } // end of for
        } // end if
        if (currentPlayer == com.clubpenguin.games.treasure.GameEngine.PLAYER_2)
        {
            if (com.clubpenguin.games.treasure.GameEngine.PLAYING_MULTIPLAYER_GAME)
            {
                if (netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_1 || netPlayerID == com.clubpenguin.games.treasure.GameEngine.SPECTATOR)
                {
                    for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
                    {
                        movieClip.placer["downbutton" + _loc2 + "_mc"]._visible = false;
                    } // end of for
                } // end if
            } // end if
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc2)
            {
                movieClip.placer["rightbutton" + _loc2 + "_mc"]._visible = false;
            } // end of for
        } // end if
        if (currentTurn == com.clubpenguin.games.treasure.GameEngine.NUM_TURNS)
        {
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc2)
            {
                movieClip.placer["downbutton" + _loc2 + "_mc"]._visible = false;
            } // end of for
            for (var _loc2 = 0; _loc2 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc2)
            {
                movieClip.placer["rightbutton" + _loc2 + "_mc"]._visible = false;
            } // end of for
        } // end if
    } // End of the function
    function refreshPlayerNames()
    {
        if (player1Name == "")
        {
            movieClip.player0_mc.gotoAndStop(1);
        }
        else
        {
            if (currentPlayer == 0)
            {
                movieClip.player0_mc.gotoAndStop("Turn");
            } // end if
            if (currentPlayer == 1)
            {
                movieClip.player0_mc.gotoAndStop("Wait");
            } // end if
            movieClip.player0_mc.name1_txt.text = player1Name.toUpperCase();
            movieClip.player0_mc.name2_txt.text = player1Name.toUpperCase();
        } // end else if
        if (player2Name == "")
        {
            movieClip.player1_mc.gotoAndStop(1);
        }
        else
        {
            if (currentPlayer == 0)
            {
                movieClip.player1_mc.gotoAndStop("Wait");
            } // end if
            if (currentPlayer == 1)
            {
                movieClip.player1_mc.gotoAndStop("Turn");
            } // end if
            movieClip.player1_mc.name1_txt.text = player2Name.toUpperCase();
            movieClip.player1_mc.name2_txt.text = player2Name.toUpperCase();
        } // end else if
    } // End of the function
    function createDigButtonClickHandlers()
    {
        var _loc2;
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc3)
        {
            _loc2 = "rightbutton" + _loc3 + "_mc";
            movieClip.placer[_loc2].digbutton.onRelease = this.createContextSpecificFunction(this, onDigButtonClick, _loc2, "right", _loc3);
        } // end of for
        for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc3)
        {
            _loc2 = "downbutton" + _loc3 + "_mc";
            movieClip.placer[_loc2].digbutton.onRelease = this.createContextSpecificFunction(this, onDigButtonClick, _loc2, "down", _loc3);
        } // end of for
    } // End of the function
    function createContextSpecificFunction(objectContext, functionToCall)
    {
        var _loc2 = function ()
        {
            var _loc2 = arguments.callee;
            var _loc3 = arguments.concat(_loc2.initArgs);
            return (_loc2.handler.apply(_loc2.target, _loc3));
        };
        _loc2.target = objectContext;
        _loc2.handler = functionToCall;
        _loc2.initArgs = arguments.slice(2);
        return (_loc2);
    } // End of the function
    function onDigButtonClick(buttonName, buttonDir, buttonNum, autoFill)
    {
        if (autoFill == undefined)
        {
            autoFill = false;
        } // end if
        if (movieClip.placer[buttonName].active == false || movieClip.placer[buttonName].active == undefined && currentTurn < com.clubpenguin.games.treasure.GameEngine.NUM_TURNS)
        {
            if (com.clubpenguin.games.treasure.GameEngine.PLAYING_MULTIPLAYER_GAME)
            {
                if (netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_1 && buttonDir == "right" || netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_2 && buttonDir == "down")
                {
                    netClient.sendDigMessage(buttonName, buttonDir, buttonNum);
                } // end if
            } // end if
            if (!autoFill)
            {
                movieClip.placer["pc" + buttonNum + "_" + buttonDir].gotoAndPlay(2);
            } // end if
            var _loc5;
            if (buttonDir == "down")
            {
                if (!autoFill)
                {
                    _loc5 = movieClip.placer["dirtsquare0" + buttonNum + "_mc"];
                    movieClip.placer.attachMovie("sanddownanim", "sanddownanim" + currentTurn + "_mc", 4500 + currentTurn);
                    movieClip.placer["sanddownanim" + currentTurn + "_mc"]._x = _loc5._x;
                    movieClip.placer["sanddownanim" + currentTurn + "_mc"]._y = _loc5._y;
                } // end if
                for (var _loc4 = 0; _loc4 < com.clubpenguin.games.treasure.GameEngine.MAP_HEIGHT; ++_loc4)
                {
                    _loc5 = movieClip.placer["dirtsquare" + _loc4 + buttonNum + "_mc"];
                    _loc5.nextFrame();
                    ++playerDigMap[_loc4][buttonNum];
                    if (treasureMap[_loc4][buttonNum] != com.clubpenguin.games.treasure.GameEngine.TREASURE_NONE)
                    {
                        movieClip.placer["dirtsquare" + _loc4 + buttonNum + "_mc"].shine._visible = true;
                    }
                    else
                    {
                        movieClip.placer["dirtsquare" + _loc4 + buttonNum + "_mc"].shine._visible = false;
                    } // end else if
                    if (treasureMap[_loc4][buttonNum] == com.clubpenguin.games.treasure.GameEngine.TREASURE_COIN)
                    {
                        if (playerDigMap[_loc4][buttonNum] == 2)
                        {
                            ++totalCoinsFound;
                        } // end if
                    } // end if
                } // end of for
            } // end if
            if (buttonDir == "right")
            {
                if (!autoFill)
                {
                    _loc5 = movieClip.placer["dirtsquare" + buttonNum + "0_mc"];
                    movieClip.placer.attachMovie("sandrightanim", "sandrightanim" + currentTurn + "_mc", 4500 + currentTurn);
                    movieClip.placer["sandrightanim" + currentTurn + "_mc"]._x = _loc5._x;
                    movieClip.placer["sandrightanim" + currentTurn + "_mc"]._y = _loc5._y;
                } // end if
                for (var _loc3 = 0; _loc3 < com.clubpenguin.games.treasure.GameEngine.MAP_WIDTH; ++_loc3)
                {
                    _loc5 = movieClip.placer["dirtsquare" + buttonNum + _loc3 + "_mc"];
                    _loc5.nextFrame();
                    ++playerDigMap[buttonNum][_loc3];
                    if (treasureMap[buttonNum][_loc3] != com.clubpenguin.games.treasure.GameEngine.TREASURE_NONE)
                    {
                        movieClip.placer["dirtsquare" + buttonNum + _loc3 + "_mc"].shine._visible = true;
                    }
                    else
                    {
                        movieClip.placer["dirtsquare" + buttonNum + _loc3 + "_mc"].shine._visible = false;
                    } // end else if
                    if (treasureMap[buttonNum][_loc3] == com.clubpenguin.games.treasure.GameEngine.TREASURE_COIN)
                    {
                        if (playerDigMap[buttonNum][_loc3] == 2)
                        {
                            ++totalCoinsFound;
                        } // end if
                    } // end if
                } // end of for
            } // end if
            movieClip.placer[buttonName].active = true;
            movieClip.placer[buttonName]._visible = false;
            this.updateForNextTurn(buttonDir, buttonNum);
        } // end if
    } // End of the function
    function executeCallback()
    {
        movieClip.placer["pc" + hackyHackNumbers[hackyHack] + "_" + hackyHackDirections[hackyHack]].gotoAndPlay(2);
        var _loc2;
        if (hackyHackDirections[hackyHack] == "down")
        {
            _loc2 = movieClip.placer["dirtsquare0" + hackyHackNumbers[hackyHack] + "_mc"];
            movieClip.placer.attachMovie("sanddownanim", "sanddownanim" + hackyHack + "_mc", 4500 + hackyHack);
            movieClip.placer["sanddownanim" + hackyHack + "_mc"]._x = _loc2._x;
            movieClip.placer["sanddownanim" + hackyHack + "_mc"]._y = _loc2._y;
        } // end if
        if (hackyHackDirections[hackyHack] == "right")
        {
            _loc2 = movieClip.placer["dirtsquare" + hackyHackNumbers[hackyHack] + "0_mc"];
            movieClip.placer.attachMovie("sandrightanim", "sandrightanim" + hackyHack + "_mc", 4500 + hackyHack);
            movieClip.placer["sandrightanim" + hackyHack + "_mc"]._x = _loc2._x;
            movieClip.placer["sandrightanim" + hackyHack + "_mc"]._y = _loc2._y;
        } // end if
        ++hackyHack;
    } // End of the function
    function showGameAborted(nickname)
    {
        INTERFACE.showPrompt("ok", com.clubpenguin.util.LocaleText.getTextReplaced("id_quit_game", [nickname]));
        this.leaveGame();
    } // End of the function
    function showGameOver()
    {
        clearInterval(netClient.gameOverDelay);
        if (netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_1 || netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_2)
        {
            if (totalCoinsFound > 0 || totalGemsFound > 0)
            {
                var _loc4 = SHELL.getMyPlayerTotalCoins();
                var _loc2 = totalGemsFound * com.clubpenguin.games.treasure.GameEngine.GEM_VALUE + totalCoinsFound * com.clubpenguin.games.treasure.GameEngine.COIN_VALUE;
                if (superRareGemFound)
                {
                    _loc2 = _loc2 + com.clubpenguin.games.treasure.GameEngine.GEM_VALUE * 3;
                } // end if
                INTERFACE.showScopedGameOverPrompt(_loc4, _loc2, leaveGame, this);
            }
            else
            {
                var _loc3 = player1Name;
                if (netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_1)
                {
                    _loc3 = player2Name;
                } // end if
                INTERFACE.showPrompt("ok", com.clubpenguin.util.LocaleText.getTextReplaced("id_quit_game", [_loc3]));
                this.leaveGame();
            } // end else if
            return;
        } // end if
        if (netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_1 || netPlayerID == com.clubpenguin.games.treasure.GameEngine.PLAYER_2)
        {
            this.leaveGame();
        } // end if
    } // End of the function
    function closeGame()
    {
        if (netPlayerID == com.clubpenguin.games.treasure.GameEngine.SPECTATOR)
        {
            this.leaveGame();
        }
        else
        {
            var _loc2 = SHELL.getLocalizedString("quit_game_prompt");
            INTERFACE.showScopedPrompt("question", _loc2, undefined, leaveGame, this);
        } // end else if
    } // End of the function
    function leaveGame()
    {
        if (netPlayerID != com.clubpenguin.games.treasure.GameEngine.SPECTATOR && currentTurn > 0)
        {
            netClient.sendLeaveMessage();
        } // end if
        netClient.destroy();
        ENGINE.sendLeaveTable();
        INTERFACE.closeGameWidget();
    } // End of the function
    static var TREASURE_NONE = 0;
    static var TREASURE_COIN = 1;
    static var TREASURE_GEM = 2;
    static var TREASURE_GEM_PIECE = 3;
    static var TREASURE_GEM_RARE = 4;
    static var SPECTATOR = -1;
    static var PLAYER_1 = 0;
    static var PLAYER_2 = 1;
    static var MAP_WIDTH = 10;
    static var MAP_HEIGHT = 10;
    static var TILE_WIDTH = 21;
    static var TILE_HEIGHT = 21;
    static var BORDER_SIZE = 10;
    static var COIN_NUM_HIDDEN = 34;
    static var GEM_NUM_HIDDEN = 3;
    static var GEM_VALUE = 25;
    static var COIN_VALUE = 1;
    static var NUM_TURNS = 12;
    static var PLAYING_MULTIPLAYER_GAME = true;
    var netPlayerID = com.clubpenguin.games.treasure.GameEngine.SPECTATOR;
    var totalCoinsFound = 0;
    var totalGemsFound = 0;
    var currentPlayer = 0;
    var currentTurn = 0;
    var player1Name = "";
    var player2Name = "";
} // End of Class
