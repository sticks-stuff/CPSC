class com.clubpenguin.shell.analytics.WebLoggerContext extends com.clubpenguin.shell.analytics.AnalyticsContext
{
   function WebLoggerContext()
   {
      super();
      this._categoryMap = {};
      this._categoryIndexMap = {};
   }
   function initFromConfig(config)
   {
      super.initFromConfig(config);
      this._categoryMap = config.categoryMap;
      this._categoryIndexMap = config.CATEGORY_INDEX_MAP;
   }
   function __get__categoryMap()
   {
      return this._categoryMap;
   }
   function __set__categoryMap(map)
   {
      this._categoryMap = map;
      return this.__get__categoryMap();
   }
   function __get__categoryIndexMap()
   {
      return this._categoryIndexMap;
   }
   function __set__categoryIndexMap(map)
   {
      this._categoryIndexMap = map;
      return this.__get__categoryIndexMap();
   }
   function toString()
   {
      var _loc3_ = super();
      _loc3_ = _loc3_ + ("\n   _categoryMap=" + this._categoryMap);
      _loc3_ = _loc3_ + ("\n   _categoryIndexMap=" + this._categoryIndexMap);
      return _loc3_;
   }
}
