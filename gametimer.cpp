#include "gametimer.h"

GameTimer::GameTimer()
{
    connect(this, &GameTimer::timeout, this, &GameTimer::modifyTimeAndDoSth);

}

GameTimer::~GameTimer()
{

}

void GameTimer::startTimer(int totalTime)
{
    setTotalTime(totalTime);
    setPastTime(0);
    setRemainTime(0);
    start(1000);    // 每1s发送timeout信号
}

void GameTimer::restartTimer()
{
    if(this->totalTime == 0){
        return;
    }
    else{
        startTimer(this->totalTime);
    }
}

void GameTimer::stopTimer()
{
    this->remainTime = 0;
}

void GameTimer::clearTimer()
{
    this->totalTime = 0;
    this->remainTime = 0;
    this->pastTime = 0;
}

void GameTimer::modifyTimeAndDoSth()
{
    this->pastTime += 1;
    this->remainTime = this->totalTime - this->pastTime;
    emit timeNotify(this->remainTime);
    if (this->pastTime == this->totalTime){
        this->stop();
        emit timerIsRunOut();
    }
}

