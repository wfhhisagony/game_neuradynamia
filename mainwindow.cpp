#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    connect(&m_gameTimer,&GameTimer::timeNotify,this,&MainWindow::refreshTimer);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::refreshWindow()
{

}

void MainWindow::startTimerMode(MainWindow::timerModeDiff diff)
{
    if(diff == t_simple){
        m_gameTimer.startTimer(t_simple_limit);
    }else if(diff == t_common){

    }else if(diff == t_hard){

    }
}

void MainWindow::refreshTimer(int tn)
{
    ui->lbl_time->setNum(tn);
}


void MainWindow::on_pushButton_clicked()
{
    startTimerMode(t_simple);
}
