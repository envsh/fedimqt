#ifndef _QML_CPP_BRIDGET_
#define _QML_CPP_BRIDGET_

#include <QObject>
#include <QDebug>
#include <QtQml>


// qml 调用cxx/go，有返回值，但都是string
// cxx/go 调用 qml，没有返回
class QmlCppBridge : public QObject {
    Q_OBJECT;
public:
    Q_INVOKABLE static QString invoke(QString jstr);

    static void regist() {
        qmlRegisterType<QmlCppBridge>("QmlCppBridge", 1, 0, "QmlCppBridge");
    }
    static QmlCppBridge* inst();
    static void setrootwin(QObject*);
signals:
    void callqml(QVariant str); // 必须 QVariant，否则connect找到
};


#endif
