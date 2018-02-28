class com.clubpenguin.tower.towers.views.TowerActor extends MovieClip
{
    var __currentTurret, turretBase, turretLevel0, turretLevel1, turretLevel2;
    function TowerActor()
    {
        super();
    } // End of the function
    function setAim(_aimFrame)
    {
        __currentTurret.triggerFrame(_aimFrame - 20);
    } // End of the function
    function upgradeTower(_towerLevel)
    {
        this.hideTowers();
        __currentTurret = this["turretLevel" + _towerLevel];
        __currentTurret._visible = true;
        __currentTurret.trigger();
        if (_towerLevel == 0)
        {
            turretBase.trigger();
        } // end if
    } // End of the function
    function hideTowers()
    {
        turretLevel0._visible = false;
        turretLevel1._visible = false;
        turretLevel2._visible = false;
    } // End of the function
} // End of Class
