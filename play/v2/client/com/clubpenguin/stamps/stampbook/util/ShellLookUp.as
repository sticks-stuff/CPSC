class com.clubpenguin.stamps.stampbook.util.ShellLookUp extends MovieClip
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.util.ShellLookUp;
   function ShellLookUp()
   {
      super();
   }
   static function __get__shell()
   {
      return com.clubpenguin.stamps.stampbook.util.ShellLookUp._shell;
   }
   static function __set__shell(shell)
   {
      com.clubpenguin.stamps.stampbook.util.ShellLookUp._shell = shell;
      return com.clubpenguin.stamps.stampbook.util.ShellLookUp.__get__shell();
   }
}
