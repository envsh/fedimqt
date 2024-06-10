

#include <QtQml>

#include "QmlCppBridge.h"

// 
//qmlRegisterType<QmlCppBridge>("QmlCppBridge", 1, 0, "QmlCppBridge");

// works
auto QmlCppBridgeQmlType = qmlRegisterType<QmlCppBridge>("QmlCppBridge", 1, 0, "QmlCppBridge");

