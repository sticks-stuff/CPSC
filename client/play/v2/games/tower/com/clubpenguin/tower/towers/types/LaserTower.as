class com.clubpenguin.tower.towers.types.LaserTower extends com.clubpenguin.tower.towers.types.AbstractTower
{
    var damages, ranges, rates, _damage, _range, _delay, _view;
    function LaserTower(stage, position, id, dropZones, towersArray, isPlaceable)
    {
        super(stage, position, id, dropZones, towersArray, new com.clubpenguin.tower.towers.views.LaserTowerView(stage, id, towersArray), isPlaceable);
        damages = [1, 4, 8];
        ranges = [72, 84, 96];
        rates = [500, 500, 500];
        _damage = damages[0];
        _range = ranges[0];
        _delay = rates[0];
        _view.drawRange(_range);
        _view.drawCircle(_range);
    } // End of the function
    var _type = "LaserTower";
} // End of Class
