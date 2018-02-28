class com.clubpenguin.text.TextResize
{
    function TextResize()
    {
    } // End of the function
    static function scaleDown($field, $verticalAlign, $minFontSize)
    {
        if ($field.autoSize != "none")
        {
            trace ("(TextResize): Error, cannont resize fields that have autoSize enabled!\r(textResize): Error occured at " + $field);
            return;
        } // end if
        var _loc7 = $field._width;
        var _loc5 = $field._height;
        var _loc6;
        var _loc10 = $field.textHeight;
        var _loc11;
        var _loc9 = $field._x;
        var _loc8 = $field._y;
        var _loc2 = $field.getTextFormat();
        var _loc12 = _loc2.size;
        var _loc4 = true;
        _loc6 = _loc2.align;
        _loc11 = _loc2.size;
        $minFontSize = $minFontSize == undefined ? (2) : ($minFontSize);
        if ($field.multiline)
        {
            $field.wordWrap = true;
        }
        else
        {
            $field.wordWrap = false;
        } // end else if
        while (_loc4)
        {
            $field.autoSize = _loc6;
            if ($field._width > _loc7 || $field._height > _loc5)
            {
                --_loc2.size;
                if (_loc2.size < $minFontSize)
                {
                    trace ("(TextResize): Error, font size is < " + $minFontSize + "!" + "\n" + "(textResize): Error occured at " + $field);
                    _loc2.size = $minFontSize;
                    _loc4 = false;
                } // end if
            }
            else
            {
                _loc4 = false;
            } // end else if
            $field.autoSize = "none";
            _loc2.align = _loc6;
            $field.setTextFormat(_loc2);
            $field._height = _loc5;
            $field._width = _loc7;
            $field._x = _loc9;
            $field._y = _loc8;
        } // end while
        if (!$field.multiline)
        {
            switch ($verticalAlign)
            {
                case "center":
                {
                    $field._y = $field._y + (_loc10 - $field.textHeight - 1) / 2;
                    break;
                } 
                case "bottom":
                {
                    $field._y = $field._y + (_loc10 - $field.textHeight - 1);
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
