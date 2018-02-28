class com.disney.dlearning.util.Guid
{
    function Guid()
    {
    } // End of the function
    static function create(len)
    {
        len > 40 ? (len = 40, 40) : (true);
        var _loc4 = new Date();
        var _loc6 = _loc4.getTime();
        var _loc5 = Math.random() * Number.MAX_VALUE;
        var _loc1 = System.capabilities.serverString;
        if (_loc1 == undefined)
        {
            _loc1 = com.disney.dlearning.util.Guid.generateRandomString(len);
        } // end if
        counter = ++com.disney.dlearning.util.Guid.counter;
        var _loc3 = com.disney.dlearning.util.Guid.calculate(_loc6 + _loc1 + _loc5 + com.disney.dlearning.util.Guid.counter).toUpperCase();
        return (_loc3.substr(1, len));
    } // End of the function
    static function generateRandomString(len)
    {
        for (var _loc1 = ""; _loc1.length < len; _loc1 = _loc1 + com.disney.dlearning.util.Guid.chars[com.disney.dlearning.util.Guid.randrange(0, com.disney.dlearning.util.Guid.chars.length - 1)])
        {
        } // end of for
        return (_loc1);
    } // End of the function
    static function randrange(min, max)
    {
        return (Math.floor(Math.random() * (max - min + 1)) + min);
    } // End of the function
    static function calculate(src)
    {
        return (com.disney.dlearning.util.Guid.hex_sha1(src));
    } // End of the function
    static function hex_sha1(src)
    {
        return (com.disney.dlearning.util.Guid.binb2hex(com.disney.dlearning.util.Guid.core_sha1(com.disney.dlearning.util.Guid.str2binb(src), src.length * 8)));
    } // End of the function
    static function core_sha1(x, len)
    {
        x[len >> 5] = x[len >> 5] | 128 << 24 - len % 32;
        x[(len + 64 >> 9 << 4) + 15] = len;
        var _loc2 = new Array(80);
        var _loc6 = 1732584193;
        var _loc5 = -271733879;
        var _loc4 = -1732584194;
        var _loc3 = 271733878;
        var _loc7 = -1009589776;
        for (var _loc9 = 0; _loc9 < x.length; _loc9 = _loc9 + 16)
        {
            var _loc15 = _loc6;
            var _loc14 = _loc5;
            var _loc13 = _loc4;
            var _loc12 = _loc3;
            var _loc11 = _loc7;
            for (var _loc1 = 0; _loc1 < 80; ++_loc1)
            {
                if (_loc1 < 16)
                {
                    _loc2[_loc1] = x[_loc9 + _loc1];
                }
                else
                {
                    _loc2[_loc1] = com.disney.dlearning.util.Guid.rol(_loc2[_loc1 - 3] ^ _loc2[_loc1 - 8] ^ _loc2[_loc1 - 14] ^ _loc2[_loc1 - 16], 1);
                } // end else if
                var _loc8 = com.disney.dlearning.util.Guid.safe_add(com.disney.dlearning.util.Guid.safe_add(com.disney.dlearning.util.Guid.rol(_loc6, 5), com.disney.dlearning.util.Guid.sha1_ft(_loc1, _loc5, _loc4, _loc3)), com.disney.dlearning.util.Guid.safe_add(com.disney.dlearning.util.Guid.safe_add(_loc7, _loc2[_loc1]), com.disney.dlearning.util.Guid.sha1_kt(_loc1)));
                _loc7 = _loc3;
                _loc3 = _loc4;
                _loc4 = com.disney.dlearning.util.Guid.rol(_loc5, 30);
                _loc5 = _loc6;
                _loc6 = _loc8;
            } // end of for
            _loc6 = com.disney.dlearning.util.Guid.safe_add(_loc6, _loc15);
            _loc5 = com.disney.dlearning.util.Guid.safe_add(_loc5, _loc14);
            _loc4 = com.disney.dlearning.util.Guid.safe_add(_loc4, _loc13);
            _loc3 = com.disney.dlearning.util.Guid.safe_add(_loc3, _loc12);
            _loc7 = com.disney.dlearning.util.Guid.safe_add(_loc7, _loc11);
        } // end of for
        return (new Array(_loc6, _loc5, _loc4, _loc3, _loc7));
    } // End of the function
    static function sha1_ft(t, b, c, d)
    {
        if (t < 20)
        {
            return (b & c | (b ^ 4.294967E+009) & d);
        } // end if
        if (t < 40)
        {
            return (b ^ c ^ d);
        } // end if
        if (t < 60)
        {
            return (b & c | b & d | c & d);
        } // end if
        return (b ^ c ^ d);
    } // End of the function
    static function sha1_kt(t)
    {
        return (t < 20 ? (1518500249) : (t < 40 ? (1859775393) : (t < 60 ? (-1894007588) : (-899497514))));
    } // End of the function
    static function safe_add(x, y)
    {
        var _loc1 = (x & 65535) + (y & 65535);
        var _loc2 = (x >> 16) + (y >> 16) + (_loc1 >> 16);
        return (_loc2 << 16 | _loc1 & 65535);
    } // End of the function
    static function rol(num, cnt)
    {
        return (num << cnt | num >>> 32 - cnt);
    } // End of the function
    static function str2binb(str)
    {
        var _loc3 = new Array();
        var _loc4 = 255;
        for (var _loc1 = 0; _loc1 < str.length * 8; _loc1 = _loc1 + 8)
        {
            _loc3[_loc1 >> 5] = _loc3[_loc1 >> 5] | (str.charCodeAt(_loc1 / 8) & _loc4) << 24 - _loc1 % 32;
        } // end of for
        return (_loc3);
    } // End of the function
    static function binb2hex(binarray)
    {
        var _loc4 = new String("");
        var _loc3 = new String("0123456789abcdef");
        for (var _loc1 = 0; _loc1 < binarray.length * 4; ++_loc1)
        {
            _loc4 = _loc4 + (_loc3.charAt(binarray[_loc1 >> 2] >> (3 - _loc1 % 4) * 8 + 4 & 15) + _loc3.charAt(binarray[_loc1 >> 2] >> (3 - _loc1 % 4) * 8 & 15));
        } // end of for
        return (_loc4);
    } // End of the function
    static var counter = 0;
    static var chars = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "q", "r", "s", "t", "v", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "@", "!", "#", "$", "%", "&", "*", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
} // End of Class
