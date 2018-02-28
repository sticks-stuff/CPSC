class com.disney.dlearning.security.Md5
{
    function Md5(b64pad, chrsz)
    {
        if (b64pad != undefined)
        {
            this.b64pad = b64pad;
        } // end if
        if (chrsz != undefined && chrsz == 8 || chrsz == 16)
        {
            this.chrsz = chrsz;
        } // end if
    } // End of the function
    function hash(s)
    {
        return (this.hex_md5(s));
    } // End of the function
    function hex_md5(s)
    {
        return (this.binl2hex(this.core_md5(this.str2binl(s), s.length * chrsz)));
    } // End of the function
    function b64_md5(s)
    {
        return (this.binl2b64(this.core_md5(this.str2binl(s), s.length * chrsz)));
    } // End of the function
    function str_md5(s)
    {
        return (this.binl2str(this.core_md5(this.str2binl(s), s.length * chrsz)));
    } // End of the function
    function hex_hmac_md5(key, data)
    {
        return (this.binl2hex(this.core_hmac_md5(key, data)));
    } // End of the function
    function b64_hmac_md5(key, data)
    {
        return (this.binl2b64(this.core_hmac_md5(key, data)));
    } // End of the function
    function str_hmac_md5(key, data)
    {
        return (this.binl2str(this.core_hmac_md5(key, data)));
    } // End of the function
    function md5_cmn(q, a, b, x, s, t)
    {
        return (this.safe_add(this.bit_rol(this.safe_add(this.safe_add(a, q), this.safe_add(x, t)), s), b));
    } // End of the function
    function md5_ff(a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(b & c | (b ^ 4.294967E+009) & d, a, b, x, s, t));
    } // End of the function
    function md5_gg(a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(b & d | c & (d ^ 4.294967E+009), a, b, x, s, t));
    } // End of the function
    function md5_hh(a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(b ^ c ^ d, a, b, x, s, t));
    } // End of the function
    function md5_ii(a, b, c, d, x, s, t)
    {
        return (this.md5_cmn(c ^ (b | d ^ 4.294967E+009), a, b, x, s, t));
    } // End of the function
    function core_md5(x, len)
    {
        x[len >> 5] = x[len >> 5] | 128 << len % 32;
        x[(len + 64 >>> 9 << 4) + 14] = len;
        var _loc5 = 1732584193;
        var _loc4 = -271733879;
        var _loc3 = -1732584194;
        var _loc2 = 271733878;
        for (var _loc6 = 0; _loc6 < x.length; _loc6 = _loc6 + 16)
        {
            var _loc11 = _loc5;
            var _loc10 = _loc4;
            var _loc9 = _loc3;
            var _loc8 = _loc2;
            _loc5 = this.md5_ff(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 0], 7, -680876936);
            _loc2 = this.md5_ff(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 1], 12, -389564586);
            _loc3 = this.md5_ff(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 2], 17, 606105819);
            _loc4 = this.md5_ff(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 3], 22, -1044525330);
            _loc5 = this.md5_ff(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 4], 7, -176418897);
            _loc2 = this.md5_ff(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 5], 12, 1200080426);
            _loc3 = this.md5_ff(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 6], 17, -1473231341);
            _loc4 = this.md5_ff(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 7], 22, -45705983);
            _loc5 = this.md5_ff(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 8], 7, 1770035416);
            _loc2 = this.md5_ff(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 9], 12, -1958414417);
            _loc3 = this.md5_ff(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 10], 17, -42063);
            _loc4 = this.md5_ff(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 11], 22, -1990404162);
            _loc5 = this.md5_ff(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 12], 7, 1804603682);
            _loc2 = this.md5_ff(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 13], 12, -40341101);
            _loc3 = this.md5_ff(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 14], 17, -1502002290);
            _loc4 = this.md5_ff(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 15], 22, 1236535329);
            _loc5 = this.md5_gg(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 1], 5, -165796510);
            _loc2 = this.md5_gg(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 6], 9, -1069501632);
            _loc3 = this.md5_gg(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 11], 14, 643717713);
            _loc4 = this.md5_gg(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 0], 20, -373897302);
            _loc5 = this.md5_gg(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 5], 5, -701558691);
            _loc2 = this.md5_gg(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 10], 9, 38016083);
            _loc3 = this.md5_gg(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 15], 14, -660478335);
            _loc4 = this.md5_gg(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 4], 20, -405537848);
            _loc5 = this.md5_gg(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 9], 5, 568446438);
            _loc2 = this.md5_gg(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 14], 9, -1019803690);
            _loc3 = this.md5_gg(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 3], 14, -187363961);
            _loc4 = this.md5_gg(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 8], 20, 1163531501);
            _loc5 = this.md5_gg(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 13], 5, -1444681467);
            _loc2 = this.md5_gg(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 2], 9, -51403784);
            _loc3 = this.md5_gg(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 7], 14, 1735328473);
            _loc4 = this.md5_gg(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 12], 20, -1926607734);
            _loc5 = this.md5_hh(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 5], 4, -378558);
            _loc2 = this.md5_hh(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 8], 11, -2022574463);
            _loc3 = this.md5_hh(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 11], 16, 1839030562);
            _loc4 = this.md5_hh(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 14], 23, -35309556);
            _loc5 = this.md5_hh(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 1], 4, -1530992060);
            _loc2 = this.md5_hh(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 4], 11, 1272893353);
            _loc3 = this.md5_hh(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 7], 16, -155497632);
            _loc4 = this.md5_hh(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 10], 23, -1094730640);
            _loc5 = this.md5_hh(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 13], 4, 681279174);
            _loc2 = this.md5_hh(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 0], 11, -358537222);
            _loc3 = this.md5_hh(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 3], 16, -722521979);
            _loc4 = this.md5_hh(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 6], 23, 76029189);
            _loc5 = this.md5_hh(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 9], 4, -640364487);
            _loc2 = this.md5_hh(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 12], 11, -421815835);
            _loc3 = this.md5_hh(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 15], 16, 530742520);
            _loc4 = this.md5_hh(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 2], 23, -995338651);
            _loc5 = this.md5_ii(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 0], 6, -198630844);
            _loc2 = this.md5_ii(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 7], 10, 1126891415);
            _loc3 = this.md5_ii(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 14], 15, -1416354905);
            _loc4 = this.md5_ii(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 5], 21, -57434055);
            _loc5 = this.md5_ii(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 12], 6, 1700485571);
            _loc2 = this.md5_ii(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 3], 10, -1894986606);
            _loc3 = this.md5_ii(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 10], 15, -1051523);
            _loc4 = this.md5_ii(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 1], 21, -2054922799);
            _loc5 = this.md5_ii(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 8], 6, 1873313359);
            _loc2 = this.md5_ii(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 15], 10, -30611744);
            _loc3 = this.md5_ii(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 6], 15, -1560198380);
            _loc4 = this.md5_ii(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 13], 21, 1309151649);
            _loc5 = this.md5_ii(_loc5, _loc4, _loc3, _loc2, x[_loc6 + 4], 6, -145523070);
            _loc2 = this.md5_ii(_loc2, _loc5, _loc4, _loc3, x[_loc6 + 11], 10, -1120210379);
            _loc3 = this.md5_ii(_loc3, _loc2, _loc5, _loc4, x[_loc6 + 2], 15, 718787259);
            _loc4 = this.md5_ii(_loc4, _loc3, _loc2, _loc5, x[_loc6 + 9], 21, -343485551);
            _loc5 = this.safe_add(_loc5, _loc11);
            _loc4 = this.safe_add(_loc4, _loc10);
            _loc3 = this.safe_add(_loc3, _loc9);
            _loc2 = this.safe_add(_loc2, _loc8);
        } // end of for
        var _loc13 = new Array(_loc5, _loc4, _loc3, _loc2);
        return (_loc13);
    } // End of the function
    function core_hmac_md5(key, data)
    {
        var _loc3 = new Array(this.str2binl(key));
        if (_loc3.length > 16)
        {
            _loc3 = this.core_md5(_loc3, key.length * chrsz);
        } // end if
        var _loc4 = new Array(16);
        var _loc5 = new Array(16);
        for (var _loc2 = 0; _loc2 < 16; ++_loc2)
        {
            _loc4[_loc2] = _loc3[_loc2] ^ 909522486;
            _loc5[_loc2] = _loc3[_loc2] ^ 1549556828;
        } // end of for
        var _loc6 = new Array(this.core_md5(_loc4.concat(this.str2binl(data)), 512 + data.length * chrsz));
        return (this.core_md5(_loc5.concat(_loc6), 640));
    } // End of the function
    function safe_add(x, y)
    {
        var _loc1 = new Number((x & 65535) + (y & 65535));
        var _loc2 = new Number((x >> 16) + (y >> 16) + (_loc1 >> 16));
        return (_loc2 << 16 | _loc1 & 65535);
    } // End of the function
    function bit_rol(num, cnt)
    {
        return (num << cnt | num >>> 32 - cnt);
    } // End of the function
    function str2binl(str)
    {
        var _loc4 = new Array();
        var _loc5 = (1 << chrsz) - 1;
        for (var _loc2 = 0; _loc2 < str.length * chrsz; _loc2 = _loc2 + chrsz)
        {
            _loc4[_loc2 >> 5] = _loc4[_loc2 >> 5] | (str.charCodeAt(_loc2 / chrsz) & _loc5) << _loc2 % 32;
        } // end of for
        return (_loc4);
    } // End of the function
    function binl2str(bin)
    {
        var _loc4 = new String("");
        var _loc5 = (1 << chrsz) - 1;
        for (var _loc2 = 0; _loc2 < bin.length * 32; _loc2 = _loc2 + chrsz)
        {
            _loc4 = _loc4 + String.fromCharCode(bin[_loc2 >> 5] >>> _loc2 % 32 & _loc5);
        } // end of for
        return (_loc4);
    } // End of the function
    function binl2hex(binarray)
    {
        var _loc3 = "0123456789abcdef";
        var _loc4 = new String("");
        for (var _loc1 = 0; _loc1 < binarray.length * 4; ++_loc1)
        {
            _loc4 = _loc4 + (_loc3.charAt(binarray[_loc1 >> 2] >> _loc1 % 4 * 8 + 4 & 15) + _loc3.charAt(binarray[_loc1 >> 2] >> _loc1 % 4 * 8 & 15));
        } // end of for
        return (_loc4);
    } // End of the function
    function binl2b64(binarray)
    {
        var _loc7 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        var _loc5 = new String("");
        for (var _loc3 = 0; _loc3 < binarray.length * 4; _loc3 = _loc3 + 3)
        {
            var _loc6 = (binarray[_loc3 >> 2] >> 8 * (_loc3 % 4) & 255) << 16 | (binarray[_loc3 + 1 >> 2] >> 8 * ((_loc3 + 1) % 4) & 255) << 8 | binarray[_loc3 + 2 >> 2] >> 8 * ((_loc3 + 2) % 4) & 255;
            for (var _loc2 = 0; _loc2 < 4; ++_loc2)
            {
                if (_loc3 * 8 + _loc2 * 6 > binarray.length * 32)
                {
                    _loc5 = _loc5 + b64pad;
                    continue;
                } // end if
                _loc5 = _loc5 + _loc7.charAt(_loc6 >> 6 * (3 - _loc2) & 63);
            } // end of for
        } // end of for
        return (_loc5);
    } // End of the function
    var b64pad = new String("");
    var chrsz = new Number(8);
} // End of Class
