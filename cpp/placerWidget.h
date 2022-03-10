//-*-c++-*-

///////////////////////////////////////////////////////////////////////////
//
// The PlacerWidget class allows you to create a dialog, placing
// the widgets wherever you want.  The Widgets will automatically
// resize when the dialog is resized.
//
// NOTES:
// 1. Do NOT add Layout widgets to your design. The whole
//    point of this is to avoid them.
// 2. For fonts to resize, you must call placerWidget->setFontSize(),
//    Otherwise they keep the same font attributes as set
//    in the .ui file.
// 3. YOU MUST CALL setObjectName() for widgets that are added
//    without using the designer.
//
// See the main.cpp example.
// 
// Qt note: Qt Fonts will resize if their size is set via
// setPixelSize() but not setPointSize() (which is the default).
// Calling placerWidget->setFontSize() will change all fonts to
// use setPixelSize() and ignore all other font size attributes.
//
///////////////////////////////////////////////////////////////////////////

#ifndef PLACERWIDGET_H
#define PLACERWIDGET_H

#include <iostream>
#include <QWidget>
#include <QList>
#include <QMap>
#include <QObjectList>
#include <QStyle>
#include <QGroupBox>
#include <QTabWidget>
#include <QLabel>
#include <QDialog>
#include <QGraphicsView>
#include <QAbstractGraphicsShapeItem>
#include <QGraphicsScale>
#include <QDialogButtonBox>
#include <QToolButton>
#include <QPushButton>
#include <QDebug>

#include <iostream>

//
// Newer Qt Versions have a static QPixmap, but older ones do not.
// In addition to being "clickable," this class also contains a
// static QPixmap, required to keep scaling consistant.
//
class ClickableLabel : public QLabel { 
    Q_OBJECT 

  public:
    explicit ClickableLabel(QWidget* parent = Q_NULLPTR
                            ,Qt::WindowFlags f = Qt::WindowFlags()):QLabel(parent) {}

    void scale(void) {
        QLabel::setPixmap(_pixmap.scaled(width(),height()));
    }

  public slots:
    void setPixmap(const QPixmap &pixmap) { _pixmap = pixmap; }
    
  signals:
    void clicked();

  protected:
    QPixmap _pixmap;
    void mousePressEvent(QMouseEvent* event) {
        emit clicked();
    }

};

class ScaledLayout {

    class WidgetData {
      public:
        QString _name;
        QWidget *_widget;
        float _w;
        float _h;
        float _x;
        float _y;
        float _fontSize;
        float _originalFontSize;
        float _originalWidth;
        float _originalHeight;
        QSize _iconSize;
        WidgetData(const QString &name, QWidget *item, int width, int height,
                   int xpos, int ypos, float fontSize) {
            _name = name;
            _widget = item;
            _w = width;
            _h = height;
            _x = xpos;
            _y = ypos;
            _fontSize = fontSize;
            _originalFontSize = fontSize;
            QWidget *parentWidget = qobject_cast<QWidget *>(item->parent());
            _originalWidth = parentWidget->width();
            _originalHeight = parentWidget->height();
        }
    };

  public:

    QList<WidgetData *>      _arr;
    QSizeF                    _oldParentSize;
    ScaledLayout(QWidget *parent) { // parent required!
        if (parent != nullptr) {
            QRect geom      = parent->geometry();
            _oldParentSize.setWidth(geom.width());
            _oldParentSize.setHeight(geom.height());
        }
    }

//
// Just remove the data from the list, don't delete the widget.
// The calling function should take care of that.
//
    void deleteWidget(QWidget *widget) {
        using namespace std;
        for (int i = 0; i < _arr.size(); ++i) {
            WidgetData *data = _arr.at(i);
            if (widget == data->_widget) {
                _arr.removeAt(i);
                delete data;
                break;
            }
        }
    }

    void setWidgetFontSize(QWidget *widget, float size) {
        using namespace std;
        for (int i = 0; i < _arr.size(); ++i) {
            WidgetData *data = _arr.at(i);
            if (widget == data->_widget) {
                data->_fontSize = size;
                data->_originalFontSize = size;
                break;
            }
        }
    }
    
    void addWidget(QWidget *widget)
    {
        using namespace std;

        QString name = "unknown";
        try {
            if (widget->objectName() != "") {
                name = widget->objectName();
            }
        }
        catch (...) {
            std::cout << "widget has no object name" << std::endl;
        }
        
    //
    // some children of widgets are not "widgets" and won't
    // have any geometry. The 'catch' will take care of
    // that
    //
        try {
            QRect geom = widget->geometry();
            QFont font = widget->font();
            WidgetData *data = new WidgetData( name,
                                               widget,
                                               geom.width(),
                                               geom.height(),
                                               geom.x(),
                                               geom.y(),
                                               font.pixelSize());
        // toolbuttons can have icons
            QToolButton *toolbutton = qobject_cast<QToolButton *>(widget);
            if (toolbutton) {
                data->_iconSize = toolbutton->iconSize();
            }
            QPushButton *pushbutton = qobject_cast<QPushButton *>(widget);
            if (pushbutton) {
                data->_iconSize = pushbutton->iconSize();
            }

            _arr << data;
        } catch(...) {
            std::cout << "widget has no geometry" << std::endl;
        }
    }
    
//
// qrect is the geometry of the parent widget.
// This will be called when the geometry changes.
//
    void setGeometry(QRect qrect) {

        for (int i = 0; i < _arr.size(); ++i) {
            WidgetData *data = _arr.at(i);
            QWidget *widget = data->_widget;
            QString name = widget->objectName();
        //
        // some object without a name will screw up the display
        // if it's geometry is set.  I don't know what
        // widget it's talking about.
        //
        // If you add a widget directory, be certain to call
        // setObjectName() (the designer does it automatically)
        //
            if (name != "") {
                widget->setGeometry(reScale(data,qrect));
            }

        //
        // Clickable Labels - see class definition above
        //
            ClickableLabel *clickableLabel = dynamic_cast<ClickableLabel *>(widget);
            if (clickableLabel) {
                clickableLabel->scale();
            }

        //
        // regular labels that contain pixmaps.
        //
            QLabel *label = dynamic_cast<QLabel *>(widget);
            if (label) {
                const QPixmap *pixmapConst = label->pixmap();
                if (pixmapConst) {
                    int w = label->width();
                    int h = label->height();
                    label->setPixmap(pixmapConst->scaled(w,h));
                }
            }
            
        //
        // QToolButtons can contain icons
        //
            QToolButton *toolbutton = dynamic_cast<QToolButton *>(widget);
            if (toolbutton) {
                QSize sz = toolbutton->iconSize();
                float wscale = (float)qrect.width() / (float)data->_originalWidth;
                float hscale = (float)qrect.height() / (float)data->_originalHeight;
                sz.setWidth(data->_iconSize.width()*wscale);
                sz.setHeight(data->_iconSize.height()*hscale);
                toolbutton->setIconSize(sz);
            }

        //
        // QPushButtons can also contain icons
        //
            QPushButton *pushbutton = qobject_cast<QPushButton *>(widget);
            if (pushbutton) {
                QIcon icon = pushbutton->icon();
                if (!icon.isNull()) {
                    QSize sz = pushbutton->iconSize();
                    float wscale = (float)qrect.width() / (float)data->_originalWidth;
                    float hscale = (float)qrect.height() / (float)data->_originalHeight;
                    sz.setWidth(data->_iconSize.width()*wscale);
                    sz.setHeight(data->_iconSize.height()*hscale);
                    pushbutton->setIconSize(sz);
                }
            }

        // re-scale a graphicview
            QGraphicsView *view = dynamic_cast<QGraphicsView *>(widget);
            if (view) {
                float wscale = (float)qrect.width() / (float)data->_originalWidth;
                float hscale = (float)qrect.height() / (float)data->_originalHeight;
                // std::cout << "wscale " << wscale << " " << hscale << std::endl;
#if QT_VERSION >= 0x060000
                view->resetTransform();
#else
                view->resetMatrix();
#endif
                view->scale(wscale,hscale);
            }

            if (data->_fontSize != -1) {
                QFont font = widget->font();
                if (data->_fontSize >= 1)
                    font.setPixelSize(data->_fontSize);
                widget->setFont(font);
            }
        }            

        _oldParentSize.setWidth(qrect.width());
        _oldParentSize.setHeight(qrect.height());

    }

//
// resize and re-position one widget, called by setGeometry
// 
    QRect reScale(WidgetData *data,QRect parentRect) {

        float wScale = parentRect.width()  / _oldParentSize.width();
        float hScale = parentRect.height() / _oldParentSize.height();
        float w    = data->_w  * wScale;
        float h    = data->_h  * hScale;
        float x    = data->_x  * wScale;
        float y    = data->_y  * hScale;
        data->_w = w;
        data->_h = h;
        data->_x = x;
        data->_y = y;
        if (data->_fontSize != -1) {
            data->_fontSize = hScale * data->_fontSize;
        // fontsize can lose precision, restore the original value here if the width is
        // within 20 pixels
            if ((parentRect.width() > data->_originalWidth - 10) && (parentRect.width() < data->_originalWidth + 10)) { 
                data->_fontSize = data->_originalFontSize;
            }
        }
        return QRect(x,y,w,h);
    }

};

class Placer {

  protected:

    struct Group {
        QWidget      *_group;
        ScaledLayout *_scaledLayout;
    };
    QList<Group>     _groups;
    ScaledLayout     *_scaledLayout;
    int              _fontSize;
    QWidget          *_widget;
    
  public:

    Placer(QWidget *widget) {
        _widget = widget;
        _scaledLayout = nullptr;
        _fontSize     = 0;
    }

//
// You can set the font size of every widget by calling
// this function.  Every widget added will then have the
// specfied font size, and the font will be resizeable.
// Setting it back to 0 will cancel the function.
//
    void setFontSize(int size) {
        _fontSize = size;
    }

//
// You can change the font size of an individual widget,
// BUT ONLY AFTER show() has been called.
// The _scaledLayout is only created after show
//
    void setWidgetFontSize(QWidget *widget, float size) {
        if (_scaledLayout)
            _scaledLayout->setWidgetFontSize(widget, size);
        else
            std::cout << "error, scaled layout not created yet" << std::endl;
    }

//
// Add a group widget to a scaled layout.  We can specify a
// different parent to scale from if needed (e.g. tabWidgets)
//
    void addGroup(QWidget *group,QWidget *parent = nullptr) {
        QString name = group->objectName();
        if (group->children().size() > 0) {
            ScaledLayout *scaledLayout = new ScaledLayout(parent == nullptr ? group : parent);
            addChildren(group,scaledLayout);
            struct Group g;
            g._group = (parent == nullptr ? group : parent);
            g._scaledLayout = scaledLayout;
            _groups.push_back(g);
        }
    }

//
// add all child widgets to the scaled layout
//
    void addChildren(QWidget *parent,ScaledLayout *scaledLayout) {

        QObjectList list = parent->children();
        for (int i = 0; i < list.size(); ++i) {
            QObject *data = list.at(i);
            QWidget *widget = qobject_cast<QWidget *>(data);
            if (widget == nullptr) continue;

        //
        // add all the widgets that MIGHT have children
        // addGroup() will check if there are actual
        // children
        // 
            QGroupBox *group = qobject_cast<QGroupBox *>(data);
            if (group != nullptr) {
                addGroup(group);
            }
            QFrame *frame = qobject_cast<QFrame *>(data);
            if (frame != nullptr) {
                addGroup(frame);
            }
        //
        // For tab widgets, you need to add each tab as a group.
        // You must also set the QTabWidget as the parent of the
        // tab-group, else the resize will be too small
        //
            QTabWidget *tabWidget = qobject_cast<QTabWidget *>(data);
            if (tabWidget) {
                adjustFont(tabWidget);
                for (int i=0; i< tabWidget->count(); ++i) {
                    QWidget *tab = tabWidget->widget(i);
                    addGroup(tab,tabWidget);
                }
            }

            if (widget) {           
                adjustFont(widget);
                scaledLayout->addWidget(widget);
            }
        }
    }

//
// You can add widgets after show() has been called
// by using add()
//
    void add(QWidget *widget) {
        adjustFont(widget);
        if (_scaledLayout != nullptr)
            _scaledLayout->addWidget(widget);
        widget->show();
    }
    void addWidget(QWidget *widget) {
        add(widget);
    }

//
// Call delete only after "show" has been called.
// Otherwise there is no scaledLayout
//
    void deleteChild(QWidget *child) {
        if (_scaledLayout != nullptr) {
            _scaledLayout->deleteWidget(child);
            delete child;
        }
    }
    
  protected:

//
// We create a new scaled layout the first time that resize
// is called, which will automatically happen after show()
// is called. All the child widgets are added.
//
    void newScaledLayout(void) {
        if (_scaledLayout == nullptr) {
            _scaledLayout = new ScaledLayout(_widget);
            addChildren(_widget,_scaledLayout);
        }
    }

    void resizeGroups(void) {
        for (auto g: _groups) {
            g._scaledLayout->setGeometry(g._group->geometry());
        }
    }

    void adjustFont(QWidget *widget) {
        if (_fontSize > 0) {
            QFont font = widget->font();
            font.setPixelSize(_fontSize);
            widget->setFont(font);
        }
    }

};

//
// To force a resize:
//
// QMainWindow *win;
//  win->resize(win->geometry().width(), win->geometry().height()+1);
//  win->resize(win->geometry().width(), win->geometry().height()-1);
//
class PlacerWidget : public QWidget, public Placer {

    Q_OBJECT

  public:

    PlacerWidget(QWidget *parent = nullptr):QWidget(parent),Placer(this) {
    }

    virtual void resizeEvent(QResizeEvent *event) {
        resize();
    }
    void resize(void) {
        newScaledLayout();
        _scaledLayout->setGeometry(rect());
        resizeGroups();
    }

    void resize(const QRect &rect) {
        newScaledLayout();
        _scaledLayout->setGeometry(rect);
        resizeGroups();
    }


};


// TODO: fonts inside of QDialogButtonBox do not change
class PlacerDialog : public QDialog, public Placer {
    Q_OBJECT

  public:

    PlacerDialog(QWidget *parent = nullptr):QDialog(parent),Placer(this) {
    }

    virtual void resizeEvent(QResizeEvent *event) {
        newScaledLayout();
        _scaledLayout->setGeometry(rect());
        resizeGroups();
    }
  public Q_SLOTS:
    virtual void accept() { return QDialog::accept(); }
    virtual void reject () { return QDialog::reject(); }
};

#endif //PLACERWIDGET_H
