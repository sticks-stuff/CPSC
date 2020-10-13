class com.clubpenguin.games.beatbox.UserInputBeatbox extends com.clubpenguin.games.generic.UserInput
{
    var keysPressed, movie;
    function UserInputBeatbox($movie)
    {
        super();
        keysPressed = new Array();
        movie = $movie;
    } // End of the function
    function handleKeyDown()
    {
        super.handleKeyDown();
        if (Key.isDown(8) && Key.isDown(77))
        {
            this.handleHIDKeyPress();
        } // end if
    } // End of the function
    function handleKeyUp()
    {
        super.handleKeyUp();
        var _loc7 = Key.getCode();
        keysPressed[_loc7] = false;
        if (!Key.isDown(35) && !Key.isDown(97))
        {
            keysPressed[97] = false;
        } // end if
        if (!Key.isDown(40) && !Key.isDown(98))
        {
            keysPressed[98] = false;
        } // end if
        if (!Key.isDown(34) && !Key.isDown(99))
        {
            keysPressed[99] = false;
        } // end if
        if (!Key.isDown(37) && !Key.isDown(100))
        {
            keysPressed[100] = false;
        } // end if
        if (!Key.isDown(12) && !Key.isDown(101))
        {
            keysPressed[101] = false;
        } // end if
        if (!Key.isDown(39) && !Key.isDown(102))
        {
            keysPressed[102] = false;
        } // end if
        if (!Key.isDown(36) && !Key.isDown(103))
        {
            keysPressed[103] = false;
        } // end if
        if (!Key.isDown(38) && !Key.isDown(104))
        {
            keysPressed[104] = false;
        } // end if
        if (!Key.isDown(33) && !Key.isDown(105))
        {
            keysPressed[105] = false;
        } // end if
    } // End of the function
    function handleHIDKeyPress()
    {
        if (!(Key.isDown(192) && !keysPressed[192]))
        {
            if (!(Key.isDown(49) && !keysPressed[49]))
            {
                if (!(Key.isDown(81) && !keysPressed[81]))
                {
                    if (!(Key.isDown(65) && !keysPressed[65]))
                    {
                        if (!(Key.isDown(90) && !keysPressed[90]))
                        {
                            if (!(Key.isDown(50) && !keysPressed[50]))
                            {
                                if (!(Key.isDown(87) && !keysPressed[87]))
                                {
                                    if (!(Key.isDown(83) && !keysPressed[83]))
                                    {
                                        if (!(Key.isDown(52) && !keysPressed[52]))
                                        {
                                            if (!(Key.isDown(53) && !keysPressed[53]))
                                            {
                                                if (!(Key.isDown(54) && !keysPressed[54]))
                                                {
                                                    if (!(Key.isDown(82) && !keysPressed[82]))
                                                    {
                                                        if (!(Key.isDown(70) && !keysPressed[70]))
                                                        {
                                                            if (!(Key.isDown(86) && !keysPressed[86]))
                                                            {
                                                                if (!(Key.isDown(84) && !keysPressed[84]))
                                                                {
                                                                    if (!(Key.isDown(71) && !keysPressed[71]))
                                                                    {
                                                                        if (!(Key.isDown(66) && !keysPressed[66]))
                                                                        {
                                                                            if (!(Key.isDown(89) && !keysPressed[89]))
                                                                            {
                                                                                if (!(Key.isDown(72) && !keysPressed[72]))
                                                                                {
                                                                                    if (!(Key.isDown(78) && !keysPressed[78]))
                                                                                    {
                                                                                        if (!(Key.isDown(85) && !keysPressed[85]))
                                                                                        {
                                                                                            if (!(Key.isDown(74) && !keysPressed[74]))
                                                                                            {
                                                                                                if (!(Key.isDown(73) && !keysPressed[73]))
                                                                                                {
                                                                                                    if (!(Key.isDown(188) && !keysPressed[188]))
                                                                                                    {
                                                                                                        if (!(Key.isDown(79) && !keysPressed[79]))
                                                                                                        {
                                                                                                            if (!(Key.isDown(76) && !keysPressed[76]))
                                                                                                            {
                                                                                                                if (!(Key.isDown(190) && !keysPressed[190]))
                                                                                                                {
                                                                                                                    if (!(Key.isDown(80) && !keysPressed[80]))
                                                                                                                    {
                                                                                                                        if (!(Key.isDown(186) && !keysPressed[186]))
                                                                                                                        {
                                                                                                                            if (!(Key.isDown(191) && !keysPressed[191]))
                                                                                                                            {
                                                                                                                                if (!(Key.isDown(219) && !keysPressed[219]))
                                                                                                                                {
                                                                                                                                    if (!(Key.isDown(222) && !keysPressed[222]))
                                                                                                                                    {
                                                                                                                                        if (!(Key.isDown(75) && !keysPressed[75]))
                                                                                                                                        {
                                                                                                                                            if (!(Key.isDown(88) && !keysPressed[88]))
                                                                                                                                            {
                                                                                                                                                if (!(Key.isDown(51) && !keysPressed[51]))
                                                                                                                                                {
                                                                                                                                                    if (!(Key.isDown(69) && !keysPressed[69]))
                                                                                                                                                    {
                                                                                                                                                        if (!(Key.isDown(68) && !keysPressed[68]))
                                                                                                                                                        {
                                                                                                                                                            if (!(Key.isDown(67) && !keysPressed[67]))
                                                                                                                                                            {
                                                                                                                                                                if (!((Key.isDown(97) || Key.isDown(35)) && !keysPressed[97]))
                                                                                                                                                                {
                                                                                                                                                                    if (!((Key.isDown(98) || Key.isDown(40)) && !keysPressed[98]))
                                                                                                                                                                    {
                                                                                                                                                                        if (!((Key.isDown(99) || Key.isDown(34)) && !keysPressed[99]))
                                                                                                                                                                        {
                                                                                                                                                                            if (!((Key.isDown(100) || Key.isDown(37)) && !keysPressed[100]))
                                                                                                                                                                            {
                                                                                                                                                                                if (!((Key.isDown(101) || Key.isDown(12)) && !keysPressed[101]))
                                                                                                                                                                                {
                                                                                                                                                                                    if (!((Key.isDown(102) || Key.isDown(39)) && !keysPressed[102]))
                                                                                                                                                                                    {
                                                                                                                                                                                        if (!((Key.isDown(103) || Key.isDown(36)) && !keysPressed[103]))
                                                                                                                                                                                        {
                                                                                                                                                                                            if (!((Key.isDown(104) || Key.isDown(38)) && !keysPressed[104]))
                                                                                                                                                                                            {
                                                                                                                                                                                                if (!((Key.isDown(105) || Key.isDown(33)) && !keysPressed[105]))
                                                                                                                                                                                                {
                                                                                                                                                                                                    if (!(Key.isDown(107) && !keysPressed[107]))
                                                                                                                                                                                                    {
                                                                                                                                                                                                        if (!(Key.isDown(111) && !keysPressed[111]))
                                                                                                                                                                                                        {
                                                                                                                                                                                                            if (!(Key.isDown(106) && !keysPressed[106]))
                                                                                                                                                                                                            {
                                                                                                                                                                                                                if (!(Key.isDown(109) && !keysPressed[109]))
                                                                                                                                                                                                                {
                                                                                                                                                                                                                    if (Key.isDown(220) && !keysPressed[220])
                                                                                                                                                                                                                    {
                                                                                                                                                                                                                        com.clubpenguin.games.beatbox.GameEngine.instance.stopSounds();
                                                                                                                                                                                                                        movie.buttonStopAll.gotoAndPlay(2);
                                                                                                                                                                                                                        keysPressed[220] = true;
                                                                                                                                                                                                                    } // end if
                                                                                                                                                                                                                }
                                                                                                                                                                                                                else
                                                                                                                                                                                                                {
                                                                                                                                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyCHigh", "noteKey13", 100, 0, 1, false);
                                                                                                                                                                                                                    movie.noteKey13.gotoAndPlay(3);
                                                                                                                                                                                                                    keysPressed[109] = true;
                                                                                                                                                                                                                } // end else if
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyB", "noteKey12", 100, 0, 1, false);
                                                                                                                                                                                                                movie.noteKey12.gotoAndPlay(3);
                                                                                                                                                                                                                keysPressed[106] = true;
                                                                                                                                                                                                            } // end else if
                                                                                                                                                                                                        }
                                                                                                                                                                                                        else
                                                                                                                                                                                                        {
                                                                                                                                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyASharp", "noteKey11", 100, 0, 1, false);
                                                                                                                                                                                                            movie.noteKey11.gotoAndPlay(3);
                                                                                                                                                                                                            keysPressed[111] = true;
                                                                                                                                                                                                        } // end else if
                                                                                                                                                                                                    }
                                                                                                                                                                                                    else
                                                                                                                                                                                                    {
                                                                                                                                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyA", "noteKey10", 100, 0, 1, false);
                                                                                                                                                                                                        movie.noteKey10.gotoAndPlay(3);
                                                                                                                                                                                                        keysPressed[107] = true;
                                                                                                                                                                                                    } // end else if
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyGSharp", "noteKey9", 100, 0, 1, false);
                                                                                                                                                                                                    movie.noteKey9.gotoAndPlay(3);
                                                                                                                                                                                                    keysPressed[105] = true;
                                                                                                                                                                                                } // end else if
                                                                                                                                                                                            }
                                                                                                                                                                                            else
                                                                                                                                                                                            {
                                                                                                                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyG", "noteKey8", 100, 0, 1, false);
                                                                                                                                                                                                movie.noteKey8.gotoAndPlay(3);
                                                                                                                                                                                                keysPressed[104] = true;
                                                                                                                                                                                            } // end else if
                                                                                                                                                                                        }
                                                                                                                                                                                        else
                                                                                                                                                                                        {
                                                                                                                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyFSharp", "noteKey7", 100, 0, 1, false);
                                                                                                                                                                                            movie.noteKey7.gotoAndPlay(3);
                                                                                                                                                                                            keysPressed[103] = true;
                                                                                                                                                                                        } // end else if
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyF", "noteKey6", 100, 0, 1, false);
                                                                                                                                                                                        movie.noteKey6.gotoAndPlay(3);
                                                                                                                                                                                        keysPressed[102] = true;
                                                                                                                                                                                    } // end else if
                                                                                                                                                                                }
                                                                                                                                                                                else
                                                                                                                                                                                {
                                                                                                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyE", "noteKey5", 100, 0, 1, false);
                                                                                                                                                                                    movie.noteKey5.gotoAndPlay(3);
                                                                                                                                                                                    keysPressed[101] = true;
                                                                                                                                                                                } // end else if
                                                                                                                                                                            }
                                                                                                                                                                            else
                                                                                                                                                                            {
                                                                                                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyDSharp", "noteKey4", 100, 0, 1, false);
                                                                                                                                                                                movie.noteKey4.gotoAndPlay(3);
                                                                                                                                                                                keysPressed[100] = true;
                                                                                                                                                                            } // end else if
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyD", "noteKey3", 100, 0, 1, false);
                                                                                                                                                                            movie.noteKey3.gotoAndPlay(3);
                                                                                                                                                                            keysPressed[99] = true;
                                                                                                                                                                        } // end else if
                                                                                                                                                                    }
                                                                                                                                                                    else
                                                                                                                                                                    {
                                                                                                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyCSharp", "noteKey2", 100, 0, 1, false);
                                                                                                                                                                        movie.noteKey2.gotoAndPlay(3);
                                                                                                                                                                        keysPressed[97] = true;
                                                                                                                                                                    } // end else if
                                                                                                                                                                }
                                                                                                                                                                else
                                                                                                                                                                {
                                                                                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("keyCLow", "noteKey1", 100, 0, 1, false);
                                                                                                                                                                    movie.noteKey1.gotoAndPlay(3);
                                                                                                                                                                    keysPressed[97] = true;
                                                                                                                                                                } // end else if
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectWhistle", "Speaker5", 100, 0, 1, true);
                                                                                                                                                                movie.button38.gotoAndPlay(2);
                                                                                                                                                                keysPressed[67] = true;
                                                                                                                                                            } // end else if
                                                                                                                                                        }
                                                                                                                                                        else
                                                                                                                                                        {
                                                                                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectEep", "Speaker4", 100, 0, 1, true);
                                                                                                                                                            movie.button37.gotoAndPlay(2);
                                                                                                                                                            keysPressed[68] = true;
                                                                                                                                                        } // end else if
                                                                                                                                                    }
                                                                                                                                                    else
                                                                                                                                                    {
                                                                                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectCops", "Speaker3", 100, 0, 1, true);
                                                                                                                                                        movie.button36.gotoAndPlay(2);
                                                                                                                                                        keysPressed[69] = true;
                                                                                                                                                    } // end else if
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectKlaxon", "Speaker2", 100, 0, 1, true);
                                                                                                                                                    movie.button35.gotoAndPlay(2);
                                                                                                                                                    keysPressed[51] = true;
                                                                                                                                                } // end else if
                                                                                                                                            }
                                                                                                                                            else
                                                                                                                                            {
                                                                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectCowbell", "Speaker1", 100, 0, 1, true);
                                                                                                                                                movie.button34.gotoAndPlay(2);
                                                                                                                                                keysPressed[88] = true;
                                                                                                                                            } // end else if
                                                                                                                                        }
                                                                                                                                        else
                                                                                                                                        {
                                                                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck10", "TurntableRight", 100, 0, 1, false);
                                                                                                                                            keysPressed[75] = true;
                                                                                                                                        } // end else if
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck8", "TurntableRight1", 100, 0, 1, true);
                                                                                                                                        movie.mixer.button32.gotoAndPlay(2);
                                                                                                                                        keysPressed[222] = true;
                                                                                                                                    } // end else if
                                                                                                                                }
                                                                                                                                else
                                                                                                                                {
                                                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck6", "TurntableRight2", 100, 0, 1, true);
                                                                                                                                    movie.mixer.button31.gotoAndPlay(2);
                                                                                                                                    keysPressed[219] = true;
                                                                                                                                } // end else if
                                                                                                                            }
                                                                                                                            else
                                                                                                                            {
                                                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck4", "TurntableRight4", 100, 0, 1, true);
                                                                                                                                movie.mixer.button30.gotoAndPlay(2);
                                                                                                                                keysPressed[191] = true;
                                                                                                                            } // end else if
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck2", "TurntableRight3", 100, 0, 1, true);
                                                                                                                            movie.mixer.button29.gotoAndPlay(2);
                                                                                                                            keysPressed[186] = true;
                                                                                                                        } // end else if
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck7", "TurntableLeft3", 100, 0, 1, true);
                                                                                                                        movie.mixer.button28.gotoAndPlay(2);
                                                                                                                        keysPressed[80] = true;
                                                                                                                    } // end else if
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck5", "TurntableLeft1", 100, 0, 1, true);
                                                                                                                    movie.mixer.button27.gotoAndPlay(2);
                                                                                                                    keysPressed[190] = true;
                                                                                                                } // end else if
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck3", "TurntableLeft2", 100, 0, 1, true);
                                                                                                                movie.mixer.button26.gotoAndPlay(2);
                                                                                                                keysPressed[76] = true;
                                                                                                            } // end else if
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck11", "TurntableLeft4", 100, 0, 1, true);
                                                                                                            movie.mixer.button25.gotoAndPlay(2);
                                                                                                            keysPressed[79] = true;
                                                                                                        } // end else if
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        movie.mixer.slider_anim.gotoAndPlay("on");
                                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck1", "Crossfader", 100, 0, 1, false);
                                                                                                        keysPressed[188] = true;
                                                                                                    } // end else if
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRewindDeck9", "TurntableLeft", 100, 0, 1, true);
                                                                                                    keysPressed[73] = true;
                                                                                                } // end else if
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", 16))
                                                                                                {
                                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", 16);
                                                                                                    movie.rackmountedMelodyLoops.slider5.gotoAndStop("off");
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    var _loc7 = com.clubpenguin.games.beatbox.GameEngine.beatbox.unmuteBeatboxSound("beatbox_sequence", 16);
                                                                                                    if (!_loc7)
                                                                                                    {
                                                                                                        com.clubpenguin.games.beatbox.GameEngine.debugTrace("sound 16 not ready to be unmuted");
                                                                                                    } // end if
                                                                                                    movie.rackmountedMelodyLoops.slider5.gotoAndStop("on");
                                                                                                } // end else if
                                                                                                com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                                                keysPressed[74] = true;
                                                                                            } // end else if
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", 15))
                                                                                            {
                                                                                                com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", 15);
                                                                                                movie.rackmountedMelodyLoops.slider4.gotoAndStop("off");
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                _loc7 = com.clubpenguin.games.beatbox.GameEngine.beatbox.unmuteBeatboxSound("beatbox_sequence", 15);
                                                                                                if (!_loc7)
                                                                                                {
                                                                                                    com.clubpenguin.games.beatbox.GameEngine.debugTrace("sound 15 not ready to be unmuted");
                                                                                                } // end if
                                                                                                movie.rackmountedMelodyLoops.slider4.gotoAndStop("on");
                                                                                            } // end else if
                                                                                            com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                                            keysPressed[85] = true;
                                                                                        } // end else if
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", 14))
                                                                                        {
                                                                                            com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", 14);
                                                                                            movie.rackmountedMelodyLoops.slider3.gotoAndStop("off");
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            _loc7 = com.clubpenguin.games.beatbox.GameEngine.beatbox.unmuteBeatboxSound("beatbox_sequence", 14);
                                                                                            if (!_loc7)
                                                                                            {
                                                                                                com.clubpenguin.games.beatbox.GameEngine.debugTrace("sound 14 not ready to be unmuted");
                                                                                            } // end if
                                                                                            movie.rackmountedMelodyLoops.slider3.gotoAndStop("on");
                                                                                        } // end else if
                                                                                        com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                                        keysPressed[78] = true;
                                                                                    } // end else if
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", 13))
                                                                                    {
                                                                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", 13);
                                                                                        movie.rackmountedMelodyLoops.slider2.gotoAndStop("off");
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        _loc7 = com.clubpenguin.games.beatbox.GameEngine.beatbox.unmuteBeatboxSound("beatbox_sequence", 13);
                                                                                        if (!_loc7)
                                                                                        {
                                                                                            com.clubpenguin.games.beatbox.GameEngine.debugTrace("sound 13 not ready to be unmuted");
                                                                                        } // end if
                                                                                        movie.rackmountedMelodyLoops.slider2.gotoAndStop("on");
                                                                                    } // end else if
                                                                                    com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                                    keysPressed[72] = true;
                                                                                } // end else if
                                                                            }
                                                                            else
                                                                            {
                                                                                if (!com.clubpenguin.games.beatbox.GameEngine.beatbox.isBeatboxMuted("beatbox_sequence", 12))
                                                                                {
                                                                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.muteBeatboxSound("beatbox_sequence", 12);
                                                                                    movie.rackmountedMelodyLoops.slider1.gotoAndStop("off");
                                                                                }
                                                                                else
                                                                                {
                                                                                    _loc7 = com.clubpenguin.games.beatbox.GameEngine.beatbox.unmuteBeatboxSound("beatbox_sequence", 12);
                                                                                    if (!_loc7)
                                                                                    {
                                                                                        com.clubpenguin.games.beatbox.GameEngine.debugTrace("sound 12 not ready to be unmuted");
                                                                                    } // end if
                                                                                    movie.rackmountedMelodyLoops.slider1.gotoAndStop("on");
                                                                                } // end else if
                                                                                com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                                keysPressed[89] = true;
                                                                            } // end else if
                                                                        }
                                                                        else
                                                                        {
                                                                            com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedDrumLoops.squareButton6, 11, com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
                                                                            com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                            keysPressed[66] = true;
                                                                        } // end else if
                                                                    }
                                                                    else
                                                                    {
                                                                        com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedDrumLoops.squareButton5, 10, com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
                                                                        com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                        keysPressed[71] = true;
                                                                    } // end else if
                                                                }
                                                                else
                                                                {
                                                                    com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedDrumLoops.squareButton4, 9, com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
                                                                    com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                    keysPressed[84] = true;
                                                                } // end else if
                                                            }
                                                            else
                                                            {
                                                                com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedDrumLoops.squareButton3, 8, com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
                                                                com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                                keysPressed[86] = true;
                                                            } // end else if
                                                        }
                                                        else
                                                        {
                                                            com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedDrumLoops.squareButton2, 7, com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
                                                            com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                            keysPressed[70] = true;
                                                        } // end else if
                                                    }
                                                    else
                                                    {
                                                        com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedDrumLoops.squareButton1, 6, com.clubpenguin.games.beatbox.GameEngine.DRUM_LOOPS);
                                                        com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                        keysPressed[82] = true;
                                                    } // end else if
                                                }
                                                else
                                                {
                                                    com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedBassLines.roundButton3, 19, com.clubpenguin.games.beatbox.GameEngine.BASSLINE_LOOPS);
                                                    com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                    keysPressed[54] = true;
                                                } // end else if
                                            }
                                            else
                                            {
                                                com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedBassLines.roundButton2, 18, com.clubpenguin.games.beatbox.GameEngine.BASSLINE_LOOPS);
                                                com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                                keysPressed[53] = true;
                                            } // end else if
                                        }
                                        else
                                        {
                                            com.clubpenguin.games.beatbox.GameEngine.instance.buttonRelease(movie.rackmountedBassLines.roundButton1, 17, com.clubpenguin.games.beatbox.GameEngine.BASSLINE_LOOPS);
                                            com.clubpenguin.games.beatbox.GameEngine.instance.refreshAnimatedElements();
                                            keysPressed[52] = true;
                                        } // end else if
                                    }
                                    else
                                    {
                                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRide", "Rackmounted8", 100, 0, 1, true);
                                        movie.button8.gotoAndPlay(2);
                                        keysPressed[83] = true;
                                    } // end else if
                                }
                                else
                                {
                                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectWahAm7Long", "Rackmounted7", 100, 0, 1, false);
                                    movie.button7.gotoAndPlay(2);
                                    keysPressed[87] = true;
                                } // end else if
                            }
                            else
                            {
                                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectWahDm7Long", "Rackmounted6", 100, 0, 1, false);
                                movie.button6.gotoAndPlay(2);
                                keysPressed[50] = true;
                            } // end else if
                        }
                        else
                        {
                            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectJungleBird", "Rackmounted5", 100, 0, 1, true);
                            movie.button5.gotoAndPlay(2);
                            keysPressed[90] = true;
                        } // end else if
                    }
                    else
                    {
                        com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectRideReverse", "Rackmounted4", 100, 0, 1, false);
                        movie.button4.gotoAndPlay(2);
                        keysPressed[65] = true;
                    } // end else if
                }
                else
                {
                    com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectChopAmShort", "Rackmounted3", 100, 0, 1, true);
                    movie.button3.gotoAndPlay(2);
                    keysPressed[81] = true;
                } // end else if
            }
            else
            {
                com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectWahDmShort", "Rackmounted2", 100, 0, 1, true);
                movie.button2.gotoAndPlay(2);
                keysPressed[49] = true;
            } // end else if
        }
        else
        {
            com.clubpenguin.games.beatbox.GameEngine.beatbox.playSound("effectChopDmShort", "Rackmounted1", 100, 0, 1, true);
            movie.button1.gotoAndPlay(2);
            keysPressed[192] = true;
        } // end else if
    } // End of the function
} // End of Class
