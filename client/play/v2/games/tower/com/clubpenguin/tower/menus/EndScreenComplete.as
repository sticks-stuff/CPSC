class com.clubpenguin.tower.menus.EndScreenComplete extends MovieClip
{
    var currentLevel, ok_btn, stats, gotoAndStop, tutorial_complete_text, tutorial_complete_info, system_defended_text, system_defended_info, good_work_agent_info, good_work_agent_text, removeMovieClip;
    function EndScreenComplete()
    {
        super();
        currentLevel = com.clubpenguin.tower.GameEngine.getInstance().currentLevel;
        this.initScreen();
    } // End of the function
    function initScreen()
    {
        ok_btn.ok_text.text = com.clubpenguin.lib.locale.LocaleText.getText("ok_text");
        ok_btn.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOver, com.clubpenguin.tower.menus.EndScreenComplete.OK_BTN);
        ok_btn.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut, com.clubpenguin.tower.menus.EndScreenComplete.OK_BTN);
        ok_btn.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleBtnPress, com.clubpenguin.tower.menus.EndScreenComplete.OK_BTN);
        ok_btn.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleReleaseOutside, com.clubpenguin.tower.menus.EndScreenComplete.OK_BTN);
        ok_btn.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleCoinPayout);
        stats.time.text = (getTimer() - com.clubpenguin.tower.GameEngine.getInstance()._levelManager.__startTime) / 1000;
        stats.enemies_count.text = com.clubpenguin.tower.GameEngine.getInstance()._enemyManager.enemyKilledCount;
        stats.turret_count.text = com.clubpenguin.tower.GameEngine.getInstance()._towerManager.__towerCount;
        stats.coins_count.text = "0";
        switch (currentLevel)
        {
            case -1:
            {
                this.gotoAndStop("tutorial_complete");
                tutorial_complete_text.text = com.clubpenguin.lib.locale.LocaleText.getText("tutorial_complete_text");
                tutorial_complete_info.text = com.clubpenguin.lib.locale.LocaleText.getText("tutorial_complete_info");
                break;
            } 
            case 0:
            {
                this.gotoAndStop("scenario_complete");
                system_defended_text.text = com.clubpenguin.lib.locale.LocaleText.getText("system_defended_text");
                system_defended_info.text = com.clubpenguin.lib.locale.LocaleText.getText("system_defended_info");
                break;
            } 
            case 1:
            {
                this.gotoAndStop("elite_good");
                good_work_agent_info.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_info");
                good_work_agent_text.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_text");
                break;
            } 
            case 2:
            {
                this.gotoAndStop("elite_good");
                good_work_agent_info.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_info");
                good_work_agent_text.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_text");
                break;
            } 
            case 3:
            {
                this.gotoAndStop("elite_good");
                good_work_agent_info.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_info");
                good_work_agent_text.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_text");
                break;
            } 
            case 4:
            {
                this.gotoAndStop("elite_good");
                good_work_agent_info.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_info");
                good_work_agent_text.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_text");
                break;
            } 
            case 5:
            {
                this.gotoAndStop("elite_good");
                good_work_agent_info.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_info");
                good_work_agent_text.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_text");
                break;
            } 
            case 6:
            {
                this.gotoAndStop("elite_good");
                good_work_agent_info.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_info");
                good_work_agent_text.text = com.clubpenguin.lib.locale.LocaleText.getText("good_work_agent_text");
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
} // End of Class
