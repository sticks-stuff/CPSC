class com.clubpenguin.util.Localization
{
   static var PENGUIN_ID_PREFIX = "P";
   function Localization()
   {
   }
   static function getLocalizedNickname(penguinID, username, approvedLanguagesBitmask, currentLanguageBitmask)
   {
      if(approvedLanguagesBitmask & currentLanguageBitmask)
      {
         return username;
      }
      return com.clubpenguin.util.Localization.PENGUIN_ID_PREFIX + String(penguinID);
   }
}
