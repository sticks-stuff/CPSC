class com.clubpenguin.tower.towers.types.RocketTower extends com.clubpenguin.tower.towers.types.AbstractTower
{
    var damages, ranges, rates, _damage, _range, _delay, _view;
    function RocketTower(stage, position, id, dropZones, towersArray, isPlaceable)
    {
        super(stage, position, id, dropZones, towersArray, new com.clubpenguin.tower.towers.views.RocketTowerView(stage, id, towersArray), isPlaceable);
        damages = [8, 10, 12];
        ranges = [180, 200, 220];
        rates = [2500, 1750, 1000];
        _damage = damages[0];
        _range = ranges[0];
        _delay = rates[0];
        _view.drawRange(_range);
        _view.drawCircle(_range);
    } // End of the function
    var _type = "RocketTower";
} // End of Class
