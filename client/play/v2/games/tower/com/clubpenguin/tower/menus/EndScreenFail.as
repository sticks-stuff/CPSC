class com.clubpenguin.tower.menus.EndScreenFail extends MovieClip
{
    var currentLevel, ok_btn, gotoAndStop, tutorial_fail_text, tutorial_fail_info, system_damaged_info, system_damaged_text, more_training_needed_text, more_training_needed_info, stats, removeMovieClip;
    function EndScreenFail()
    {
        super();
        currentLevel = com.clubpenguin.tower.GameEngine.getInstance().currentLevel;
        this.initScreen();
    } // End of the function
    function initScreen()
    {
        ok_btn.ok_text.text = com.clubpenguin.lib.locale.LocaleText.getText("ok_text");
        ok_btn.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOver, com.clubpenguin.tower.menus.EndScreenFail.OK_BTN);
        ok_btn.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut, com.clubpenguin.tower.menus.EndScreenFail.OK_BTN);
        ok_btn.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleBtnPress, com.clubpenguin.tower.menus.EndScreenFail.OK_BTN);
        ok_btn.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleReleaseOutside, com.clubpenguin.tower.menus.EndScreenFail.OK_BTN);
        ok_btn.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleCoinPayout);
        switch (currentLevel)
        {
            case TUTORIAL:
            {
                this.gotoAndStop("tutorial_fail");
                tutorial_fail_text.text = com.clubpenguin.lib.locale.LocaleText.getText("tutorial_fail_text");
                tutorial_fail_info.text = com.clubpenguin.lib.locale.LocaleText.getText("tutorial_fail_info");
                break;
            } 
            case SCENARIO:
            {
                this.gotoAndStop("scenario_fail");
                system_damaged_info.text = com.clubpenguin.lib.locale.LocaleText.getText("system_damaged_info");
                system_damaged_text.text = com.clubpenguin.lib.locale.LocaleText.getText("system_damaged_text");
                break;
            } 
            case LEVEL1:
            {
                this.gotoAndStop("elite_not_good");
                more_training_needed_text.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_text");
                more_training_needed_info.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_info");
                break;
            } 
            case LEVEL2:
            {
                this.gotoAndStop("elite_not_good");
                more_training_needed_text.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_text");
                more_training_needed_info.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_info");
                break;
            } 
            case LEVEL3:
            {
                this.gotoAndStop("elite_not_good");
                more_training_needed_text.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_text");
                more_training_needed_info.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_info");
                break;
            } 
            case LEVEL4:
            {
                this.gotoAndStop("elite_not_good");
                more_training_needed_text.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_text");
                more_training_needed_info.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_info");
                break;
            } 
            case LEVEL5:
            {
                this.gotoAndStop("elite_not_good");
                more_training_needed_text.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_text");
                more_training_needed_info.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_info");
                break;
            } 
            case LEVEL6:
            {
                this.gotoAndStop("elite_not_good");
                more_training_needed_text.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_text");
                more_training_needed_info.text = com.clubpenguin.lib.locale.LocaleText.getText("more_training_needed_info");
                break;
            } 
        } // End of switch
        stats.time_bonus.text = com.clubpenguin.lib.locale.LocaleText.getText("time_bonus");
        stats.enemies.text = com.clubpenguin.lib.locale.LocaleText.getText("enemies");
        stats.turrets.text = com.clubpenguin.lib.locale.LocaleText.getText("turrets");
        stats.coins.text = com.clubpenguin.lib.locale.LocaleText.getText("coins");
        stats.enemies_count.text = com.clubpenguin.tower.GameEngine.getInstance()._enemyManager.enemyKilledCount;
        stats.turret_count.text = com.clubpenguin.tower.GameEngine.getInstance()._towerManager.__towerCount;
        stats.coins_count.text = com.clubpenguin.tower.GameEngine.getInstance()._enemyManager.enemyKilledCount;
        var _loc2;
        _loc2 = (getTimer() - com.clubpenguin.tower.GameEngine.getInstance()._levelManager.__startTime) / 1000;
        _loc2 = Math.round(_loc2);
        stats.time.text = Math.floor(_loc2 / 60);
        var _loc3;
        _loc3 = _loc2 % 60;
        if (_loc3 < 10)
        {
            stats.time.text = stats.time.text + (":0" + _loc3);
        }
        else
        {
            stats.time.text = stats.time.text + (":" + _loc3);
        } // end else if
    } // End of the function
    function handleCoinPayout()
    {
        com.clubpenguin.tower.GameEngine.getInstance().handleGameOver();
    } // End of the function
    function handleBtnRollOut()
    {
        ok_btn.gotoAndStop("default");
    } // End of the function
    function handleReleaseOutside()
    {
        ok_btn.gotoAndStop("default");
    } // End of the function
    function handleBtnRollOver()
    {
        ok_btn.gotoAndStop("rollover");
    } // End of the function
    function handleBtnPress()
    {
        ok_btn.gotoAndStop("press");
    } // End of the function
    function cleanUp()
    {
        this.removeMovieClip();
    } // End of the function
    static var OK_BTN = "OK_BTN";
    var TUTORIAL = -1;
    var SCENARIO = 0;
    var LEVEL1 = 1;
    var LEVEL2 = 2;
    var LEVEL3 = 3;
    var LEVEL4 = 4;
    var LEVEL5 = 5;
    var LEVEL6 = 6;
} // End of Class
