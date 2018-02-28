class com.clubpenguin.tower.levels.views.AbstractLevelView implements com.clubpenguin.tower.levels.interfaces.ILevelView
{
    var _mc, updateListeners;
    function AbstractLevelView(scope)
    {
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        if (LINKAGE_ID == "" || NAME == "")
        {
            throw new Error("LINKAGE_ID and NAME must be overidden by subclass");
        } // end if
        _mc = scope.background.attachMovie(LINKAGE_ID, NAME, scope.background.getNextHighestDepth());
        com.clubpenguin.tower.display.views.AbstractDisplayView.__instance.addEventListener(com.clubpenguin.tower.display.views.AbstractDisplayView.TOWER_CLICKED, com.clubpenguin.tower.util.Delegate.create(this, handleTowerClicked));
        this.attachEvents();
        var _loc5 = _global.getCurrentShell();
        if (_loc5.MUSIC.isMusicMuted())
        {
            return;
        } // end if
        scope.createEmptyMovieClip("scenarioMusicHolder", scope.getNextHighestDepth());
        var _loc4 = new Sound(scope.scenarioMusicHolder);
        _loc4.attachSound("ScenarioMusic");
        _loc4.start(0, 99);
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function removeEventListener()
    {
    } // End of the function
    function setPosition()
    {
        _mc._x = 0;
        _mc._y = 0;
    } // End of the function
    function onCPUHit(target)
    {
        if (target._view.NAME == "RedBossView" || target._view.NAME == "PurpleBossView" || target._view.NAME == "YellowBossView")
        {
            hitAmount = hitAmount + BOSS_DAMAGE_AMOUNT;
        }
        else
        {
            ++hitAmount;
        } // end else if
        var _loc3 = 100 * (CPUHealth - hitAmount) / 15;
        _mc.CPU.healthBar.bar._xscale = _loc3;
        if (hitAmount >= 2 && hitAmount < 5 && damageStateOneComplete == false)
        {
            _mc.CPU.gotoAndPlay("damageStateOne");
            damageStateOneComplete = true;
        }
        else if (hitAmount >= 5 && hitAmount < 8 && damageStateTwoComplete == false)
        {
            _mc.CPU.gotoAndPlay("damageStateTwo");
            damageStateTwoComplete = true;
        }
        else if (hitAmount >= 8 && hitAmount < 12 && damageStateThreeComplete == false)
        {
            _mc.CPU.gotoAndPlay("damageStateThree");
            damageStateThreeComplete = true;
        }
        else if (hitAmount >= 12 && hitAmount < 15 && damageStateFourComplete == false)
        {
            _mc.CPU.gotoAndPlay("damageStateFour");
            damageStateFourComplete = true;
        } // end else if
        this.updateListeners(com.clubpenguin.tower.levels.views.AbstractLevelView.ON_ENEMY_HIT_CPU, target);
        if (hitAmount >= 15)
        {
            this.updateListeners(com.clubpenguin.tower.levels.views.AbstractLevelView.ON_CPU_DESTROYED);
        } // end if
    } // End of the function
    function handleTowerClicked()
    {
        for (var _loc2 in _mc.dropZones_mc)
        {
            if (typeof(_mc.dropZones_mc[_loc2]) == "movieclip")
            {
                _mc.dropZones_mc[_loc2].gotoAndPlay("fadein");
            } // end if
        } // end of for...in
    } // End of the function
    function setDropZonesNormal()
    {
        for (var _loc2 in _mc.dropZones_mc)
        {
            if (typeof(_mc.dropZones_mc[_loc2]) == "movieclip")
            {
                _mc.dropZones_mc[_loc2].gotoAndPlay("fadeout");
            } // end if
        } // end of for...in
    } // End of the function
    function cleanUp()
    {
        removeMovieClip (_mc);
    } // End of the function
    function attachEvents()
    {
    } // End of the function
    static var ON_ENEMY_HIT_CPU = "onEnemyHitCPU";
    static var ON_CPU_DESTROYED = "onCpuDestroyed";
    var BOSS_DAMAGE_AMOUNT = com.clubpenguin.tower.GameSettings.BOSS_DAMAGE_AMOUNT;
    var LINKAGE_ID = "";
    var NAME = "";
    var hitAmount = 0;
    var CPUHealth = 15;
    var damageStateOneComplete = false;
    var damageStateTwoComplete = false;
    var damageStateThreeComplete = false;
    var damageStateFourComplete = false;
} // End of Class
