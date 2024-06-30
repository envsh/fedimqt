

#include <QtWidgets>
#include <QtQml>
#include <QtQuick>
#include <QQuickWidget>
#include <QQuickWindow>

#include "mainwindow.h"
#include "../ui_mainwindow.h"

class MainWindow2Data {
public:
    QQuickWidget* tabw0;
    QQuickWidget* tabw1;
    QQuickWidget* tabw2;
    QQuickWidget* tabw3;
    QQuickWidget* tabw4;
};

MainWindow2Data* mw2d = nullptr;

MainWindow2::MainWindow2(QWidget*parent) : QMainWindow(parent) {
    uiw = new Ui_MainWindow2();
    uiw->setupUi(this);
    uiw->menubar->setNativeMenuBar(false); // sofuck macos

    mw2d = new MainWindow2Data();

    auto qw = new QQuickWidget();
    mw2d->tabw0 = qw;
    uiw->tabWidget->insertTab(0, qw, "qml00");
    uiw->tabWidget->setCurrentIndex(0);

    #ifdef Q_OS_ANDROID
    const QUrl url("qrc:///mainqml/srcui/Settingui.qml");
    #else
    const QUrl url("./srcui/Settingui.qml");
    #endif
    qw->setSource(url);
}

    // auto mw = new QMainWindow();
    // auto qw = new QQuickWidget();
    // mw->setCentralWidget(qw);
    // // mw->show();
    // qw->setSource(QUrl("./srcui/Settingui.qml"));
    // mw->show();
    // // if (true) { return app.exec(); }

// \see https://stackoverflow.com/questions/43234163/how-to-insert-qml-view-in-a-qwidget

void MainWindow2::setQmlAppWindow(QQmlApplicationEngine* qmlae) {
    auto m_engine = qmlae;
    QWindow *qmlWindow = qobject_cast<QWindow*>(m_engine->rootObjects().at(0));
    QWidget *container = QWidget::createWindowContainer(qmlWindow, this);
    container->setMinimumSize(200, 200);
    container->setMaximumSize(1200, 900);
    // ui->verticalLayout->addWidget(container);
    uiw->tabWidget->insertTab(0, container, "qmlapw");
    uiw->tabWidget->setCurrentIndex(0);
}
