#ifndef GAMETIMER_H
#define GAMETIMER_H

#include <QTimer>



class GameTimer : public QTimer
{
    Q_OBJECT
public:
    explicit GameTimer();
    ~GameTimer();
    // getter and setter
    inline int getTotalTime(){
        return totalTime;
    }
    inline void setTotalTime(int totalTime){
        this->totalTime = totalTime;
    }

    inline int getPastTime(){
        return pastTime;
    }
    inline void setPastTime(int pastTime){
        this->pastTime = pastTime;
    }

    inline int getRemainTime(){
        return remainTime;
    }
    inline void setRemainTime(int remainTime){
        this->remainTime = remainTime;
    }

    void startTimer(int totalTime);     // 设置开始时间并计时开始
    void restartTimer();    // 按照之前给定的时间重新开始
    void stopTimer();       // 停止计时
    void clearTimer();      // 时间清零
private:
    int totalTime = 0;
    int pastTime = 0;
    int remainTime =0;
public slots:
    void modifyTimeAndDoSth(); // 在timeout时，修改时间并做一些其他的事情

signals:
    void timeNotify(int remainTime);    // 通知主界面修改剩余时间
    void timerIsRunOut();   // 发送计时结束信号
};

#endif // GAMETIMER_H
