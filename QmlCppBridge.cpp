

#include <QtQml>

#include "QmlCppBridge.h"

// 
//qmlRegisterType<QmlCppBridge>("QmlCppBridge", 1, 0, "QmlCppBridge");

// works
auto QmlCppBridgeQmlType = qmlRegisterType<QmlCppBridge>("QmlCppBridge", 1, 0, "QmlCppBridge");

QObject *qmlrootwin = nullptr;
auto qcbrg = new QmlCppBridge();
QmlCppBridge* QmlCppBridge::inst() { return qcbrg; }
// QObject::connect(QmlCppBridge::inst(), &QmlCppBridge::callqml, qmlwin, "oncallqml(QString)");
void QmlCppBridge::setrootwin(QObject*rw) {
    qmlrootwin = rw;
    QObject::connect(QmlCppBridge::inst(), SIGNAL(callqml(QVariant)), rw, SLOT(oncallqml(QVariant)));
}

extern "C" { char* qmlinvokenative(char*); }

QString QmlCppBridge::invoke(QString jstr) {
        qDebug()<<"hello invoked"<<jstr;
        auto str2 = "'"+jstr+"'" + QString(" brg added");
        auto res = qmlinvokenative(str2.toUtf8().data());
        return QString(res);
}

// call qml slot/function
void qtemitcallqmlcxx(QString str) {
    emit qcbrg->callqml(str);
}

extern "C"
void qtemitcallqml(char* str) { qtemitcallqmlcxx(QString(str)); }
