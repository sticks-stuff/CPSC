class com.clubpenguin.missions.ui.ScreenFade
{
    var _modal, dispatchEvent, _onComplete, _onCompleteScope, __get__color, __get__alpha, __get__fadeDuration, __get__onComplete, __get__onCompleteScope, __set__alpha, __set__color, __set__fadeDuration, __set__onComplete, __set__onCompleteScope;
    function ScreenFade($scope)
    {
        if ($scope)
        {
            this.setupModal($scope);
            mx.events.EventDispatcher.initialize(this);
            
        } // end if
    } // End of the function
    function setupModal($scope)
    {
        if ($scope.modalClip)
        {
            $scope.modalClip.removeMovieClip();
        } // end if
        _modal = $scope.createEmptyMovieClip("modalClip", $scope.getNextHighestDepth());
        _modal._visible = false;
        _modal.onPress = null;
        _modal.useHandCursor = false;
        this.drawModal();
    } // End of the function
    function drawModal()
    {
        _modal.clear();
        _modal.beginFill(_color, _alpha);
        _modal.moveTo(0, 0);
        _modal.lineTo(Stage.width, 0);
        _modal.lineTo(Stage.width, Stage.height);
        _modal.lineTo(0, Stage.height);
        _modal.lineTo(0, 0);
        _modal.endFill();
    } // End of the function
    function onFadingModalIn()
    {
        this.dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_IN, this));
        this.dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE, this));
    } // End of the function
    function onFadeModalInComplete()
    {
        this.fadeComplete();
        this.dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_IN_COMPLETE, this));
    } // End of the function
    function onFadingModalOut()
    {
        this.dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_OUT, this));
        this.dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE, this));
    } // End of the function
    function onFadeModalOutComplete()
    {
        _modal._visible = false;
        this.fadeComplete();
        this.dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_OUT_COMPLETE, this));
    } // End of the function
    function fadeComplete()
    {
        if (_onComplete)
        {
            var _loc2;
            if (_onCompleteScope)
            {
                _loc2 = com.clubpenguin.util.Delegate.create(_onCompleteScope, _onComplete);
            }
            else
            {
                _loc2 = _onComplete;
            } // end else if
            _loc2();
        } // end if
        this.dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_COMPLETE, this));
    } // End of the function
    function fadeIn()
    {
        _modal._alpha = 0;
        _modal._visible = true;
        gs.TweenLite.to(_modal, _fadeDuration, {_alpha: 100, onUpdate: com.clubpenguin.util.Delegate.create(this, onFadingModalIn), onComplete: com.clubpenguin.util.Delegate.create(this, onFadeModalInComplete)});
    } // End of the function
    function fadeOut()
    {
        _modal._visible = true;
        _modal._alpha = 100;
        gs.TweenLite.to(_modal, _fadeDuration, {_alpha: 0, onUpdate: com.clubpenguin.util.Delegate.create(this, onFadingModalOut), onComplete: com.clubpenguin.util.Delegate.create(this, onFadeModalOutComplete)});
    } // End of the function
    function set color($color)
    {
        _color = $color;
        this.drawModal();
        //return (this.color());
        null;
    } // End of the function
    function set alpha($alpha)
    {
        _alpha = $alpha;
        this.drawModal();
        //return (this.alpha());
        null;
    } // End of the function
    function showModal()
    {
        if (_modal)
        {
            _modal._visible = true;
            _modal._alpha = 100;
        } // end if
    } // End of the function
    function hideModal()
    {
        if (_modal)
        {
            _modal._visible = false;
            _modal._alpha = 0;
        } // end if
    } // End of the function
    function set fadeDuration($duration)
    {
        _fadeDuration = $duration;
        //return (this.fadeDuration());
        null;
    } // End of the function
    function set onComplete($function)
    {
        _onComplete = $function;
        //return (this.onComplete());
        null;
    } // End of the function
    function set onCompleteScope($scope)
    {
        _onCompleteScope = $scope;
        //return (this.onCompleteScope());
        null;
    } // End of the function
    var _color = 0;
    var _alpha = 100;
    var _fadeDuration = 1;
} // End of Class
