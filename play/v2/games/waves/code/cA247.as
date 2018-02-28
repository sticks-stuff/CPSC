function getCoins()
{
    var _loc2 = new Object();
    _loc2.score = coinsCountTotal;
    _loc2.coins = coinsCountTotal;
    _root.showWindow("Game Over", _loc2);
} // End of the function
function resetLevel()
{
    if (waveOver == true)
    {
        gameplay = false;
        removeMovieClip ("player");
        attachMovie("cutsceneendwave", "cutscene", 105);
        cutscene._x = 380;
        cutscene._y = 240;
        waveOver = false;
        lives = lives + 1;
        cutscenePlaced = true;
        cutscene.stylePoints_tf.text = stylePointsCount.toString();
        cutscene.board.gotoAndStop(boardupgrade + 1);
        var _loc5 = 0;
        var _loc3 = 0;
        var _loc4 = 0;
        if (hasPuffle == false)
        {
            cutscene.pufflejumpin.gotoAndStop("gone");
        } // end if
        if (_parent.wave3Complete == true)
        {
            cutscene.judgeone.gotoAndStop(judge7);
            cutscene.judgetwo.gotoAndStop(judge8);
            cutscene.judgethree.gotoAndStop(judge9);
            cutscene.judgeone.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge7 + "score"].toString();
            cutscene.judgetwo.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge8 + "score"].toString();
            cutscene.judgethree.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge9 + "score"].toString();
        }
        else if (_parent.wave2Complete == true)
        {
            cutscene.judgeone.gotoAndStop(judge4);
            cutscene.judgetwo.gotoAndStop(judge5);
            cutscene.judgethree.gotoAndStop(judge6);
            cutscene.judgeone.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge4 + "score"].toString();
            cutscene.judgetwo.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge5 + "score"].toString();
            cutscene.judgethree.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge6 + "score"].toString();
        }
        else if (wave1Complete == true)
        {
            cutscene.judgeone.gotoAndStop(judge1);
            cutscene.judgetwo.gotoAndStop(judge2);
            cutscene.judgethree.gotoAndStop(judge3);
            cutscene.judgeone.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge1 + "score"].toString();
            cutscene.judgetwo.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge2 + "score"].toString();
            cutscene.judgethree.judge.nameAndScore.scoreBoard.text = this["judgerating" + judge3 + "score"].toString();
        } // end else if
    }
    else if (cutscenePlaced == false)
    {
        cutscenePlaced = true;
        gameplay = false;
        removeMovieClip ("player");
        if (hasPuffle == true)
        {
            attachMovie("cutsceneresetpuffletrue", "cutscene", 105);
        }
        else
        {
            attachMovie("cutsceneresetpufflefalse", "cutscene", 105);
        } // end else if
        cutscene._x = 380;
        cutscene._y = 240;
    }
    else
    {
        removeMovieClip ("cutscene");
        bg.gotoAndStop("normal");
        wave.wave.bulk.gotoAndStop("normal");
        if (lives > 0)
        {
            lives = lives - 1;
        } // end if
        screeninterface.livesRemaining.gotoAndStop(lives + 1);
        screeninterface.livesRemaining.boardRemaining.gotoAndStop("normal");
        gameplay = true;
        ripplei = -1;
        rippleframe = 1;
        waveoffset = 0;
        waveoffsetdirection = "up";
        gravity = 1;
        onwater = false;
        cutscenePlaced = false;
        playerX = 0;
        playercamera = 480;
        playerY = 0;
        puffleX = 12;
        puffleY = 0;
        falling = false;
        flipspeed = 0;
        flipdegree = 0;
        flipslanded = 0;
        flipsmade = 0;
        spinspeed = 0;
        spinsInCurrentJump = 0;
        playerspeed = 0;
        backfliptest = 0;
        frontfliptest = 0;
        frontspintest = 1;
        backspintest = 1;
        mouseisdown = false;
        wipeout = false;
        balance = 100;
        balancecount = 2;
        doingtrick = false;
        doingAdvancedTrick = false;
        trickType = "none";
        lastTrick = "none";
        jumped = true;
        flippoints = 0;
        stabilizing = false;
        puffleJumped = true;
        baseoffset = 0;
        risklevel = 0;
        grinding = false;
        didgrind = false;
        grindpoints = 0;
        holdpoints = 0;
        waveXlimit = -2000;
        waveending = false;
        pointsPopupCount = 0;
        delete sharkBite;
        if (playstyle == "freestyle")
        {
            if (challenge1Complete == true)
            {
                challengecount = 900;
            } // end if
        }
        else if (playstyle == "competition")
        {
            if (challenge1Complete == false)
            {
                if (challengecount > 1000)
                {
                    challengecount = 1000;
                }
                else
                {
                    challengecount = 0;
                } // end else if
            }
            else if (challenge1Complete == true && wave1Complete == false)
            {
                if (challengecount > 900)
                {
                    challengecount = 900;
                }
                else
                {
                    challengecount = 0;
                } // end else if
            }
            else if (challenge2Complete == false && wave1Complete == true)
            {
                if (challengecount > 1400)
                {
                    challengecount = 1400;
                }
                else
                {
                    challengecount = 0;
                } // end else if
            }
            else if (challenge2Complete == true && wave2Complete == false)
            {
                if (challengecount > 900)
                {
                    challengecount = 900;
                }
                else
                {
                    challengecount = 0;
                } // end else if
            }
            else if (challenge3Complete == false && wave2Complete == true)
            {
                if (challengecount > 1400)
                {
                    challengecount = 1400;
                }
                else
                {
                    challengecount = 0;
                } // end else if
            }
            else if (challenge3Complete == true && wave3Complete == false)
            {
                if (challengecount > 900)
                {
                    challengecount = 900;
                }
                else
                {
                    challengecount = 0;
                } // end else if
            } // end else if
        }
        else if (playstyle == "survival")
        {
            playercamera = "freeroam";
            playerswake.ripples._y = 0;
            debris = false;
            debris2 = false;
            if (challenge3Complete == true)
            {
                challengecount = 10000;
            }
            else if (challenge2Complete == true)
            {
                if (challengecount > 8300)
                {
                    challengecount = 8301;
                } // end if
                if (challengecount > 6999)
                {
                    challengecount = 7000;
                }
                else
                {
                    challengecount = 5900;
                } // end else if
            }
            else if (challenge1Complete == true)
            {
                if (challengecount > 4500)
                {
                    challengecount = 4501;
                }
                else if (challengecount > 3100)
                {
                    challengecount = 3101;
                    debris = true;
                    debrisWarning = false;
                }
                else
                {
                    challengecount = 2100;
                } // end else if
            }
            else if (challengecount > 1000)
            {
                challengecount = 1001;
            }
            else
            {
                challengecount = 0;
            } // end else if
        } // end else if
        if (sharkattack == true)
        {
            shark._x = -3000;
            shark._y = map.water._y + 500;
            shark.gotoAndStop("gone");
        } // end if
        attachMovie("player", "player", 100);
        lean = "forward";
        player._x = 480;
        player._y = 0;
        player._rotation = 0;
        puffle._x = player._x + 100;
        puffle._y = player._y - 300;
        puffle.gotoAndStop("air");
        map.water._x = 380;
        map.water._y = 240;
        map.water.gotoAndStop("wave");
        wavecurl._x = wave._x + 1510;
        wavecurl._y = map.water._y - map._y;
        watersurface._x = 380;
        watersurface2._x = 380;
        watersurface3._x = 380;
        watersurface4._x = 380;
        watersurface._y = map.water._y + 502;
        watersurface2._y = map.water._y + 502;
        watersurface3._y = map.water._y + 502;
        watersurface4._y = map.water._y + 502;
        watersurface.gotoAndStop("normal");
        watersurface.watertop.gotoAndStop("show");
        watersurface._yscale = 100;
        wave._x = -1400;
        wave._y = 240;
        wavespeed = defaultwavespeed;
        lastplayerY = player._y;
        cutscenePlaced = false;
    } // end else if
} // End of the function
function endtheGame()
{
    gameplay = false;
    removeMovieClip ("player");
    removeMovieClip ("shark");
    removeMovieClip ("puffle");
    map.gotoAndStop("gone");
    watersurface.gotoAndStop("gone");
    watersurface2.gotoAndStop("gone");
    watersurface3.gotoAndStop("gone");
    watersurface4.gotoAndStop("gone");
    playerswake._y = playerswake._y + 9000;
    removeMovieClip ("wave");
    removeMovieClip ("screeninterface");
    removeMovieClip ("cutscene");
    if (playstyle == "freestyle")
    {
        if (hasPuffle == true)
        {
            cutscenepuffle.gotoAndStop("show");
        } // end if
        prizeBonusCount = 0;
        trace ("stylePointsCount = " + stylePointsCount);
        coinsCountEarned = Math.round(Number(stylePointsCount) / 10);
        coinsCountTotal = coinsCountEarned + prizeBonusCount;
        gotoAndStop("endnormal");
    }
    else if (playstyle == "survival")
    {
        prizeBonusCount = Math.round(distancetravelled / 100);
        prizeBonusCount = prizeBonusCount * 200;
        prizeBonusCount = Math.round(prizeBonusCount / 10);
        coinsCountEarned = Math.round(stylePointsCount / 10);
        coinsCountTotal = coinsCountEarned + prizeBonusCount;
        if (wave4Complete == true)
        {
            coinsCountTotal = coinsCountTotal + 500;
        } // end if
        if (wave4Complete == true)
        {
            detectAchievement(114);
            gotoAndStop("endsurvivalgood");
        }
        else
        {
            gotoAndStop("endsurvivalbad");
        } // end else if
        if (hasPuffle == true)
        {
            cutscenepuffle.gotoAndStop("showendscreen");
        } // end if
    }
    else if (playstyle == "competition")
    {
        var _loc1 = judgeScoreCount / 9;
        if (_loc1 > 9)
        {
            prizeBonusCount = 500;
            detectAchievement(108);
            gotoAndStop("endcompetitionfirst");
            if (hasPuffle == true)
            {
                detectAchievement(100);
                endscreen.gotoAndStop("haspuffle");
            }
            else
            {
                endscreen.gotoAndStop("nopuffle");
            } // end else if
        }
        else if (_loc1 > 7)
        {
            prizeBonusCount = 300;
            gotoAndStop("endcompetitionsecond");
            if (hasPuffle == true)
            {
                detectAchievement(100);
                endscreen.gotoAndStop("haspuffle");
            }
            else
            {
                endscreen.gotoAndStop("nopuffle");
            } // end else if
        }
        else if (_loc1 > 5)
        {
            prizeBonusCount = 100;
            gotoAndStop("endcompetitionthird");
            if (hasPuffle == true)
            {
                detectAchievement(100);
                endscreen.gotoAndStop("haspuffle");
            }
            else
            {
                endscreen.gotoAndStop("nopuffle");
            } // end else if
        }
        else
        {
            prizeBonusCount = 0;
            trace ("stylePointsCount = " + stylePointsCount);
            coinsCountEarned = Math.round(stylePointsCount / 10);
            coinsCountTotal = coinsCountEarned + prizeBonusCount;
            if (hasPuffle == true)
            {
                cutscenepuffle.gotoAndStop("show");
            } // end if
            gotoAndStop("endnormal");
        } // end else if
        coinsCountEarned = Math.round(stylePointsCount / 10);
        coinsCountTotal = coinsCountEarned + prizeBonusCount;
    } // end else if
} // End of the function
function puffleTrick()
{
    if (puffleY < -10)
    {
        puffle.gotoAndStop(Math.round(random(7) + 2));
    }
    else
    {
        puffle.gotoAndStop("air");
    } // end else if
} // End of the function
function challenge0()
{
    if (this.seeSharkDone == false)
    {
        this.seeSharkDone = true;
        detectAchievement(113);
    } // end if
    wave._x = wave._x - 6;
    shark._y = map.water._y + 400;
    if (wipeout == true)
    {
        shark._x = shark._x + (100 - playerX);
    } // end if
    if (sharkcount < 1)
    {
        if (shark._x < -100)
        {
            shark._x = -100;
        } // end if
        shark._x = shark._x + wavespeed;
        shark.gotoAndStop("normal");
        if (shark._x < player._x)
        {
            shark._x = shark._x + sharkspeed;
            sharkspeed = sharkspeed + 1.000000E-002;
        }
        else if (shark._x >= player._x)
        {
            sharkcount = sharkcount + 1;
        } // end else if
    }
    else if (sharkcount < 2)
    {
        shark.gotoAndStop("bite");
        shark._x = shark._x + wavespeed / 2;
        if (shark._x < player._x - 1600)
        {
            sharkattack = false;
            shark.gotoAndStop("gone");
            removeMovieClip ("shark");
            sharkattack = false;
            delete sharkcount;
        } // end if
        if (sharkenergy < 1)
        {
            sharkattack = false;
            shark.gotoAndStop("gone");
            removeMovieClip ("shark");
            sharkattack = false;
            delete sharkcount;
        } // end if
    } // end else if
    if (shark.shark.shark.hitTest(player._x, player._y, true))
    {
        falling = true;
        player._rotation = 0;
        balance = 80;
        if (onwater == true)
        {
            sharkBite = true;
        } // end if
    } // end if
} // End of the function
function waveends()
{
    if (challengecount < 1000)
    {
        challengecount = challengecount + 1;
    }
    else
    {
        waveending = true;
    } // end else if
    if (waveOver == false && wipeout == false && waveending == true && gameplay == true)
    {
        map.water._y = map.water._y + 2;
        map.wave._y = map.wave._y + 2;
        wavespeed = wavespeed - 1;
        baseoffset = baseoffset - 2;
        waveXlimit = -8000;
        map.water.gotoAndStop("waveend");
        if (grinding == true)
        {
            player._y = player._y + 2;
        }
        else if (onwater == true)
        {
            player._y = player._y + 2;
        } // end else if
        if (watersurface._yscale < 50)
        {
            watersurface.gotoAndStop("end");
            watersurface._x = watersurface._x + playerX;
        } // end if
        if (watersurface._yscale > 40)
        {
            watersurface._yscale = watersurface._yscale - 4.000000E-001;
        }
        else if (gameplay == true)
        {
            waveOver = true;
            if (playstyle == "freestyle")
            {
                if (challenge1Complete == true)
                {
                    wave1Complete = true;
                } // end if
                if (wave1Complete == true)
                {
                    endtheGame();
                }
                else
                {
                    resetLevel();
                } // end else if
            }
            else if (playstyle == "survival")
            {
                if (challenge4Complete == true)
                {
                    wave4Complete = true;
                }
                else if (challenge3Complete == true)
                {
                    wave3Complete = true;
                }
                else if (challenge2Complete == true)
                {
                    wave2Complete = true;
                }
                else if (challenge1Complete == true)
                {
                    wave1Complete = true;
                } // end else if
                if (wave4Complete == true)
                {
                    endtheGame();
                }
                else
                {
                    resetLevel();
                } // end else if
            }
            else if (playstyle == "competition")
            {
                if (challenge3Complete == true)
                {
                    wave3Complete = true;
                }
                else if (challenge2Complete == true)
                {
                    wave2Complete = true;
                }
                else if (challenge1Complete == true)
                {
                    wave1Complete = true;
                } // end else if
                resetLevel();
            } // end else if
        } // end else if
    } // end else if
} // End of the function
function determineChallengesurvival()
{
    if (wave4Complete == false && challenge4Complete == true)
    {
        if (wipeout == false)
        {
            waveends();
        } // end if
    }
    else if (challenge4Complete == false && challenge3Complete == true)
    {
        if (sharkattack == true)
        {
            challenge0();
        }
        else if (wipeout == false)
        {
            challenge4survival();
        } // end else if
    }
    else if (challenge3Complete == false && challenge2Complete == true && wipeout == false)
    {
        challenge3survival();
    }
    else if (challenge2Complete == false && challenge1Complete == true && wipeout == false)
    {
        challenge2survival();
    }
    else if (challenge1Complete == false && wipeout == false)
    {
        challenge1survival();
    } // end else if
    if (distancetravelled < challengecount)
    {
        distancetravelled = challengecount;
    } // end if
} // End of the function
function determineChallengecompetition()
{
    if (wave3Complete == true)
    {
        if (wipeout == false)
        {
            waveends();
        } // end if
    }
    else if (wave3Complete == false && challenge3Complete == true && wipeout == false)
    {
        waveends();
    }
    else if (challenge3Complete == false && wave2Complete == true && wipeout == false)
    {
        challenge3competition();
    }
    else if (wave2Complete == false && challenge2Complete == true && wipeout == false)
    {
        waveends();
    }
    else if (challenge2Complete == false && wave1Complete == true && wipeout == false)
    {
        challenge2competition();
    }
    else if (wave1Complete == false && challenge1Complete == true && wipeout == false)
    {
        waveends();
    }
    else if (challenge1Complete == false && wipeout == false)
    {
        challenge1competition();
    } // end else if
} // End of the function
function determineChallengefreestyle()
{
    if (wave1Complete == false && challenge1Complete == true && wipeout == false)
    {
        screeninterface.tips._visible = false;
        screeninterface.speedhelper._visible = false;
        screeninterface.gouparrow._visible = false;
        waveends();
    }
    else if (challenge1Complete == false && wipeout == false)
    {
        challenge1freestyle();
    } // end else if
} // End of the function
function challenge1survival()
{
    if (challengecount < 34)
    {
        wavespeed = 4 + boardupgrade;
        challengecount = challengecount + 1;
        debris = false;
        debris2 = false;
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 36)
    {
        wavespeed = 4 + boardupgrade;
        challengecount = challengecount + 1;
        playercamera = 200;
    }
    else if (challengecount < 200)
    {
        wavespeed = 4 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 201)
    {
        wavespeed = 4 + boardupgrade;
        challengecount = challengecount + 1;
        debris = true;
        debrisWarning = true;
    }
    else if (challengecount < 300)
    {
        wavespeed = 6 + boardupgrade;
        challengecountgoal = 2100;
    }
    else if (challengecount < 1000)
    {
        wavespeed = 7 + boardupgrade;
    }
    else if (challengecount < 1001)
    {
        wavespeed = 7 + boardupgrade;
        debris = false;
    }
    else if (challengecount < 1100)
    {
        debris = false;
        wavespeed = 6 + boardupgrade;
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 1200)
    {
        wavespeed = 8 + boardupgrade;
    }
    else if (challengecount < 2040)
    {
        wavespeed = 9 + boardupgrade;
    }
    else if (challengecount < 2080)
    {
        wavespeed = 7 + boardupgrade;
    }
    else if (challengecount < 2100)
    {
        wavespeed = 6 + boardupgrade;
    }
    else
    {
        defaultwavespeed = 5 + boardupgrade;
        wavespeed = defaultwavespeed;
        challenge1Complete = true;
    } // end else if
    if (shootingthetube == true)
    {
        wavespeed = wavespeed - 1;
    } // end if
} // End of the function
function challenge2survival()
{
    if (challengecount < 2164)
    {
        wavespeed = 5 + boardupgrade;
        challengecount = challengecount + 1;
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 2165)
    {
        wavespeed = 5 + boardupgrade;
        challengecount = challengecount + 1;
        playercamera = 200;
    }
    else if (challengecount < 2300)
    {
        wavespeed = 5 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 2301)
    {
        wavespeed = 5 + boardupgrade;
        challengecount = challengecount + 1;
        debrisWarning = false;
        debris = true;
    }
    else if (challengecount < 3099)
    {
        wavespeed = 5 + boardupgrade;
        challengecountgoal = 3100;
    }
    else if (challengecount < 3100)
    {
        wavespeed = 6 + boardupgrade;
    }
    else if (challengecount < 3200)
    {
        challengecount = challengecount + 1;
        wavespeed = 7 + boardupgrade;
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 3300)
    {
        challengecount = challengecount + 1;
        wavespeed = 8 + boardupgrade;
        debrisWarning = true;
    }
    else if (challengecount < 4300)
    {
        challengecount = challengecount + 1;
        wavespeed = 9 + boardupgrade;
    }
    else if (challengecount < 4400)
    {
        challengecount = challengecount + 1;
        wavespeed = 8 + boardupgrade;
    }
    else if (challengecount < 4500)
    {
        challengecount = challengecount + 1;
        wavespeed = 7 + boardupgrade;
    }
    else if (challengecount < 4501)
    {
        challengecount = challengecount + 1;
        wavespeed = 7 + boardupgrade;
        debris = false;
    }
    else if (challengecount < 4600)
    {
        challengecount = challengecount + 1;
        debris = false;
        wavespeed = 8 + boardupgrade;
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 4700)
    {
        challengecount = challengecount + 1;
        wavespeed = 9 + boardupgrade;
    }
    else if (challengecount < 5700)
    {
        challengecount = challengecount + 1;
        wavespeed = 9 + boardupgrade;
    }
    else if (challengecount < 5800)
    {
        challengecount = challengecount + 1;
        wavespeed = 8 + boardupgrade;
    }
    else if (challengecount < 5900)
    {
        challengecount = challengecount + 1;
        wavespeed = 7 + boardupgrade;
    }
    else
    {
        defaultwavespeed = 7 + boardupgrade;
        wavespeed = defaultwavespeed;
        challenge2Complete = true;
    } // end else if
    if (shootingthetube == true)
    {
        wavespeed = wavespeed - 1;
    } // end if
} // End of the function
function challenge3survival()
{
    if (challengecount < 5964)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 5965)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
        playercamera = 200;
    }
    else if (challengecount < 6100)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 6101)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
        debrisWarning = false;
        debris = true;
    }
    else if (challengecount < 6125)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 6126)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
        debris2 = true;
    }
    else if (challengecount < 6127)
    {
        wavespeed = 8 + boardupgrade;
        challengecountgoal = 7000;
    }
    else if (challengecount < 6400)
    {
        wavespeed = 7 + boardupgrade;
    }
    else if (challengecount < 6900)
    {
        wavespeed = 8 + boardupgrade;
    }
    else if (challengecount < 7000)
    {
        wavespeed = 9 + boardupgrade;
    }
    else if (challengecount < 7001)
    {
        wavespeed = 9 + boardupgrade;
        challengecount = challengecount + 1;
        if (debris == false)
        {
            debris = true;
        } // end if
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 7099)
    {
        wavespeed = 9 + boardupgrade;
        challengecount = challengecount + 1;
        if (debris == false)
        {
            debris = true;
        } // end if
    }
    else if (challengecount < 7100)
    {
        wavespeed = 9 + boardupgrade;
        challengecount = challengecount + 1;
        if (debris2 == false)
        {
            debris2 = true;
        } // end if
    }
    else if (challengecount < 7101)
    {
        challengecountgoal = 8200;
        wavespeed = 8 + boardupgrade;
    }
    else if (challengecount < 7500)
    {
        wavespeed = 8 + boardupgrade;
    }
    else if (challengecount < 7600)
    {
        wavespeed = 8 + boardupgrade;
        debris2 = false;
    }
    else if (challengecount < 7800)
    {
        wavespeed = 9 + boardupgrade;
    }
    else if (challengecount < 8100)
    {
        wavespeed = 9 + boardupgrade;
        debris = false;
    }
    else if (challengecount < 8200)
    {
        wavespeed = 8 + boardupgrade;
    }
    else if (challengecount < 8300)
    {
        challengecount = challengecount + 1;
        wavespeed = 7 + boardupgrade;
    }
    else if (challengecount < 8301)
    {
        challengecount = challengecount + 1;
        wavespeed = 7 + boardupgrade;
    }
    else if (challengecount < 8400)
    {
        challengecount = challengecount + 1;
        wavespeed = 7 + boardupgrade;
        bg.gotoAndStop("icestorm");
        map.water.gotoAndStop("waveicestorm");
        watersurface.watertop.gotoAndStop("icestorm");
        wave.wave.bulk.gotoAndStop("icestorm");
    }
    else if (challengecount < 8500)
    {
        wavespeed = 8 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 8600)
    {
        wavespeed = 9 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 9600)
    {
        wavespeed = 10 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 9700)
    {
        wavespeed = 11 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 9800)
    {
        wavespeed = 9 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 9900)
    {
        wavespeed = 8 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 9999)
    {
        wavespeed = 8 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 10000)
    {
        wavespeed = 4;
        challengecount = challengecount + 1;
        bg.storm.gotoAndPlay("end");
        map.water.gotoAndStop("waveendicestorm");
        watersurface.watertop.gotoAndStop("icestormend");
        wave.wave.bulk.gotoAndStop("icestormend");
    }
    else
    {
        wavespeed = 4;
        defaultwavespeed = 4;
        challenge3Complete = true;
        sharkcount = 0;
    } // end else if
    if (shootingthetube == true)
    {
        wavespeed = wavespeed - 1;
    } // end if
} // End of the function
function challenge4survival()
{
    wavespeed = defaultwavespeed;
    challenge4Complete = true;
    watersurface.watertop.gotoAndStop("show");
} // End of the function
function challenge1freestyle()
{
    if (challengecount < 3000)
    {
        challengecount = challengecount + 1;
    }
    else
    {
        defaultwavespeed = 5 + boardupgrade;
        wavespeed = defaultwavespeed;
        challengecount = 900;
        challenge1Complete = true;
        watersurface.watertop.gotoAndStop("show");
    } // end else if
} // End of the function
function challenge1competition()
{
    if (challengecount < 1000)
    {
        challengecount = challengecount + 1;
    }
    else if (challengecount < 1100)
    {
        challengecount = challengecount + 1;
        bg.gotoAndStop("storm");
    }
    else if (challengecount < 1200)
    {
        wavespeed = 5 + boardupgrade;
        challengecount = challengecount + 1;
        watersurface.watertop.gotoAndStop("angry");
    }
    else if (challengecount < 2200)
    {
        wavespeed = 6 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 2201)
    {
        challengecount = challengecount + 1;
        bg.storm.gotoAndPlay("end");
    }
    else if (challengecount < 2300)
    {
        wavespeed = 5 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else
    {
        defaultwavespeed = 5 + boardupgrade;
        wavespeed = defaultwavespeed;
        challengecount = 0;
        challenge1Complete = true;
        watersurface.watertop.gotoAndStop("show");
    } // end else if
} // End of the function
function challenge2competition()
{
    if (challengecount < 1400)
    {
        challengecount = challengecount + 1;
    }
    else if (challengecount < 1500)
    {
        challengecount = challengecount + 1;
        bg.gotoAndStop("storm");
    }
    else if (challengecount < 1600)
    {
        wavespeed = 5 + boardupgrade;
        challengecount = challengecount + 1;
        watersurface.watertop.gotoAndStop("angry");
    }
    else if (challengecount < 1700)
    {
        wavespeed = 6 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 2700)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 2800)
    {
        wavespeed = 6 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 2801)
    {
        challengecount = challengecount + 1;
        bg.storm.gotoAndPlay("end");
    }
    else if (challengecount < 3300)
    {
        challengecount = challengecount + 1;
    }
    else
    {
        defaultwavespeed = 6 + boardupgrade;
        wavespeed = defaultwavespeed;
        challengecount = 0;
        challenge2Complete = true;
        watersurface.watertop.gotoAndStop("show");
    } // end else if
} // End of the function
function challenge3competition()
{
    if (challengecount < 1400)
    {
        challengecount = challengecount + 1;
    }
    else if (challengecount < 1500)
    {
        challengecount = challengecount + 1;
        bg.gotoAndStop("storm");
    }
    else if (challengecount < 1600)
    {
        wavespeed = 6 + boardupgrade;
        challengecount = challengecount + 1;
        watersurface.watertop.gotoAndStop("angry");
    }
    else if (challengecount < 1700)
    {
        wavespeed = 6 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 1800)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 2800)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 2900)
    {
        wavespeed = 7 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 3000)
    {
        wavespeed = 6 + boardupgrade;
        challengecount = challengecount + 1;
    }
    else if (challengecount < 3001)
    {
        wavespeed = 6 + boardupgrade;
        challengecount = challengecount + 1;
        bg.storm.gotoAndPlay("end");
    }
    else if (challengecount < 3500)
    {
        challengecount = challengecount + 1;
    }
    else
    {
        wavespeed = defaultwavespeed;
        challengecount = 0;
        challenge3Complete = true;
        watersurface.watertop.gotoAndStop("show");
    } // end else if
} // End of the function
function grindingfunction()
{
    playerY = 0;
    playerYmomentum = 0;
    grinding = true;
    flipspeed = 0;
    backfliptest = 1;
    frontfliptest = 1;
    horizontalside = _xmouse - player._x;
    verticalside = -1 * (_ymouse - player._y);
    angle = Math.atan2(verticalside, horizontalside);
    angle = Math.round(angle / 3.141593E+000 * 180);
    angle = -1 * angle;
    if (player._rotation > Math.round(angle))
    {
        player._rotation = player._rotation - (player._rotation - Math.round(angle)) / 6;
    } // end if
    if (player._rotation < Math.round(angle))
    {
        player._rotation = player._rotation + (Math.round(angle) - player._rotation) / 6;
    } // end if
    if (player._rotation >= 80)
    {
        balance = balance - 100;
        wipeout = true;
        player._rotation = 0;
        grinding = false;
    }
    else if (player._rotation <= -80)
    {
        balance = balance - 100;
        wipeout = true;
        player._rotation = 0;
        grinding = false;
    } // end else if
    if (flipdegree < 0)
    {
        flipdegree = flipdegree * -1;
    } // end if
    flipsmade = Math.round(flipdegree / 360);
    if (grindpointcount > 0)
    {
        grindpointcount = grindpointcount - 1;
    }
    else
    {
        grindpoints = grindpoints + 1;
        if (doingtrick == true)
        {
            totaltrickgrindpoints = totaltrickgrindpoints + 1;
        } // end if
        if (doingAdvancedTrick == true)
        {
            lowestgpc = 0;
            grindpoints = grindpoints + 1;
        }
        else if (doingtrick == true)
        {
            lowestgpc = 1;
        }
        else
        {
            lowestgpc = 2;
        } // end else if
        if (defaultgrindpointcount > lowestgpc)
        {
            defaultgrindpointcount = defaultgrindpointcount - 1;
        }
        else if (defaultgrindpointcount < lowestgpc)
        {
            defaultgrindpointcount = defaultgrindpointcount + 1;
        } // end else if
        grindpointcount = defaultgrindpointcount;
    } // end else if
    for (f = flipsmade; f > 0; f = f - 1)
    {
        if (doingtrick == true)
        {
            flippoints = flippoints + f * 20;
            continue;
        } // end if
        flippoints = flippoints + f * 10;
    } // end of for
    if (grindpoints > 0)
    {
        pointsPopupCount = flippoints + grindpoints + holdpoints;
        playerswake.attachMovie("popuppoints", "popup", 200);
        playerswake.popup.points_mc.points_tf.text = pointsPopupCount.toString();
        playerswake.popup._x = player._x - playerswake._x;
        playerswake.popup._y = player._y - playerswake._y - 100;
        flippoints = 0;
        if (flipsmade > 0)
        {
            if (flipsmade == 1)
            {
                playerswake.popup.flips_mc.flips_tf.text = flipsmade + " FLIP";
            }
            else
            {
                playerswake.popup.flips_mc.flips_tf.text = flipsmade + " FLIPS";
            } // end else if
        }
        else
        {
            playerswake.popup.flips_mc.flips_tf.text = " ";
        } // end if
    } // end else if
} // End of the function
function endgrindingfunction()
{
    playerswake.popup.gotoAndStop(1);
    playerY = -10;
    grinding = false;
    didgrind = true;
    if (mostgrindpoints < grindpoints)
    {
        mostgrindpoints = grindpoints;
    } // end if
    if (gameplay == false)
    {
        pointsPopupCount = 0;
    } // end if
    grindpointcount = 1;
    defaultgrindpointcount = 1;
} // End of the function
function intheairfunction()
{
    onwater = false;
    grinding = false;
    if (doingtrick == true)
    {
        if (holdpointcount > 0)
        {
            holdpointcount = holdpointcount - 1;
        }
        else
        {
            holdpoints = holdpoints + 1;
            if (doingAdvancedTrick == true)
            {
                if (flipsmade > 0)
                {
                    holdpointcount = 0;
                }
                else
                {
                    holdpointcount = 1;
                } // end else if
            }
            else if (doingtrick == true)
            {
                if (flipsmade > 0)
                {
                    holdpointcount = 1;
                }
                else
                {
                    holdpointcount = 2;
                } // end else if
            }
            else if (flipsmade > 0)
            {
                holdpointcount = 2;
            }
            else
            {
                holdpointcount = 3;
            } // end else if
        } // end else if
    } // end else if
    for (f = flipsmade; f > 0; f = f - 1)
    {
        if (doingtrick == true)
        {
            flippoints = flippoints + f * 20;
            continue;
        } // end if
        flippoints = flippoints + f * 10;
    } // end of for
    if (flippoints + holdpoints + grindpoints > 0)
    {
        pointsPopupCount = flippoints + grindpoints + holdpoints;
        playerswake.attachMovie("popuppoints", "popup", 200);
        if (wipeout == true)
        {
            pointsPopupCount = 0;
        } // end if
        playerswake.popup.points_mc.points_tf.text = pointsPopupCount.toString();
        playerswake.popup._x = player._x - playerswake._x;
        playerswake.popup._y = player._y - playerswake._y - 100;
        flippoints = 0;
        playerswake.popup.flips_mc.flips_tf.text = "";
    } // end if
} // End of the function
function steerpufflefunction()
{
    if (puffle._y < player._y + 50)
    {
        if (puffleY < 4)
        {
            puffleY = puffleY + (player._y - puffle._y) / 100;
        }
        else if (puffleY > 4)
        {
            puffleY = 4;
        } // end else if
    }
    else if (puffle._y > player._y + 50)
    {
        if (puffleY > -40)
        {
            puffleY = puffleY - (puffle._y - player._y) / 100;
        }
        else if (puffleY < -40)
        {
            puffleY = -40;
        } // end else if
    } // end else if
    if (puffle._x < player._x - 100)
    {
        if (puffle._x < 170)
        {
            if (puffleX < 30)
            {
                puffleX = puffleX + (player._x - (puffle._x + 100)) / 100;
            }
            else if (puffleX > 30)
            {
                puffleX = 30;
            } // end else if
        }
        else if (puffleX < 20)
        {
            puffleX = puffleX + (player._x - (puffle._x + 100)) / 100;
        } // end else if
    }
    else if (puffle._x > player._x - 100)
    {
        if (puffleX > -20)
        {
            puffleX = puffleX - (puffle._x + 100 - player._x) / 100;
        } // end if
    } // end else if
    puffleJumped = false;
} // End of the function
function swappuffle()
{
    puffle.swapDepths(puffleswap);
} // End of the function
function mousecontrolling()
{
    if (player._y > _ymouse && player._x > _xmouse && grinding == false)
    {
        playerXmomentum = (_ymouse - player._y + (_xmouse - player._x)) / 200 + boardupgrade * 2;
    } // end if
    if (player._y < _ymouse && grinding == false)
    {
        playerYmomentum = (_ymouse - player._y) / 100 + boardupgrade;
        playerXmomentum = (_ymouse - player._y + (_xmouse - player._x)) / 200 + boardupgrade * 2;
    }
    else if (player._y > _ymouse && grinding == false)
    {
        playerYmomentum = -(player._y - _ymouse) / 100 - boardupgrade * 2;
    } // end else if
    if (player._x < _xmouse)
    {
        lean = "forward";
    }
    else if (player._x > _xmouse)
    {
        lean = "back";
    } // end else if
} // End of the function
function tricksfunction()
{
    if (trickwait > 0)
    {
        trickwait = trickwait - 1;
    } // end if
    if (Key.isDown(87) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "wavestart";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(87) && trickType == "wave")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "wave";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(87) && trickType == "handstandend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "starthandstandWavestand";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(87) && trickType == "handstandjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavestandjump";
                lastTrick = "handstandend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(87) && trickType == "danceend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startdanceWavedance";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(87) && trickType == "dancejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavedancejump";
                lastTrick = "danceend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(87) && trickType == "sitend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startsitSitwave";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(87) && trickType == "sitjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitwavejump";
                lastTrick = "sitend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "wavestart";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "wave")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "wave";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "handstandend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "starthandstandWavestand";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "handstandjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavestandjump";
                lastTrick = "handstandend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "danceend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startdanceWavedance";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "dancejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavedancejump";
                lastTrick = "danceend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "sitend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startsitSitwave";
            }
            else
            {
                trickType = "wavejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(38) && trickType == "sitjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitwavejump";
                lastTrick = "sitend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "sitstart";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "sit")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "sit";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "handstandend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "starthandstandSitstand";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "handstandjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitstandjump";
                lastTrick = "handstandend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "danceend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startdanceBreakdance";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "dancejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "breakdancejump";
                lastTrick = "danceend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "waveend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startwaveSitwave";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(83) && trickType == "wavejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitwavejump";
                lastTrick = "waveend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "sitstart";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "sit")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "sit";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "handstandend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "starthandstandSitstand";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "handstandjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitstandjump";
                lastTrick = "handstandend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "danceend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startdanceBreakdance";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "dancejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "breakdancejump";
                lastTrick = "danceend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "waveend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startwaveSitwave";
            }
            else
            {
                trickType = "sitjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(40) && trickType == "wavejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitwavejump";
                lastTrick = "waveend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "handstandstart";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "handstand")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "handstand";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "waveend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startwaveWavestand";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "wavejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavestandjump";
                lastTrick = "waveend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "sitend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startsitSitstand";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "sitjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitstandjump";
                lastTrick = "sitend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "danceend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startdanceHanddance";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(65) && trickType == "dancejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "handdancejump";
                lastTrick = "danceend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "handstandstart";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "handstand")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "handstand";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "waveend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startwaveWavestand";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "wavejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavestandjump";
                lastTrick = "waveend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "sitend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startsitSitstand";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "sitjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "sitstandjump";
                lastTrick = "sitend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "danceend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startdanceHanddance";
            }
            else
            {
                trickType = "handstandjump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(37) && trickType == "dancejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "handdancejump";
                lastTrick = "danceend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "dancestart";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "dance")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "dance";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "waveend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startwaveWavedance";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "wavejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavedancejump";
                lastTrick = "waveend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "sitend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startsitBreakdance";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "sitjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "breakdancejump";
                lastTrick = "sitend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "handstandend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "starthandstandHanddance";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(68) && trickType == "handstandjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "handdancejump";
                lastTrick = "handstandend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "none")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "dancestart";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "dance")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == true)
            {
                trickType = "dance";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "waveend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startwaveWavedance";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "wavejumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "wavedancejump";
                lastTrick = "waveend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "sitend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "startsitBreakdance";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "sitjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "breakdancejump";
                lastTrick = "sitend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "handstandend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            doingAdvancedTrick = true;
            if (onwater == true)
            {
                trickType = "starthandstandHanddance";
            }
            else
            {
                trickType = "dancejump";
            } // end else if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (Key.isDown(39) && trickType == "handstandjumpend")
    {
        if (balance == 100)
        {
            doingtrick = true;
            if (onwater == false)
            {
                trickType = "handdancejump";
                lastTrick = "handstandend";
            } // end if
        }
        else
        {
            balance = balance - 100;
        } // end else if
    }
    else if (trickType != "none" && trickType != "waveend" && trickType != "sitend" && trickType != "handstandend" && trickType != "danceend" && trickType != "wavestart" && trickType != "sitstart" && trickType != "handstandstart" && trickType != "dancestart" && trickType != "danceBreakdance" && trickType != "danceHanddance" && trickType != "danceWavedance" && trickType != "handstandHanddance" && trickType != "handstandSitstand" && trickType != "handstandWavestand" && trickType != "sitBreakdance" && trickType != "sitSitstand" && trickType != "sitSitwave" && trickType != "waveSitwave" && trickType != "waveWavedance" && trickType != "waveWavestand" && trickType != "wavejump" && trickType != "sitjumpend" && trickType != "handstandjump" && trickType != "dancejump" && trickType != "wavestandjump" && trickType != "wavedancejump" && trickType != "handdancejump" && trickType != "sitstandjump" && trickType != "breakdancejump" && trickType != "sitwavejump" && doingtrick == true && onwater == true)
    {
        trickType = trickType + "end";
    } // end else if
} // End of the function
function calculatefriction()
{
    if (puffleY > 20)
    {
        puffleY = puffleY * 9.000000E-001;
    }
    else if (puffleY > 0)
    {
        puffleY = puffleY - 5.000000E-001;
    }
    else if (puffleY < 0)
    {
        puffleY = puffleY + 5.000000E-001;
    } // end else if
    if (playerY > 30)
    {
        playerY = playerY * 9.000000E-001;
    }
    else if (playerY > 0)
    {
        playerY = playerY - 5.000000E-001;
    }
    else if (playerY < 0)
    {
        playerY = playerY + 5.000000E-001;
    } // end else if
    if (playerX > 40)
    {
        playerX = playerX * 9.000000E-001;
    }
    else if (playerX > 0)
    {
        playerX = playerX - 5.000000E-001;
    }
    else if (playerX < -40)
    {
        playerX = playerX * 9.000000E-001;
    }
    else if (playerX < 0)
    {
        playerX = playerX + 5.000000E-001;
    } // end else if
    if (playerY < -52)
    {
        playerY = -52;
    } // end if
    if (playerX > 52)
    {
        playerX = 52;
    } // end if
} // End of the function
function calculateplayerspeed()
{
    if (playerX > 0)
    {
        speedX = playerX;
    }
    else if (playerX < 0)
    {
        speedX = playerX * -1;
    } // end else if
    if (playerY > 0)
    {
        speedY = playerY;
    }
    else if (playerY < 0)
    {
        speedY = playerY * -1;
    } // end else if
    playerspeed = (speedX + speedY) / 2;
} // End of the function
function playermovingright()
{
    puffle._x = puffle._x - playerX / 2;
    playerswake.ripples._x = playerswake.ripples._x - playerX;
    watersurface._x = watersurface._x - playerX;
    watersurface2._x = watersurface2._x - playerX * 1.500000E+000;
    watersurface3._x = watersurface3._x - playerX * 2;
    watersurface4._x = watersurface4._x - playerX * 3;
} // End of the function
function playermovingleft()
{
    puffle._x = puffle._x - playerX / 2;
    playerswake.ripples._x = playerswake.ripples._x - playerX;
    watersurface._x = watersurface._x - playerX;
    watersurface2._x = watersurface2._x - playerX * 1.500000E+000;
    watersurface3._x = watersurface3._x - playerX * 2;
    watersurface4._x = watersurface4._x - playerX * 3;
} // End of the function
function playermovingdown()
{
    puffle._y = puffle._y - playerY;
    playerswake.ripples._y = playerswake.ripples._y - playerY;
    watersurface._y = watersurface._y - playerY;
    watersurface2._y = watersurface2._y - playerY;
    watersurface3._y = watersurface3._y - playerY;
    watersurface4._y = watersurface4._y - playerY;
    map.water._y = map.water._y - playerY;
    hazard._y = hazard._y - playerY;
    hazard2._y = hazard2._y - playerY;
    playerswake.popup._y = playerswake.popup._y - playerY;
    playerswake.popuppuffle._y = playerswake.popuppuffle._y - playerY;
} // End of the function
function playermovingup()
{
    puffle._y = puffle._y - playerY;
    playerswake.ripples._y = playerswake.ripples._y - playerY;
    watersurface._y = watersurface._y - playerY;
    watersurface2._y = watersurface2._y - playerY;
    watersurface3._y = watersurface3._y - playerY;
    watersurface4._y = watersurface4._y - playerY;
    map.water._y = map.water._y - playerY;
    hazard._y = hazard._y - playerY;
    hazard2._y = hazard2._y - playerY;
    playerswake.popup._y = playerswake.popup._y - playerY;
    playerswake.popuppuffle._y = playerswake.popuppuffle._y - playerY;
} // End of the function
function wavesrising()
{
    if (waveoffsetdirection == "up")
    {
        if (waveoffset > -10)
        {
            waveoffset = waveoffset - 5.000000E-001;
            watersurface._y = watersurface._y - 5.000000E-001;
            watersurface2._y = watersurface2._y - 1;
            watersurface3._y = watersurface3._y - 1.500000E+000;
            watersurface4._y = watersurface4._y - 2;
        }
        else
        {
            waveoffsetdirection = "down";
        } // end else if
    }
    else if (waveoffsetdirection == "down")
    {
        if (waveoffset < 0)
        {
            waveoffset = waveoffset + 5.000000E-001;
            watersurface._y = watersurface._y + 5.000000E-001;
            watersurface2._y = watersurface2._y + 1;
            watersurface3._y = watersurface3._y + 1.500000E+000;
            watersurface4._y = watersurface4._y + 2;
        }
        else
        {
            waveoffsetdirection = "up";
        } // end else if
    } // end else if
} // End of the function
function loopwatersurface()
{
    if (watersurface._x < -800)
    {
        watersurface._x = watersurface._x + 800;
    }
    else if (watersurface._x > 0)
    {
        watersurface._x = watersurface._x - 800;
    } // end else if
    if (watersurface2._x < -800)
    {
        watersurface2._x = watersurface2._x + 800;
    }
    else if (watersurface2._x > 0)
    {
        watersurface2._x = watersurface2._x - 800;
    } // end else if
    if (watersurface3._x < -800)
    {
        watersurface3._x = watersurface3._x + 800;
    }
    else if (watersurface3._x > 0)
    {
        watersurface3._x = watersurface3._x - 800;
    } // end else if
    if (watersurface4._x < -800)
    {
        watersurface4._x = watersurface4._x + 800;
    }
    else if (watersurface4._x > 0)
    {
        watersurface4._x = watersurface4._x - 800;
    } // end else if
} // End of the function
function pullingahead()
{
    if (playerY > 0 && onwater == true && lastplayerY < player._y)
    {
        wave._x = wave._x - (playerY + (playerX - 20) / 10);
        if (sharkattack == true)
        {
            shark._x = shark._x - (playerY + (playerX - 20) / 10);
        } // end if
        if (puffleOnwater == true)
        {
            puffleX = puffleX - (playerY + (playerX - 20) / 8) / 20;
        } // end if
    }
    else
    {
        wave._x = wave._x - (playerX - 20) / 10;
    } // end else if
} // End of the function
function keepcharactersonscreen()
{
    if (player._x > 760)
    {
        player._x = 759;
    }
    else if (player._x < 0)
    {
        player._x = 1;
    } // end else if
    if (player._y > 480)
    {
        player._y = 479;
    }
    else if (player._y < 0)
    {
        player._y = 1;
    } // end else if
    if (puffle._x > 860)
    {
        puffle._x = 859;
    }
    else if (puffle._x < -100)
    {
        puffle._x = -99;
    } // end else if
    if (puffle._y > 680)
    {
        puffle._y = 679;
    }
    else if (puffe._y < -100)
    {
        puffle._y = -99;
    } // end else if
} // End of the function
function playerperspective()
{
    player._xscale = (player._y - map.water._y + 200 - baseoffset) / 4;
    if (player._xscale < 100)
    {
        player._xscale = 100;
    }
    else if (player._xscale > 200)
    {
        player._xscale = 200;
    } // end else if
    player._yscale = (player._y - map.water._y + 200 - baseoffset) / 4;
    if (player._yscale < 100)
    {
        player._yscale = 100;
    }
    else if (player._yscale > 200)
    {
        player._yscale = 200;
    } // end else if
} // End of the function
function puffleperspective()
{
    puffle._xscale = (puffle._y - map.water._y + 200 - baseoffset) / 4;
    if (puffle._xscale < 100)
    {
        puffle._xscale = 100;
    }
    else if (puffle._xscale > 200)
    {
        puffle._xscale = 200;
    } // end else if
    puffle._yscale = (puffle._y - map.water._y + 200 - baseoffset) / 4;
    if (puffle._yscale < 100)
    {
        puffle._yscale = 100;
    }
    else if (puffle._yscale > 200)
    {
        puffle._yscale = 200;
    } // end else if
} // End of the function
function placeripplefunction()
{
    steamSound.start(0, 1);
    playerswake.ripples.attachMovie("ripple", "ripple" + ripplei, ripplei);
    this.playerswake.ripples["ripple" + ripplei]._x = -playerswake.ripples._x + player._x;
    this.playerswake.ripples["ripple" + ripplei]._y = -playerswake.ripples._y + player._y;
    this.playerswake.ripples["ripple" + ripplei].ripple.waketop.gotoAndPlay(rippleframe * 2);
    this.playerswake.ripples["ripple" + ripplei].ripple.wakebottom.gotoAndPlay(rippleframe * 2);
    if (rippleframe < 6)
    {
        rippleframe = rippleframe + 2;
    }
    else
    {
        rippleframe = 1;
    } // end else if
    if (this.playerswake.ripples["ripple" + (ripplei + 1)]._x == 0)
    {
        this.playerswake.ripples["ripple" + ripplei].gotoAndStop("gone");
    }
    else if (playerspeed < 3)
    {
        this.playerswake.ripples["ripple" + ripplei].gotoAndStop("gone");
    } // end else if
    this.playerswake.ripples["ripple" + ripplei]._xscale = playerspeed * 10;
    if (ripplei == -1)
    {
        horizontalside = this.playerswake.ripples["ripple" + ripplei]._x - this.playerswake.ripples["ripple" + (ripplei - 40)]._x;
        verticalside = -1 * (this.playerswake.ripples["ripple" + ripplei]._y - this.playerswake.ripples["ripple" + (ripplei - 40)]._y);
    }
    else
    {
        horizontalside = this.playerswake.ripples["ripple" + ripplei]._x - this.playerswake.ripples["ripple" + (ripplei + 1)]._x;
        verticalside = -1 * (this.playerswake.ripples["ripple" + ripplei]._y - this.playerswake.ripples["ripple" + (ripplei + 1)]._y);
    } // end else if
    angle = Math.atan2(verticalside, horizontalside);
    angle = Math.round(angle / 3.141593E+000 * 180);
    this.playerswake.ripples["ripple" + ripplei]._rotation = -1 * angle;
    if (ripplei < -40)
    {
        ripplei = -1;
    }
    else
    {
        ripplei = ripplei - 1;
    } // end else if
} // End of the function
function detectbackflipgesture()
{
    if (backfliptest == 1 && falling == false && grinding == false && didgrind == false)
    {
        recordmouseX = _xmouse;
        recordmouseY = _ymouse;
        backfliptest = 2;
    }
    else if (backfliptest == 2)
    {
        if (_xmouse < recordmouseX - 1 && _ymouse > recordmouseY + 1)
        {
            recordmouseX = _xmouse;
            recordmouseY = _ymouse;
            backfliptest = 3;
            flipspeed = flipspeed - 2;
        }
        else
        {
            backfliptest = 1;
        } // end else if
    }
    else if (backfliptest == 3)
    {
        if (_xmouse > recordmouseX + 1 && _ymouse > recordmouseY + 1)
        {
            recordmouseX = _xmouse;
            recordmouseY = _ymouse;
            backfliptest = 4;
            flipspeed = flipspeed - 2;
        } // end if
    }
    else if (backfliptest == 4)
    {
        if (_xmouse > recordmouseX + 1 && _ymouse < recordmouseY - 1)
        {
            recordmouseX = _xmouse;
            recordmouseY = _ymouse;
            backfliptest = 5;
            flipspeed = flipspeed - 2;
        } // end if
    }
    else if (backfliptest == 5)
    {
        if (_xmouse < recordmouseX - 1 && _ymouse < recordmouseY - 1)
        {
            recordmouseX = _xmouse;
            recordmouseY = _ymouse;
            backfliptest = 2;
            flipspeed = flipspeed - 4;
            frontfliptest = 0;
        } // end else if
    } // end else if
} // End of the function
function detectfrontflipgesture()
{
    if (frontfliptest == 1 && falling == false && grinding == false && didgrind == false)
    {
        recordmouseXF = _xmouse;
        recordmouseYF = _ymouse;
        frontfliptest = 2;
    }
    else if (frontfliptest == 2)
    {
        if (_xmouse > recordmouseXF + 1 && _ymouse > recordmouseYF + 1)
        {
            recordmouseXF = _xmouse;
            recordmouseYF = _ymouse;
            frontfliptest = 3;
            flipspeed = flipspeed + (2 + boardupgrade * 2);
        }
        else
        {
            frontfliptest = 1;
        } // end else if
    }
    else if (frontfliptest == 3)
    {
        if (_xmouse < recordmouseXF - 1 && _ymouse > recordmouseYF + 1)
        {
            recordmouseXF = _xmouse;
            recordmouseYF = _ymouse;
            frontfliptest = 4;
            flipspeed = flipspeed + (2 + boardupgrade * 2);
        } // end if
    }
    else if (frontfliptest == 4)
    {
        if (_xmouse < recordmouseXF - 1 && _ymouse < recordmouseYF - 1)
        {
            recordmouseXF = _xmouse;
            recordmouseYF = _ymouse;
            frontfliptest = 5;
            flipspeed = flipspeed + (2 + boardupgrade * 2);
        } // end if
    }
    else if (frontfliptest == 5)
    {
        if (_xmouse > recordmouseXF + 1 && _ymouse < recordmouseYF - 1)
        {
            recordmouseXF = _xmouse;
            recordmouseYF = _ymouse;
            frontfliptest = 2;
            flipspeed = flipspeed + 4;
            backfliptest = 0;
        } // end else if
    } // end else if
} // End of the function
function slowflipspeed()
{
    if (flipspeed > 20)
    {
        flipspeed = flipspeed - 10;
    }
    else if (flipspeed > 10)
    {
        flipspeed = flipspeed - 5;
    }
    else if (flipspeed > 0)
    {
        flipspeed = flipspeed - 1;
    }
    else if (flipspeed < -20)
    {
        flipspeed = flipspeed + 10;
    }
    else if (flipspeed < -10)
    {
        flipspeed = flipspeed + 5;
    }
    else if (flipspeed < 0)
    {
        flipspeed = flipspeed + 1;
    } // end else if
} // End of the function
function steerplayertowardmouse()
{
    horizontalside = _xmouse - player._x;
    verticalside = -1 * (_ymouse - player._y);
    angle = Math.atan2(verticalside, horizontalside);
    angle = Math.round(angle / 3.141593E+000 * 180);
    angle = -1 * angle;
} // End of the function
function stabilizingbackflip()
{
    flipspeed = flipspeed - 1;
    if (player._rotation < -120)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 120;
            flipdegree = flipdegree - 120;
        }
        else
        {
            player._rotation = player._rotation - 40;
            flipdegree = flipdegree - 40;
        } // end else if
    }
    else if (player._rotation < -60)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 60;
            flipdegree = flipdegree - 60;
        }
        else
        {
            player._rotation = player._rotation - 20;
            flipdegree = flipdegree - 20;
        } // end else if
    }
    else if (player._rotation < -30)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 30;
            flipdegree = flipdegree - 30;
        }
        else
        {
            player._rotation = player._rotation - 10;
            flipdegree = flipdegree - 10;
        } // end else if
    }
    else if (player._rotation < -10)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 10;
            flipdegree = flipdegree - 10;
        }
        else
        {
            player._rotation = player._rotation - 4;
            flipdegree = flipdegree - 4;
        } // end else if
    }
    else if (Math.round(player._rotation) < 0)
    {
        flipdegree = flipdegree - Math.round(player._rotation);
        player._rotation = player._rotation - 0;
        flipspeed = 0;
    }
    else if (player._rotation > 120)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 120;
            flipdegree = flipdegree - 120;
        }
        else
        {
            player._rotation = player._rotation - 40;
            flipdegree = flipdegree - 40;
        } // end else if
    }
    else if (player._rotation > 60)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 60;
            flipdegree = flipdegree - 60;
        }
        else
        {
            player._rotation = player._rotation - 20;
            flipdegree = flipdegree - 20;
        } // end else if
    }
    else if (player._rotation > 30)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 30;
            flipdegree = flipdegree - 30;
        }
        else
        {
            player._rotation = player._rotation - 10;
            flipdegree = flipdegree - 10;
        } // end else if
    }
    else if (player._rotation > 10)
    {
        if (flipspeed < -20)
        {
            player._rotation = player._rotation - 10;
            flipdegree = flipdegree - 10;
        }
        else
        {
            player._rotation = player._rotation - 4;
            flipdegree = flipdegree - 4;
        } // end else if
    }
    else if (Math.round(player._rotation) > 0)
    {
        flipdegree = flipdegree - Math.round(player._rotation);
        player._rotation = 0;
        flipspeed = 0;
    } // end else if
} // End of the function
function stabilizingfrontflip()
{
    flipspeed = flipspeed + 1;
    if (player._rotation > 120)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 120;
            flipdegree = flipdegree + 120;
        }
        else
        {
            player._rotation = player._rotation + 40;
            flipdegree = flipdegree + 40;
        } // end else if
    }
    else if (player._rotation > 60)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 60;
            flipdegree = flipdegree + 60;
        }
        else
        {
            player._rotation = player._rotation + 20;
            flipdegree = flipdegree + 20;
        } // end else if
    }
    else if (player._rotation > 30)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 30;
            flipdegree = flipdegree + 30;
        }
        else
        {
            player._rotation = player._rotation + 10;
            flipdegree = flipdegree + 10;
        } // end else if
    }
    else if (player._rotation > 10)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 10;
            flipdegree = flipdegree + 10;
        }
        else
        {
            player._rotation = player._rotation + 4;
            flipdegree = flipdegree + 4;
        } // end else if
    }
    else if (Math.round(player._rotation) > 0)
    {
        flipdegree = flipdegree - Math.round(player._rotation);
        player._rotation = 0;
        flipspeed = 0;
    }
    else if (player._rotation < -120)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 120;
            flipdegree = flipdegree + 120;
        }
        else
        {
            player._rotation = player._rotation + 40;
            flipdegree = flipdegree + 40;
        } // end else if
    }
    else if (player._rotation < -60)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 60;
            flipdegree = flipdegree + 60;
        }
        else
        {
            player._rotation = player._rotation + 20;
            flipdegree = flipdegree + 20;
        } // end else if
    }
    else if (player._rotation < -30)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 30;
            flipdegree = flipdegree + 30;
        }
        else
        {
            player._rotation = player._rotation + 10;
            flipdegree = flipdegree + 10;
        } // end else if
    }
    else if (player._rotation < -10)
    {
        if (flipspeed > 20)
        {
            player._rotation = player._rotation + 10;
            flipdegree = flipdegree + 10;
        }
        else
        {
            player._rotation = player._rotation + 4;
            flipdegree = flipdegree + 4;
        } // end else if
    }
    else if (Math.round(player._rotation) < 0)
    {
        flipdegree = flipdegree - Math.round(player._rotation);
        player._rotation = 0;
        flipspeed = 0;
    } // end else if
} // End of the function
function shootingthetubefunction()
{
    shootingthetube = true;
    if (tubepointcount > 0)
    {
        tubepointcount = tubepointcount - 1;
    }
    else
    {
        risklevel = risklevel + 1;
        tubepoints = tubepoints + 1;
        if (tubepoints > 1000)
        {
            tubepoints = tubepoints + 1;
        } // end if
        if (tubepoints > 2000)
        {
            tubepoints = tubepoints + 1;
        } // end if
        if (tubepoints > 3000)
        {
            tubepoints = tubepoints + 1;
        } // end if
        if (doingAdvancedTrick == true)
        {
            lowesttpc = 0;
        }
        else if (doingtrick == true)
        {
            lowesttpc = 1;
        }
        else
        {
            lowesttpc = 2;
        } // end else if
        if (defaulttubepointcount > lowesttpc)
        {
            defaulttubepointcount = defaulttubepointcount - 1;
        }
        else if (defaulttubepointcount < lowesttpc)
        {
            defaulttubepointcount = defaulttubepointcount + 1;
        } // end else if
        tubepointcount = defaulttubepointcount;
    } // end else if
    if (tubepoints > 0)
    {
        pointsPopupCount = tubepoints;
        playerswake.attachMovie("popuppoints", "popup", 200);
        if (wipeout == true)
        {
            pointsPopupCount = 0;
        } // end if
        playerswake.popup.points_mc.points_tf.text = pointsPopupCount.toString();
        playerswake.popup.flips_mc.flips_tf.text = "";
        playerswake.popup._x = player._x - playerswake._x + 100;
        playerswake.popup._y = player._y - playerswake._y - 20;
    } // end if
} // End of the function
function displaytips()
{
    if (playerhasCompletednothing == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_steer");
        } // end else if
        if (wipeout == false)
        {
            screeninterface.speedhelper.gotoAndStop("still");
            screeninterface.speedhelper._y = map.water._y;
        }
        else
        {
            screeninterface.speedhelper.gotoAndStop("hide");
        } // end else if
        if (screeninterface.speedhelper.hitTest(_xmouse, _ymouse, true) && gameplay == true)
        {
            steeringtest = steeringtest + 1;
        }
        else
        {
            steeringtest = steeringtest + 1.000000E-001;
        } // end else if
        if (steeringtest > 20)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletednothing = true;
            steeringtest = 0;
        } // end if
    }
    else if (playerhasCompletedsteerupdown == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_steer");
        } // end else if
        if (wipeout == false)
        {
            screeninterface.speedhelper.gotoAndStop("show");
            screeninterface.speedhelper._y = map.water._y;
        }
        else
        {
            screeninterface.speedhelper.gotoAndStop("hide");
        } // end else if
        if (playerY > 14 && gameplay == true)
        {
            steeringtest = steeringtest + 1;
        } // end if
        if (playerY < -14 && gameplay == true)
        {
            steeringtest = steeringtest + 1;
        } // end if
        if (steeringtest > 400)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletedsteerupdown = true;
            steeringtest = 0;
        } // end if
    }
    else if (playerhasCompletedleanforwardback == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_lean");
        } // end else if
        if (wipeout == false)
        {
            screeninterface.speedhelper.gotoAndStop("showslow");
            screeninterface.speedhelper._y = map.water._y;
        }
        else
        {
            screeninterface.speedhelper.gotoAndStop("hide");
        } // end else if
        if (playerX > 38 && gameplay == true)
        {
            forwardtest = true;
        } // end if
        if (playerX < 21 && gameplay == true)
        {
            backtest = true;
        } // end if
        if (forwardtest == true && backtest == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            delete backtest;
            delete forwardtest;
            playerhasCompletedleanforwardback = true;
        } // end if
    }
    else if (playerhasCompletedshootingthetube == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_shoot_tube");
        } // end else if
        if (wipeout == false)
        {
            screeninterface.speedhelper.gotoAndStop("showslow");
            screeninterface.speedhelper._y = map.water._y;
        }
        else
        {
            screeninterface.speedhelper.gotoAndStop("hide");
        } // end else if
        if (gameplay == true && shotthetube == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            delete shotthetube;
            playerhasCompletedshootingthetube = true;
        } // end if
    }
    else if (playerhasCompletedpullahead == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_speed");
        } // end else if
        if (wipeout == false)
        {
            screeninterface.speedhelper.gotoAndStop("show");
            screeninterface.speedhelper._y = map.water._y;
        }
        else
        {
            screeninterface.speedhelper.gotoAndStop("hide");
        } // end else if
        if (pulledahead == true && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            delete pulledahead;
            playerhasCompletedpullahead = true;
        } // end if
    }
    else if (playerhasCompletedbackflip == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_backflip");
        } // end else if
        if (wipeout == false)
        {
            screeninterface.speedhelper.gotoAndStop("showbackflip");
            screeninterface.speedhelper._y = map.water._y;
        }
        else
        {
            screeninterface.speedhelper.gotoAndStop("hide");
        } // end else if
        if (flipspeed < 0 && Math.round(flipdegree / 360) < 0)
        {
            didabackflip = true;
        } // end if
        if (doneabackflip == true && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            delete didabackflip;
            delete doneabackflip;
            playerhasCompletedbackflip = true;
        }
        else if (player._x - wave._x < 2000)
        {
            pulledahead = false;
            playerhasCompletedpullahead = false;
            screeninterface.tips.gotoAndPlay("donetip");
            screeninterface.speedhelper.gotoAndStop("show");
            steeringtest = 0;
        } // end else if
        if (onwater == true && playerY > -20 && showmouseuparrow == true)
        {
            screeninterface.gouparrow.gotoAndPlay("show");
        } // end if
    }
    else if (playerhasCompletedfrontflip == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_frontflip");
        } // end else if
        if (wipeout == false)
        {
            screeninterface.speedhelper.gotoAndStop("showfrontflip");
            screeninterface.speedhelper._y = map.water._y;
        }
        else
        {
            screeninterface.speedhelper.gotoAndStop("hide");
        } // end else if
        if (flipspeed > 0 && Math.round(flipdegree / 360) > 0)
        {
            didafrontflip = true;
        } // end if
        if (doneafrontflip == true && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            delete didafrontflip;
            delete doneafrontflip;
            playerhasCompletedfrontflip = true;
        }
        else if (player._x - wave._x < 2000)
        {
            pulledahead = false;
            playerhasCompletedpullahead = false;
            screeninterface.tips.gotoAndPlay("donetip");
            screeninterface.speedhelper.gotoAndStop("show");
            steeringtest = 0;
        } // end else if
        if (onwater == true && playerY > -20 && showmouseuparrow == true)
        {
            screeninterface.gouparrow.gotoAndPlay("show");
        } // end if
    }
    else if (playerhasCompletedgrinding == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_grind");
        } // end else if
        screeninterface.speedhelper.gotoAndStop("hide");
        if (mostgrindpoints > 2 && grindpoints > 2 && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletedgrinding = true;
            delete showmouseuparrow;
        } // end if
    }
    else if (playerhasCompletedwave == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_wave");
        } // end else if
        if (trickType == "wave" && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletedwave = true;
        } // end if
    }
    else if (playerhasCompletedsit == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_lay_back");
        } // end else if
        if (trickType == "sit" && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletedsit = true;
        } // end if
    }
    else if (playerhasCompletedhandstand == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_handstand");
        } // end else if
        if (trickType == "handstand" && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletedhandstand = true;
        } // end if
    }
    else if (playerhasCompleteddance == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_dance");
        } // end else if
        if (trickType == "dance" && gameplay == true)
        {
            totalspinjumps = 0;
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompleteddance = true;
        } // end if
    }
    else if (playerhasCompletedspin == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_spin");
        } // end else if
        if (totalspinjumps > 0 && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletedspin = true;
        } // end if
    }
    else if (playerhasCompletedtrickgrind == false)
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_trick_grind");
        } // end else if
        if (holdpoints > 0 && grindpoints >= 10 && gameplay == true)
        {
            screeninterface.tips.gotoAndPlay("donetip");
            playerhasCompletedtrickgrind = true;
            finaltipwait = 0;
        } // end if
    }
    else
    {
        if (balance < 80)
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_balance");
        }
        else
        {
            currentTip = com.clubpenguin.util.LocaleText.getText("tips_complete");
        } // end else if
        if (finaltipwait < 200)
        {
            finaltipwait = finaltipwait + 1;
        }
        else
        {
            screeninterface.tips.gotoAndPlay("donetip");
            delete finaltipwait;
            playerhasCompletedtips = true;
            if (this.didLessonDone == false)
            {
                this.didLessonDone = true;
                detectAchievement(98);
            } // end else if
        } // end else if
    } // end else if
} // End of the function
function determinejudgescores()
{
    if (wave2Complete == true)
    {
        this["judgerating" + judge7]();
        this["judgerating" + judge8]();
        this["judgerating" + judge9]();
    }
    else if (wave1Complete == true)
    {
        this["judgerating" + judge4]();
        this["judgerating" + judge5]();
        this["judgerating" + judge6]();
    }
    else
    {
        this["judgerating" + judge1]();
        this["judgerating" + judge2]();
        this["judgerating" + judge3]();
    } // end else if
    judgeaverage = Math.round((this["judgerating" + judge1 + "score"] + this["judgerating" + judge2 + "score"] + this["judgerating" + judge3 + "score"] + this["judgerating" + judge4 + "score"] + this["judgerating" + judge5 + "score"] + this["judgerating" + judge6 + "score"] + this["judgerating" + judge7 + "score"] + this["judgerating" + judge8 + "score"] + this["judgerating" + judge9 + "score"]) / 9);
} // End of the function
function displayjudgescores()
{
    if (wave2Complete == true)
    {
        if (this["judgerating" + judge7 + "score"] > 0)
        {
            screeninterface.judgescores.bar1.gotoAndStop(this["judgerating" + judge7 + "score"]);
            if (this["judgerating" + judge7 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge7 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge7 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar1.gotoAndStop(1);
            screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge7 + "normal");
        } // end else if
        if (this["judgerating" + judge8 + "score"] > 0)
        {
            screeninterface.judgescores.bar2.gotoAndStop(this["judgerating" + judge8 + "score"]);
            if (this["judgerating" + judge8 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge8 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge8 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar2.gotoAndStop(1);
            screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge8 + "normal");
        } // end else if
        if (this["judgerating" + judge9 + "score"] > 0)
        {
            screeninterface.judgescores.bar3.gotoAndStop(this["judgerating" + judge9 + "score"]);
            if (this["judgerating" + judge9 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge9 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge9 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar3.gotoAndStop(1);
            screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge9 + "normal");
        } // end else if
    }
    else if (wave1Complete == true)
    {
        if (this["judgerating" + judge4 + "score"] > 0)
        {
            screeninterface.judgescores.bar1.gotoAndStop(this["judgerating" + judge4 + "score"]);
            if (this["judgerating" + judge4 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge4 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge4 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar1.gotoAndStop(1);
            screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge4 + "normal");
        } // end else if
        if (this["judgerating" + judge5 + "score"] > 0)
        {
            screeninterface.judgescores.bar2.gotoAndStop(this["judgerating" + judge5 + "score"]);
            if (this["judgerating" + judge5 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge5 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge5 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar2.gotoAndStop(1);
            screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge5 + "normal");
        } // end else if
        if (this["judgerating" + judge6 + "score"] > 0)
        {
            screeninterface.judgescores.bar3.gotoAndStop(this["judgerating" + judge6 + "score"]);
            if (this["judgerating" + judge6 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge6 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge6 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar3.gotoAndStop(1);
            screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge6 + "normal");
        } // end else if
    }
    else
    {
        if (this["judgerating" + judge1 + "score"] > 0)
        {
            screeninterface.judgescores.bar1.gotoAndStop(this["judgerating" + judge1 + "score"]);
            if (this["judgerating" + judge1 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge1 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge1 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar1.gotoAndStop(1);
            screeninterface.judgescores.judgebarface1.gotoAndStop("judge" + judge1 + "normal");
        } // end else if
        if (this["judgerating" + judge2 + "score"] > 0)
        {
            screeninterface.judgescores.bar2.gotoAndStop(this["judgerating" + judge2 + "score"]);
            if (this["judgerating" + judge2 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge2 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge2 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar2.gotoAndStop(1);
            screeninterface.judgescores.judgebarface2.gotoAndStop("judge" + judge2 + "normal");
        } // end else if
        if (this["judgerating" + judge3 + "score"] > 0)
        {
            screeninterface.judgescores.bar3.gotoAndStop(this["judgerating" + judge3 + "score"]);
            if (this["judgerating" + judge3 + "score"] > 9)
            {
                screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge3 + "impressed");
            }
            else
            {
                screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge3 + "normal");
            } // end else if
        }
        else
        {
            screeninterface.judgescores.bar3.gotoAndStop(1);
            screeninterface.judgescores.judgebarface3.gotoAndStop("judge" + judge3 + "normal");
        } // end else if
    } // end else if
} // End of the function
function judgerating1()
{
    judgerating1score = Math.round(totalgrindpoints / 20);
    if (judgerating1score > 10)
    {
        judgerating1score = 10;
    } // end if
} // End of the function
function judgerating2()
{
    judgerating2score = Math.round(totaltubepoints / 150);
    if (judgerating2score > 10)
    {
        judgerating2score = 10;
    } // end if
} // End of the function
function judgerating3()
{
    judgerating3score = Math.round(totalflips / 2);
    if (judgerating3score > 10)
    {
        judgerating3score = 10;
    } // end if
} // End of the function
function judgerating4()
{
    littlegrinding = Math.round(totalgrindpoints / 20);
    if (littlegrinding > 2)
    {
        littlegrinding = 2;
    } // end if
    littletube = Math.round(totaltubepoints / 70);
    if (littletube > 2)
    {
        littletube = 2;
    } // end if
    littleflip = Math.round(totalflips / 2);
    if (littleflip > 2)
    {
        littleflip = 2;
    } // end if
    littletrick = Math.round(basictrickpoints / 100);
    if (littletrick > 2)
    {
        littletrick = 2;
    } // end if
    littlespin = Math.round(totalspinjumps / 4);
    if (littlespin > 2)
    {
        littlespin = 2;
    } // end if
    judgerating1score = littlegrinding + littletube + littleflip + littletrick + littlespin;
    if (judgerating4score > 10)
    {
        judgerating4score = 10;
    } // end if
} // End of the function
function judgerating5()
{
    judgerating5score = Math.round(basictrickpoints / 300);
    if (judgerating5score > 10)
    {
        judgerating5score = 10;
    } // end if
} // End of the function
function judgerating6()
{
    judgerating6score = Math.round(totalspinjumps / 4);
    if (judgerating6score > 10)
    {
        judgerating6score = 10;
    } // end if
} // End of the function
function judgerating7()
{
    judgerating7score = Math.round(totalbalance / 10);
    if (judgerating7score > 10)
    {
        judgerating7score = 10;
    } // end if
} // End of the function
function judgerating8()
{
    judgerating8score = Math.round(totaltrickgrindpoints / 30);
    if (judgerating8score > 10)
    {
        judgerating8score = 10;
    } // end if
} // End of the function
function judgerating9()
{
    judgerating9score = Math.round(totalwavestand / 110);
    if (judgerating9score > 10)
    {
        judgerating9score = 10;
    } // end if
} // End of the function
function judgerating10()
{
    judgerating10score = Math.round(totalsitstand / 110);
    if (judgerating10score > 10)
    {
        judgerating10score = 10;
    } // end if
} // End of the function
function judgerating11()
{
    judgerating11score = Math.round(totalhanddance / 110);
    if (judgerating11score > 10)
    {
        judgerating11scoree = 10;
    } // end if
} // End of the function
function judgerating12()
{
    judgerating12score = Math.round(totalwavedance / 110);
    if (judgerating12score > 10)
    {
        judgerating12score = 10;
    } // end if
} // End of the function
function judgerating13()
{
    judgerating13score = Math.round(totalbreakdance / 110);
    if (judgerating13score > 10)
    {
        judgerating13score = 10;
    } // end if
} // End of the function
function judgerating14()
{
    if (totalsitwave == undefined)
    {
        totalsitwave = 0;
    } // end if
    judgerating14score = Math.round(totalsitwave / 110);
    if (judgerating14score > 10)
    {
        judgerating14score = 10;
    } // end if
} // End of the function
function didspinjump()
{
    totalspinjumps = totalspinjumps + 1;
    ++spinsInCurrentJump;
} // End of the function
function doingwavestand()
{
    totalwavestand = totalwavestand + 1;
    if (this.didIcebreakerTrickDone == false)
    {
        this.didIcebreakerTrickDone = true;
        incrementTricksDone();
    } // end if
} // End of the function
function doingsitstand()
{
    totalsitstand = totalsitstand + 1;
    if (this.didBackstandTrickDone == false)
    {
        this.didBackstandTrickDone = true;
        incrementTricksDone();
    } // end if
} // End of the function
function doinghanddance()
{
    totalhanddance = totalhanddance + 1;
    if (this.didCoastalkickTrickDone == false)
    {
        this.didCoastalkickTrickDone = true;
        incrementTricksDone();
    } // end if
} // End of the function
function doingwavedance()
{
    totalwavedance = totalwavedance + 1;
    if (this.didSurffeverTrickDone == false)
    {
        this.didSurffeverTrickDone = true;
        incrementTricksDone();
    } // end if
} // End of the function
function doingbreakdance()
{
    totalbreakdance = totalbreakdance + 1;
    if (this.didBlenderTrickDone == false)
    {
        this.didBlenderTrickDone = true;
        incrementTricksDone();
    } // end if
} // End of the function
function doingsitwave()
{
    totalsitwave = totalsitwave + 1;
    if (this.didLazywaveTrickDone == false)
    {
        this.didLazywaveTrickDone = true;
        incrementTricksDone();
    } // end if
} // End of the function
function puffleState()
{
    pufflelaststate = pufflecurrentstate;
    pufflecurrentstate = puffleOnwater;
    if (pufflelaststate == false && pufflecurrentstate == true)
    {
        pufflePointCount = random(3) + 1;
        playerswake.attachMovie("popuppointspuffle", "popuppuffle", 201);
        playerswake.popuppuffle.points_mc.points_tf.text = pufflePointCount.toString();
        playerswake.popuppuffle._x = puffle._x - playerswake._x;
        playerswake.popuppuffle._y = puffle._y - playerswake._y - 40;
        stylePointsCount = stylePointsCount + pufflePointCount;
        screeninterface.displayscore.stylePoints_tf.text = stylePointsCount.toString();
    } // end if
} // End of the function
function puffleboundary()
{
    if (gameplay == true)
    {
        if (puffle._x < -40)
        {
            puffle._x = -30;
            puffleX = 20;
            puffleY = 0;
        } // end if
        if (puffle._x > 800)
        {
            puffle._x = 799;
        } // end if
    } // end if
} // End of the function
function weaktrick()
{
    var _loc2 = 10;
    attachMovie("weakpopuppoints", "popup", 200);
    popup.pointsContainer_mc.points_tf.text = _loc2.toString();
    popup._x = player._x - playerswake._x;
    popup._y = player._y - playerswake._y - 60;
    stylePointsCount = stylePointsCount + 10;
    screeninterface.displayscore.stylePoints_tf.text = stylePointsCount.toString();
    checkDoneTrick(trickType);
    if (trickType == "wave")
    {
        if (this.didWaveTrickDone == false)
        {
            this.didWaveTrickDone = true;
            incrementTricksDone();
        } // end if
    }
    else if (trickType == "sit")
    {
        if (this.didSitTrickDone == false)
        {
            this.didSitTrickDone = true;
            incrementTricksDone();
        } // end if
    }
    else if (trickType == "handstand")
    {
        if (this.didHandstandTrickDone == false)
        {
            this.didHandstandTrickDone = true;
            incrementTricksDone();
        } // end if
    }
    else if (trickType == "dance")
    {
        if (this.didDanceTrickDone == false)
        {
            this.didDanceTrickDone = true;
            incrementTricksDone();
        } // end else if
    } // end else if
} // End of the function
function weaktrickAdvanced()
{
    var _loc1 = 20;
    attachMovie("weakpopuppoints", "popup", 200);
    popup.pointsContainer_mc.points_tf.text = _loc1.toString();
    popup._x = player._x - playerswake._x;
    popup._y = player._y - playerswake._y - 60;
    stylePointsCount = stylePointsCount + 20;
    screeninterface.displayscore.stylePoints_tf.text = stylePointsCount.toString();
    checkDoneTrick(trickType);
    if (playstyle == "competition")
    {
        if (trickType == "waveWavestand")
        {
            totalwavestand = totalwavestand + 5;
        }
        else if (trickType == "handstandWavestand")
        {
            totalwavestand = totalwavestand + 5;
        }
        else if (trickType == "sitSitstand")
        {
            totalsitstand = totalsitstand + 5;
        }
        else if (trickType == "handstandSitstand")
        {
            totalsitstand = totalsitstand + 5;
        }
        else if (trickType == "danceHanddance")
        {
            totalhanddance = totalhanddance + 5;
        }
        else if (trickType == "handstandHanddance")
        {
            totalhanddance = totalhanddance + 5;
        }
        else if (trickType == "danceWavedance")
        {
            totalwavedance = totalwavedance + 5;
        }
        else if (trickType == "waveWavedance")
        {
            totalwavedance = totalwavedance + 5;
        }
        else if (trickType == "danceBreakdance")
        {
            totalbreakdance = totalbreakdance + 5;
        }
        else if (trickType == "sitBreakdance")
        {
            totalbreakdance = totalbreakdance + 5;
        }
        else if (trickType == "sitSitwave")
        {
            totalsitwave = totalsitwave + 5;
        }
        else if (trickType == "waveSitwave")
        {
            totalsitwave = totalsitwave + 5;
        } // end else if
    } // end else if
} // End of the function
function placedebris()
{
    if (gameplay == true && wipeout == false)
    {
        if (debris == true)
        {
            playerswake.ripples.attachMovie("debrisice", "debri", 6000);
            if (debrisWarning == false)
            {
                playerswake.ripples.debri._x = 1280 - playerswake.ripples._x;
            }
            else if (debrisWarning == true)
            {
                playerswake.ripples.debri._x = 1600 - playerswake.ripples._x;
            } // end else if
            playerswake.ripples.debri._y = random(300) + 301;
            playerswake.ripples.debri.gotoAndStop(random(3) + 1);
            debris = "placed";
            attachMovie("hazard", "hazard", 6000);
            hazard._x = 700;
            hazard._y = playerswake.ripples.debri._y + playerswake.ripples._y;
        } // end if
        if (debris2 == true)
        {
            playerswake.ripples.attachMovie("debrisice", "debri2", 6001);
            if (debrisWarning == false)
            {
                playerswake.ripples.debri2._x = 1280 - playerswake.ripples._x;
            }
            else if (debrisWarning == true)
            {
                playerswake.ripples.debri2._x = 1600 - playerswake.ripples._x;
            } // end else if
            playerswake.ripples.debri2._y = random(300) + 301;
            playerswake.ripples.debri2.gotoAndStop(random(3) + 1);
            debris2 = "placed";
            attachMovie("hazard", "hazard2", 6001);
            hazard2._x = 700;
            hazard2._y = playerswake.ripples.debri2._y + playerswake.ripples._y;
        } // end if
        if (playerswake.ripples.debri._x < -800 - playerswake.ripples._x)
        {
            if (debris == false)
            {
                playerswake.ripples.removeMovieClip("debri");
            }
            else
            {
                if (debrisWarning == false)
                {
                    playerswake.ripples.debri._x = 1280 - playerswake.ripples._x;
                }
                else if (debrisWarning == true)
                {
                    playerswake.ripples.debri._x = 1600 - playerswake.ripples._x;
                } // end else if
                playerswake.ripples.debri._y = random(300) + 301;
                playerswake.ripples.debri.gotoAndStop(random(3) + 1);
                attachMovie("hazard", "hazard", 6000);
                hazard._x = 700;
                hazard._y = playerswake.ripples.debri._y + playerswake.ripples._y;
            } // end if
        } // end else if
        if (playerswake.ripples.debri2._x < -800 - playerswake.ripples._x)
        {
            if (debris2 == false)
            {
                playerswake.ripples.removeMovieClip("debri2");
            }
            else
            {
                if (debrisWarning == false)
                {
                    playerswake.ripples.debri2._x = 1280 - playerswake.ripples._x;
                }
                else if (debrisWarning == true)
                {
                    playerswake.ripples.debri2._x = 1600 - playerswake.ripples._x;
                } // end else if
                playerswake.ripples.debri2._y = random(300) + 301;
                playerswake.ripples.debri2.gotoAndStop(random(3) + 1);
                attachMovie("hazard", "hazard2", 6000);
                hazard2._x = 700;
                hazard2._y = playerswake.ripples.debri2._y + playerswake.ripples._y;
            } // end if
        } // end else if
        if (playerswake.ripples.debri.hitTest(player.board))
        {
            if (doingtrick == true)
            {
                balance = balance - 100;
            }
            else if (player._x < 200)
            {
                balance = balance - 20;
            }
            else
            {
                balance = balance - 10;
            } // end else if
        } // end else if
        if (playerswake.ripples.debri2.hitTest(player.board))
        {
            if (doingtrick == true)
            {
                balance = balance - 100;
            }
            else if (player._x < 200)
            {
                balance = balance - 20;
            }
            else
            {
                balance = balance - 10;
            } // end if
        } // end else if
    } // end else if
} // End of the function
function detectAchievement($idNum)
{
    if (this["achievement" + $idNum + "Done"] == false)
    {
        this["achievement" + $idNum + "Done"] = true;
        com.clubpenguin.util.Stamp.sendStamp($idNum);
    } // end if
} // End of the function
function checkDoneTrick($trickType)
{
    if (tricksDone[$trickType] != "DONE")
    {
        tricksDone[$trickType] = "DONE";
        ++numTricksDone;
        trace ($trickType + ":" + numTricksDone);
        if (numTricksDone == 13)
        {
            detectAchievement(99);
        } // end if
        if (numTricksDone == 1)
        {
            detectAchievement(93);
        } // end if
    } // end if
} // End of the function
stop ();
gameplay = true;
ripplei = -1;
rippleframe = 1;
waveoffset = 0;
waveoffsetdirection = "up";
gravity = 1;
onwater = false;
cutscenePlaced = false;
playerX = 0;
playerY = 0;
puffleX = 12;
puffleY = 0;
falling = false;
flipspeed = 0;
spinspeed = 0;
flipdegree = 0;
flipslanded = 0;
flippoints = 0;
mostflips = 0;
totalflips = 0;
mosttubepoints = 0;
totaltubepoints = 0;
stabilizing = false;
lean = "forward";
risklevel = 0;
playerspeed = 0;
trickType = "none";
lastTrick = "none";
backfliptest = 0;
frontfliptest = 0;
frontspintest = 1;
backspintest = 1;
grinding = false;
didgrind = false;
mostgrindpoints = 0;
grindpointcount = 1;
defaultgrindpointcount = 1;
grindpoints = 0;
totalgrindpoints = 0;
totaltrickgrindpoints = 0;
mostholdpoints = 0;
holdpointcount = 2;
holdpoints = 0;
basictrickpoints = 0;
totalholdpoints = 0;
totalspinjumps = 0;
spinsInCurrentJump = 0;
totalwavestand = 0;
totalsitstand = 0;
totalhanddance = 0;
totalwavedance = 0;
totalbreakdance = 0;
puffleJumped = true;
baseoffset = 0;
waveXlimit = -2000;
waveending = false;
waveOver = false;
mouseisdown = false;
wipeout = false;
balance = 100;
totalbalance = 100;
balancecount = 2;
challengecount = 0;
challenge1Complete = false;
wave1Complete = false;
challenge2Complete = false;
wave2Complete = false;
challenge3Complete = false;
wave3Complete = false;
challenge4Complete = false;
wave4Complete = false;
airtime = 0;
airtimecount = 24;
trickwait = 0;
doingtrick = false;
doingAdvancedTrick = false;
jumped = true;
var pointsPopupCount = 0;
var pufflePointCount = 0;
var judgeScoreCount;
if (playstyle == "freestyle")
{
    steeringtest = 0;
    playerhasCompletednothing = false;
    playerhasCompletedsteerupdown = false;
    playerhasCompletedleanforwardback = false;
    playerhasCompletedshootingthetube = false;
    playerhasCompletedpullahead = false;
    playerhasCompletedbackflip = false;
    playerhasCompletedfrontflip = false;
    playerhasCompletedgrinding = false;
    playerhasCompletedwave = false;
    playerhasCompletedsit = false;
    playerhasCompletedhandstand = false;
    playerhasCompleteddance = false;
    playerhasCompletedspin = false;
    playerhasCompletedtrickgrind = false;
    playerhasCompletedtips = false;
} // end if
if (playstyle == "competition")
{
    judgerating1score = 0;
    judgerating2score = 0;
    judgerating3score = 0;
    judgerating4score = 0;
    judgerating5score = 0;
    judgerating6score = 0;
    judgerating7score = 0;
    judgerating8score = 0;
    judgerating9score = 0;
    judgerating10score = 0;
    judgerating11score = 0;
    judgerating12score = 0;
    judgerating13score = 0;
    judgerating14score = 0;
} // end if
if (playstyle == "survival")
{
    distancetravelled = 0;
    debris = false;
} // end if
if (playstyle == "survival")
{
    sharkattack = true;
}
else
{
    sharkattack = false;
} // end else if
if (sharkattack == true)
{
    attachMovie("shark", "shark", 102);
    shark._x = -3000;
    shark._y = map.water._y + 500;
    shark.gotoAndStop("gone");
    sharkspeed = 2;
    sharkenergy = 10;
} // end if
attachMovie("player", "player", 100);
player._x = 480;
player._y = 0;
playercamera = 480;
if (hasPuffle == true)
{
    attachMovie("puffle", "puffle", 99);
    puffle._x = player._x + 100;
    puffle._y = player._y - 300;
    puffle.gotoAndStop("air");
    attachMovie("puffleswap", "puffleswap", 101);
    pufflebehindplayer = true;
} // end if
attachMovie("map", "map", -1004);
map.water._x = 380;
map.water._y = 240;
attachMovie("playerswake", "playerswake", -1002);
attachMovie("wavecurl", "wavecurl", -1001);
wavecurl._x = wave._x + 1510;
wavecurl._y = map.water._y - map._y;
attachMovie("watersurface", "watersurface", -1003);
attachMovie("watersurface2", "watersurface2", -1000);
attachMovie("watersurface3", "watersurface3", -999);
attachMovie("watersurface4", "watersurface4", -998);
watersurface._x = 380;
watersurface2._x = 380;
watersurface3._x = 380;
watersurface4._x = 380;
watersurface._y = map.water._y + 502;
watersurface2._y = map.water._y + 502;
watersurface3._y = map.water._y + 502;
watersurface4._y = map.water._y + 502;
attachMovie("wave", "wave", 103);
wave._x = -1400;
wave._y = 240;
defaultwavespeed = 4 + boardupgrade;
wavespeed = defaultwavespeed;
lastplayerY = player._y;
attachMovie("screeninterface", "screeninterface", 104);
screeninterface._x = 0;
screeninterface._y = 0;
lives = 3;
screeninterface.livesRemaining.gotoAndStop(lives + 1);
screeninterface.displayscore.stylePoints_tf.text = stylePointsCount.toString();
if (playstyle == "freestyle")
{
    if (showtips == false)
    {
        screeninterface.tips._visible = false;
        screeninterface.speedhelper._visible = false;
    }
    else
    {
        screeninterface.tips.gotoAndStop("freestyletips");
    } // end if
} // end else if
if (playstyle == "competition")
{
    screeninterface.judgescores.gotoAndStop("judgebars");
} // end if
if (playstyle == "survival")
{
    screeninterface.displayscore.gotoAndStop("survival");
    screeninterface.displayscore.survivalScore_tf.text = "0";
} // end if
var splash4Sound = new Sound(this);
splash4Sound.attachSound("splash4");
var achord1Sound = new Sound(this);
achord1Sound.attachSound("achord1");
var achord2Sound = new Sound(this);
achord2Sound.attachSound("achord2");
var achord3Sound = new Sound(this);
achord3Sound.attachSound("achord3");
var agliss1Sound = new Sound(this);
agliss1Sound.attachSound("agliss1");
var agliss2Sound = new Sound(this);
agliss2Sound.attachSound("agliss2");
var dchord1Sound = new Sound(this);
dchord1Sound.attachSound("dchord1");
var dchord2Sound = new Sound(this);
dchord2Sound.attachSound("dchord2");
onEnterFrame = function ()
{
    if (gameplay == true)
    {
        this["determineChallenge" + playstyle]();
    } // end if
    if (map.water.hitTest(puffle._x, puffle._y - 20, true))
    {
        puffleOnwater = true;
    }
    else
    {
        puffleOnwater = false;
    } // end else if
    if (map.water.hitTest(player._x, player._y, true) && mouseisdown == true && jumped == true && player._rotation < 80 && player._rotation > -80 && wave._x < -1200 + player._x - 480 - (wavespeed - 4) * 10 && balance == 100 && waveending == false)
    {
        grindingfunction();
    }
    else if (grinding == true)
    {
        endgrindingfunction();
    }
    else if (map.water.hitTest(player._x, player._y - 10, true))
    {
        onwater = true;
        grinding = false;
    }
    else
    {
        intheairfunction();
    } // end else if
    if (puffleOnwater == true && wipeout == false)
    {
        steerpufflefunction();
    }
    else if (wipeout == true)
    {
        puffle._x = puffle._x + (100 - playerX);
    } // end else if
    if (hasPuffle == true)
    {
        puffleboundary();
    } // end if
    if (puffle._y > player._y && pufflebehindplayer == true)
    {
        swappuffle();
        pufflebehindplayer = false;
    } // end if
    if (puffle._y < player._y && pufflebehindplayer == false)
    {
        swappuffle();
        pufflebehindplayer = true;
    } // end if
    if (onwater == true && wipeout == false)
    {
        mousecontrolling();
    } // end if
    if (gameplay == true)
    {
        tricksfunction();
        if (trickType == "wavestandjump")
        {
            doingwavestand();
        }
        else if (trickType == "handstandWavestand")
        {
            doingwavestand();
        }
        else if (trickType == "waveWavestand")
        {
            doingwavestand();
        }
        else if (trickType == "sitstandjump")
        {
            doingsitstand();
        }
        else if (trickType == "handstandSitstand")
        {
            doingsitstand();
        }
        else if (trickType == "sitSitstand")
        {
            doingsitstand();
        }
        else if (trickType == "handdancejump")
        {
            doinghanddance();
        }
        else if (trickType == "handstandHanddance")
        {
            doinghanddance();
        }
        else if (trickType == "danceHanddance")
        {
            doinghanddance();
        }
        else if (trickType == "wavedancejump")
        {
            doingwavedance();
        }
        else if (trickType == "waveWavedance")
        {
            doingwavedance();
        }
        else if (trickType == "danceWavedance")
        {
            doingwavedance();
        }
        else if (trickType == "breakdancejump")
        {
            doingbreakdance();
        }
        else if (trickType == "danceBreakdance")
        {
            doingbreakdance();
        }
        else if (trickType == "sitBreakdance")
        {
            doingbreakdance();
        }
        else if (trickType == "sitwavejump")
        {
            doingsitwave();
        }
        else if (trickType == "waveSitwave")
        {
            doingsitwave();
        }
        else if (trickType == "sitSitwave")
        {
            doingsitwave();
        } // end else if
    } // end else if
    if (doingtrick == true)
    {
        basictrickpoints = basictrickpoints + 1;
    } // end if
    if (playerX > 0)
    {
        playerDirection = "RIGHT";
    }
    else if (playerX < 0)
    {
        playerDirection = "LEFT";
    } // end else if
    if (onwater == false && grinding == false)
    {
        playerY = playerY + gravity;
        playerYmomentum = 0;
        playerXmomentum = 0;
    } // end if
    if (puffleOnwater == false)
    {
        puffleY = puffleY + gravity;
        if (puffleJumped == false)
        {
            puffleJumped = true;
            puffleTrick();
        } // end if
    } // end if
    calculatefriction();
    if (wipeout == false)
    {
        playerY = playerY + playerYmomentum;
        playerX = playerX + playerXmomentum;
    }
    else
    {
        playerYmomentum = 0;
        playerXmomentum = 0;
        if (Math.round(playerX) == 0)
        {
            playerX = 0;
        }
        else if (playerX > 0)
        {
            playerX = playerX - 1;
        }
        else if (playerX < 0)
        {
            playerX = playerX + 0;
        } // end else if
    } // end else if
    calculateplayerspeed();
    playermovingright();
    if (gameplay == true && wipeout == false)
    {
        if (playercamera == 480)
        {
            if (Math.round(player._x) == playercamera)
            {
                player._x = playercamera;
            }
            else if (player._x > playercamera)
            {
                player._x = player._x - 1;
            }
            else if (player._x < playercamera)
            {
                player._x = player._x + 1;
            } // end else if
        } // end else if
        if (playercamera == 200)
        {
            if (player._x > playercamera)
            {
                player._x = player._x - (player._x - playercamera) / 20;
            }
            else if (player._x < playercamera)
            {
                player._x = player._x + 1;
            }
            else if (player._x == playercamera)
            {
                playercamera = "freeroam";
            } // end else if
        } // end else if
        if (playercamera == "freeroam")
        {
            if (balance < 100)
            {
                player._x = player._x + (balance - 100) / 10;
            }
            else if (playerY > 0 && onwater == true)
            {
                player._x = player._x + playerY / 4;
            } // end else if
            if (player._x >= 480)
            {
                player._x = 480;
            } // end if
            if (challengecount < challengecountgoal && player._x >= 480 && playerY > 0)
            {
                challengecount = challengecount + Math.round(playerY / 10);
            }
            else if (challengecount < challengecountgoal && stylePointsCount > challengecount)
            {
                challengecount = challengecount + 1;
            } // end if
        } // end if
    } // end else if
    if (player._y > 380 && playerY > 0)
    {
        if (map.water._y > -150)
        {
            playermovingdown();
        } // end if
    }
    else if (player._y < 100 && playerY < 0)
    {
        playermovingup();
    }
    else
    {
        player._y = player._y + playerY;
    } // end else if
    puffle._x = puffle._x + puffleX;
    puffle._y = puffle._y + puffleY;
    if (gameplay == false)
    {
        wavesrising();
    } // end if
    playerswake.watermask._y = map.water._y;
    loopwatersurface();
    wave._y = map.water._y;
    wave._x = wave._x + (wavespeed + tubepoints / 1000);
    if (wipeout == false)
    {
        pullingahead();
    }
    else
    {
        wave._x = wave._x + (100 - playerX);
    } // end else if
    lastplayerY = player._y;
    if (wave._x < waveXlimit)
    {
        wave._x = waveXlimit;
    } // end if
    wavecurl._x = wave._x + 1510;
    wavecurl._y = map.water._y - map._y;
    keepcharactersonscreen();
    playerperspective();
    if (hasPuffle == true)
    {
        puffleperspective();
    } // end if
    if (onwater == true && wipeout == false)
    {
        backfliptest = 1;
        frontfliptest = 1;
        spintest = 1;
        recordmouseXS = undefined;
        stabilizing = false;
        placeripplefunction();
        if (falling == true)
        {
            wipeout = true;
            balance = balance - 100;
        }
        else if (player._rotation > 80)
        {
            if (jumped == true)
            {
                if (doingtrick == true)
                {
                    balance = balance - 100;
                }
                else if (wave._x > -1100 + player._x - 480)
                {
                    balance = balance - 100;
                }
                else
                {
                    balance = balance - 80;
                    agliss1Sound.start(0, 1);
                } // end else if
                doingtrick = false;
                doingAdvancedTrick = false;
            } // end if
        }
        else if (player._rotation < -80)
        {
            if (jumped == true)
            {
                if (doingtrick == true)
                {
                    balance = balance - 100;
                }
                else if (wave._x > -1100 + player._x - 480)
                {
                    balance = balance - 100;
                }
                else
                {
                    balance = balance - 80;
                    agliss1Sound.start(0, 1);
                } // end else if
                doingtrick = false;
                doingAdvancedTrick = false;
            } // end if
        }
        else if (jumped == true)
        {
            if (wave._x < -1100 + player._x - 480)
            {
                balance = 100;
                didgrind = false;
            }
            else
            {
                balance = balance - 100;
            } // end else if
            if (flipdegree < 0)
            {
                flipdegree = flipdegree * -1;
            } // end if
            flipsmade = Math.round(flipdegree / 360);
            totalflips = totalflips + flipsmade;
            if (this.didAnyFlipDone == false)
            {
                if (flipsmade > 0)
                {
                    this.didAnyFlipDone = true;
                    detectAchievement(95);
                } // end if
            } // end if
            if (this.didTripleFlipDone == false)
            {
                if (flipsmade > 2)
                {
                    this.didTripleFlipDone = true;
                    detectAchievement(101);
                } // end if
            } // end if
            if (this.didTenFlipDone == false)
            {
                if (flipsmade > 9)
                {
                    this.didTenFlipDone = true;
                    detectAchievement(109);
                } // end if
            } // end if
            if (this.didThreeSpinDone == false)
            {
                if (spinsInCurrentJump > 2)
                {
                    this.didThreeSpinDone = true;
                    detectAchievement(104);
                } // end if
            } // end if
            if (this.didSevenSpinDone == false)
            {
                if (spinsInCurrentJump > 6)
                {
                    this.didSevenSpinDone = true;
                    detectAchievement(105);
                } // end if
            } // end if
            if (this.didTenSpinDone == false)
            {
                if (spinsInCurrentJump > 9)
                {
                    this.didTenSpinDone = true;
                    detectAchievement(112);
                } // end if
            } // end if
            if (flipsmade >= 6)
            {
                achord1Sound.start(0, 1);
            }
            else if (flipsmade >= 3)
            {
                achord3Sound.start(0, 1);
            }
            else if (flipsmade >= 1)
            {
                achord2Sound.start(0, 1);
            } // end else if
            for (f = flipsmade; f > 0; f = f - 1)
            {
                if (doingtrick == true)
                {
                    flippoints = flippoints + f * 20;
                    continue;
                } // end if
                flippoints = flippoints + f * 10;
            } // end of for
            if (flipsmade + grindpoints + holdpoints > 0 && wave._x < -1100 + player._x - 480)
            {
                pointsPopupCount = flippoints + grindpoints + holdpoints;
                stylePointsCount = stylePointsCount + pointsPopupCount;
                totalholdpoints = totalholdpoints + holdpoints;
                totalgrindpoints = totalgrindpoints + grindpoints;
                screeninterface.displayscore.stylePoints_tf.text = stylePointsCount.toString();
                playerswake.attachMovie("popuppoints", "popup", 200);
                if (wipeout == true)
                {
                    pointsPopupCount = 0;
                } // end if
                playerswake.popup.points_mc.points_tf.text = pointsPopupCount.toString();
                playerswake.popup._x = player._x - playerswake._x;
                playerswake.popup._y = player._y - playerswake._y - 100;
                if (flipsmade > 0)
                {
                    if (flipsmade == 1)
                    {
                        playerswake.popup.flips_mc.flips_tf.text = flipsmade + " FLIP";
                    }
                    else
                    {
                        playerswake.popup.flips_mc.flips_tf.text = flipsmade + " FLIPS";
                    } // end else if
                }
                else
                {
                    playerswake.popup.flips_mc.flips_tf.text = " ";
                } // end if
            } // end else if
            if (mostflips < flipsmade)
            {
                mostflips = flipsmade;
            } // end if
            if (grindpoints > 0)
            {
                checkDoneTrick("grind");
            } // end if
            if (flipsmade > 0)
            {
                checkDoneTrick("flip");
            } // end if
            if (this.didGrindEasyDone == false)
            {
                if (pointsPopupCount > 99 && grindpoints > 0)
                {
                    this.didGrindEasyDone = true;
                    detectAchievement(97);
                } // end if
            } // end if
            if (this.didGrindMedDone == false)
            {
                if (pointsPopupCount > 699 && grindpoints > 0)
                {
                    this.didGrindMedDone = true;
                    detectAchievement(106);
                } // end if
            } // end if
            if (this.didGrindHardDone == false)
            {
                if (pointsPopupCount > 1199 && grindpoints > 0)
                {
                    this.didGrindHardDone = true;
                    detectAchievement(107);
                } // end else if
            } // end else if
        } // end else if
        player._rotation = -1 * angle;
        jumped = false;
        flipspeed = 0;
        flipdegree = 0;
        backfliptest = 1;
        frontfliptest = 1;
        backspintest = 1;
        frontspintest = 1;
        spinspeed = 0;
        flippoints = 0;
        grindpoints = 0;
        holdpoints = 0;
        flipsmade = 0;
        spinsInCurrentJump = 0;
    }
    else if (onwater == false)
    {
        if (balance < 100 && wipeout == false)
        {
            if (falling == false)
            {
                agliss2Sound.start(0, 1);
            } // end if
            falling = true;
            player._rotation = 0;
            balance = 80;
        } // end if
        jumped = true;
        this.playerswake.ripples["ripple" + (ripplei + 1)]._x = 0;
        playerX = playerX + 1;
        if (puffleX < 12)
        {
            puffleX = puffleX + 1;
        } // end if
        if (grinding == false)
        {
            wave._x = wave._x - Math.round(risklevel / 100);
        }
        else
        {
            risklevel = 0;
        } // end else if
        detectbackflipgesture();
        detectfrontflipgesture();
        if (flipspeed > 62)
        {
            flipspeed = 62;
        }
        else if (flipspeed < -62)
        {
            flipspeed = -62;
        } // end else if
        if (mouseisdown == true && falling == false && grinding == false)
        {
            backfliptest = 0;
            frontfliptest = 0;
            slowflipspeed();
            steerplayertowardmouse();
            if (flipspeed < 0)
            {
                stabilizingbackflip();
            }
            else if (flipspeed > 0)
            {
                stabilizingfrontflip();
            } // end else if
            stabilizing = true;
        }
        else
        {
            stabilizing = false;
        } // end else if
        player._rotation = player._rotation + flipspeed;
        flipdegree = flipdegree + flipspeed;
    } // end else if
    if (ripplei == -1)
    {
        this.playerswake.ripples["ripple" + (ripplei - 40)]._yscale = player._yscale * 2 - 150;
    }
    else
    {
        this.playerswake.ripples["ripple" + (ripplei + 1)]._yscale = player._yscale * 2 - 150;
    } // end else if
    if (wave._x > -1000 + player._x - 480 && onwater == true && gameplay == true)
    {
        shootingthetubefunction();
    }
    else
    {
        if (gameplay == true && shootingthetube == true)
        {
            if (tubepoints > 1000)
            {
                dchord2Sound.start(0, 1);
            }
            else if (tubepoints > 10)
            {
                dchord1Sound.start(0, 1);
            } // end else if
            stylePointsCount = stylePointsCount + tubepoints;
            screeninterface.displayscore.stylePoints_tf.text = stylePointsCount.toString();
            totaltubepoints = totaltubepoints + tubepoints;
            if (mosttubepoints < tubepoints)
            {
                mosttubepoints = tubepoints;
            } // end if
            checkDoneTrick("shootingthetube");
            if (this.didTubeEasyDone == false)
            {
                if (tubepoints > 99)
                {
                    this.didTubeEasyDone = true;
                    detectAchievement(96);
                } // end if
            } // end if
            if (this.didTubeMedDone == false)
            {
                if (tubepoints > 999)
                {
                    this.didTubeMedDone = true;
                    detectAchievement(103);
                } // end if
            } // end if
            if (this.didTubeHardDone == false)
            {
                if (tubepoints > 4999)
                {
                    this.didTubeHardDone = true;
                    detectAchievement(111);
                } // end if
            } // end if
        } // end if
        if (gameplay == false)
        {
            pointsPopupCount = 0;
        } // end if
        pointsPopupCount = 0;
        shootingthetube = false;
        tubepoints = 0;
        tubepointcount = 10;
        defaulttubepointcount = 10;
    } // end else if
    if (onwater == true && gameplay == true)
    {
        candoweaktrick = true;
    }
    else
    {
        candoweaktrick = false;
    } // end else if
    if (risklevel > 0)
    {
        if (shootingthetube == false)
        {
            risklevel = risklevel - 1;
            if (onwater == true)
            {
                risklevel = 0;
            } // end if
        } // end if
    } // end if
    if (wave._x > -550 + player._x - 480 && onwater == true)
    {
        if (doingtrick == true)
        {
            balance = balance - 100;
        }
        else
        {
            balance = balance - 1;
        } // end if
    } // end else if
    if (player._y > 380 && map.water._y + baseoffset < -150)
    {
        balance = balance - 100;
    }
    else if (player._y - map.water._y - baseoffset > 410)
    {
        if (doingtrick == true)
        {
            balance = balance - 100;
        }
        else
        {
            balance = balance - 1;
        } // end else if
    } // end else if
    if (balancecount > 0)
    {
        balancecount = balancecount - 1;
    } // end if
    if (balance < 0)
    {
        balance = 0;
    } // end if
    if (balance < 1)
    {
        wipeout = true;
        player._rotation = 0;
        screeninterface.livesRemaining.boardRemaining.gotoAndStop("break");
    }
    else if (balance < 100 && balancecount <= 0)
    {
        if (totalbalance > 0)
        {
            totalbalance = totalbalance - 5.000000E-001;
        } // end if
        if (player._y - map.water._y < 410 && wave._x < -500 + player._x - 480 && onwater == true)
        {
            if (mouseisdown == true)
            {
                balance = balance + 4;
            } // end if
            if (lean == "back")
            {
                balance = balance + 4;
            } // end if
            if (playerspeed <= 11)
            {
                balance = balance + 6;
            }
            else if (playerspeed <= 16)
            {
                balance = balance + 4;
            }
            else if (playerspeed <= 20)
            {
                balance = balance + 2;
            }
            else if (balance < 50)
            {
                balance = balance - 5.000000E-001;
            }
            else
            {
                balance = balance + 1;
            } // end else if
        }
        else if (playerspeed > 20 && balance < 50)
        {
            balance = balance - 5.000000E-001;
        } // end else if
        balancecount = 2;
    } // end else if
    if (balance > 100)
    {
        balance = 100;
    } // end if
    if (hasPuffle == true && gameplay == true)
    {
        puffleState();
    } // end if
    if (gameplay == true)
    {
        if (playstyle == "survival")
        {
            survivalScoreCount = Math.round(distancetravelled / 100);
            survivalScoreCount = survivalScoreCount * 200;
            screeninterface.displayscore.survivalScore_tf.text = String(Math.round(stylePointsCount) + Math.round(survivalScoreCount));
            coinsCountTotal = Math.round(stylePointsCount / 10) + Math.round(survivalScoreCount / 10);
        }
        else
        {
            coinsCountTotal = Math.round(stylePointsCount / 10);
        } // end if
    } // end else if
    if (wipeout == true)
    {
        if (sharkBite == true)
        {
            player.gotoAndStop("sharkattacked");
        }
        else
        {
            player.gotoAndStop("wipeout");
        } // end else if
    }
    else if (stabilizing == true)
    {
        if (doingtrick == true)
        {
            player.gotoAndStop([trickType + "stabilizing"]);
        }
        else
        {
            player.gotoAndStop("stabilizing");
        } // end else if
    }
    else if (grinding == true)
    {
        if (doingtrick == true)
        {
            player.gotoAndStop([trickType + "grinding"]);
            player.penguin.board.gotoAndStop(boardart + 1);
        }
        else
        {
            player.gotoAndStop("grinding");
            player.penguin.board.gotoAndStop(boardart + 1);
        } // end else if
    }
    else if (onwater == true && balance < 100)
    {
        player.gotoAndStop("offbalance");
        player.penguin.gotoAndStop(Math.round(balance + 1));
    }
    else if (onwater == false && balance < 100)
    {
        player.gotoAndStop("falling");
    }
    else if (doingtrick == true)
    {
        player.gotoAndStop(trickType);
    }
    else if (doingtrick == false)
    {
        player.gotoAndStop(["normal" + lean]);
        trickType = "none";
    } // end else if
    player.board.gotoAndStop(boardart + 1);
    if (wave._x > -150 && balance < 1)
    {
        puffle.gotoAndStop("gone");
    }
    else if (puffleOnwater == true && wavespeed > defaultwavespeed)
    {
        puffle.gotoAndStop("scared");
    }
    else if (puffleOnwater == true && wave._x - puffle._x > -1500)
    {
        puffle.gotoAndStop("scared");
    }
    else if (puffleOnwater == true)
    {
        puffle.gotoAndStop("normal");
    } // end else if
    if (puffleOnwater == true)
    {
        puffle._rotation = puffleY * 1.500000E+000;
    } // end if
    if (playerX < 20 && wipeout == false)
    {
        playerX = 20;
    } // end if
    if (wave._x > 100)
    {
        if (gameplay == true)
        {
            gameplay = false;
            map.water.gotoAndStop("shallow");
            watersurface.watertop.gotoAndStop("hide");
            this.playerswake.ripples._x = this.playerswake.ripples._x - 1000;
            playerswake.ripples.debri._y = playerswake.ripples.debri._y + 1000;
            playerswake.ripples.debri2._y = playerswake.ripples.debri2._y + 1000;
        } // end if
    } // end if
    if (playstyle == "freestyle")
    {
        displaytips();
    } // end if
    if (playstyle == "competition")
    {
        determinejudgescores();
        displayjudgescores();
    } // end if
    if (playstyle == "survival")
    {
        placedebris();
    } // end if
    if (gameplay == true && waveending == false)
    {
        watersurface._y = map.water._y + 502;
    } // end if
    if (this.didJumpEasyDone == false)
    {
        var _loc2 = player._y - (map.water._y - map._y);
        if (_loc2 < -375)
        {
            this.didJumpEasyDone = true;
            detectAchievement(102);
        } // end if
    } // end if
    if (this.didJumpHardDone == false)
    {
        _loc2 = player._y - (map.water._y - map._y);
        if (_loc2 < -900)
        {
            this.didJumpHardDone = true;
            detectAchievement(110);
        } // end if
    } // end if
};
this.achievement93Done = false;
this.achievement94Done = false;
this.achievement95Done = false;
this.achievement96Done = false;
this.achievement97Done = false;
this.achievement98Done = false;
this.achievement99Done = false;
this.achievement100Done = false;
this.achievement101Done = false;
this.achievement102Done = false;
this.achievement103Done = false;
this.achievement104Done = false;
this.achievement105Done = false;
this.achievement106Done = false;
this.achievement107Done = false;
this.achievement108Done = false;
this.achievement109Done = false;
this.achievement110Done = false;
this.achievement111Done = false;
this.achievement112Done = false;
this.achievement113Done = false;
this.achievement114Done = false;
this.didWaveTrickDone = false;
this.didSitTrickDone = false;
this.didHandstandTrickDone = false;
this.didDanceTrickDone = false;
this.didIcebreakerTrickDone = false;
this.didBackstandTrickDone = false;
this.didCoastalkickTrickDone = false;
this.didSurffeverTrickDone = false;
this.didBlenderTrickDone = false;
this.didLazywaveTrickDone = false;
var numTricksDone = 0;
var tricksDone = new Object();
this.didThreeSpinDone = false;
this.didSevenSpinDone = false;
this.didTenSpinDone = false;
this.didAnyFlipDone = false;
this.didTripleFlipDone = false;
this.didTenFlipDone = false;
this.didTubeEasyDone = false;
this.didTubeMedDone = false;
this.didTubeHardDone = false;
this.didGrindEasyDone = false;
this.didGrindMedDone = false;
this.didGrindHardDone = false;
this.didLessonDone = false;
this.seeSharkDone = false;
this.didJumpEasyDone = false;
this.didJumpHardDone = false;
if (hasPuffle == true)
{
    detectAchievement(94);
} // end if
