class com.clubpenguin.tower.display.DisplayManager
{
    var _stage, _displayFactory, laserTowerCost, snowballTowerCost, rocketTowerCost, upgradeTowerCost, display, updateListeners;
    function DisplayManager(stage)
    {
        _stage = stage;
        _displayFactory = new com.clubpenguin.tower.display.DisplayFactory();
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function removeEventListener()
    {
    } // End of the function
    function createDisplay(startingEnergy, LASER_TOWER_COST, SNOWBALL_TOWER_COST, ROCKET_TOWER_COST, UPGRADE_TOWER_COST)
    {
        laserTowerCost = LASER_TOWER_COST;
        snowballTowerCost = SNOWBALL_TOWER_COST;
        rocketTowerCost = ROCKET_TOWER_COST;
        upgradeTowerCost = UPGRADE_TOWER_COST;
        ++uniqueID;
        display = _displayFactory.create(_stage, com.clubpenguin.tower.display.DisplayFactory.DISPLAY, uniqueID, startingEnergy, LASER_TOWER_COST, SNOWBALL_TOWER_COST, ROCKET_TOWER_COST, UPGRADE_TOWER_COST);
        display.addEventListener(com.clubpenguin.tower.display.types.AbstractDisplay.TOWER_CLICKED, onTowerClicked, this);
        display.addEventListener(com.clubpenguin.tower.display.types.AbstractDisplay.PAUSE_GAME, onPauseGame, this);
    } // End of the function
    function onPauseGame()
    {
        this.updateListeners(com.clubpenguin.tower.display.DisplayManager.PAUSE_GAME);
    } // End of the function
    function setMenuClickable()
    {
        display.setMenuClickable();
    } // End of the function
    function increaseScore(amount)
    {
        display.increaseScore(amount);
    } // End of the function
    function decreaseScore(cost)
    {
        display.decreaseScore(cost);
    } // End of the function
    function updateScore()
    {
        display.updateScore();
    } // End of the function
    function getScore()
    {
        return (display.getScore());
    } // End of the function
    function onTowerClicked(event)
    {
        this.updateListeners(com.clubpenguin.tower.display.DisplayManager.TOWER_CLICKED, event);
    } // End of the function
    function setUpEndScreen()
    {
        display.setUpEndScreen();
    } // End of the function
    function cleanUp()
    {
        display.cleanUp();
        display = null;
    } // End of the function
    var uniqueID = 0;
    var rocketHidden = false;
    var laserHidden = false;
    var snowballHidden = false;
    static var TOWER_CLICKED = "towerClicked";
    static var PAUSE_GAME = "pauseGame";
} // End of Class
