class com.clubpenguin.tower.towers.types.SnowballTower extends com.clubpenguin.tower.towers.types.AbstractTower
{
    var damages, ranges, rates, _damage, _range, _delay, _view;
    function SnowballTower(stage, position, id, dropZones, towersArray, isPlaceable)
    {
        super(stage, position, id, dropZones, towersArray, new com.clubpenguin.tower.towers.views.SnowballTowerView(stage, id, towersArray), isPlaceable);
        damages = [40, 70, 90];
        ranges = [72, 72, 72];
        rates = [4000, 3500, 3000];
        _damage = damages[0];
        _range = ranges[0];
        _delay = rates[0];
        _view.drawRange(_range);
        _view.drawCircle(_range);
    } // End of the function
    var _type = "SnowballTower";
} // End of Class
