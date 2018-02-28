class com.clubpenguin.tower.util.MathHelper
{
    function MathHelper()
    {
    } // End of the function
    static function getRandomNumberInRange(min, max)
    {
        return (Math.floor(Math.random() * (max - min)) + min);
    } // End of the function
} // End of Class
