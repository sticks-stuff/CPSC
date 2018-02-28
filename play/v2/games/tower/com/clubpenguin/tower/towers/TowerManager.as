class com.clubpenguin.tower.towers.TowerManager extends com.clubpenguin.tower.util.EventDispatcher
{
    var _stage, _towerFactory, _currentScore, numOfUpgradedTowers, updateListeners, _xpos, _ypos, _dropZones, removeAllListeners;
    static var __instance, _towers;
    function TowerManager(stage)
    {
        super();
        __instance = this;
        _stage = stage;
        _towerFactory = new com.clubpenguin.tower.towers.TowerFactory();
        _towers = new Array();
    } // End of the function
    function createTowers(target, type, score)
    {
        _currentScore = score;
        var _loc2;
        _loc2 = _towerFactory.getTowerByType(type);
        _loc2.addEventListener(com.clubpenguin.tower.towers.types.AbstractTower.SHOOT_ENEMY, shootEnemy, this);
        _loc2.addEventListener(com.clubpenguin.tower.towers.types.AbstractTower.TOWER_DROPPED, onTowerDropped, this);
        _loc2.addEventListener(com.clubpenguin.tower.towers.types.AbstractTower.TOWER_COST, handleTowerCost, this);
        _loc2.setOrigin(target);
        _loc2.show();
        com.clubpenguin.tower.towers.TowerManager._towers.push(_loc2);
    } // End of the function
    static function getTowers()
    {
        return (com.clubpenguin.tower.towers.TowerManager._towers);
    } // End of the function
    function generateTowers(_isPlaceable)
    {
        numOfUpgradedTowers = 0;
        _towerFactory.generateTowers(this.getDropZones().length, _stage, this.getDropZones(), com.clubpenguin.tower.towers.TowerManager._towers, _isPlaceable);
    } // End of the function
    function onTowerDropped(target)
    {
        this.updateListeners(com.clubpenguin.tower.towers.TowerManager.TOWER_DROPPED, target);
        _xpos = target._xpos;
        _ypos = target._ypos;
        ++__towerCount;
    } // End of the function
    function handleTowerCost(target)
    {
        this.updateListeners(com.clubpenguin.tower.towers.TowerManager.TOWER_COST, target);
    } // End of the function
    function shootEnemy(target)
    {
        this.updateListeners(com.clubpenguin.tower.towers.TowerManager.SHOOT_ENEMY, target);
    } // End of the function
    function handleActiveUpgrade()
    {
        var _loc2;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.tower.towers.TowerManager._towers.length; ++_loc1)
        {
            _loc2 = com.clubpenguin.tower.towers.TowerManager._towers[_loc1];
            _loc2.handleActiveUpgrade();
        } // end of for
    } // End of the function
    function handleInactiveUpgrade()
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.tower.towers.TowerManager._towers.length; ++_loc1)
        {
            com.clubpenguin.tower.towers.TowerManager._towers[_loc1].handleInactiveUpgrade();
        } // end of for
    } // End of the function
    function checkForUpgrades()
    {
        for (var _loc2 = 0; _loc2 < com.clubpenguin.tower.towers.TowerManager._towers.length; ++_loc2)
        {
            if (com.clubpenguin.tower.towers.TowerManager._towers[_loc2].checkForUpgrades() == true)
            {
                ++numOfUpgradedTowers;
            } // end if
        } // end of for
        return (numOfUpgradedTowers);
    } // End of the function
    function handleUpgradeTower(upgradeTowerID)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.tower.towers.TowerManager._towers.length; ++_loc1)
        {
            if (upgradeTowerID == com.clubpenguin.tower.towers.TowerManager._towers[_loc1]._id)
            {
                com.clubpenguin.tower.towers.TowerManager._towers[_loc1].handleUpgrade();
            } // end if
        } // end of for
    } // End of the function
    function onShotHit(target)
    {
        this.updateListeners(com.clubpenguin.tower.towers.TowerManager.SHOT_HIT, target);
    } // End of the function
    function getDropZones()
    {
        return (_dropZones);
    } // End of the function
    function getTowerCost()
    {
        return (0);
    } // End of the function
    function setDropZones(dropZones)
    {
        _dropZones = dropZones;
    } // End of the function
    function fireTowers(allTargets)
    {
        var _loc1 = 0;
        var _loc2;
        while (_loc1 < com.clubpenguin.tower.towers.TowerManager._towers.length)
        {
            _loc2 = com.clubpenguin.tower.towers.TowerManager._towers[_loc1].checkForRange(allTargets);
            if (_loc2)
            {
                com.clubpenguin.tower.towers.TowerManager._towers[_loc1].shoot(_loc2);
            } // end if
            ++_loc1;
        } // end while
    } // End of the function
    function getTowerPosition()
    {
        var _loc3 = _stage._xmouse;
        var _loc2 = _stage._ymouse;
        return (new flash.geom.Point(_loc3, _loc2));
    } // End of the function
    function checkForUniGunnerStamp()
    {
        var _loc3 = 0;
        var _loc2 = 0;
        var _loc4 = 0;
        for (var _loc1 = 0; _loc1 < com.clubpenguin.tower.towers.TowerManager._towers.length; ++_loc1)
        {
            if (com.clubpenguin.tower.towers.TowerManager._towers[_loc1].getTowerType() == "LaserTower")
            {
                ++_loc3;
                continue;
            } // end if
            if (com.clubpenguin.tower.towers.TowerManager._towers[_loc1].getTowerType() == "RocketTower")
            {
                ++_loc2;
                continue;
            } // end if
            if (com.clubpenguin.tower.towers.TowerManager._towers[_loc1].getTowerType() == "SnowballTower")
            {
                ++_loc4;
            } // end if
        } // end of for
        if (_loc3 > 0 && _loc2 == 0 && _loc4 == 0)
        {
            return (true);
        }
        else if (_loc2 > 0 && _loc3 == 0 && _loc4 == 0)
        {
            return (true);
        }
        else if (_loc4 > 0 && _loc3 == 0 && _loc2 == 0)
        {
            return (true);
        } // end else if
    } // End of the function
    function cleanUpTower(tower)
    {
        _towerFactory.returnTower(tower);
        com.clubpenguin.tower.towers.TowerManager._towers.splice();
        this.updateListeners(com.clubpenguin.tower.towers.TowerManager.TOWER_REMOVED, this);
        return;
    } // End of the function
    function checkEliteMechanicStamp()
    {
        var _loc3 = 0;
        for (var _loc2 = 0; _loc2 < com.clubpenguin.tower.towers.TowerManager._towers.length; ++_loc2)
        {
            if (com.clubpenguin.tower.towers.TowerManager._towers[_loc2]._upgradeCount >= 2)
            {
                ++_loc3;
            } // end if
        } // end of for
        if (_loc3 == _dropZones.length)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function checkMasterMechanicStamp()
    {
        if (com.clubpenguin.tower.towers.TowerManager._towers.length == _dropZones.length)
        {
            return (true);
        }
        else
        {
            false;
        } // end else if
    } // End of the function
    function cleanUp()
    {
        for (var _loc2 = 0; _loc2 < com.clubpenguin.tower.towers.TowerManager._towers.length; ++_loc2)
        {
            com.clubpenguin.tower.towers.TowerManager._towers[_loc2].cleanUp();
        } // end of for
        this.removeAllListeners();
        com.clubpenguin.tower.towers.TowerManager._towers.length = 0;
    } // End of the function
    var uniqueID = 0;
    var __towerCount = 0;
    static var SHOT_HIT = "shotHit";
    static var SHOOT_ENEMY = "shootEnemy";
    static var TOWER_DROPPED = "towerDropped";
    static var TOWER_COST = "towerCost";
    static var TOWER_REMOVED = "towerRemoved";
} // End of Class
