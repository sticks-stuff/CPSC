class com.clubpenguin.tower.display.types.AbstractDisplay implements com.clubpenguin.tower.display.interfaces.IDisplay
{
    var _laserTowerCost, _snowballTowerCost, _rocketTowerCost, _upgradeCost, _id, _view, _score, updateListeners;
    static var instance;
    function AbstractDisplay(id, startingEnergy, LASER_TOWER_COST, SNOWBALL_TOWER_COST, ROCKET_TOWER_COST, UPGRADE_TOWER_COST, view)
    {
        instance = this;
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        _laserTowerCost = LASER_TOWER_COST;
        _snowballTowerCost = SNOWBALL_TOWER_COST;
        _rocketTowerCost = ROCKET_TOWER_COST;
        _upgradeCost = UPGRADE_TOWER_COST;
        _id = id;
        _view = view;
        _score = startingEnergy;
        this.setUpTextFields();
        this.attachListeners();
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function removeEventListener()
    {
    } // End of the function
    function attachListeners()
    {
        _view.addEventListener(com.clubpenguin.tower.display.views.AbstractDisplayView.CLICK, onTowerRelease, this);
        _view.addEventListener(com.clubpenguin.tower.display.views.AbstractDisplayView.PAUSE_GAME, onPauseGame, this);
    } // End of the function
    function onPauseGame()
    {
        this.updateListeners(com.clubpenguin.tower.display.types.AbstractDisplay.PAUSE_GAME);
    } // End of the function
    function setUpTextFields()
    {
        _view.setUpTowerCosts(_laserTowerCost, _snowballTowerCost, _rocketTowerCost, _upgradeCost);
    } // End of the function
    function increaseScore(amount)
    {
        if (!amount)
        {
            amount = 10;
            _score = _score + amount;
            _view.increaseScore(_score);
            this.getScore(_score);
        }
        else
        {
            _score = _score + amount;
            _view.increaseScore(_score);
            this.getScore(_score);
        } // end else if
    } // End of the function
    function decreaseScore(cost)
    {
        if (_score - cost < 0)
        {
            return;
        } // end if
        _score = _score - cost;
        _view.decreaseScore(_score);
        this.getScore(_score);
    } // End of the function
    function updateScore()
    {
        if (this.getHaveTower())
        {
            return;
        } // end if
        if (this.getScore() < _upgradeCost)
        {
            this.hideUpgrade();
        }
        else
        {
            this.showUpgrade();
        } // end else if
        if (this.getScore() < _rocketTowerCost)
        {
            this.hideRocket();
        }
        else
        {
            this.showRocket();
        } // end else if
        if (this.getScore() < _snowballTowerCost)
        {
            this.hideSnowball();
        }
        else
        {
            this.showSnowball();
        } // end else if
        if (this.getScore() < _laserTowerCost)
        {
            this.hideLaser();
        }
        else
        {
            this.showLaser();
        } // end else if
    } // End of the function
    function setMenuClickable()
    {
        if (this.getScore() < _upgradeCost)
        {
            this.hideUpgrade();
        }
        else
        {
            this.showUpgrade();
        } // end else if
        if (this.getScore() < _rocketTowerCost)
        {
            this.hideRocket();
        }
        else
        {
            this.showRocket();
        } // end else if
        if (this.getScore() < _snowballTowerCost)
        {
            this.hideSnowball();
        }
        else
        {
            this.showSnowball();
        } // end else if
        if (this.getScore() < _laserTowerCost)
        {
            this.hideLaser();
        }
        else
        {
            this.showLaser();
        } // end else if
    } // End of the function
    function showDialogue(avatar, speech)
    {
        _view.showDialogue(avatar, speech);
    } // End of the function
    function getScore(score)
    {
        return (_score);
    } // End of the function
    function hideDialogue()
    {
        _view.hideDialogue();
    } // End of the function
    function hideLaser()
    {
        _view.hideLaser();
    } // End of the function
    function hideRocket()
    {
        _view.hideRocket();
    } // End of the function
    function hideUpgrade()
    {
        _view.hideUpgrade();
    } // End of the function
    function hideSnowball()
    {
        _view.hideSnowball();
    } // End of the function
    function showLaser()
    {
        _view.showLaser();
    } // End of the function
    function showUpgrade()
    {
        _view.showUpgrade();
    } // End of the function
    function showRocket()
    {
        _view.showRocket();
    } // End of the function
    function showSnowball()
    {
        _view.showSnowball();
    } // End of the function
    function getHaveTower()
    {
        return (_view.getHaveTower());
    } // End of the function
    function onTowerRelease(event)
    {
        this.updateListeners(com.clubpenguin.tower.display.types.AbstractDisplay.TOWER_CLICKED, {target: event.target, tower: event.tower, score: _score});
    } // End of the function
    function setUpEndScreen()
    {
        _view.setUpEndScreen();
    } // End of the function
    function cleanUp()
    {
        _view.cleanUp();
    } // End of the function
    static var TOWER_CLICKED = "towerClicked";
    static var PAUSE_GAME = "pauseGame";
} // End of Class
