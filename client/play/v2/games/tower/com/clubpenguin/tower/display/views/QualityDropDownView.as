class com.clubpenguin.tower.display.views.QualityDropDownView extends MovieClip
{
    var active, _x, animation;
    function QualityDropDownView()
    {
        super();
        active = false;
        _x = _xPosition;
        this.attachListeners();
    } // End of the function
    function attachListeners()
    {
        animation.animation_mc.btn.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleButtonRelease);
        animation.animation_mc.low.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleQuality, LOW_QUALITY);
        animation.animation_mc.med.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleQuality, MEDIUM_QUALITY);
        animation.animation_mc.high.onRelease = com.clubpenguin.tower.util.Delegate.create(this, handleQuality, HIGH_QUALITY);
    } // End of the function
    function handleButtonRelease()
    {
        if (active)
        {
            animation.gotoAndPlay("up");
            active = false;
        }
        else
        {
            animation.play();
        } // end else if
    } // End of the function
    function handleQuality(quality)
    {
        com.clubpenguin.tower.GameEngine.getInstance().setQuality(quality);
    } // End of the function
    var _xPosition = 380;
    var LOW_QUALITY = "LOW";
    var MEDIUM_QUALITY = "MEDIUM";
    var HIGH_QUALITY = "HIGH";
} // End of Class
