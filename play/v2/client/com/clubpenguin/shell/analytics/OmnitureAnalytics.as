class com.clubpenguin.shell.analytics.OmnitureAnalytics extends com.clubpenguin.shell.analytics.BaseAnalytics
{
   function OmnitureAnalytics(shell)
   {
      super(shell,new com.clubpenguin.shell.analytics.AnalyticsContext());
   }
   function logItem(itemName, data)
   {
      if(!this._shell.isValidString(itemName))
      {
         return false;
      }
      var _loc2_ = Number(this._shell.isMyPlayerMember());
      if(isNaN(_loc2_))
      {
         _loc2_ = -1;
      }
      var _loc3_ = this.buildOmnitureScript(itemName,_loc2_);
      if(this._shell.getEnvironment() != this._shell.ENV_LOCAL)
      {
         getURL(_loc3_,"");
         return true;
      }
      return false;
   }
   function buildOmnitureScript(itemName, membershipType)
   {
      var _loc2_ = "javascript:cto=new CTO();";
      _loc2_ = _loc2_ + "cto.account=\"clubpenguin\";";
      _loc2_ = _loc2_ + "cto.category=\"dgame\";";
      _loc2_ = _loc2_ + "cto.site=\"clp\";";
      _loc2_ = _loc2_ + "cto.siteSection=\"play\";";
      _loc2_ = _loc2_ + ("cto.pageName=\"" + itemName + "_" + this._shell.getLanguageAbbriviation() + "\";");
      _loc2_ = _loc2_ + "cto.contentType=\"activities\";";
      _loc2_ = _loc2_ + "cto.property=\"clp\";";
      _loc2_ = _loc2_ + ("cto.membershipType=\"" + membershipType + "\";");
      _loc2_ = _loc2_ + "cto.track();";
      return _loc2_;
   }
   function toString()
   {
      return "[OmnitureAnalytics]";
   }
}
