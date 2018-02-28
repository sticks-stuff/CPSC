class com.clubpenguin.tower.menus.StartScreen extends MovieClip
{
    var onEnterFrame, main_mc, no_attack, close_btn, textBox, training_btn, survival_btn, animation, _visible;
    function StartScreen()
    {
        super();
        onEnterFrame = rendered;
    } // End of the function
    function rendered()
    {
        delete this.onEnterFrame;
        this.init();
    } // End of the function
    function init()
    {
        main_mc._visible = false;
        no_attack._visible = false;
        no_attack.scan_mc.scanning_mc.finished_scan_txt._visible = false;
        close_btn.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOver, com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN);
        close_btn.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut, com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN);
        close_btn.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleBtnPress, com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN);
        close_btn.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleReleaseOutside, com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN);
        close_btn.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleCloseButtonRelease);
        if (scenarioActive)
        {
            main_mc._visible = true;
            no_attack._visible = false;
            textBox.not_found_anim._visible = false;
            main_mc.warning_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("warning_txt");
            main_mc.attack_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("attack_txt");
            main_mc.info_mc.info_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("info_txt");
            main_mc.accept_btn.accept_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("accept_btn");
            main_mc.accept_btn.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOver, com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO);
            main_mc.accept_btn.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut, com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO);
            main_mc.accept_btn.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleBtnPress, com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO);
            main_mc.accept_btn.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleReleaseOutside, com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO);
        }
        else
        {
            no_attack._visible = true;
            no_attack.textBox.found_anim._visible = false;
            no_attack.scan_mc.system_scanner_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("system_scanner_txt");
            no_attack.scan_mc.scanning_mc.scanning_text_mc.scanning_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("scanning_txt");
            no_attack.scan_mc.scanning_mc.finished_scan_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("finished_scan_txt");
            no_attack.SD_Text_LJ.gotoAndStop(com.clubpenguin.lib.locale.LocaleText.getLocaleID());
        } // end else if
        training_btn.training_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("training_txt");
        survival_btn.survival_txt.text = com.clubpenguin.lib.locale.LocaleText.getText("survival_txt");
        training_btn.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOver, com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL);
        training_btn.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut, com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL);
        training_btn.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleBtnPress, com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL);
        training_btn.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleReleaseOutside, com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL);
        survival_btn.onRollOver = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOver, com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL);
        survival_btn.onRollOut = com.clubpenguin.tower.util.Delegate.create(this, handleBtnRollOut, com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL);
        survival_btn.onPress = com.clubpenguin.tower.util.Delegate.create(this, handleBtnPress, com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL);
        survival_btn.onReleaseOutside = com.clubpenguin.tower.util.Delegate.create(this, handleReleaseOutside, com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL);
        training_btn.onRelease = com.clubpenguin.tower.util.Delegate.create(this, initTransition, com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL);
        main_mc.accept_btn.onRelease = com.clubpenguin.tower.util.Delegate.create(this, initTransition, com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO);
        survival_btn.onRelease = com.clubpenguin.tower.util.Delegate.create(this, initLevelSelector, com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL);
    } // End of the function
    function finishedScanning()
    {
        no_attack.scan_mc.scanning_mc.finished_scan_txt._visible = true;
    } // End of the function
    function handleCloseButtonRelease()
    {
        com.clubpenguin.tower.GameEngine.getInstance().handleGameOver();
    } // End of the function
    function initTransition(type)
    {
        close_btn.enabled = false;
        if (type == com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO)
        {
            var _loc4 = _global.getCurrentInterface();
            var _loc5 = _global.getCurrentShell();
            com.clubpenguin.tower.GameEngine.getInstance().initTransition(type);
            training_btn._visible = false;
            survival_btn._visible = false;
            main_mc.accept_btn._visible = false;
            this.launchAnimation();
        } // end if
        com.clubpenguin.tower.GameEngine.getInstance().initTransition(type);
        training_btn._visible = false;
        survival_btn._visible = false;
        main_mc.accept_btn._visible = false;
        this.launchAnimation();
    } // End of the function
    function initLevelSelector(type)
    {
        com.clubpenguin.tower.GameEngine.getInstance().initLevelSelector();
        com.clubpenguin.tower.GameEngine.getInstance().removeStartScreen();
    } // End of the function
    function setActive()
    {
        training_btn.enabled = true;
        survival_btn.enabled = true;
    } // End of the function
    function handleReleaseOutside(gameType)
    {
        switch (gameType)
        {
            case com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL:
            {
                training_btn.gotoAndStop("default");
                main_mc.textBox.txt_mc.txt_box.text = "";
                no_attack.textBox.txt_mc.txt_box.text = "";
                if (com.clubpenguin.tower.GameEngine.getInstance()._scenarioActive)
                {
                    main_mc.textBox.found_anim._visible = true;
                    main_mc.textBox.map_grid._visible = true;
                }
                else
                {
                    no_attack.textBox.not_found_anim._visible = true;
                } // end else if
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL:
            {
                survival_btn.gotoAndStop("default");
                textBox.gotoAndStop("default");
                main_mc.textBox.txt_mc.txt_box.text = "";
                no_attack.textBox.txt_mc.txt_box.text = "";
                if (com.clubpenguin.tower.GameEngine.getInstance()._scenarioActive)
                {
                    main_mc.textBox.found_anim._visible = true;
                    main_mc.textBox.map_grid._visible = true;
                }
                else
                {
                    no_attack.textBox.not_found_anim._visible = true;
                } // end else if
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO:
            {
                main_mc.accept_btn.gotoAndStop("default");
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN:
            {
                close_btn.gotoAndStop("default");
                break;
            } 
        } // End of switch
    } // End of the function
    function handleBtnRollOut(gameType)
    {
        switch (gameType)
        {
            case com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL:
            {
                training_btn.gotoAndStop("default");
                main_mc.textBox.txt_mc.txt_box.text = "";
                no_attack.textBox.txt_mc.txt_box.text = "";
                if (com.clubpenguin.tower.GameEngine.getInstance()._scenarioActive)
                {
                    main_mc.textBox.found_anim._visible = true;
                    main_mc.textBox.map_grid._visible = true;
                }
                else
                {
                    no_attack.textBox.not_found_anim._visible = true;
                } // end else if
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL:
            {
                survival_btn.gotoAndStop("default");
                main_mc.textBox.txt_mc.txt_box.text = "";
                no_attack.textBox.txt_mc.txt_box.text = "";
                if (com.clubpenguin.tower.GameEngine.getInstance()._scenarioActive)
                {
                    main_mc.textBox.found_anim._visible = true;
                    main_mc.textBox.map_grid._visible = true;
                }
                else
                {
                    no_attack.textBox.not_found_anim._visible = true;
                } // end else if
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO:
            {
                main_mc.accept_btn.gotoAndStop("default");
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN:
            {
                close_btn.gotoAndStop("default");
                break;
            } 
        } // End of switch
    } // End of the function
    function handleBtnRollOver(gameType)
    {
        switch (gameType)
        {
            case com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL:
            {
                training_btn.gotoAndStop("rollover");
                main_mc.textBox.txt_mc.txt_box.text = com.clubpenguin.lib.locale.LocaleText.getText("textBox_training_txt");
                no_attack.textBox.txt_mc.txt_box.text = com.clubpenguin.lib.locale.LocaleText.getText("textBox_training_txt");
                main_mc.textBox.found_anim._visible = false;
                main_mc.textBox.map_grid._visible = false;
                no_attack.textBox.not_found_anim._visible = false;
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL:
            {
                survival_btn.gotoAndStop("rollover");
                textBox.gotoAndStop("survival");
                main_mc.textBox.txt_mc.txt_box.text = com.clubpenguin.lib.locale.LocaleText.getText("textBox_survival_txt");
                no_attack.textBox.txt_mc.txt_box.text = com.clubpenguin.lib.locale.LocaleText.getText("textBox_survival_txt");
                main_mc.textBox.found_anim._visible = false;
                main_mc.textBox.map_grid._visible = false;
                no_attack.textBox.not_found_anim._visible = false;
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO:
            {
                main_mc.accept_btn.gotoAndStop("rollover");
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN:
            {
                close_btn.gotoAndStop("rollover");
                break;
            } 
        } // End of switch
    } // End of the function
    function handleBtnPress(gameType)
    {
        var _loc2 = com.clubpenguin.tower.GameEngine.getInstance();
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode(com.clubpenguin.tower.menus.StartScreen.DLS_START, _loc2.getOpcodeGuid(), dlsmCallback, 0);
        switch (gameType)
        {
            case com.clubpenguin.tower.menus.StartScreen.MODE_TUTORIAL:
            {
                com.clubpenguin.tower.GameEngine.getInstance().currentLevel = -1;
                training_btn.gotoAndStop("press");
                _loc2.setOpcodeGuid("Elite");
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SURVIVAL:
            {
                com.clubpenguin.tower.GameEngine.getInstance().currentLevel = 2;
                survival_btn.gotoAndStop("press");
                _loc2.setOpcodeGuid("Survival");
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.MODE_SCENARIO:
            {
                com.clubpenguin.tower.GameEngine.getInstance().currentLevel = 0;
                main_mc.accept_btn.gotoAndStop("press");
                _loc2.setOpcodeGuid("Mission Quarters");
                break;
            } 
            case com.clubpenguin.tower.menus.StartScreen.CLOSE_BTN:
            {
                close_btn.gotoAndStop("press");
                break;
            } 
        } // End of switch
        com.disney.dlearning.managers.DLSManager.__get__instance().pushOpcode(com.clubpenguin.tower.menus.StartScreen.DLS_SELECTED, _loc2.getOpcodeGuid(), dlsmCallback, 0);
    } // End of the function
    function launchAnimation()
    {
        animation.play(com.clubpenguin.tower.util.Delegate.create(this, initGame));
    } // End of the function
    function cleanUp()
    {
        _visible = false;
    } // End of the function
    function initGame()
    {
        com.clubpenguin.tower.GameEngine.getInstance().initGame();
    } // End of the function
    function toString()
    {
        return ("StartScreen");
    } // End of the function
    function dlsmCallback(stringArg)
    {
    } // End of the function
    static var MODE_TUTORIAL = "MODE_TUTORIAL";
    static var MODE_SURVIVAL = "MODE_SURVIVAL";
    static var MODE_SCENARIO = "MODE_SCENARIO";
    static var OK_BTN = "OK_BTN";
    static var CLOSE_BTN = "CLOSE_BTN";
    static var DLS_START = "start";
    static var DLS_SELECTED = "selected";
    var scenarioActive = false;
} // End of Class
