

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
extern "C" { void qmlcalljsfunc(char*, uintptr_t, char**, uintptr_t*); }

QString QmlCppBridge::invoke(QString jstr) {
        // qDebug()<<"hello invoked"<<jstr<<jstr.length();
        // note: jstr.length() != jstr.toUtf8().length() when have cjk chars
        auto bcc = jstr.toUtf8();
        // qDebug()<<__FUNCTION__<<"(): hello invoked"<<jstr<<bcc.length()<<jstr.length();

        char* retstr = nullptr;
        uintptr_t retlen = 0;
        qmlinvokenative(bcc.data(), bcc.length(), &retstr, &retlen);
        // qDebug()<<__FUNCTION__<<"res"<<retlen;
        auto rv = QString(retstr); // todo get the ownership of retstr
        delete(retstr);
        return rv;
}

QString QmlCppBridge::calljs(QString jstr) {
        // qDebug()<<"hello invoked"<<jstr<<jstr.length();
        // note: jstr.length() != jstr.toUtf8().length() when have cjk chars
        auto bcc = jstr.toUtf8();
        // qDebug()<<__FUNCTION__<<"(): hello invoked"<<jstr<<bcc.length()<<jstr.length();

        char* retstr = nullptr;
        uintptr_t retlen = 0;
        qmlcalljsfunc(bcc.data(), bcc.length(), &retstr, &retlen);
        // qDebug()<<__FUNCTION__<<"res"<<retlen;
        auto rv = QString(retstr); // todo get the ownership of retstr
        // delete(retstr); // go auto free now
        return rv;
}



// call qml slot/function
void qtemitcallqmlcxx(QString str) {
    emit qcbrg->callqml(str);
}

extern "C"
void qtemitcallqml(char* jstr) { 
    // qDebug()<<__FUNCTION__<<"emitqml"<<strlen(jstr)<<jstr;
    auto s = QString(jstr); // todo get the ownership of retstr
    // delete(jstr); // go auto free now
    qtemitcallqmlcxx(s);
}
