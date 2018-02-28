class com.clubpenguin.tower.levels.DialogueData extends com.clubpenguin.tower.util.EventDispatcher implements com.clubpenguin.tower.levels.interfaces.IStoryElement
{
    var __id, avatar, speech, display, __updateMe, __spawnedNextElement, __completed, isDialogueHidden, duration, nextElementEvent, nextElementEventData, __checkSpawnNextElement, startTime, totalTime, dispatchEvent, __get__nextWaveDelay, __get__type;
    function DialogueData($avatar, $localeID, $duration, _nextElementEvent, _nextElementEventData)
    {
        super();
        __id = com.clubpenguin.tower.levels.types.AbstractLevel.__elementIDS++;
        avatar = $avatar;
        speech = com.clubpenguin.lib.locale.LocaleText.getText($localeID);
        display = com.clubpenguin.tower.display.types.AbstractDisplay.instance;
        __updateMe = false;
        __spawnedNextElement = false;
        __completed = false;
        isDialogueHidden = false;
        duration = $duration;
        nextElementEvent = _nextElementEvent;
        nextElementEventData = _nextElementEventData;
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        switch (nextElementEvent)
        {
            case com.clubpenguin.tower.levels.DialogueData.EVENT_DELAY_AFTER:
            {
                __checkSpawnNextElement = checkDelayAfter;
                break;
            } 
        } // End of switch
    } // End of the function
    function update()
    {
        if (__updateMe)
        {
            totalTime = getTimer() - startTime;
            if (!__spawnedNextElement)
            {
                this.checkSpawnNextElement();
            } // end if
            if (isDialogueHidden)
            {
                return;
            }
            else if (totalTime >= duration)
            {
                this.complete();
                isDialogueHidden = true;
            } // end else if
            if (__completed && __spawnedNextElement)
            {
                __updateMe = false;
            } // end if
        } // end if
    } // End of the function
    function get nextWaveDelay()
    {
        var _loc2;
        switch (nextElementEvent)
        {
            case com.clubpenguin.tower.levels.DialogueData.EVENT_DELAY_AFTER:
            {
                _loc2 = Number(nextElementEventData);
                break;
            } 
        } // End of switch
        return (_loc2);
    } // End of the function
    function get type()
    {
        return (com.clubpenguin.tower.levels.DialogueData.TYPE);
    } // End of the function
    function checkSpawnNextElement()
    {
        this.__checkSpawnNextElement();
    } // End of the function
    function checkDelayAfter()
    {
        if (totalTime >= Number(nextElementEventData))
        {
            this.dispatchEvent({type: com.clubpenguin.tower.levels.types.AbstractLevel.EVENT_START_NEXT_ELEMENT, target: this, id: __id});
            __spawnedNextElement = true;
        } // end if
    } // End of the function
    function start()
    {
        startTime = getTimer();
        __updateMe = true;
        display.showDialogue(avatar, speech);
    } // End of the function
    function complete()
    {
        display.hideDialogue();
        __completed = true;
    } // End of the function
    function toString()
    {
        return ("[Dialog Element] " + speech);
    } // End of the function
    function getType()
    {
        return (com.clubpenguin.tower.levels.DialogueData.TYPE);
    } // End of the function
    static var EVENT_DELAY_AFTER = "EVENT_DELAY_AFTER";
    static var TYPE = "DIALOGUE_DATA";
    var int = 0;
} // End of Class
