class com.clubpenguin.tower.util.TriggerClip extends MovieClip
{
    var stop, __callback, gotoAndStop;
    function TriggerClip()
    {
        super();
        this.stop();
    } // End of the function
    function animationComplete()
    {
        if (__callback != null)
        {
            this.__callback();
        } // end if
        this.gotoAndStop(1);
    } // End of the function
    function play(_callback)
    {
        super.play();
        if (_callback != null)
        {
            __callback = _callback;
        } // end if
    } // End of the function
} // End of Class
