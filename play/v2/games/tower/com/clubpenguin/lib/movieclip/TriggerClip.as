class com.clubpenguin.lib.movieclip.TriggerClip extends MovieClip implements com.clubpenguin.lib.event.IEventDispatcher
{
    var __uid, stop, gotoAndStop, gotoAndPlay, __callback;
    function TriggerClip()
    {
        super();
        $_instanceCount = ++com.clubpenguin.lib.movieclip.TriggerClip.$_instanceCount;
        __uid = com.clubpenguin.lib.movieclip.TriggerClip.$_instanceCount;
        this.stop();
    } // End of the function
    function getUniqueName()
    {
        return ("[TriggerClip<" + __uid + ">]");
    } // End of the function
    function reset()
    {
        this.gotoAndStop(1);
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.COMPLETE));
    } // End of the function
    function hold()
    {
        this.stop();
        com.clubpenguin.lib.event.EventManager.dispatchEvent(new com.clubpenguin.lib.event.ClipEvent(this, com.clubpenguin.lib.event.ClipEvent.COMPLETE));
    } // End of the function
    function trigger(_label)
    {
        if (_label == undefined)
        {
            this.gotoAndPlay(2);
        }
        else
        {
            this.gotoAndPlay(_label);
        } // end else if
    } // End of the function
    function triggerFrame(_label)
    {
        this.gotoAndStop(_label);
    } // End of the function
    function toString()
    {
        return (this.getUniqueName());
    } // End of the function
    function animationComplete()
    {
        if (__callback != null)
        {
            this.__callback();
        } // end if
        this.gotoAndStop(1);
    } // End of the function
    function triggerWithHook(_callback)
    {
        if (_callback != null)
        {
            __callback = _callback;
        } // end if
        this.trigger();
    } // End of the function
    static var $_instanceCount = 0;
} // End of Class
