

#include "myitemdg.h"
#include "myview.h"

Myview::Myview(QWidget*parent) : QAbstractItemView(parent) {
    qDebug()<<"ctor"<<parent;
    auto dg = new Myitemdg(parent);
    setItemDelegate(dg);
    qDebug()<<__FUNCTION__<<dg;
}

void Myview:: paintEvent(QPaintEvent *e) {
    qDebug()<<"paintEvent"<<e;
    auto dg = itemDelegate();
    qDebug()<<"paintEvent"<<dg;
     QStyleOptionViewItem opt;
    QPainter panter(this);
    auto idx = model()->index(3,0);
    dg->paint(&panter, opt, idx);
}

// QAbstractItemDelegate *	Myview::itemDelegate() const {
//     qDebug()<<"itemdg";
// }
// QAbstractItemDelegate *	itemDelegateForColumn(int column) const;
//  virtual QAbstractItemDelegate *	itemDelegateForIndex(const QModelIndex &index) const;
// QAbstractItemDelegate *	itemDelegateForRow(int row) const;


QModelIndex	Myview::indexAt(const QPoint &point) const  {
    
    auto mdl = model();
    qDebug()<<"indexAt"<<point<<mdl->rowCount();
    return mdl->index(3,0);
    return QModelIndex();
}

void	Myview::scrollTo(const QModelIndex &index, QAbstractItemView::ScrollHint hint ) {
qDebug()<<"scrollTo"<<index << hint;
}
 
QRect	Myview::visualRect(const QModelIndex &index) const {
qDebug()<<"visualRect"<<index;
return QRect(0,0, 300, 150);
return QRect();
 }


int	Myview::horizontalOffset() const {
    qDebug()<<"horizontalOffset";
    return 0;
}
bool	Myview::isIndexHidden(const QModelIndex &index) const {
    return false;
}
QModelIndex	Myview::moveCursor(QAbstractItemView::CursorAction cursorAction, Qt::KeyboardModifiers modifiers) {
qDebug()<<"moveCursor" ;
return QModelIndex();

}
void	Myview::setSelection(const QRect &rect, QItemSelectionModel::SelectionFlags flags) {
    qDebug()<<"setSelection" ;
}

int	Myview::verticalOffset() const {
    qDebug()<<"verticalOffset" ;
    return 0;
}

QRegion Myview::visualRegionForSelection(const QItemSelection &selection) const {
qDebug()<<"visualRegionForSelection" ;
return QRegion();
}
