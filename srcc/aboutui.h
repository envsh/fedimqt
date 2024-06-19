#ifndef _ABOUTUI_H_
#define _ABOUTUI_H_

#include <QObject>

class Aboutuint : public QObject {
    Q_OBJECT;
    // depends on non-NOTIFYable properties??? // add CONSTANT
    // Q_PROPERTY(QString name READ name WRITE setName FINAL);
    Q_PROPERTY(QString qtrtver READ qtrtver CONSTANT FINAL);
    Q_PROPERTY(QString qtctver READ qtctver CONSTANT FINAL);
    QML_ELEMENT;

public:
    Aboutuint(QObject*parent= nullptr);
    QString qtrtver();
    QString qtctver();
    // void setQtrtver(QString v) {}
    // void setQtctver(QString v) {}

    Q_INVOKABLE static QString qtver(bool rt);

};

#endif //_ABOUTUI_H_
