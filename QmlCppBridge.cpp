

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

// call qml slot/function
extern "C"
void qtemitcallqml(QString str) {

    emit qcbrg->callqml(str);
}
