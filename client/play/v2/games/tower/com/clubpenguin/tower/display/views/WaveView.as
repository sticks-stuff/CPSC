class com.clubpenguin.tower.display.views.WaveView
{
    var _type, _stage, _mc;
    function WaveView(_scope, __entityType)
    {
        var _loc2;
        _type = __entityType;
        _stage = _scope;
        var _loc4 = 0;
        switch (_type)
        {
            case yellowEnemy:
            {
                _loc2 = LINKAGE_ID_YELLOW;
                break;
            } 
            case purpleEnemy:
            {
                _loc2 = LINKAGE_ID_PURPLE;
                break;
            } 
            case redEnemy:
            {
                _loc2 = LINKAGE_ID_RED;
                break;
            } 
            case purpleBoss:
            {
                _loc2 = LINKAGE_ID_PURPLE_BOSS;
                break;
            } 
            case yellowBoss:
            {
                _loc2 = LINKAGE_ID_YELLOW_BOSS;
                break;
            } 
            case redBoss:
            {
                _loc2 = LINKAGE_ID_RED_BOSS;
                break;
            } 
        } // End of switch
        _mc = _scope.hud.DisplayView_1.container_mc.attachMovie(_loc2, NAME, _scope.hud.DisplayView_1.container_mc.getNextHighestDepth());
        _mc._y = com.clubpenguin.tower.display.views.WaveView.Y_POSITION;
        _mc._x = -10;
    } // End of the function
    function update(_currentPosition)
    {
        _mc._y = com.clubpenguin.tower.display.views.WaveView.Y_POSITION;
        _mc._x = _currentPosition;
    } // End of the function
    function setAlert()
    {
        _stage.hud.DisplayView_1.alert.gotoAndStop("alertOn");
        _stage.hud.DisplayView_1.alert.alert_mc.play();
    } // End of the function
    function removeAlert()
    {
        _stage.hud.DisplayView_1.alert.gotoAndStop("alertOff");
    } // End of the function
    function cleanUp()
    {
        removeMovieClip (_stage.hud.DisplayView_1.container_mc.linkage);
    } // End of the function
    var LINKAGE_ID_RED = "EnemyRadarViewRed";
    var LINKAGE_ID_YELLOW = "EnemyRadarViewYellow";
    var LINKAGE_ID_PURPLE = "EnemyRadarViewPurple";
    var LINKAGE_ID_RED_BOSS = "EnemyRadarViewRedBoss";
    var LINKAGE_ID_YELLOW_BOSS = "EnemyRadarViewYellowBoss";
    var LINKAGE_ID_PURPLE_BOSS = "EnemyRadarViewPurpleBoss";
    var yellowEnemy = "yellowEnemy";
    var purpleEnemy = "purpleEnemy";
    var redEnemy = "redEnemy";
    var yellowBoss = "yellowBoss";
    var purpleBoss = "purpleBoss";
    var redBoss = "redBoss";
    var NAME = "WaveView";
    static var Y_POSITION = 440;
} // End of Class
