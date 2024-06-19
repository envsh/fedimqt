#include <QtQml>

#include "aboutui.h"

// works
auto AboutuiQmlType = qmlRegisterType<Aboutuint>("Aboutuint", 1, 0, "Aboutuint");

Aboutuint::Aboutuint(QObject*parent) : QObject(parent) {}

QString Aboutuint::qtrtver() { return QString(qVersion()); } 
QString Aboutuint::qtctver() { return QString(QT_VERSION_STR); }

QString Aboutuint::qtver(bool rt) {
    if (rt) {
        return qVersion();
    }
    return QT_VERSION_STR;
}
