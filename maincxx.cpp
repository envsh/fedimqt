
#include <QtCore>
// #include <QtGui>
#include <QtWidgets>

#include "vlistview.h"

extern "C"
int maincxx(int argc, char**argv) {
    QApplication app (argc, argv, 0);

    auto mw = new vlistview(0);
    mw->show();
    mw->filldata();
    
    // auto btn = new QPushButton("hello 世界!!!");
    // btn->show();

    return app.exec();
}
