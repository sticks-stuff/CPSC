class com.clubpenguin.missions.managers.MusicTrack
{
    var _name, _url, _containerClip, _musicClip, _sound, dispatchEvent;
    function MusicTrack($name, $url, $target)
    {
        mx.events.EventDispatcher.initialize(this);
        _name = $name;
        _url = $url;
        _containerClip = $target;
        _musicClip = _containerClip.createEmptyMovieClip($name + "MusicClip", _containerClip.getNextHighestDepth());
        _musicClip.loadMovie(_url);
        _containerClip.onEnterFrame = mx.utils.Delegate.create(this, checkMusicClip);
    } // End of the function
    function checkMusicClip()
    {
        if (_musicClip.getBytesTotal() > 0)
        {
            _musicClip.stop();
            _sound = new Sound(_musicClip);
            delete _containerClip.onEnterFrame;
            this.dispatchEvent(new com.clubpenguin.missions.managers.MusicTrackEvent(com.clubpenguin.missions.managers.MusicTrackEvent.INIT, this));
        } // end if
    } // End of the function
    function play()
    {
        _musicClip.play();
    } // End of the function
    function stop()
    {
        _musicClip.stop();
    } // End of the function
    function fade($startVolume, $endVolume, $fadeDuration)
    {
        _sound.setVolume($startVolume);
        gs.TweenLite.to(_musicClip, $fadeDuration, {volume: $endVolume});
    } // End of the function
    function setVolume($volumeLevel)
    {
        _sound.setVolume($volumeLevel);
    } // End of the function
    function remove()
    {
        _musicClip.removeMovieClip();
    } // End of the function
} // End of Class
