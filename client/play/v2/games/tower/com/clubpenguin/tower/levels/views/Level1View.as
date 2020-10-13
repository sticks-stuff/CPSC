class com.clubpenguin.tower.levels.views.Level1View extends com.clubpenguin.tower.levels.views.AbstractLevelView
{
    var _mc;
    function Level1View(scope)
    {
        super(scope);
    } // End of the function
    function cleanUp()
    {
        removeMovieClip (_mc);
    } // End of the function
    var LINKAGE_ID = "com.clubpenguin.tower.levels.views.Level1View";
    var NAME = "Level1View";
} // End of Class
