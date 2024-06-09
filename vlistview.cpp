
#include "ui_vlistview.h"

#include "myitemdg.h"
#include "vlistview.h"
#include <QtWidgets>
#include <QThread>

QStringListModel *slm = new QStringListModel();
vlistview::vlistview(QWidget*parent) : QMainWindow(parent) {
    ui.setupUi(this);
    ui.listView->setItemDelegate(new Myitemdg(0));
    ui.listView->setModel(slm);
}

class WorkerThread : public QThread
{
    Q_OBJECT
    void run() override {
        QString result;
        /* ... here is the expensive or blocking operation ... */
        // emit resultReady(result);
        QStringList lst;
        for (int i=0; i < 23400 ;i++) {
            if (i > 600) {
            // usleep(300);
            }
            // qDebug()<<"hehehhe"<<i;
            char buf[102] = {0};
            sprintf(buf, "string value %d\0", i);
            // slm << QString(buf);
            auto s = QString(buf);
            lst << s;
            
        }
        slm->setStringList(lst);
    }
signals:
    // void resultReady(const QString &s);
};
#include "vlistview.moc"

void vlistview::filldata() {
    (new WorkerThread)->start();
}

// class vlistview : public QMainWindow {
//     Q_OBJECT;
// public:
//     // Ui::MainWindow ui;
// public slots:

// };
// #include "vlistview.moc"
