require 'Qt'

class ScaledLayout

    #
    # The item's width, height, and position must be
    # preserved as floating point values. The normal
    # geometry uses ints, and we will lose resolution
    # with every resize if we use that.
    #
    class WidgetData
        attr_accessor :name, :widget, :w, :h, :x, :y, :fontSize,
                      :originalFontSize, :originalWidth
        
        def initialize(name, item, width, height, xpos, ypos, fontSize)
            @name = name
            @widget = item
            @w = width.to_f
            @h = height.to_f
            @x = xpos
            @y = ypos
            @fontSize = fontSize.to_f
            @originalFontSize = fontSize.to_f
            parentWidget = item.parent
            @originalWidth = parentWidget.width
        end
    end

    def initialize(parent)      # parent required!
        @arr = Array.new
        geom = parent.geometry
        @oldParentSize = Qt::SizeF.new(geom.width,geom.height)
    end

    def deleteWidget widget
        for i in 0...@arr.size
            data = @arr[i]
            if widget == data.widget
                @arr.delete_at(i)
                break
            end
        end
    end
    
    def addWidget(widget)
        name = "unknown"
        begin
            if widget.objectName
                name = widget.objectName
            end
        rescue
            puts 'widget has no object name'
        end
        
        #
        # some children of widgets are not "widgets" and won't
        # have any geometry. The 'rescue' will take care of
        # that
        #
        begin
            geom = widget.geometry
            font = widget.font
            data = WidgetData.new( name,
                                   widget,
                                   geom.width.to_f,
                                   geom.height.to_f,
                                   geom.x.to_f,
                                   geom.y.to_f,
                                   font.pixelSize)
            @arr << data
        rescue
            puts "widget has no geometry #{widget.objectName}"
        end
    end
    
    #
    # qrect is the geometry of the parent widget
    # this is called when the geometry changes
    #
    def setGeometry(qrect)      # virtual, but needed
        for i in 0...@arr.size
            data = @arr[i]
            widget = data.widget
            widget.setGeometry reScale(data,qrect)

            if data.fontSize != -1 
                font = widget.font
                if data.fontSize >= 1
                    font.setPixelSize data.fontSize
                    widget.setFont font
                end
            end
        end
        @oldParentSize.width  = qrect.width.to_f
        @oldParentSize.height = qrect.height.to_f
    end


    # resize and re-position the widget
    def reScale(data,parentRect)
        wScale = parentRect.width.to_f  / @oldParentSize.width
        hScale = parentRect.height.to_f / @oldParentSize.height
        w    = data.w  * wScale
        h    = data.h  * hScale
        x    = data.x  * wScale
        y    = data.y  * hScale
        data.w = w
        data.h = h
        data.x = x
        data.y = y
        if data.fontSize != -1
            data.fontSize = hScale * data.fontSize
            # fontsize can lose precision, restore the original value here if the width is
            # within 20 pixels
            if parentRect.width > data.originalWidth - 10 && parentRect.width < data.originalWidth + 10
                data.fontSize = data.originalFontSize
            end
        end
        return Qt::Rect.new(x,y,w,h)
    end
end


class PlacerWidget < Qt::Widget

    GroupStruct = Struct.new(:group,:scaledLayout)
    
    def initialize (parent = nil)
        super parent
        @scaledLayout = nil
        @fontSize = 0
        @groups = Array.new
    end

    #
    # only widgets have geometry
    #
    def isWidget?(widget)
        isA = true
        begin
            geom = widget.geometry
        rescue
            isA = false
        end
        return isA
    end

    def addGroup(group,parentWidget = nil)

        if group.children.size > 0
            parent = parentWidget == nil ? group : parentWidget
            scaledLayout = ScaledLayout.new parent
            addChildren(group,scaledLayout)
            g = GroupStruct.new parent,scaledLayout
            @groups << g
        end
    end

    #
    # add all child widgets to the scaled layout
    #
    def addChildren(parent,scaledLayout)

        list = parent.children
        list.each do |w|
            if isWidget? w
                if w.className == 'Qt::GroupBox' ||
                   w.className == 'Qt::Frame'
                    addGroup(w)
                elsif w.className == 'Qt::TabWidget'
                    (0...w.count).each do |i|
                        tab = w.widget i
                        addGroup(tab,w)
                    end
                end
                adjustFont w
                scaledLayout.addWidget w
            end
        end
    end

    #
    # You can set the font size of every widget by calling
    # this functions.  Every font added will then have the
    # specfied font size, and the font will be resizeable.
    # Setting it back to 0 will cancel the function.
    #
    def setFontSize size
        @fontSize = size
    end

    def adjustFont(widget)
        if @fontSize > 0
            font = widget.font
            font.setPixelSize @fontSize
            widget.setFont font
        end
    end

    #
    # Call delete only after "show" has been called.
    # Otherwise there is no scaledLayout
    #
    def deleteChild w
        @scaledLayout.deleteWidget w # remove from the scaled layout
        w.deleteLater                # delete the widget
    end
    
    #
    # we create a new scaled layout the
    # first time that resize was called
    # All the child widgets should be
    # present
    #
    def newScaledLayout
        if @scaledLayout == nil
            @scaledLayout = ScaledLayout.new self
            addChildren self,@scaledLayout
        end
    end

    def resizeGroups
        @groups.each do |g|
            g.scaledLayout.setGeometry(g.group.geometry)
        end
    end

    def resizeEvent(event)
        newScaledLayout
        @scaledLayout.setGeometry rect
        resizeGroups
    end

end

if __FILE__ == $0
    Qt::Application.new(ARGV) do
        w = PlacerWidget.new
        w.resize 600,400

        b = Qt::PushButton.new("BUTTON 1",w);
        b.move(40,40)
        b.resize(200,100)
            
        b = Qt::PushButton.new("BUTTON 2",w);
        b.move(300,40)
        b.resize(200,100)
        b2  = b
        
        # test if delete works

        b = Qt::PushButton.new("BUTTON 3",w);
        b.move(40,200)
        b.resize(200,100)

        w.show
        w.deleteChild b         # only after show!

        exec
        exit 0
    end
end
