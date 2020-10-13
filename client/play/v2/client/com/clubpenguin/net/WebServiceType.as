class com.clubpenguin.net.WebServiceType
{
   static var IS_LOCALIZED = true;
   static var IS_NOT_LOCALIZED = false;
   static var GAMES = new com.clubpenguin.net.WebServiceType("Games","web_service/games.php",com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
   static var STAMPS = new com.clubpenguin.net.WebServiceType("Stamps","web_service/stamps.php",com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
   static var POLAROIDS = new com.clubpenguin.net.WebServiceType("Polaroids","web_service/polaroids.php",com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
   static var STAMPBOOK_COVER = new com.clubpenguin.net.WebServiceType("StampBook Cover","web_service/cover.php",com.clubpenguin.net.WebServiceType.IS_LOCALIZED);
   static var ANALYTICS = new com.clubpenguin.net.WebServiceType("Analytics","web_service/weblogger.php",com.clubpenguin.net.WebServiceType.IS_NOT_LOCALIZED);
   function WebServiceType(name, webServiceCrumbPath, isLocalized)
   {
      this._name = name;
      this._webServiceCrumbPath = webServiceCrumbPath;
      this._isLocalized = isLocalized;
   }
   function __get__name()
   {
      return this._name;
   }
   function __get__webServiceCrumbPath()
   {
      return this._webServiceCrumbPath;
   }
   function __get__isLocalized()
   {
      return this._isLocalized;
   }
   function toString()
   {
      return this._name;
   }
   static function getServiceTypes()
   {
      return [com.clubpenguin.net.WebServiceType.STAMPS,com.clubpenguin.net.WebServiceType.POLAROIDS,com.clubpenguin.net.WebServiceType.STAMPBOOK_COVER,com.clubpenguin.net.WebServiceType.GAMES,com.clubpenguin.net.WebServiceType.ANALYTICS];
   }
}
