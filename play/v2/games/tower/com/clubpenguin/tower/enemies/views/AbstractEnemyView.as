class com.clubpenguin.tower.enemies.views.AbstractEnemyView implements com.clubpenguin.tower.enemies.interfaces.IEnemyView
{
    var _id, _stage, _mc, explodeInterval;
    function AbstractEnemyView(scope, id)
    {
        com.clubpenguin.tower.util.EventDispatcher.initialize(this);
        _id = id;
        if (LINKAGE_ID == "" || NAME == "")
        {
            throw new Error("LINKAGE_ID and NAME must be overidden by subclass");
        } // end if
        _stage = scope;
        var _loc3;
        _loc3 = scope.enemies.getNextHighestDepth();
        _mc = scope.enemies.attachMovie(LINKAGE_ID, NAME + "_" + id, scope.enemies.getNextHighestDepth());
    } // End of the function
    function addEventListener()
    {
    } // End of the function
    function removeEventListener()
    {
    } // End of the function
    function setHealth(value, initial)
    {
        var _loc2 = value / initial * 100;
        _mc.healthBar.bar._xscale = _loc2;
    } // End of the function
    function setPosition(xpos, ypos)
    {
        _mc._x = xpos;
        _mc._y = ypos;
    } // End of the function
    function setAngle(rotation)
    {
    } // End of the function
    function animateBack()
    {
        _mc.animation.gotoAndPlay("back");
    } // End of the function
    function animateForward()
    {
        _mc.animation.gotoAndPlay("forward");
    } // End of the function
    function animateLeft()
    {
        _mc.animation.gotoAndPlay("left");
    } // End of the function
    function animateRight()
    {
        _mc.animation.gotoAndPlay("right");
    } // End of the function
    function handleEnemyExplode(direction)
    {
        if (direction == "right")
        {
            this.animateRightExplode();
        }
        else if (direction == "left")
        {
            this.animateLeftExplode();
        }
        else if (direction == "back")
        {
            this.animateBackExplode();
        }
        else if (direction == "forward" || direction == undefined)
        {
            this.animateForwardExplode();
        } // end else if
    } // End of the function
    function animateBackExplode()
    {
        _mc.animation.gotoAndPlay("backExplode");
        _mc.healthBar._visible = false;
        explodeInterval = _global.setTimeout(com.clubpenguin.tower.util.Delegate.create(this, cleanUp), 1900);
    } // End of the function
    function animateForwardExplode()
    {
        _mc.animation.gotoAndPlay("forwardExplode");
        _mc.healthBar._visible = false;
        explodeInterval = _global.setTimeout(com.clubpenguin.tower.util.Delegate.create(this, cleanUp), 1900);
    } // End of the function
    function animateLeftExplode()
    {
        _mc.animation.gotoAndPlay("leftExplode");
        _mc.healthBar._visible = false;
        explodeInterval = _global.setTimeout(com.clubpenguin.tower.util.Delegate.create(this, cleanUp), 1900);
    } // End of the function
    function animateRightExplode()
    {
        _mc.animation.gotoAndPlay("rightExplode");
        _mc.healthBar._visible = false;
        explodeInterval = _global.setTimeout(com.clubpenguin.tower.util.Delegate.create(this, cleanUp), 1900);
    } // End of the function
    function show()
    {
        _mc._visible = true;
        _mc.healthBar._visible = true;
    } // End of the function
    function hide()
    {
        _mc._visible = false;
    } // End of the function
    function cleanUp()
    {
        _global.clearTimeout(explodeInterval);
        _mc._visible = false;
    } // End of the function
    function dispose()
    {
        _global.clearTimeout(explodeInterval);
        removeMovieClip (_mc);
    } // End of the function
    function attachEvents()
    {
    } // End of the function
    function onEnemyRollOver()
    {
    } // End of the function
    function onEnemyRollOut()
    {
    } // End of the function
    var LINKAGE_ID = "";
    var NAME = "";
} // End of Class
