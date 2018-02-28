class com.clubpenguin.tower.display.views.AbstractDisplayView implements com.clubpenguin.tower.display.interfaces.IDisplayView
{
    var _mc, _score, _stage, _laserTowerCost, _snowballTowerCost, _rocketTowerCost, _upgradeTowerCost, updateListeners;
    static var __instance;
    function AbstractDisplayView(scope, id, startingEnergy)
    {
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        if (LINKAGE_ID == "" || NAME == "")
        {
            throw new Error("LINKAGE_ID and NAME must be overidden by subclass");
        } // end if
        _mc = scope.hud.attachMovie(LINKAGE_ID, NAME + "_" + id, scope.hud.getNextHighestDepth());
        __instance = this;
        _mc.dialogue.speech._visible = false;
        this.setStartingEnergy(startingEnergy);
        _score = startingEnergy;
        _stage = scope;
        this.attachEvents();
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function dispatchEvent()
    {
    } // End of the function
    function removeEventListener()
    {
    } // End of the function
    function setStartingEnergy(startingEnergy)
    {
        _mc.energy.energyText.txt.text = startingEnergy;
    } // End of the function
    function setMenuClickable()
    {
        _mc.towers.laserTowerBtn.gotoAndStop(_menuShowFrame);
        _mc.towers.rocketTowerBtn.gotoAndStop(_menuShowFrame);
        _mc.towers.snowballTowerBtn.gotoAndStop(_menuShowFrame);
        _mc.towers.upgradeTowerBtn.gotoAndStop(_menuShowFrame);
        this.attachEvents();
    } // End of the function
    function setUpTowerCosts(__laserTowerCost, __snowballTowerCost, __rocketTowerCost, __upgradeTowerCost)
    {
        _laserTowerCost = __laserTowerCost;
        _snowballTowerCost = __snowballTowerCost;
        _rocketTowerCost = __rocketTowerCost;
        _upgradeTowerCost = __upgradeTowerCost;
        _mc.towers.laserTowerCost.text = __laserTowerCost;
        _mc.towers.snowballTowerCost.text = __snowballTowerCost;
        _mc.towers.rocketTowerCost.text = __rocketTowerCost;
        _mc.towers.upgradeTowerCost.text = __upgradeTowerCost;
    } // End of the function
    function cleanUp()
    {
        removeMovieClip (_mc);
    } // End of the function
    function attachEvents()
    {
        _mc.towers.laserTowerBtn.createLaserTower.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOver, com.clubpenguin.tower.display.views.AbstractDisplayView.LASER_TOWER);
        _mc.towers.laserTowerBtn.createLaserTower.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut, com.clubpenguin.tower.display.views.AbstractDisplayView.LASER_TOWER);
        _mc.towers.laserTowerBtn.createLaserTower.onPress = com.clubpenguin.tower.util.Delegate.create(this, onTowerSelect, com.clubpenguin.tower.display.views.AbstractDisplayView.LASER_TOWER, _mc.towers.laserTowerBtn);
        _mc.towers.snowballTowerBtn.createSnowballTower.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOver, com.clubpenguin.tower.display.views.AbstractDisplayView.SNOWBALL_TOWER);
        _mc.towers.snowballTowerBtn.createSnowballTower.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut, com.clubpenguin.tower.display.views.AbstractDisplayView.SNOWBALL_TOWER);
        _mc.towers.snowballTowerBtn.createSnowballTower.onPress = com.clubpenguin.tower.util.Delegate.create(this, onTowerSelect, com.clubpenguin.tower.display.views.AbstractDisplayView.SNOWBALL_TOWER, _mc.towers.snowballTowerBtn);
        _mc.towers.rocketTowerBtn.createRocketTower.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOver, com.clubpenguin.tower.display.views.AbstractDisplayView.ROCKET_TOWER);
        _mc.towers.rocketTowerBtn.createRocketTower.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut, com.clubpenguin.tower.display.views.AbstractDisplayView.ROCKET_TOWER);
        _mc.towers.rocketTowerBtn.createRocketTower.onPress = com.clubpenguin.tower.util.Delegate.create(this, onTowerSelect, com.clubpenguin.tower.display.views.AbstractDisplayView.ROCKET_TOWER, _mc.towers.rocketTowerBtn);
        _mc.towers.upgradeTowerBtn.createUpgrade.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOver, com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_TOWER);
        _mc.towers.upgradeTowerBtn.createUpgrade.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, onTowerRollOut, com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_TOWER);
        _mc.towers.upgradeTowerBtn.createUpgrade.onPress = com.clubpenguin.tower.util.Delegate.create(this, onTowerSelect, com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_TOWER, _mc.towers.upgradeTowerBtn);
    } // End of the function
    function onButtonReleaseOutside(tower)
    {
    } // End of the function
    function onButtonRelease(tower)
    {
    } // End of the function
    function onPauseRelease()
    {
        this.updateListeners(com.clubpenguin.tower.display.views.AbstractDisplayView.PAUSE_GAME);
    } // End of the function
    function onTowerRollOver(tower)
    {
        switch (tower)
        {
            case com.clubpenguin.tower.display.views.AbstractDisplayView.LASER_TOWER:
            {
                _mc.towers.laserTowerBtn.createLaserTower.gotoAndStop(_buttonRolloverFrame);
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.SNOWBALL_TOWER:
            {
                _mc.towers.snowballTowerBtn.createSnowballTower.gotoAndStop(_buttonRolloverFrame);
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.ROCKET_TOWER:
            {
                _mc.towers.rocketTowerBtn.createRocketTower.gotoAndStop(_buttonRolloverFrame);
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_TOWER:
            {
                _mc.towers.upgradeTowerBtn.createUpgradeTower.gotoAndStop(_buttonRolloverFrame);
                break;
            } 
        } // End of switch
    } // End of the function
    function increaseScore(__score)
    {
        _score = __score;
        _mc.energy.energyText.txt.text = __score;
    } // End of the function
    function decreaseScore(__score)
    {
        _score = __score;
        _mc.energy.energyText.txt.text = __score;
        _haveTower = false;
    } // End of the function
    function onTowerRollOut(tower)
    {
        switch (tower)
        {
            case com.clubpenguin.tower.display.views.AbstractDisplayView.LASER_TOWER:
            {
                _mc.towers.laserTowerBtn.createLaserTower.gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.SNOWBALL_TOWER:
            {
                _mc.towers.snowballTowerBtn.createSnowballTower.gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.ROCKET_TOWER:
            {
                _mc.towers.rocketTowerBtn.createRocketTower.gotoAndStop(1);
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_TOWER:
            {
                _mc.towers.upgradeTowerBtn.createUpgrade.gotoAndStop(1);
                break;
            } 
        } // End of switch
    } // End of the function
    function onTowerSelect(tower, _origin)
    {
        _mc.towers.laserTowerBtn.gotoAndStop(_menuHiddenFrame);
        _mc.towers.rocketTowerBtn.gotoAndStop(_menuHiddenFrame);
        _mc.towers.snowballTowerBtn.gotoAndStop(_menuHiddenFrame);
        _mc.towers.upgradeTowerBtn.gotoAndStop(_menuHiddenFrame);
        _haveTower = true;
        switch (tower)
        {
            case com.clubpenguin.tower.display.views.AbstractDisplayView.LASER_TOWER:
            {
                this.dispatchEvent({type: com.clubpenguin.tower.display.views.AbstractDisplayView.TOWER_CLICKED});
                this.onTowerRollOut(com.clubpenguin.tower.display.views.AbstractDisplayView.LASER_TOWER);
                this.updateListeners(com.clubpenguin.tower.display.views.AbstractDisplayView.CLICK, {target: _origin, tower: tower});
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.SNOWBALL_TOWER:
            {
                this.dispatchEvent({type: com.clubpenguin.tower.display.views.AbstractDisplayView.TOWER_CLICKED});
                this.onTowerRollOut(com.clubpenguin.tower.display.views.AbstractDisplayView.SNOWBALL_TOWER);
                this.updateListeners(com.clubpenguin.tower.display.views.AbstractDisplayView.CLICK, {target: _origin, tower: tower});
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.ROCKET_TOWER:
            {
                this.dispatchEvent({type: com.clubpenguin.tower.display.views.AbstractDisplayView.TOWER_CLICKED});
                this.onTowerRollOut(com.clubpenguin.tower.display.views.AbstractDisplayView.ROCKET_TOWER);
                this.updateListeners(com.clubpenguin.tower.display.views.AbstractDisplayView.CLICK, {target: _origin, tower: tower});
                break;
            } 
            case com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_TOWER:
            {
                this.dispatchEvent({type: com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_CLICKED});
                this.onTowerRollOut(com.clubpenguin.tower.display.views.AbstractDisplayView.UPGRADE_TOWER);
                this.updateListeners(com.clubpenguin.tower.display.views.AbstractDisplayView.CLICK, {target: _origin, tower: tower});
                break;
            } 
        } // End of switch
    } // End of the function
    function showDialogue(avatar, speech)
    {
        _mc.dialogue.avatar.gotoAndStop(avatar);
        var _loc4;
        var _loc3;
        _loc3 = avatar.indexOf("_", 0);
        _loc4 = avatar.substring(0, _loc3 == -1 ? (avatar.length - 1) : (_loc3));
        if (avatar == "dot_calm" || avatar == "dot_cocky" || avatar == "dot_steely" || avatar == "dot_suprised" || avatar == "dot_worried")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("dot_name");
        }
        else if (avatar == "gary_calm" || avatar == "gary_happy" || avatar == "gary_steely" || avatar == "gary_suprised")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("gary_name");
        }
        else if (avatar == "herbert_calm" || avatar == "herbert_confident" || avatar == "herbert_angry" || avatar == "herbert_suprised" || avatar == "herbert_worried")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("herbert_name");
        }
        else if (avatar == "jetbot_calm" || avatar == "jetbot_mal")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("jetbot_name");
        }
        else if (avatar == "jetpack_cocky" || avatar == "jetpack_neutral" || avatar == "jetpack_steely" || avatar == "jetpack_suprised")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("jetpack_name");
        }
        else if (avatar == "klutzy_calm" || avatar == "klutzy_suprised" || avatar == "klutzy_worried")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("klutzy_name");
        }
        else if (avatar == "protobot_calm" || avatar == "protobot_mal")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("protobot_name");
        }
        else if (avatar == "rookie_cocky" || avatar == "rookie_steely" || avatar == "rookie_suprised" || avatar == "rookie_neutral")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("rookie_name");
        }
        else if (avatar == "snowbot_calm" || avatar == "snowbot_mal")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("snowbot_name");
        }
        else if (avatar == "mysterybot")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("mysterybot_name");
        }
        else if (avatar == "orangebug")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("orange_name");
        }
        else if (avatar == "purplebug")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("purple_name");
        }
        else if (avatar == "redbug")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("red_name");
        }
        else if (avatar == "director")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("director_name");
        }
        else if (avatar == "wheelbot_calm")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("wheelbot_name");
        }
        else if (avatar == "wheelbot_mal")
        {
            _mc.dialogue.speech.name.text = com.clubpenguin.lib.locale.LocaleText.getText("wheelbot_name");
        } // end else if
        _mc.dialogue.speech._visible = true;
        _mc.dialogue.speech.body.text = speech;
    } // End of the function
    function hideDialogue()
    {
        _mc.dialogue.avatar.gotoAndStop("none");
        _mc.dialogue.speech._visible = false;
    } // End of the function
    function hideLaser()
    {
        _mc.towers.laserTowerBtn.gotoAndStop(_menuHiddenFrame);
    } // End of the function
    function hideUpgrade()
    {
        _mc.towers.upgradeTowerBtn.gotoAndStop(_menuHiddenFrame);
    } // End of the function
    function hideRocket()
    {
        _mc.towers.rocketTowerBtn.gotoAndStop(_menuHiddenFrame);
    } // End of the function
    function hideSnowball()
    {
        _mc.towers.snowballTowerBtn.gotoAndStop(_menuHiddenFrame);
    } // End of the function
    function showLaser()
    {
        _mc.towers.laserTowerBtn.gotoAndStop(_menuShowFrame);
        this.attachEvents();
    } // End of the function
    function showUpgrade()
    {
        _mc.towers.upgradeTowerBtn.gotoAndStop(_menuShowFrame);
        this.attachEvents();
    } // End of the function
    function showRocket()
    {
        _mc.towers.rocketTowerBtn.gotoAndStop(_menuShowFrame);
        this.attachEvents();
    } // End of the function
    function showSnowball()
    {
        _mc.towers.snowballTowerBtn.gotoAndStop(_menuShowFrame);
        this.attachEvents();
    } // End of the function
    function getHaveTower()
    {
        return (_haveTower);
    } // End of the function
    function setUpEndScreen()
    {
        _mc.towers.laserTowerBtn.gotoAndStop(_menuHiddenFrame);
        _mc.towers.rocketTowerBtn.gotoAndStop(_menuHiddenFrame);
        _mc.towers.snowballTowerBtn.gotoAndStop(_menuHiddenFrame);
        _mc.towers.upgradeTowerBtn.gotoAndStop(_menuHiddenFrame);
    } // End of the function
    function handleNotEnoughEnergy()
    {
        var _loc2;
        var _loc4 = 95;
        var _loc3 = 105;
        _loc2 = _stage.hud.attachMovie("notEnoughEnergyText", "notEnoughEnergyText", _stage.hud.getNextHighestDepth());
        _loc2._x = _loc3;
        _loc2._y = _loc4;
        _loc2.play();
    } // End of the function
    static var LASER_TOWER = "LASER_TOWER";
    static var SNOWBALL_TOWER = "SNOWBALL_TOWER";
    static var ROCKET_TOWER = "ROCKET_TOWER";
    static var UPGRADE_TOWER = "UPGRADE_TOWER";
    static var CLICK = "click";
    static var TOWER_CLICKED = "towerClicked";
    static var UPGRADE_CLICKED = "upgradeClicked";
    static var PAUSE_GAME = "pauseGame";
    var LINKAGE_ID = "";
    var NAME = "";
    var MENU_FADED_FRAME = 2;
    var _menuHiddenFrame = 2;
    var _menuShowFrame = 1;
    var _buttonRolloverFrame = 2;
    var _haveTower = false;
    static var WHEELBOT = com.clubpenguin.lib.locale.LocaleText.getText("wheelbot_name");
} // End of Class
