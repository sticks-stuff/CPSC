class com.clubpenguin.games.generic.UserInput
{
    static var keyListener, mouseListener;
    function UserInput()
    {
        keyListener = new Object();
        com.clubpenguin.games.generic.UserInput.keyListener.onKeyDown = com.clubpenguin.util.Delegate.create(this, handleKeyDown);
        com.clubpenguin.games.generic.UserInput.keyListener.onKeyUp = com.clubpenguin.util.Delegate.create(this, handleKeyUp);
        Key.addListener(com.clubpenguin.games.generic.UserInput.keyListener);
        mouseListener = new Object();
        com.clubpenguin.games.generic.UserInput.mouseListener.onMouseDown = com.clubpenguin.util.Delegate.create(this, handleMouseDown);
        com.clubpenguin.games.generic.UserInput.mouseListener.onMouseUp = com.clubpenguin.util.Delegate.create(this, handleMouseUp);
        Mouse.addListener(com.clubpenguin.games.generic.UserInput.mouseListener);
    } // End of the function
    function handleKeyDown()
    {
        if (Key.getCode() == 37 && !com.clubpenguin.games.generic.UserInput.KEY_PRESSED_LEFT)
        {
            KEY_PRESSED_LEFT = true;
        } // end if
        if (Key.getCode() == 39 && !com.clubpenguin.games.generic.UserInput.KEY_PRESSED_RIGHT)
        {
            KEY_PRESSED_RIGHT = true;
        } // end if
        if (Key.getCode() == 38 && !com.clubpenguin.games.generic.UserInput.KEY_PRESSED_UP)
        {
            KEY_PRESSED_UP = true;
        } // end if
        if (Key.getCode() == 40 && !com.clubpenguin.games.generic.UserInput.KEY_PRESSED_DOWN)
        {
            KEY_PRESSED_DOWN = true;
        } // end if
        if (Key.getCode() == 32 && !com.clubpenguin.games.generic.UserInput.KEY_PRESSED_SPACE)
        {
            KEY_PRESSED_SPACE = true;
        } // end if
    } // End of the function
    function handleKeyUp()
    {
        if (Key.getCode() == 37 && com.clubpenguin.games.generic.UserInput.KEY_PRESSED_LEFT)
        {
            KEY_PRESSED_LEFT = false;
        } // end if
        if (Key.getCode() == 39 && com.clubpenguin.games.generic.UserInput.KEY_PRESSED_RIGHT)
        {
            KEY_PRESSED_RIGHT = false;
        } // end if
        if (Key.getCode() == 38 && com.clubpenguin.games.generic.UserInput.KEY_PRESSED_UP)
        {
            KEY_PRESSED_UP = false;
        } // end if
        if (Key.getCode() == 40 && com.clubpenguin.games.generic.UserInput.KEY_PRESSED_DOWN)
        {
            KEY_PRESSED_DOWN = false;
        } // end if
        if (Key.getCode() == 32 && com.clubpenguin.games.generic.UserInput.KEY_PRESSED_SPACE)
        {
            KEY_PRESSED_SPACE = false;
        } // end if
    } // End of the function
    function handleMouseDown()
    {
        MOUSE_DOWN = true;
        updateAfterEvent();
    } // End of the function
    function handleMouseUp()
    {
        if (com.clubpenguin.games.generic.UserInput.MOUSE_DOWN)
        {
            MOUSE_CLICKED = true;
        } // end if
        MOUSE_DOWN = false;
    } // End of the function
    static var KEY_PRESSED_LEFT = false;
    static var KEY_PRESSED_RIGHT = false;
    static var KEY_PRESSED_UP = false;
    static var KEY_PRESSED_DOWN = false;
    static var KEY_PRESSED_SPACE = false;
    static var MOUSE_DOWN = false;
    static var MOUSE_CLICKED = false;
} // End of Class
