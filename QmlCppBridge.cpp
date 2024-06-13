

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

extern "C" { void qmlinvokenative(char*, uintptr_t, char**, uintptr_t*); }

QString QmlCppBridge::invoke(QString jstr) {
        // qDebug()<<"hello invoked"<<jstr<<jstr.length();
        // note: jstr.length() != jstr.toUtf8().length() when have cjk chars
        auto bcc = jstr.toUtf8();
        qDebug()<<"hello invoked"<<jstr<<bcc.length()<<jstr.length();

        char* retstr = nullptr;
        uintptr_t retlen = 0;
        qmlinvokenative(bcc.data(), bcc.length(), &retstr, &retlen);
        // qDebug()<<"res"<<retlen;
        auto rv = QString(retstr); // todo get the ownership of retstr
        delete(retstr);
        return rv;
}

// call qml slot/function
void qtemitcallqmlcxx(QString str) {
    emit qcbrg->callqml(str);
}

extern "C"
void qtemitcallqml(char* jstr) { 
    // qDebug()<<"emitqml"<<strlen(jstr)<<jstr;
    auto s = QString(jstr); // todo get the ownership of retstr
    delete(jstr);
    qtemitcallqmlcxx(s);
}
