
#include <QtCore>
// #include <QtGui>
#include <QtWidgets>
#include <QtQml>

#include "vlistview.h"

extern "C"
int maincxxwgt(int argc, char**argv) {
    QApplication app (argc, argv, 0);

    auto mw = new vlistview(0);
    mw->show();
    mw->filldata();

    // auto btn = new QPushButton("hello 世界!!!");
    // btn->show();

    return app.exec();
}



extern "C"
int maincxxqml(int argc, char**argv) {
    QGuiApplication app (argc, argv, 0);

    // QT_DEBUG_PLUGINS=1 DYLD_PRINT_LIBRARIES=1 ./exe
    QQmlApplicationEngine engine;
    // engine.loadFromModule("QtQuick", "Rectangle"); //  No module named "QtQuick" found???
    // const QUrl url(u"qrc:/alarms/main.qml"_s);
    // const QUrl url("qrc:/alarms/main.qml");
    const QUrl url("./main.qml");
    qDebug()<<url;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app,
                     [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl) {
                            qDebug()<<"load error exit"<<objUrl;
                            QCoreApplication::exit(-1);
                         }
                     },
                     Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

