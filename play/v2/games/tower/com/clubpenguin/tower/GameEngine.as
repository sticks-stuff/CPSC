class com.clubpenguin.tower.GameEngine extends com.clubpenguin.game.engine.GenericGameEngine
{
    var _sdClient, SHELL, mission_specific_opcode_guid, _quality, _parent, _stage, gameDirectory, localeDirectory, getNextHighestDepth, createEmptyMovieClip, levelScenario, currentLevel, __gameType, mode, _towerManager, _enemyManager, _upgradeManager, _levelManager, _displayManager, output_hider, output_mc, listener, scenario, _tutorial, _scenarioActive, btnClose, onEnterFrame, __get___mode, __get___scenario;
    static var __instance;
    function GameEngine()
    {
        super();
        ++$_instanceID;
        if (com.clubpenguin.tower.GameEngine.__instance != null)
        {
            __instance = null;
        } // end if
        __instance = this;
        _sdClient = new com.clubpenguin.tower.SystemDefenderClient();
        SHELL = _global.getCurrentShell();
    } // End of the function
    function LoadDLSM()
    {
        var _loc2 = SHELL.getMyPlayerId();
        if (_loc2 == undefined)
        {
            _loc2 = -1;
        } // end if
        com.disney.dlearning.managers.DLSManager.init(String(_loc2), com.clubpenguin.tower.GameEngine.DLSURL);
        mission_specific_opcode_guid = com.clubpenguin.tower.GameEngine.CP_SYSTEM_DEFENDER;
    } // End of the function
    function setOpcodeGuid(whichMode)
    {
        switch (whichMode)
        {
            case "Elite":
            {
                mission_specific_opcode_guid = com.clubpenguin.tower.GameEngine.SYSTEM_DEFENDER_ELITE;
                break;
            } 
            case "Survival":
            {
                mission_specific_opcode_guid = com.clubpenguin.tower.GameEngine.SYSTEM_DEFENDER_SURVIVAL;
                break;
            } 
            case "Mission Quarters":
            {
                mission_specific_opcode_guid = com.clubpenguin.tower.GameEngine.SYSTEM_DEFENDER_MISSION_QUARTERS;
                break;
            } 
            default:
            {
                mission_specific_opcode_guid = com.clubpenguin.tower.GameEngine.CP_SYSTEM_DEFENDER;
                break;
            } 
        } // End of switch
    } // End of the function
    function getOpcodeGuid()
    {
        return (mission_specific_opcode_guid);
    } // End of the function
    function setQuality(quality)
    {
        if (_quality == quality)
        {
            return;
        } // end if
        _quality = quality;
    } // End of the function
    function init()
    {
        if (com.clubpenguin.tower.GameEngine.__instance == null)
        {
            __instance = this;
        } // end if
        _stage = _parent;
        gameDirectory = com.clubpenguin.lib.locale.LocaleText.getGameDirectory(_parent._url);
        localeDirectory = gameDirectory + "lang/" + com.clubpenguin.lib.locale.LocaleText.getLocale(com.clubpenguin.lib.locale.LocaleText.getLocaleID()) + "/";
        this.handleLocaleTextReady();
        this.LoadDLSM();
    } // End of the function
    function setUpStartScreen()
    {
        _stage.attachMovie("startScreen", "startScreen", _stage.getNextHighestDepth());
    } // End of the function
    function removeStartScreen()
    {
        _stage.startScreen.removeMovieClip();
    } // End of the function
    function initLevelSelector()
    {
        _stage.attachMovie("levelSelectScreen", "levelSelectScreen", _stage.getNextHighestDepth());
    } // End of the function
    function removeLevelSelector()
    {
        _stage.levelSelectScreen.removeMovieClip();
    } // End of the function
    function handleLoadLevelSelected(levelNumber)
    {
        levelScenario = this.createEmptyMovieClip("levelScenario", this.getNextHighestDepth());
        var _loc2 = new MovieClipLoader();
        _loc2.addListener(this);
        switch (levelNumber)
        {
            case 1:
            {
                _loc2.loadClip(gameDirectory + "scenario/level1/Scenario.swf", levelScenario);
                currentLevel = 1;
                break;
            } 
            case 2:
            {
                _loc2.loadClip(gameDirectory + "scenario/level2/Scenario.swf", levelScenario);
                currentLevel = 2;
                break;
            } 
            case 3:
            {
                _loc2.loadClip(gameDirectory + "scenario/level3/Scenario.swf", levelScenario);
                currentLevel = 3;
                break;
            } 
            case 4:
            {
                _loc2.loadClip(gameDirectory + "scenario/level4/Scenario.swf", levelScenario);
                currentLevel = 4;
                break;
            } 
            case 5:
            {
                _loc2.loadClip(gameDirectory + "scenario/level5/Scenario.swf", levelScenario);
                currentLevel = 5;
                break;
            } 
            case 6:
            {
                _loc2.loadClip(gameDirectory + "scenario/level6/Scenario.swf", levelScenario);
                currentLevel = 6;
                break;
            } 
        } // End of switch
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode(com.clubpenguin.tower.GameEngine.DLS_SELECT, this.getSLevel(levelNumber), dlsmCallback, 0);
    } // End of the function
    function getSLevel(level)
    {
        return (opArray[level - 1]);
    } // End of the function
    function initTransition(gameType)
    {
        __gameType = gameType;
    } // End of the function
    function initGame()
    {
        this.removeLevelSelector();
        this.removeStartScreen();
        mode = __gameType;
        _towerManager = new com.clubpenguin.tower.towers.TowerManager(com.clubpenguin.tower.GameEngine.__instance);
        _enemyManager = com.clubpenguin.tower.enemies.EnemyManager.getInstance();
        _upgradeManager = new com.clubpenguin.tower.upgrades.UpgradeManager(com.clubpenguin.tower.GameEngine.__instance);
        _levelManager = new com.clubpenguin.tower.levels.LevelManager(com.clubpenguin.tower.GameEngine.__instance, _enemyManager);
        _displayManager = new com.clubpenguin.tower.display.DisplayManager(com.clubpenguin.tower.GameEngine.__instance);
        _displayManager.createDisplay(startingEnergy, com.clubpenguin.tower.GameSettings.LASER_TOWER_COST, com.clubpenguin.tower.GameSettings.SNOWBALL_TOWER_COST, com.clubpenguin.tower.GameSettings.ROCKET_TOWER_COST, com.clubpenguin.tower.GameSettings.UPGRADE_TOWER_COST);
        if (debug_mode)
        {
            output_hider = _stage.attachMovie("output_hider", "output_hider", 1000);
            output_hider._x = 700;
            output_hider._y = 10;
            output_hider.onRelease = com.clubpenguin.tower.util.Delegate.create(this, onHiderRelease);
            output_mc = _stage.attachMovie("output_mc", "output_mc", 999);
            output_mc._x = 575;
            output_mc._y = 30;
            output_mc.output_txt.text = "STAMPS NOTIFIER";
        } // end if
        this.loadLevel();
        this.attachEvents();
    } // End of the function
    function onHiderRelease()
    {
        if (visible_status)
        {
            output_mc._visible = false;
            visible_status = false;
            output_hider.gotoAndStop(2);
        }
        else
        {
            output_mc._visible = true;
            visible_status = true;
            output_hider.gotoAndStop(1);
        } // end else if
    } // End of the function
    function attachEvents()
    {
        _displayManager.addEventListener(com.clubpenguin.tower.display.DisplayManager.TOWER_CLICKED, createTower, this);
        _displayManager.addEventListener(com.clubpenguin.tower.display.DisplayManager.PAUSE_GAME, onPauseGame, this);
        _upgradeManager.addEventListener(com.clubpenguin.tower.upgrades.UpgradeManager.ENERGY_UPGRADE_EVENT, increaseEnergy, this);
        _upgradeManager.addEventListener(com.clubpenguin.tower.upgrades.UpgradeManager.SINGLE_UPGRADE_EVENT, upgradeTower, this);
        _upgradeManager.addEventListener(com.clubpenguin.tower.upgrades.UpgradeManager.UPGRADE_ACTIVE, handleActiveUpgrade, this);
        _upgradeManager.addEventListener(com.clubpenguin.tower.upgrades.UpgradeManager.UPGRADE_INACTIVE, handleInactiveUpgrade, this);
        _upgradeManager.addEventListener(com.clubpenguin.tower.upgrades.UpgradeManager.UPGRADE_DELETED, handleDeletedUpgrade, this);
    } // End of the function
    function onPauseGame()
    {
    } // End of the function
    function handleLocaleTextReady()
    {
        com.clubpenguin.util.Loader.removeEventListener(listener);
        scenario = this.createEmptyMovieClip("scenario", this.getNextHighestDepth());
        var _loc3 = new MovieClipLoader();
        _loc3.addListener(this);
        _loc3.loadClip(gameDirectory + "scenario/scenario/Scenario.swf", scenario);
        var _loc4 = new Object();
        _tutorial = this.createEmptyMovieClip("_tutorial", this.getNextHighestDepth());
        var _loc2 = new MovieClipLoader();
        _loc2.addListener(_loc4);
        _loc2.loadClip(gameDirectory + "scenario/tutorial/Scenario.swf", _tutorial);
        _loc4.onLoadInit = com.clubpenguin.tower.util.Delegate.create(this, onTutorialLoaded);
    } // End of the function
    function onTutorialLoaded()
    {
    } // End of the function
    function onLoadInit()
    {
        com.clubpenguin.tower.GameSettings.ENERGY_PER_KILL = scenario.energyPerKill;
        com.clubpenguin.tower.GameSettings.MAX_ENERGY_DROP = scenario.maxEnergyDrop;
        startingEnergy = scenario.startEnergy;
        if (levelScenario != null)
        {
            __gameType = com.clubpenguin.tower.GameEngine.MODE_SURVIVAL;
            com.clubpenguin.tower.GameSettings.ENERGY_PER_KILL = levelScenario.energyPerKill;
            com.clubpenguin.tower.GameSettings.MAX_ENERGY_DROP = levelScenario.maxEnergyDrop;
            startingEnergy = levelScenario.startEnergy;
        }
        else
        {
            _scenarioActive = true;
            this.setUpStartScreen();
        } // end else if
    } // End of the function
    function onLoadError()
    {
        this.dTrace("Scenario not found!");
        _scenarioActive = false;
        this.setUpStartScreen();
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.tower.GameEngine.__instance == null)
        {
        } // end if
        return (com.clubpenguin.tower.GameEngine.__instance);
    } // End of the function
    function createTower(event)
    {
        var _loc5 = "UPGRADE_TOWER";
        var _loc4 = "singleUpgrade";
        var _loc3 = new flash.geom.Point(_stage._x, _stage._y);
        if (event.tower == _loc5)
        {
            fromMenuActive = true;
            _upgradeManager.createUpgrade(_loc4, _loc3, true);
            _towerManager.handleActiveUpgrade();
            return;
        } // end if
        _towerManager.createTowers(event.target, event.tower, event.score);
        _towerManager.addEventListener(com.clubpenguin.tower.towers.TowerManager.SHOOT_ENEMY, shootEnemy, this);
        _towerManager.addEventListener(com.clubpenguin.tower.towers.TowerManager.TOWER_DROPPED, onTowerDropped, this);
        _towerManager.addEventListener(com.clubpenguin.tower.towers.TowerManager.TOWER_COST, handleTowerCost, this);
        _towerManager.addEventListener(com.clubpenguin.tower.towers.TowerManager.TOWER_REMOVED, handleTowerRemoved, this);
    } // End of the function
    function upgradeTower(eventInfo)
    {
        _towerManager.handleUpgradeTower(eventInfo.id);
    } // End of the function
    function loadLevel()
    {
        _enemyManager.addEventListener(com.clubpenguin.tower.enemies.EnemyManager.ENEMY_DESTROYED, handleEnemyDestroyed, this);
        _enemyManager.addEventListener(com.clubpenguin.tower.enemies.EnemyManager.SINGLE_UPGRADE, handleSingleUpgrade, this);
        _enemyManager.addEventListener(com.clubpenguin.tower.enemies.EnemyManager.ENERGY_UPGRADE, handleEnergyUpgrade, this);
        _levelManager.addEventListener(com.clubpenguin.tower.levels.LevelManager.DROP_ZONES_SET, setDropZones, this);
        _levelManager.addEventListener(com.clubpenguin.tower.levels.LevelManager.LEVEL_LOAD_COMPLETE, startLevel, this);
        _levelManager.addEventListener(com.clubpenguin.tower.levels.LevelManager.ENEMY_HIT_CPU, handleEnemyHitCPU, this);
        _levelManager.addEventListener(com.clubpenguin.tower.levels.LevelManager.CPU_DESTROYED, failLevel, this);
        _levelManager.addEventListener(com.clubpenguin.tower.levels.LevelManager.GAME_OVER, levelComplete, this);
        _levelManager.loadLevel("LEVEL" + currentLevel);
        var _loc2 = _stage.getNextHighestDepth() + 1000;
        btnClose = _stage.attachMovie("close_btn", "close_btn", _loc2);
        btnClose._x = 755 - (btnClose._width + 10);
        btnClose._y = 12;
        btnClose.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleGameOver);
        btnClose.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleCloseBtnPress);
        btnClose.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleCloseBtnRollover);
        btnClose.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut);
        btnClose.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleCloseBtnReleaseOutside);
        _towerManager.generateTowers(_levelManager.__get__isPlaceable());
    } // End of the function
    function handleCloseBtnRollover()
    {
        btnClose.gotoAndStop("rollover");
    } // End of the function
    function handleBtnRollOut()
    {
        btnClose.gotoAndStop("default");
    } // End of the function
    function handleCloseBtnPress()
    {
        btnClose.gotoAndStop("press");
    } // End of the function
    function handleCloseBtnReleaseOutside()
    {
        btnClose.gotoAndStop("default");
    } // End of the function
    function startLevel()
    {
        var _loc2 = _enemyManager.getEnemies().length;
        _levelManager.startLevel();
        _displayManager.updateScore();
        onEnterFrame = com.clubpenguin.tower.util.Delegate.create(this, gameLoop);
    } // End of the function
    function handleEnemyDestroyed()
    {
        if (_enemyManager.enemyKilledCount == com.clubpenguin.tower.GameEngine.STAMP_GARBAGE_DISPOLSAL_ENEMY_COUNT)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.GARBAGE_DISPOSAL_STAMP);
            output_mc.output_txt.text = "STAMP : Garbage disposal";
        } // end if
        if (_enemyManager.enemyKilledCount == com.clubpenguin.tower.GameEngine.STAMP_SPENDTHRIFT_MEDIUM_ENEMY_COUNT && _towerManager.checkForUpgrades() == com.clubpenguin.tower.GameEngine.STAMP_SPENDTHRIFT_MEDIUM_UPGRADE_COUNT)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.STRATEGIC_SUCCESS_STAMP);
            output_mc.output_txt.text = "STAMP : Strategic Success";
        } // end if
        if (_enemyManager.enemyKilledCount == com.clubpenguin.tower.GameEngine.STAMP_SPENDTHRIFT_HARD_ENEMY_COUNT && _towerManager.checkForUpgrades() == com.clubpenguin.tower.GameEngine.STAMP_SPENDTHRIFT_HARD_UPGRADE_COUNT)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.STRATEGIC_MASTER_STAMP);
            output_mc.output_txt.text = "STAMP : Strategic Master";
        } // end if
        if (_enemyManager.enemyKilledCount == com.clubpenguin.tower.GameEngine.STAMP_SPENDTHRIFT_EXTREME_ENEMY_COUNT && _towerManager.checkForUpgrades() == com.clubpenguin.tower.GameEngine.STAMP_SPENDTHRIFT_EXTREME_UPGRADE_COUNT)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.STRATEGIC_EXPERT_STAMP);
            output_mc.output_txt.text = "STAMP : Strategic Expert";
        } // end if
        if (_enemyManager.enemyKilledCount == com.clubpenguin.tower.GameEngine.STAMP_PERFECT_VICTORY_MEDIUM_ENEMY_COUNT && _levelManager.cpuHitCount == com.clubpenguin.tower.GameEngine.STAMP_PERFECT_VICTORY_MEDIUM_CPU_HIT_COUNT)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.TACTICAL_PRO_STAMP);
            output_mc.output_txt.text = "STAMP : Tactical Pro";
        } // end if
        if (_enemyManager.enemyKilledCount == com.clubpenguin.tower.GameEngine.STAMP_PERFECT_VICTORY_HARD_ENEMY_COUNT && _levelManager.cpuHitCount == com.clubpenguin.tower.GameEngine.STAMP_PERFECT_VICTORY_HARD_CPU_HIT_COUNT)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.TACTICAL_ACE_STAMP);
            output_mc.output_txt.text = "STAMP : Tactical Ace";
        } // end if
        if (_displayManager.getScore() >= com.clubpenguin.tower.GameEngine.STAMP_OVER_9000_COUNT && com.clubpenguin.tower.GameEngine.STAMP_OVER_9000_COMPLETE == false)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.ENERGY_9999_STAMP);
            output_mc.output_txt.text = "STAMP : Energy 9999";
            STAMP_OVER_9000_COMPLETE = true;
        } // end if
        _displayManager.increaseScore(com.clubpenguin.tower.GameSettings.ENERGY_PER_KILL);
        _displayManager.updateScore();
    } // End of the function
    function handleTowerRemoved()
    {
        _displayManager.setMenuClickable();
        _displayManager.updateScore();
    } // End of the function
    function handleTowerCost(target)
    {
        if (target.tower == "UPGRADE_TOWER")
        {
            if (fromMenuActive == true)
            {
                _displayManager.decreaseScore(com.clubpenguin.tower.GameSettings.UPGRADE_TOWER_COST);
                fromMenuActive = false;
            } // end if
        }
        else
        {
            _displayManager.decreaseScore(target.cost);
            _levelManager.setDropZonesNormal();
        } // end else if
        _displayManager.setMenuClickable();
        _displayManager.updateScore();
        this.checkMasterMechanicStamp();
    } // End of the function
    function checkMasterMechanicStamp()
    {
        if (_towerManager.checkMasterMechanicStamp() == true && com.clubpenguin.tower.GameEngine.STAMP_MASTER_MECHANIC_COMPLETE == false)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.MASTER_MECHANIC_STAMP);
            output_mc.output_txt.text = "STAMP : Master Mechanic";
            STAMP_MASTER_MECHANIC_COMPLETE = true;
        } // end if
    } // End of the function
    function checkEliteMechanicStamp()
    {
        if (_towerManager.checkEliteMechanicStamp() == true && com.clubpenguin.tower.GameEngine.STAMP_ELITE_MECHANIC_COMPLETE == false)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.ELITE_MECHANIC_STAMP);
            output_mc.output_txt.text = "STAMP : Elite Mechanic";
            STAMP_ELITE_MECHANIC_COMPLETE = true;
        } // end if
    } // End of the function
    function handleEnemyHitCPU(target)
    {
        _enemyManager.handleEnemyHitCPU(target);
    } // End of the function
    function handleSingleUpgrade(pos)
    {
        var _loc2 = "singleUpgrade";
        fromMenu = false;
        _upgradeManager.createUpgrade(_loc2, pos, fromMenu);
    } // End of the function
    function handleEnergyUpgrade(event)
    {
        var _loc2 = "energyUpgrade";
        fromMenu = false;
        _upgradeManager.createUpgrade(_loc2, event, fromMenu);
        _displayManager.updateScore();
    } // End of the function
    function increaseEnergy(eventInfo)
    {
        var _loc2 = eventInfo.energy;
        _displayManager.increaseScore(_loc2);
        _displayManager.updateScore();
    } // End of the function
    function onTowerDropped(target)
    {
    } // End of the function
    function setDropZones(dropZones)
    {
        _towerManager.setDropZones(dropZones);
    } // End of the function
    function handleActiveUpgrade()
    {
        _towerManager.handleActiveUpgrade();
    } // End of the function
    function handleInactiveUpgrade()
    {
        this.handleTowerCost({tower: "UPGRADE_TOWER"});
        _towerManager.handleInactiveUpgrade();
        this.checkEliteMechanicStamp();
    } // End of the function
    function handleDeletedUpgrade()
    {
        _towerManager.handleInactiveUpgrade();
        _displayManager.setMenuClickable();
    } // End of the function
    function shootEnemy(target)
    {
        _enemyManager.onEnemyHit(target);
    } // End of the function
    function onShotHit(target)
    {
        _enemyManager.onEnemyHit(target);
    } // End of the function
    function gameLoop()
    {
        _levelManager.update();
        _levelManager.checkCPU(_enemyManager.getEnemies());
        _enemyManager.moveEnemies();
        _towerManager.fireTowers(_enemyManager.getEnemies());
    } // End of the function
    function get _mode()
    {
        return (mode);
    } // End of the function
    function get _scenario()
    {
        return (scenario);
    } // End of the function
    function failLevel()
    {
        delete this.onEnterFrame;
        scenario = null;
        levelScenario = null;
        btnClose.enabled = false;
        _enemyManager.cleanUp();
        _displayManager.setUpEndScreen();
        _stage.attachMovie("endScreenFail", "EndGameScreenFailure", _stage.getNextHighestDepth());
        _towerManager.cleanUp();
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode(com.clubpenguin.tower.GameEngine.DLS_STOP, com.clubpenguin.tower.GameEngine.CP_SYSTEM_DEFENDER, dlsmCallback, 0);
    } // End of the function
    function getCoins()
    {
        var _loc2 = 0;
        if (_enemyManager.enemyKilledCount == undefined)
        {
            _loc2 = 0;
            return (_loc2);
        } // end if
        _loc2 = _enemyManager.enemyKilledCount;
        _enemyManager.enemyKilledCount = 0;
        return (_loc2);
    } // End of the function
    function handleGameOver()
    {
        delete this.onEnterFrame;
        scenario = null;
        levelScenario = null;
        _enemyManager.cleanUp();
        _towerManager.cleanUp();
        _levelManager.cleanUp();
        _upgradeManager.cleanUp();
        var _loc2 = this.getCoins();
        SHELL.sendGameOver(_loc2);
    } // End of the function
    function levelComplete()
    {
        delete this.onEnterFrame;
        _upgradeManager.cleanUp();
        _enemyManager.cleanUp();
        _displayManager.setUpEndScreen();
        if (currentLevel >= 0)
        {
            this.checkForUniGunnerStamp();
        } // end if
        if (currentLevel == -1)
        {
            output_mc.output_txt.text = "STAMP : TUTORIAL COMPLETE";
            _sdClient.sendEPFMedalCheck(com.clubpenguin.tower.GameSettings.TUTORIAL_STAMP);
        } // end if
        if (currentLevel == 0)
        {
            _sdClient.sendEPFMedalCheck(com.clubpenguin.tower.GameSettings.__activeStampId);
        } // end if
        if (currentLevel == 1)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.LEVEL_1_STAMP);
        } // end if
        if (currentLevel == 2)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.LEVEL_2_STAMP);
        } // end if
        if (currentLevel == 3)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.LEVEL_3_STAMP);
        } // end if
        if (currentLevel == 4)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.LEVEL_4_STAMP);
        } // end if
        if (currentLevel == 5)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.LEVEL_5_STAMP);
        } // end if
        _stage.attachMovie("endScreenComplete", "endScreenComplete", _stage.getNextHighestDepth());
        _stage.createEmptyMovieClip("gameEndCompleteHolder", _stage.getNextHighestDepth());
        var _loc2 = new Sound(_stage.gameEndCompleteHolder);
        _loc2.attachSound("GameWin");
        _loc2.start();
        _towerManager.cleanUp();
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode(com.clubpenguin.tower.GameEngine.DLS_STOP, com.clubpenguin.tower.GameEngine.CP_SYSTEM_DEFENDER, dlsmCallback, 0);
    } // End of the function
    function checkForUniGunnerStamp()
    {
        if (_towerManager.checkForUniGunnerStamp() == true)
        {
            com.clubpenguin.util.Stamp.sendStamp(com.clubpenguin.tower.GameSettings.UNIGUNNER_STAMP);
            output_mc.output_txt.text = "STAMP : Unigunner";
        }
        else
        {
            return;
        } // end else if
    } // End of the function
    function dTrace(_msg)
    {
    } // End of the function
    function dlsmCallback(stringArg)
    {
    } // End of the function
    function toString()
    {
        return ("[GameEngine " + $_instanceID + "]");
    } // End of the function
    var $_instanceID = 0;
    var fromMenu = false;
    var fromMenuActive = false;
    var startingEnergy = com.clubpenguin.tower.GameSettings.STARTING_ENERGY;
    static var MODE_TUTORIAL = "MODE_TUTORIAL";
    static var MODE_SURVIVAL = "MODE_SURVIVAL";
    static var MODE_SCENARIO = "MODE_SCENARIO";
    static var OK_BTN = "OK_BTN";
    static var TRY_AGAIN = "TRY_AGAIN";
    static var CLOSE_BTN = "CLOSE_BTN";
    var gameIsPaused = false;
    static var CP_SYSTEM_DEFENDER = "D6CDCEB6-DE82-DD82-D0BF-C5D113C0E21C";
    static var SYSTEM_DEFENDER_MISSION_QUARTERS = "E307EA2E-594E-C294-DED7-F86EEE7ED467";
    static var SYSTEM_DEFENDER_ELITE = "77102839-D78E-46B5-37F8-7533461EEDC4";
    static var SYSTEM_DEFENDER_SURVIVAL = "B69698FF-8511-7DE3-C255-39B74ACB2C37";
    static var SURVIVAL_LEVEL_1 = "12144FC4-4C46-7BB8-DA27-EBE75434918B";
    static var SURVIVAL_LEVEL_2 = "1701635A-206D-6025-648F-24079F5F40B5";
    static var SURVIVAL_LEVEL_3 = "4546F690-9700-F1EC-BC94-45211E0B2BAE";
    static var SURVIVAL_LEVEL_4 = "4CA36F90-1096-0355-68AD-CD3627B4C72F";
    static var SURVIVAL_LEVEL_5 = "6325895F-D722-E276-DB58-96E25981748E";
    static var SURVIVAL_LEVEL_6 = "C0F042DE-40FE-243E-AAFF-B1C2F9725E97";
    static var DLSURL = "k.api.dlsnetwork.com";
    static var DLS_STOP = "stop";
    static var LEARNER_SCORE = "learnerscore";
    static var DLS_SELECT = "selected";
    var opArray = [com.clubpenguin.tower.GameEngine.SURVIVAL_LEVEL_1, com.clubpenguin.tower.GameEngine.SURVIVAL_LEVEL_2, com.clubpenguin.tower.GameEngine.SURVIVAL_LEVEL_3, com.clubpenguin.tower.GameEngine.SURVIVAL_LEVEL_4, com.clubpenguin.tower.GameEngine.SURVIVAL_LEVEL_5, com.clubpenguin.tower.GameEngine.SURVIVAL_LEVEL_6];
    static var STAMP_GARBAGE_DISPOLSAL_ENEMY_COUNT = 100;
    static var STAMP_SPENDTHRIFT_MEDIUM_ENEMY_COUNT = 100;
    static var STAMP_SPENDTHRIFT_MEDIUM_UPGRADE_COUNT = 0;
    static var STAMP_SPENDTHRIFT_HARD_ENEMY_COUNT = 250;
    static var STAMP_SPENDTHRIFT_HARD_UPGRADE_COUNT = 0;
    static var STAMP_SPENDTHRIFT_EXTREME_ENEMY_COUNT = 1000;
    static var STAMP_SPENDTHRIFT_EXTREME_UPGRADE_COUNT = 0;
    static var STAMP_PERFECT_VICTORY_MEDIUM_ENEMY_COUNT = 100;
    static var STAMP_PERFECT_VICTORY_MEDIUM_CPU_HIT_COUNT = 0;
    static var STAMP_PERFECT_VICTORY_HARD_ENEMY_COUNT = 250;
    static var STAMP_PERFECT_VICTORY_HARD_CPU_HIT_COUNT = 0;
    static var STAMP_OVER_9000_COMPLETE = false;
    static var STAMP_OVER_9000_COUNT = 9999;
    static var STAMP_MASTER_MECHANIC_COMPLETE = false;
    static var STAMP_ELITE_MECHANIC_COMPLETE = false;
    var visible_status = true;
    var debug_mode = false;
} // End of Class
