class gs.TweenLite
{
    var tweenID, endTargetID, vars, duration, delay, _active, target, tweens, _subTweens, _initted, _hst, initTime, startTime, _hasUpdate, __get__active;
    static var _e, _classInitted, _curTime, _gc, _listening;
    function TweenLite($target, $duration, $vars)
    {
        _cnt = ++gs.TweenLite._cnt;
        tweenID = "tw" + gs.TweenLite._cnt;
        endTargetID = gs.TweenLite.getID($target, true);
        if ($vars.overwrite != false && $target != undefined)
        {
            delete gs.TweenLite._all[endTargetID];
            gs.TweenLite._all[endTargetID] = {info: [$target, endTargetID]};
        } // end if
        gs.TweenLite._all[endTargetID][tweenID] = this;
        vars = $vars;
        duration = $duration || 1.000000E-003;
        delay = $vars.delay || 0;
        _active = $duration == 0 && delay == 0;
        target = $target;
        if (typeof(vars.ease) != "function")
        {
            vars.ease = gs.TweenLite.defaultEase;
        } // end if
        if (vars.easeParams != undefined)
        {
            vars.proxiedEase = vars.ease;
            vars.ease = easeProxy;
        } // end if
        if (typeof(vars.autoAlpha) == "number")
        {
            vars._alpha = vars.autoAlpha;
            vars._visible = vars._alpha > 0;
        } // end if
        tweens = [];
        _subTweens = [];
        _hst = _initted = false;
        if (gs.TweenLite._e._visible != false || !gs.TweenLite._classInitted)
        {
            _curTime = getTimer();
            for (var _loc3 = 999; _root.getInstanceAtDepth(_loc3) != undefined; ++_loc3)
            {
            } // end of for
            _e = _root.createEmptyMovieClip("__tweenLite_mc", _loc3);
            gs.TweenLite._e._visible = false;
            clearInterval(gs.TweenLite._gc);
            _gc = setInterval(gs.TweenLite.killGarbage, 2000);
            gs.TweenLite._e.onEnterFrame = gs.TweenLite.executeAll;
            _classInitted = true;
        } // end if
        initTime = gs.TweenLite._curTime;
        if (_active || vars.runBackwards == true && vars.renderOnStart != true)
        {
            this.initTweenVals();
            startTime = gs.TweenLite._curTime;
            if (_active)
            {
                this.render(startTime + 1);
            }
            else
            {
                this.render(startTime);
            } // end else if
            if (vars._visible != undefined && vars.runBackwards == true)
            {
                target._visible = vars._visible;
            } // end if
        } // end if
        if (!_active && !gs.TweenLite._listening)
        {
            _listening = true;
        } // end if
    } // End of the function
    function initTweenVals($hrp, $reservedProps)
    {
        var _loc8 = typeof(target) == "movieclip";
        var _loc4;
        var _loc2;
        if (target instanceof Array)
        {
            var _loc5 = vars.endArray || [];
            for (var _loc2 = 0; _loc2 < _loc5.length; ++_loc2)
            {
                if (target[_loc2] != _loc5[_loc2] && target[_loc2] != undefined)
                {
                    tweens[tweens.length] = {o: target, p: _loc2.toString(), s: target[_loc2], c: _loc5[_loc2] - target[_loc2]};
                } // end if
            } // end of for
        }
        else
        {
            if ((vars.tint != undefined || vars.removeTint == true) && (_loc8 || target instanceof TextField))
            {
                var _loc13 = new Color(target);
                var _loc10 = vars._alpha;
                if (_loc10 != undefined)
                {
                    delete vars._alpha;
                }
                else
                {
                    _loc10 = target._alpha;
                } // end else if
                if (vars.removeTint == true || vars.tint == null || vars.tint == "")
                {
                    this.addSubTween(gs.TweenLite.tintProxy, _loc13.getTransform(), {rb: 0, gb: 0, bb: 0, ab: 0, ra: _loc10, ga: _loc10, ba: _loc10, aa: _loc10}, {color: _loc13});
                }
                else
                {
                    this.addSubTween(gs.TweenLite.tintProxy, _loc13.getTransform(), {rb: vars.tint >> 16, gb: vars.tint >> 8 & 255, bb: vars.tint & 255, ra: 0, ga: 0, ba: 0, aa: _loc10}, {color: _loc13});
                } // end if
            } // end else if
            if (vars.frame != undefined && _loc8)
            {
                this.addSubTween(gs.TweenLite.frameProxy, {frame: target._currentframe}, {frame: vars.frame}, {mc: target});
            } // end if
            if (vars.volume != undefined && (_loc8 || target instanceof Sound))
            {
                var _loc14;
                if (_loc8)
                {
                    _loc14 = new Sound(target);
                }
                else
                {
                    _loc14 = (Sound)(target);
                } // end else if
                this.addSubTween(gs.TweenLite.volumeProxy, {volume: _loc14.getVolume()}, {volume: vars.volume}, {sound: _loc14});
            } // end if
            for (var _loc4 in vars)
            {
                if (_loc4 == "ease" || _loc4 == "delay" || _loc4 == "overwrite" || _loc4 == "onComplete" || _loc4 == "onCompleteParams" || _loc4 == "onCompleteScope" || _loc4 == "runBackwards" || _loc4 == "onUpdate" || _loc4 == "onUpdateParams" || _loc4 == "onUpdateScope" || _loc4 == "persist" || _loc4 == "volume" || _loc4 == "onStart" || _loc4 == "onStartParams" || _loc4 == "onStartScope" || _loc4 == "renderOnStart" || _loc4 == "proxiedEase" || _loc4 == "easeParams" || $hrp && $reservedProps.indexOf(" " + _loc4 + " ") != -1)
                {
                    continue;
                } // end if
                if (!(_loc8 && (_loc4 == "_visible" || _loc4 == "autoAlpha" || _loc4 == "tint" || _loc4 == "removeTint" || _loc4 == "frame")) && target[_loc4] != undefined)
                {
                    if (typeof(vars[_loc4]) == "number")
                    {
                        tweens[tweens.length] = {o: target, p: _loc4, s: target[_loc4], c: vars[_loc4] - target[_loc4]};
                        continue;
                    } // end if
                    tweens[tweens.length] = {o: target, p: _loc4, s: target[_loc4], c: Number(vars[_loc4])};
                } // end if
            } // end of for...in
        } // end else if
        if (vars.runBackwards == true)
        {
            var _loc3;
            for (var _loc2 = tweens.length - 1; _loc2 > -1; --_loc2)
            {
                _loc3 = tweens[_loc2];
                _loc3.s = _loc3.s + _loc3.c;
                _loc3.c = _loc3.c * -1;
            } // end of for
        } // end if
        if (vars._visible == true)
        {
            target._visible = true;
        } // end if
        if (vars.onUpdate != null)
        {
            _hasUpdate = true;
        } // end if
        _initted = true;
    } // End of the function
    function addSubTween($proxy, $target, $props, $info)
    {
        var _loc5 = {proxy: $proxy, target: $target, info: $info};
        _subTweens[_subTweens.length] = _loc5;
        for (var _loc8 in $props)
        {
            if (typeof($props[_loc8]) == "number")
            {
                tweens[tweens.length] = {o: $target, p: _loc8, s: $target[_loc8], c: $props[_loc8] - $target[_loc8], sub: _loc5};
                continue;
            } // end if
            tweens[tweens.length] = {o: $target, p: _loc8, s: $target[_loc8], c: Number($props[_loc8]), sub: _loc5};
        } // end of for...in
        _hst = true;
    } // End of the function
    static function to($target, $duration, $vars)
    {
        return (new gs.TweenLite($target, $duration, $vars));
    } // End of the function
    static function from($target, $duration, $vars)
    {
        $vars.runBackwards = true;
        return (new gs.TweenLite($target, $duration, $vars));
    } // End of the function
    static function delayedCall($delay, $onComplete, $onCompleteParams, $onCompleteScope)
    {
        return (new gs.TweenLite($onComplete, 0, {delay: $delay, onComplete: $onComplete, onCompleteParams: $onCompleteParams, onCompleteScope: $onCompleteScope, overwrite: false}));
    } // End of the function
    function render($t)
    {
        var _loc5 = ($t - startTime) / 1000;
        var _loc4;
        var _loc3;
        var _loc2;
        if (_loc5 >= duration)
        {
            _loc5 = duration;
            _loc4 = 1;
        }
        else
        {
            _loc4 = vars.ease(_loc5, 0, 1, duration);
        } // end else if
        for (var _loc2 = tweens.length - 1; _loc2 > -1; --_loc2)
        {
            _loc3 = tweens[_loc2];
            _loc3.o[_loc3.p] = _loc3.s + _loc4 * _loc3.c;
        } // end of for
        if (_hst)
        {
            for (var _loc2 = _subTweens.length - 1; _loc2 > -1; --_loc2)
            {
                _subTweens[_loc2].proxy(_subTweens[_loc2]);
            } // end of for
        } // end if
        if (_hasUpdate)
        {
            vars.onUpdate.apply(vars.onUpdateScope, vars.onUpdateParams);
        } // end if
        if (_loc5 == duration)
        {
            this.complete(true);
        } // end if
    } // End of the function
    static function executeAll()
    {
        var _loc5 = _curTime = getTimer();
        if (gs.TweenLite._listening)
        {
            var _loc2 = gs.TweenLite._all;
            var _loc1;
            var _loc4;
            var _loc3;
            for (var _loc3 in _loc2)
            {
                for (var _loc4 in _loc2[_loc3])
                {
                    _loc1 = _loc2[_loc3][_loc4];
                    if (_loc1.active)
                    {
                        _loc1.render(_loc5);
                    } // end if
                } // end of for...in
            } // end of for...in
        } // end if
    } // End of the function
    static function removeTween($t)
    {
        gs.TweenLite._all[$t.endTargetID][$t.tweenID] = {active: false};
        delete gs.TweenLite._all[$t.endTargetID][$t.tweenID];
    } // End of the function
    static function killTweensOf($tg, $complete)
    {
        var _loc3 = gs.TweenLite.getID($tg, true);
        if ($complete)
        {
            var _loc1 = gs.TweenLite._all[_loc3];
            for (var _loc2 in _loc1)
            {
                _loc1[_loc2].complete(false);
            } // end of for...in
        } // end if
        delete gs.TweenLite._all[_loc3];
    } // End of the function
    function complete($skipRender)
    {
        if ($skipRender != true)
        {
            if (!_initted)
            {
                this.initTweenVals();
            } // end if
            startTime = gs.TweenLite._curTime - duration * 1000;
            this.render(gs.TweenLite._curTime);
            return;
        } // end if
        if (vars._visible != undefined)
        {
            if (vars.autoAlpha != undefined && target._alpha == 0)
            {
                target._visible = false;
            }
            else if (vars.runBackwards != true)
            {
                target._visible = vars._visible;
            } // end if
        } // end else if
        if (vars.onComplete)
        {
            vars.onComplete.apply(vars.onCompleteScope, vars.onCompleteParams);
        } // end if
        if (vars.persist != true)
        {
            gs.TweenLite.removeTween(this);
        } // end if
    } // End of the function
    static function getID($tg, $lookup)
    {
        var _loc3;
        if ($lookup)
        {
            var _loc1 = gs.TweenLite._all;
            if (typeof($tg) == "movieclip")
            {
                if (_loc1[String($tg)] != undefined)
                {
                    return (String($tg));
                }
                else
                {
                    _loc3 = String($tg);
                    gs.TweenLite._all[_loc3] = {info: [$tg, _loc3]};
                    return (_loc3);
                } // end else if
            }
            else
            {
                for (var _loc4 in _loc1)
                {
                    if (_loc1[_loc4].info[0] == $tg)
                    {
                        return (_loc4);
                    } // end if
                } // end of for...in
            } // end if
        } // end else if
        _cnt = ++gs.TweenLite._cnt;
        _loc3 = "t" + gs.TweenLite._cnt;
        gs.TweenLite._all[_loc3] = {info: [$tg, _loc3]};
        return (_loc3);
    } // End of the function
    static function killGarbage()
    {
        if (gs.TweenLite._listening)
        {
            var _loc1 = gs.TweenLite._all;
            var _loc2;
            var _loc3;
            var _loc5;
            var _loc6 = 0;
            var _loc4 = 0;
            for (var _loc3 in _loc1)
            {
                _loc4 = 0;
                for (var _loc5 in _loc1[_loc3])
                {
                    _loc2 = _loc1[_loc3][_loc5];
                    if (_loc2.tweens == undefined)
                    {
                        false;
                        continue;
                    } // end if
                    ++_loc4;
                } // end of for...in
                if (_loc4 == 0)
                {
                    delete _loc1[_loc3];
                    continue;
                } // end if
                ++_loc6;
            } // end of for...in
            if (_loc6 == 0)
            {
                _listening = false;
            } // end if
        } // end if
    } // End of the function
    static function defaultEase($t, $b, $c, $d)
    {
        $t = $t / $d;
        return (-$c * ($t) * ($t - 2) + $b);
    } // End of the function
    function easeProxy($t, $b, $c, $d)
    {
        var _loc3 = this;
        return (_loc3.proxiedEase.apply(null, arguments.concat(_loc3.easeParams)));
    } // End of the function
    static function tintProxy($o)
    {
        $o.info.color.setTransform($o.target);
    } // End of the function
    static function frameProxy($o)
    {
        $o.info.mc.gotoAndStop(Math.round($o.target.frame));
    } // End of the function
    static function volumeProxy($o)
    {
        $o.info.sound.setVolume($o.target.volume);
    } // End of the function
    function get active()
    {
        if (_active)
        {
            return (true);
        }
        else if ((gs.TweenLite._curTime - initTime) / 1000 > delay)
        {
            _active = true;
            startTime = initTime + delay * 1000;
            if (!_initted)
            {
                this.initTweenVals();
            }
            else if (vars._visible != undefined)
            {
                target._visible = true;
            } // end else if
            if (duration == 1.000000E-003)
            {
                startTime = startTime - 1;
            } // end if
            if (vars.onStart != undefined)
            {
                vars.onStart.apply(vars.onStartScope, vars.onStartParams);
            } // end if
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    static var version = 7.010000E+000;
    static var killDelayedCallsTo = gs.TweenLite.killTweensOf;
    static var _all = new Object();
    static var _cnt = -16000;
    static var _hrp = false;
} // End of Class
