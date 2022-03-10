#-*- coding: utf-8 -*-
# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
from PySide6 import QtCore, QtGui, QtWidgets
from dataclasses import dataclass

# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
class ScaledLayout():
    def __init__(self,parent):  # parent required!
        self.arr = []
        geom = parent.geometry()
        self.oldParentSize = QtCore.QSizeF(geom.width(),geom.height())

    def deleteWidget(self,widget):
        for i in self.arr:
            if widget == i.widget:
                self.arr.remove(i) # remove from the array
                break
    
    def addWidget(self,widget):
        name = "unknown"
        try:
            if widget.objectName() != None:
                name = widget.objectName()
        except:
            print("widget has no object name")
        #
        # some children of widgets are not "widgets" and won't
        # have any geometry. The 'except' will take care of
        # that
        #
        try:
            geom = widget.geometry()
            font = widget.font()
            data = WidgetData(name,
                              widget,
                              geom.width(),
                              geom.height(),
                              geom.x(),
                              geom.y(),
                              font.pixelSize())
            self.arr.append(data)
        except:
            print("widget has no geometry")
    
    #
    # qrect is the geometry of the parent widget
    # this is called when the geometry changes
    #
    def setGeometry(self,qrect):
        for data in self.arr:
            widget=data.widget
            widget.setGeometry(self.reScale(data,qrect))
            if data.fontSize != -1:
                font = widget.font()
                if data.fontSize >= 1:
                    font.setPixelSize(data.fontSize)
                    widget.setFont(font)
        self.oldParentSize.setWidth(float(qrect.width()))
        self.oldParentSize.setHeight(float(qrect.height()))

    #
    # resize and re-position the widget
    #
    def reScale(self,data,parentRect):
        wScale = float(parentRect.width()) / self.oldParentSize.width()
        hScale = float(parentRect.height()) / self.oldParentSize.height()
        w    = data.w  * wScale
        h    = data.h  * hScale
        x    = data.x  * wScale
        y    = data.y  * hScale
        data.w = w
        data.h = h
        data.x = x
        data.y = y
        if data.fontSize != -1:
            data.fontSize = hScale * data.fontSize
            # fontsize can lose precision, restore the original value
            # here if the width is within 20 pixels
            if parentRect.width() > data.originalWidth - 10 and parentRect.width() < data.originalWidth + 10:
                data.fontSize = data.originalFontSize
        return QtCore.QRect(x,y,w,h)

# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
# For Qt Group widgets
# something to hold the scaled layout and the group widget
@dataclass
class Group:
    scaledLayout : ScaledLayout
    group        : QtWidgets.QGroupBox

# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
# The item's width, height, and position must be
# preserved as floating point values. The normal
# geometry uses ints. We will lose resolution
# with every resize if we use that, so save as floats.
#
class WidgetData():
    def __init__(self,name, item, width, height, xpos, ypos, fontSize):
        self.name = name
        self.widget = item
        self.w = float(width)
        self.h = float(height)
        self.x = xpos
        self.y = ypos
        self.fontSize = float(fontSize)
        self.originalFontSize = float(fontSize)
        parentWidget = item.parent()
        self.originalWidth = parentWidget.width()


# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
# This is the container widget that will resize all child widgets
class PlacerWidget(QtWidgets.QWidget):

    def __init__(self,parent = None):
       super(PlacerWidget, self).__init__(parent)
       self.scaledLayout = None
       self.fontSize = 0
       self.groups = []

    #
    # only widgets have geometry
    #
    def isWidget(self,widget):
        isA = True
        try:
            geom = widget.geometry()
        except:
            isA = False
        return isA

    #
    # To add a group widget, we need to add all the children
    # of the group
    #
    def addGroup(self,group,parentWidget = None):
        kids = group.children()
        if len(kids) > 0:
            if parentWidget == None:
                parent = group
            else:
                parent = parentWidget
            scaledLayout = ScaledLayout(parent)
            self.addChildren(group,scaledLayout)
            g = Group(scaledLayout,parent)
            self.groups.append(g)

    #
    # add all child widgets to the scaled layout
    #
    def addChildren(self,parent,scaledLayout):
        list = parent.children()
        for w in list:
            if self.isWidget(w):
                name = w.__class__.__name__
                if  name == 'QGroupBox' or name == 'QFrame':
                    self.addGroup(w)
                elif name == 'QTabWidget':
                    for i in range(w.count()):
                        tab = w.widget(i)
                        self.addGroup(tab,w)
                self.adjustFont(w)
                scaledLayout.addWidget(w)
    #
    # You can set the font size of every widget by calling
    # this function.  Every font added will then have the
    # specfied font size, and the font will be resizeable.
    # Setting it back to 0 will cancel the function.
    #
    def setFontSize(self,size):
        self.fontSize = size

    def adjustFont(self,widget):
        if self.fontSize > 0:
            font = widget.font()
            font.setPixelSize(self.fontSize)
            widget.setFont(font)

    #
    # Call delete only after "show" has been called.
    # Otherwise there is no scaledLayout
    #
    def deleteChild(self,w):
        # remove the widget from the layout
        self.scaledLayout.deleteWidget(w)
        # delete the widget
        w.deleteLater()

    #
    # We create a new scaled layout the first time a
    # resize() is called. All the child widgets should be
    # present at this time.
    #
    def newScaledLayout(self):
        if self.scaledLayout == None:
            self.scaledLayout = ScaledLayout(self)
            self.addChildren(self,self.scaledLayout)

    def resizeGroups(self):
        for g in self.groups:
            layout = g.scaledLayout
            geom   = g.group.geometry()
            layout.setGeometry(geom)

    def resizeEvent(self,event):
        self.newScaledLayout()
        self.scaledLayout.setGeometry(self.rect())
        self.resizeGroups()

# simple test
if __name__ == '__main__':
    import sys
    app = QtWidgets.QApplication(sys.argv)
    w = PlacerWidget(None)
    w.setFontSize(12)
    w.resize(600,400)

    b = QtWidgets.QPushButton("BUTTON 1",w)
    b.move(40,40)
    b.resize(200,100)
            
    b = QtWidgets.QPushButton("BUTTON 2",w);
    b.move(300,40)
    b.resize(200,100)

    # test if delete works
    b = QtWidgets.QPushButton("BUTTON 3",w);
    b.move(40,200)
    b.resize(200,100)

    w.show()
    w.deleteChild(b)         # only after show!
    sys.exit(app.exec_())
