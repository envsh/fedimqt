#ifndef _myview_h_
#define _myview_h_

#include <QtWidgets>


class Myview : public QAbstractItemView {
    Q_OBJECT;
public:
        Myview(QWidget*p = nullptr);

virtual QModelIndex	indexAt(const QPoint &point) const ;

virtual void	scrollTo(const QModelIndex &index, QAbstractItemView::ScrollHint hint = EnsureVisible) ;
virtual QRect	visualRect(const QModelIndex &index) const ;

// QAbstractItemDelegate *	itemDelegate() const;
// QAbstractItemDelegate *	itemDelegateForColumn(int column) const;
//  virtual QAbstractItemDelegate *	itemDelegateForIndex(const QModelIndex &index) const;
// QAbstractItemDelegate *	itemDelegateForRow(int row) const;

protected:
virtual void paintEvent(QPaintEvent *e);
virtual int	horizontalOffset() const;
virtual bool	isIndexHidden(const QModelIndex &index) const;
virtual QModelIndex	moveCursor(QAbstractItemView::CursorAction cursorAction, Qt::KeyboardModifiers modifiers);
virtual void	setSelection(const QRect &rect, QItemSelectionModel::SelectionFlags flags);

virtual int	verticalOffset() const;

virtual QRegion visualRegionForSelection(const QItemSelection &selection) const;
};

#endif
