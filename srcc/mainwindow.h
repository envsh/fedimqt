#ifndef _MAIN_WINDOW2_H_
#define _MAIN_WINDOW2_H_

#include <QMainWindow>
class QQmlApplicationEngine;
// class Ui::MainWindow2;
class Ui_MainWindow2;

class MainWindow2 : public QMainWindow {
    Q_OBJECT;

public:
    Ui_MainWindow2 *uiw;
    MainWindow2(QWidget*parent = nullptr);
    void setupMenuSlots();

    void setQmlAppWindow(QQmlApplicationEngine* qmlae);
};

#endif // _MAIN_WINDOW2_H_