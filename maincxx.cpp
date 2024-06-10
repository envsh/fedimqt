
#include <QtCore>
// #include <QtGui>
#include <QtWidgets>
#include <QtQml>
#include <QtQuick>

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

// QT_DEBUG_PLUGINS=1 DYLD_PRINT_LIBRARIES=1 ./exe

extern "C"
int maincxxqml2(int argc, char**argv) {
    QGuiApplication app (argc, argv, 0);

    // QQuickView does not support using a window as a root item.
    auto mw = new QWindow();
    QQuickView view(mw);
    view.setSource(QUrl("./main.qml"));
    view.show();

    return app.exec();
}
