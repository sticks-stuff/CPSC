class com.clubpenguin.tower.util.Array2D
{
    var hashRow;
    function Array2D()
    {
        hashRow = new Object();
    } // End of the function
    function getit(row, col)
    {
        var _loc2 = hashRow["r" + row];
        return (_loc2["c" + col]);
    } // End of the function
    function setit(row, col, val)
    {
        var _loc3;
        if (hashRow["r" + row] == undefined)
        {
            hashRow["r" + row] = new Object();
        } // end if
        _loc3 = hashRow["r" + row];
        _loc3["c" + col] = val;
    } // End of the function
    function swap(row, col, val)
    {
        var _loc2 = this.getit(row, col);
        this.setit(row, col, val);
        return (_loc2);
    } // End of the function
    function update(row, col, val)
    {
        return (null);
    } // End of the function
    function clean()
    {
        delete this.hashRow;
    } // End of the function
} // End of Class
