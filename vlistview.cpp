
#include "ui_vlistview.h"

#include "myitemdg.h"
#include "vlistview.h"
#include <QtWidgets>
#include <QThread>

QStringListModel *slm = new QStringListModel();
QGraphicsScene *scene = 0;
vlistview* vlstv = 0;
vlistview::vlistview(QWidget*parent) : QMainWindow(parent) {
    ui.setupUi(this);
    ui.listView->setItemDelegate(new Myitemdg(0));
    ui.listView->setModel(slm);
    // 重叠，并且CPU没有降低？？？
    // 可能是背景没有清，有重叠吧。这可能是一种减少滚动CPU的方法。
    // ui.listView->viewport()->setAttribute(Qt::WA_OpaquePaintEvent, true);
    
    scene = new QGraphicsScene();
    // scene->setItemIndexMethod(QGraphicsScene::NoIndex); // CPU 50%=>100%!!!
    scene->addText(QString("hahahhasssss%1").arg(123));
    // ui.graphicsView->setScene(scene);
    vlstv = this;
}
void vlistview::setscene() {
    ui.graphicsView->setScene(scene);
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
            
            if (i < 30000) {
                // 占用内存比较多，而且CPU也没见少。
                // auto item = scene->addText(QString("haha呵呵呵sss%1").arg(i));
                // item->setCacheMode(QGraphicsItem::ItemCoordinateCache);
                // item->setPos(0, 20+100*i);
            }
        }
        slm->setStringList(lst);
        vlstv->setscene();
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
