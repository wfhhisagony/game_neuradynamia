#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include "gametimer.h"

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    // 模式
    enum gameMode{
      timerMode = 0,
      computerMode = 1,
      netMode = 2
    };

    enum timerModeDiff{
        t_simple = 3,
        t_common = 4,
        t_hard = 5,
        t_simple_limit = 80,
        t_simple_cardNum = 16,
        t_common_limit = 80,
        t_common_cardNum = 24,
        t_hard_limit = 120,
        t_hard_cardNum = 36
    };
    enum computerModeDiff{
        c_simple = 6,
        c_common = 7,
        c_hard = 8
    };

    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
    GameTimer m_gameTimer;  // 自定义定时器

private:
    Ui::MainWindow *ui;
    void refreshWindow();
    void startTimerMode(timerModeDiff diff);
public slots:
    void refreshTimer(int tn);
private slots:
    void on_pushButton_clicked();
};
#endif // MAINWINDOW_H
