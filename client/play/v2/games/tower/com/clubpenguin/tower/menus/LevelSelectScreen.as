class com.clubpenguin.tower.menus.LevelSelectScreen extends MovieClip
{
    var level1, level2, level3, level4, level5, level6, onEnterFrame, close, map, level_select, animation, removeMovieClip;
    function LevelSelectScreen()
    {
        super();
        level1.enabled = true;
        level2.enabled = true;
        level3.enabled = true;
        level4.enabled = true;
        level5.enabled = true;
        level6.enabled = false;
        level6.gotoAndStop(2);
        onEnterFrame = rendered;
    } // End of the function
    function rendered()
    {
        delete this.onEnterFrame;
        this.init();
    } // End of the function
    function init()
    {
        close.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOver);
        close.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut);
        close.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleBtnPress);
        close.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleReleaseOutside);
        close.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleCloseLevelScreen);
        level1.play_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("play_txt");
        level2.play_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("play_txt");
        level3.play_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("play_txt");
        level4.play_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("play_txt");
        level5.play_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("play_txt");
        level6.play_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("play_txt");
        map.description.level1_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level1_description");
        map.description.level2_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level2_description");
        map.description.level3_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level3_description");
        map.description.level4_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level4_description");
        map.description.level5_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level5_description");
        map.description.level6_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level6_description");
        level_select.text = com.clubpenguin.lib.locale.LocaleText.getText("level_select_txt");
        level1.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOver, "level1");
        level1.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOut, "level1");
        level1.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenReleaseOutside, "level1");
        level2.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOver, "level2");
        level2.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOut, "level2");
        level2.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenReleaseOutside, "level2");
        level3.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOver, "level3");
        level3.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOut, "level3");
        level3.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenReleaseOutside, "level3");
        level4.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOver, "level4");
        level4.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOut, "level4");
        level4.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenReleaseOutside, "level4");
        level5.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOver, "level5");
        level5.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOut, "level5");
        level5.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenReleaseOutside, "level5");
        level6.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOver, "level6");
        level6.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenRollOut, "level6");
        level6.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleLevelSelectScreenReleaseOutside, "level6");
        close.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleCloseLevelScreen);
        level1.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleLoadLevelSelected, LEVEL_1);
        level2.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleLoadLevelSelected, LEVEL_2);
        level3.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleLoadLevelSelected, LEVEL_3);
        level4.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleLoadLevelSelected, LEVEL_4);
        level5.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleLoadLevelSelected, LEVEL_5);
        level6.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleLoadLevelSelected, LEVEL_6);
    } // End of the function
    function handleLoadLevelSelected(type)
    {
        var _loc4 = _global.getCurrentInterface();
        var _loc6 = _global.getCurrentShell();
        var _loc5 = _loc6.isMyPlayerMember();
        if (type == LEVEL_4 || type == LEVEL_5 || type == LEVEL_6)
        {
            if (_loc5)
            {
                com.clubpenguin.tower.GameEngine.getInstance().handleLoadLevelSelected(type);
                level1.enabled = false;
                level2.enabled = false;
                level3.enabled = false;
                level4.enabled = false;
                level5.enabled = false;
                level6.enabled = false;
                this.launchAnimation();
                return;
            }
            else
            {
                _loc4.showContent("oops_general");
                return;
            } // end if
        } // end else if
        com.clubpenguin.tower.GameEngine.getInstance().handleLoadLevelSelected(type);
        level1.enabled = false;
        level2.enabled = false;
        level3.enabled = false;
        level4.enabled = false;
        level5.enabled = false;
        level6.enabled = false;
        close.enabled = false;
        this.launchAnimation();
    } // End of the function
    function launchAnimation()
    {
        animation.play(com.clubpenguin.tower.util.Delegate.create(this, initGame));
    } // End of the function
    function initGame()
    {
        this.removeMovieClip();
        com.clubpenguin.tower.GameEngine.getInstance().initGame();
    } // End of the function
    function handleCloseLevelScreen()
    {
        this.removeMovieClip();
        com.clubpenguin.tower.GameEngine.getInstance().removeLevelSelector();
        com.clubpenguin.tower.GameEngine.getInstance().setUpStartScreen();
    } // End of the function
    function handleLevelSelectScreenReleaseOutside(level)
    {
        switch (level)
        {
            case "level1":
            {
                level1.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level2":
            {
                level2.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level3":
            {
                level3.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level4":
            {
                level4.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level5":
            {
                level5.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level6":
            {
                level6.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
        } // End of switch
    } // End of the function
    function handleLevelSelectScreenRollOut(level)
    {
        switch (level)
        {
            case "level1":
            {
                level1.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level2":
            {
                level2.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level3":
            {
                level3.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level4":
            {
                level4.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level5":
            {
                level5.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
            case "level6":
            {
                level6.indicator.gotoAndStop("default");
                map.levelSelectMap.gotoAndStop("default");
                map.description.gotoAndStop("default");
                break;
            } 
        } // End of switch
    } // End of the function
    function handleLevelSelectScreenRollOver(level)
    {
        switch (level)
        {
            case "level1":
            {
                level1.indicator.gotoAndStop("rollover");
                map.levelSelectMap.gotoAndStop("level1");
                map.description.gotoAndStop("level1");
                map.description.level1_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level1_description");
                break;
            } 
            case "level2":
            {
                level2.indicator.gotoAndStop("rollover");
                map.levelSelectMap.gotoAndStop("level2");
                map.description.gotoAndStop("level2");
                map.description.level2_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level2_description");
                break;
            } 
            case "level3":
            {
                level3.indicator.gotoAndStop("rollover");
                map.levelSelectMap.gotoAndStop("level3");
                map.description.gotoAndStop("level3");
                map.description.level3_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level3_description");
                break;
            } 
            case "level4":
            {
                level4.indicator.gotoAndStop("rollover");
                map.levelSelectMap.gotoAndStop("level4");
                map.description.gotoAndStop("level4");
                map.description.level4_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level4_description");
                break;
            } 
            case "level5":
            {
                level5.indicator.gotoAndStop("rollover");
                map.levelSelectMap.gotoAndStop("level5");
                map.description.gotoAndStop("level5");
                map.description.level5_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level5_description");
                break;
            } 
            case "level6":
            {
                level6.indicator.gotoAndStop("rollover");
                map.levelSelectMap.gotoAndStop("level6");
                map.description.gotoAndStop("level6");
                map.description.level6_description.text = com.clubpenguin.lib.locale.LocaleText.getText("level6_description");
                break;
            } 
        } // End of switch
    } // End of the function
    function handleBtnRollOut()
    {
        close.gotoAndStop("default");
    } // End of the function
    function handleReleaseOutside()
    {
        close.gotoAndStop("default");
    } // End of the function
    function handleBtnRollOver()
    {
        close.gotoAndStop("rollover");
    } // End of the function
    function handleBtnPress()
    {
        close.gotoAndStop("press");
    } // End of the function
    function cleanUp()
    {
        this.removeMovieClip();
    } // End of the function
    var LEVEL_1 = 1;
    var LEVEL_2 = 2;
    var LEVEL_3 = 3;
    var LEVEL_4 = 4;
    var LEVEL_5 = 5;
    var LEVEL_6 = 6;
} // End of Class
