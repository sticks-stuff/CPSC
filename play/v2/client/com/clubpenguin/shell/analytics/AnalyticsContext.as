class com.clubpenguin.shell.analytics.AnalyticsContext
{
   function AnalyticsContext()
   {
      this._blockedPrefixes = [];
      this._blockedSuffixes = [];
      this._blockedOverrides = [];
      this._isEnabled = true;
      this._isBlockingAll = false;
   }
   function initFromConfig(config)
   {
      this.appendBlockedPrefixes(config.blockedPrefixes);
      this.appendBlockedSuffixes(config.blockedSuffixes);
      this.appendBlockedOverrides(config.blockedOverrides);
      this.__set__isEnabled(config.enabled == undefined?false:config.enabled);
      this.__set__isBlockingAll(config.blockAll);
   }
   function __get__isEnabled()
   {
      return this._isEnabled;
   }
   function __set__isEnabled(isEnabled)
   {
      this._isEnabled = isEnabled == undefined?false:isEnabled;
      return this.__get__isEnabled();
   }
   function __get__isBlockingAll()
   {
      return this._isBlockingAll;
   }
   function __set__isBlockingAll(isBlockingAll)
   {
      this._isBlockingAll = isBlockingAll == undefined?false:isBlockingAll;
      return this.__get__isBlockingAll();
   }
   function __get__blockedPrefixes()
   {
      return this._blockedPrefixes;
   }
   function __set__blockedPrefixes(prefixes)
   {
      this._blockedPrefixes = prefixes == undefined?[]:prefixes;
      return this.__get__blockedPrefixes();
   }
   function __get__blockedSuffixes()
   {
      return this._blockedSuffixes;
   }
   function __set__blockedSuffixes(suffixes)
   {
      this._blockedSuffixes = suffixes == undefined?[]:suffixes;
      return this.__get__blockedSuffixes();
   }
   function __get__blockedOverrides()
   {
      return this._blockedOverrides;
   }
   function __set__blockedOverrides(overrides)
   {
      this._blockedOverrides = overrides == undefined?[]:overrides;
      return this.__get__blockedOverrides();
   }
   function appendBlockedPrefixes(arr)
   {
      if(arr == undefined)
      {
         return undefined;
      }
      this._blockedPrefixes = this._blockedPrefixes.concat(arr);
   }
   function appendBlockedSuffixes(arr)
   {
      if(arr == undefined)
      {
         return undefined;
      }
      this._blockedSuffixes = this._blockedSuffixes.concat(arr);
   }
   function appendBlockedOverrides(arr)
   {
      if(arr == undefined)
      {
         return undefined;
      }
      this._blockedOverrides = this._blockedOverrides.concat(arr);
   }
   function toString()
   {
      var _loc2_ = "AnalyticsContext:";
      _loc2_ = _loc2_ + ("\n   isEnabled=" + this.__get__isEnabled());
      _loc2_ = _loc2_ + ("\n   isBlockingAll=" + this.__get__isBlockingAll());
      _loc2_ = _loc2_ + ("\n   _blockedPrefixes=" + this._blockedPrefixes);
      _loc2_ = _loc2_ + ("\n   _blockedSuffixes=" + this._blockedSuffixes);
      _loc2_ = _loc2_ + ("\n   _blockedOverrides=" + this._blockedOverrides);
      return _loc2_;
   }
}
