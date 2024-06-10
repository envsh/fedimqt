#ifndef _QML_CPP_BRIDGET_
#define _QML_CPP_BRIDGET_

#include <QObject>
#include <QDebug>
#include <QtQml>


class QmlCppBridge : public QObject {
    Q_OBJECT;
public:
    Q_INVOKABLE static void invoke(QString jstr) {
        qDebug()<<"hello invoke from qml"<<jstr;
    }

    static void regist() {
        qmlRegisterType<QmlCppBridge>("QmlCppBridge", 1, 0, "QmlCppBridge");
    }
    static QmlCppBridge* inst();
    static void setrootwin(QObject*);
signals:
    void callqml(QVariant str); // 必须 QVariant，否则connect找到
};


#endif
