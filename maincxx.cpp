
#include <QtCore>
// #include <QtGui>
#include <QtWidgets>
#include <QtQml>
#include <QtQuick>
#include <QQuickWidget>

#include "vlistview.h"
// #include "srcc/modelbase.h"
#include "srcc/mainwindow.h"

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

#include <dlfcn.h>
#include "QmlCppBridge.h"

QQmlApplicationEngine* qmlapp = nullptr;
// itis cgofunc
// extern "C" QQmlApplicationEngine* qmlappenginenew(int step);

void onQmlAppEngineCreated(QObject *obj, const QUrl &objUrl) {

    auto url = objUrl;
    qDebug()<<__FUNCTION__<<"QmlAppEngine created";
    QString resmsg = QString("QmlAppEngineOK %1").arg(objUrl.toString());
    if (!obj && url == objUrl) {
        resmsg = QString("load error exit %1").arg(objUrl.toString());
        qDebug()<<__FUNCTION__<<"load error exit"<<objUrl;
        // todo 也许在UI上显示错误更好
        QCoreApplication::exit(-1); exit(-1);
    }
    qtemitcallqmlcxx(resmsg);

    auto engine = qmlapp;
    auto rootobjs = engine->rootObjects();
    // qDebug()<<__FUNCTION__<<rootobjs; // only one
    auto rootobj = rootobjs.value(0); // it's main.qml
    auto uiofnt = rootobj->findChild<QObject*>(QString("Aboutuint"));
    qDebug()<<__FUNCTION__<<uiofnt;

    typedef int (*fnty)(int);
    auto symx = dlsym(RTLD_DEFAULT, "qmlappenginenew");
    fnty qmlappenginenew = (fnty)symx;

    qmlappenginenew(3);

    // new ListModelBase();
}

// impl in minqt/srcc/mainglob.cpp
extern void initQtmsgout();

#include <QtQml/private/qqmlbuiltinfunctions_p.h>
extern "C"
int maincxxqml(int argc, char**argv) {
    // 需要在 java 里设置...
    setenv("QT_ANDROID_DEBUGGER_MAIN_THREAD_SLEEP_MS", "123", 1);
    initQtmsgout();

    // oldqtmsgoutfn = qInstallMessageHandler(qtMessageOutput);
    // QmlCppBridge::regist();
    // QGuiApplication app (argc, argv, 0);
    QApplication app (argc, argv, 0);

    // auto mw = new vlistview(0);
    // mw->show();
    // // mw->filldata();


    typedef void* (*fnty)(int);
    auto symx = dlsym(RTLD_DEFAULT, "qmlappenginenew");
    fnty qmlappenginenew = (fnty)symx;

    // QT_DEBUG_PLUGINS=1 DYLD_PRINT_LIBRARIES=1 ./exe
    // QQmlApplicationEngine engine;
    QQmlApplicationEngine *engine = (QQmlApplicationEngine *)qmlappenginenew(0) ;
    qmlapp = engine;

    // 相同的，应该是单例
    // auto qtobj = QtObject::create(engine, engine);
    // auto qtobj2 = QtObject::create(engine, engine);
    // qDebug()<<__FUNCTION__<<__LINE__<<qtobj<<qtobj2;

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
    // qDebug()<<(sizeof(QQuickItem));

    engine->load(url);

     // should be ApplicationWindow in main.qml
    auto rootobj = engine->rootObjects().value(0);
    // qDebug()<<rootobj;
    QmlCppBridge::setrootwin(rootobj);
    qtemitcallqmlcxx(QString("hello this c++, ")+QString(QT_VERSION_STR));

    qmlappenginenew(2);

    auto mw = new MainWindow2();
    mw->setQmlAppWindow(engine);
    mw->show();
    // mw->uiw.menubar->show();

    return app.exec();
}

const char* argv[] = {
    "./qtimntexe", "-qmljsdebugger=port:3768", 0,
};

extern "C"
int maincxxqml0() {
    int argc = 2;
    return maincxxqml(argc, (char**)argv);
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
