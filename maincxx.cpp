
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


#include "QmlCppBridge.h"

QQmlApplicationEngine* qmlapp = nullptr;
// itis cgofunc
extern "C" QQmlApplicationEngine* qmlappenginenew(int step);

void onQmlAppEngineCreated(QObject *obj, const QUrl &objUrl) {
    auto url = objUrl;
                        qDebug()<<__FUNCTION__<<"QmlAppEngine created";
                        QString resmsg = QString("QmlAppEngineOK %1").arg(objUrl.toString());
                        if (!obj && url == objUrl) {
                            resmsg = QString("load error exit %1").arg(objUrl.toString());
                            qDebug()<<__FUNCTION__<<"load error exit"<<objUrl;
                            QCoreApplication::exit(-1);
                        }
                        qtemitcallqmlcxx(resmsg);

    auto engine = qmlapp;
    auto rootobjs = engine->rootObjects();
    // qDebug()<<__FUNCTION__<<rootobjs; // only one
    auto rootobj = rootobjs.value(0); // it's main.qml
    auto uiofnt = rootobj->findChild<QObject*>(QString("Aboutuint"));
    qDebug()<<__FUNCTION__<<uiofnt;
    qmlappenginenew(3);
}



extern "C"
int maincxxqml(int argc, char**argv) {
    // QmlCppBridge::regist();
    QGuiApplication app (argc, argv, 0);

    // QT_DEBUG_PLUGINS=1 DYLD_PRINT_LIBRARIES=1 ./exe
    // QQmlApplicationEngine engine;
    QQmlApplicationEngine *engine = qmlappenginenew(0) ;
    qmlapp = engine;

    // engine.loadFromModule("QtQuick", "Rectangle"); //  No module named "QtQuick" found???
    // const QUrl url(u"qrc:/alarms/main.qml"_s);
    // const QUrl url("qrc:/alarms/main.qml");
    #ifdef Q_OS_ANDROID
    const QUrl url("qrc:///mainqml/main.qml");
    #else
    const QUrl url("./main.qml");
    #endif
    qDebug()<<__FUNCTION__<<"():"<<"main.qml:"<<url;
    QObject::connect(engine, &QQmlApplicationEngine::objectCreated, &app,
                     [url](QObject *obj, const QUrl &objUrl) {
                        onQmlAppEngineCreated(obj, objUrl);
                     },
                     Qt::QueuedConnection);

    // run flow return back to go
    qmlappenginenew(1);

    // QQmlEngine::addImportPath();
    // QQmlEngine::importPathList();
    auto qmldirs = engine->importPathList();
    qDebug()<<__FUNCTION__<<"():"<<"qmldirs:"<<qmldirs;

    engine->load(url);

     // should be ApplicationWindow in main.qml
    auto rootobj = engine->rootObjects().value(0);
    // qDebug()<<rootobj;
    QmlCppBridge::setrootwin(rootobj);
    qtemitcallqmlcxx(QString("hello this c++, ")+QString(QT_VERSION_STR));

    qmlappenginenew(2);
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
