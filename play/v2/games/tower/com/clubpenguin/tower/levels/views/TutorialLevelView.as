class com.clubpenguin.tower.levels.views.TutorialLevelView extends com.clubpenguin.tower.levels.views.AbstractLevelView
{
    var _mc;
    function TutorialLevelView(scope)
    {
        super(scope);
    } // End of the function
    function cleanUp()
    {
        removeMovieClip (_mc);
    } // End of the function
    var LINKAGE_ID = "com.clubpenguin.tower.levels.views.TutorialLevelView";
    var NAME = "TutorialLevelView";
} // End of Class
