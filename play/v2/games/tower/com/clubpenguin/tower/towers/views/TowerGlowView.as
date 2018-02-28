class com.clubpenguin.tower.towers.views.TowerGlowView extends MovieClip
{
    var _x, _y, gotoAndPlay, gotoAndStop;
    function TowerGlowView()
    {
        super();
    } // End of the function
    function setPosition(x, y)
    {
        _x = x - 21;
        _y = y - 21;
    } // End of the function
    function fadeIn()
    {
        if (fadingIn)
        {
            return;
        }
        else if (fadingOut)
        {
            fadingOut = false;
            fadeInActive = true;
            fadingIn = true;
            this.gotoAndPlay("fadeIn");
            return;
        }
        else if (fadeInActive)
        {
            this.gotoAndStop(8);
            fadingIn = true;
            return;
        } // end else if
        fadeInActive = true;
        fadingIn = true;
        this.gotoAndPlay("fadeIn");
    } // End of the function
    function fadeOut()
    {
        if (fadingOut)
        {
            return;
        }
        else if (!fadeInActive)
        {
            return;
        } // end else if
        fadingOut = true;
        this.gotoAndPlay("fadeOut");
    } // End of the function
    function finishedFadeIn()
    {
        fadingIn = false;
        fadeInActive = true;
    } // End of the function
    function finishedFadeOut()
    {
        fadingOut = false;
        fadeInActive = false;
    } // End of the function
    var fadingIn = false;
    var fadingOut = false;
    var fadeInActive = false;
} // End of Class
