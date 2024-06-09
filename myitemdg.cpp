
#include "myitemdg.h"

Myitemdg::Myitemdg(QObject*p) : QAbstractItemDelegate(p) {

}

void	Myitemdg::paint(QPainter *painter, const QStyleOptionViewItem &option, const QModelIndex &index) const {
    // return;
    // qDebug()<<"dgpaint"<<index<<painter->viewport();
    auto data = index.data();
    // qDebug()<<__FUNCTION__<<data<<index<<option.rect;
    int row = index.row();
    auto rect = option.rect;
        int x = rect.x()+30;
        int y = rect.y()+30;
        int w = rect.width();
        int h = rect.height();
        // painter->eraseRect(x, y, w, h);
        painter->drawText(x, y, QString("%1hello世界!!!%2").arg(data.toString()).arg(row));
}
    QSize	Myitemdg::sizeHint(const QStyleOptionViewItem &option, const QModelIndex &index) const  {
        // qDebug()<<"dgsizehint"<<index;
        int h = 60+QRandomGenerator::global()->generate()%100;
        auto rv = QSize(option.rect.width(),h);
        // qDebug()<<rv;
        return rv;
        // return QSize(200,100);
    }