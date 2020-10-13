class com.clubpenguin.tower.levels.LevelFactory
{
    function LevelFactory()
    {
    } // End of the function
    function create(scope, level)
    {
        switch (level)
        {
            case LEVEL1:
            {
                return (new com.clubpenguin.tower.levels.types.Level1(scope, 1));
            } 
            case LEVEL2:
            {
                return (new com.clubpenguin.tower.levels.types.Level2(scope, 2));
            } 
            case LEVEL3:
            {
                return (new com.clubpenguin.tower.levels.types.Level3(scope, 3));
            } 
            case LEVEL4:
            {
                return (new com.clubpenguin.tower.levels.types.Level4(scope, 4));
            } 
            case LEVEL5:
            {
                return (new com.clubpenguin.tower.levels.types.Level5(scope, 5));
            } 
            case LEVEL6:
            {
                return (new com.clubpenguin.tower.levels.types.Level6(scope, 6));
            } 
            case TUTORIAL_LEVEL:
            {
                return (new com.clubpenguin.tower.levels.types.TutorialLevel(scope, -1));
            } 
            case SCENARIO_LEVEL:
            {
                return (new com.clubpenguin.tower.levels.types.ScenarioLevel(scope, 0));
            } 
        } // End of switch
        throw new Error("Not a recognized type of level requested!");
        
    } // End of the function
    var LEVEL1 = "LEVEL1";
    var LEVEL2 = "LEVEL2";
    var LEVEL3 = "LEVEL3";
    var LEVEL4 = "LEVEL4";
    var LEVEL5 = "LEVEL5";
    var LEVEL6 = "LEVEL6";
    var TUTORIAL_LEVEL = "LEVEL-1";
    var SCENARIO_LEVEL = "LEVEL0";
} // End of Class
