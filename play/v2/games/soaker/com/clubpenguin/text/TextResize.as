class com.clubpenguin.text.TextResize
{
    function TextResize()
    {
    } // End of the function
    static function scaleDown($field, $verticalAlign, $minFontSize)
    {
        if ($field.autoSize != "none")
        {
            return;
        } // end if
        var _loc16 = $field._width;
        var _loc15 = $field._height;
        var _loc14;
        var _loc13 = $field.textHeight;
        var _loc12;
        var _loc11 = $field._x;
        var _loc10 = $field._y;
        var _loc9 = $field.getTextFormat();
        var _loc8 = _loc9.size;
        var _loc7 = true;
        _loc14 = _loc9.align;
        _loc12 = _loc9.size;
        $minFontSize = $minFontSize == undefined ? (2) : ($minFontSize);
        if (!$field.multiline)
        {
            $field.wordWrap = false;
        }
        else
        {
            $field.wordWrap = true;
        } // end else if
        while (_loc7)
        {
            $field.autoSize = _loc14;
            if (!($field._width > _loc16 || $field._height > _loc15))
            {
                _loc7 = false;
            }
            else
            {
                --_loc9.size;
                if (_loc9.size < $minFontSize)
                {
                    _loc9.size = $minFontSize;
                    _loc7 = false;
                } // end if
            } // end else if
            $field.autoSize = "none";
            _loc9.align = _loc14;
            $field.setTextFormat(_loc9);
            $field._height = _loc15;
            $field._width = _loc16;
            $field._x = _loc11;
            $field._y = _loc10;
        } // end while
        if (!$field.multiline)
        {
            switch ($verticalAlign)
            {
                case "center":
                {
                    $field._y = $field._y + (_loc13 - $field.textHeight - 1) / 2;
                    break;
                } 
                case "bottom":
                {
                    $field._y = $field._y + (_loc13 - $field.textHeight - 1);
                    break;
                } 
                case "top":
                default:
                {
                    ++$field._y;
                    break;
                } 
            } // End of switch
        } // end if
    } // End of the function
} // End of Class
