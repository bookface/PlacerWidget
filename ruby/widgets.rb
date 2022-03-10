=begin
** Form generated from reading ui file 'widgets.ui'
**
** Created: Wed Mar 9 10:58:56 2022
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_Form
    attr_reader :buttonBox
    attr_reader :comboBox
    attr_reader :tabWidget
    attr_reader :tab
    attr_reader :groupBox_4
    attr_reader :d1F
    attr_reader :d2F
    attr_reader :d3F
    attr_reader :d4F
    attr_reader :d5F
    attr_reader :d6F
    attr_reader :groupBox_6
    attr_reader :line2
    attr_reader :check3
    attr_reader :check1
    attr_reader :check2
    attr_reader :line1
    attr_reader :line3
    attr_reader :label
    attr_reader :label_6
    attr_reader :label_9
    attr_reader :spinBox
    attr_reader :label_3
    attr_reader :timeEdit
    attr_reader :plainTextEdit
    attr_reader :dateEdit
    attr_reader :label_2
    attr_reader :label_5
    attr_reader :label_7
    attr_reader :dateTimeEdit
    attr_reader :label_8
    attr_reader :doubleSpinBox
    attr_reader :frame
    attr_reader :dial
    attr_reader :horizontalSlider
    attr_reader :verticalSlider
    attr_reader :label_4
    attr_reader :groupBox
    attr_reader :pushButton
    attr_reader :checkBox
    attr_reader :lineEdit

    def setupUi(form)
    if form.objectName.nil?
        form.objectName = "form"
    end
    form.resize(643, 781)
    @buttonBox = Qt::DialogButtonBox.new(form)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.geometry = Qt::Rect.new(400, 730, 156, 23)
    @buttonBox.orientation = Qt::Horizontal
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok
    @comboBox = Qt::ComboBox.new(form)
    @comboBox.objectName = "comboBox"
    @comboBox.geometry = Qt::Rect.new(190, 460, 171, 22)
    @tabWidget = Qt::TabWidget.new(form)
    @tabWidget.objectName = "tabWidget"
    @tabWidget.geometry = Qt::Rect.new(110, 240, 421, 211)
    @tab = Qt::Widget.new()
    @tab.objectName = "tab"
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Preferred)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = @tab.sizePolicy.hasHeightForWidth
    @tab.sizePolicy = @sizePolicy
    @groupBox_4 = Qt::GroupBox.new(@tab)
    @groupBox_4.objectName = "groupBox_4"
    @groupBox_4.geometry = Qt::Rect.new(294, 9, 81, 165)
    @d1F = Qt::RadioButton.new(@groupBox_4)
    @d1F.objectName = "d1F"
    @d1F.geometry = Qt::Rect.new(10, 23, 61, 17)
    @d1F.checked = true
    @d2F = Qt::RadioButton.new(@groupBox_4)
    @d2F.objectName = "d2F"
    @d2F.geometry = Qt::Rect.new(10, 46, 61, 17)
    @d3F = Qt::RadioButton.new(@groupBox_4)
    @d3F.objectName = "d3F"
    @d3F.geometry = Qt::Rect.new(10, 69, 61, 17)
    @d4F = Qt::RadioButton.new(@groupBox_4)
    @d4F.objectName = "d4F"
    @d4F.geometry = Qt::Rect.new(10, 90, 61, 17)
    @d5F = Qt::RadioButton.new(@groupBox_4)
    @d5F.objectName = "d5F"
    @d5F.geometry = Qt::Rect.new(10, 115, 61, 17)
    @d6F = Qt::RadioButton.new(@groupBox_4)
    @d6F.objectName = "d6F"
    @d6F.geometry = Qt::Rect.new(10, 138, 61, 17)
    @groupBox_6 = Qt::GroupBox.new(@tab)
    @groupBox_6.objectName = "groupBox_6"
    @groupBox_6.geometry = Qt::Rect.new(9, 9, 220, 161)
    @line2 = Qt::LineEdit.new(@groupBox_6)
    @line2.objectName = "line2"
    @line2.geometry = Qt::Rect.new(77, 77, 133, 20)
    @check3 = Qt::CheckBox.new(@groupBox_6)
    @check3.objectName = "check3"
    @check3.geometry = Qt::Rect.new(10, 118, 61, 17)
    @check1 = Qt::CheckBox.new(@groupBox_6)
    @check1.objectName = "check1"
    @check1.geometry = Qt::Rect.new(10, 38, 61, 17)
    @check1.checked = true
    @check2 = Qt::CheckBox.new(@groupBox_6)
    @check2.objectName = "check2"
    @check2.geometry = Qt::Rect.new(10, 78, 61, 17)
    @line1 = Qt::LineEdit.new(@groupBox_6)
    @line1.objectName = "line1"
    @line1.geometry = Qt::Rect.new(77, 37, 133, 20)
    @line3 = Qt::LineEdit.new(@groupBox_6)
    @line3.objectName = "line3"
    @line3.geometry = Qt::Rect.new(77, 117, 133, 20)
    @tabWidget.addTab(@tab, Qt::Application.translate("Form", "Tab Widget", nil, Qt::Application::UnicodeUTF8))
    @label = Qt::Label.new(form)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(80, 740, 161, 20)
    @label_6 = Qt::Label.new(form)
    @label_6.objectName = "label_6"
    @label_6.geometry = Qt::Rect.new(30, 520, 141, 20)
    @label_6.layoutDirection = Qt::RightToLeft
    @label_6.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @label_9 = Qt::Label.new(form)
    @label_9.objectName = "label_9"
    @label_9.geometry = Qt::Rect.new(30, 590, 301, 20)
    @label_9.layoutDirection = Qt::RightToLeft
    @label_9.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @spinBox = Qt::SpinBox.new(form)
    @spinBox.objectName = "spinBox"
    @spinBox.geometry = Qt::Rect.new(220, 10, 311, 20)
    @label_3 = Qt::Label.new(form)
    @label_3.objectName = "label_3"
    @label_3.geometry = Qt::Rect.new(20, 40, 181, 20)
    @label_3.layoutDirection = Qt::RightToLeft
    @label_3.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @timeEdit = Qt::TimeEdit.new(form)
    @timeEdit.objectName = "timeEdit"
    @timeEdit.geometry = Qt::Rect.new(190, 520, 118, 22)
    @plainTextEdit = Qt::PlainTextEdit.new(form)
    @plainTextEdit.objectName = "plainTextEdit"
    @plainTextEdit.geometry = Qt::Rect.new(190, 490, 291, 21)
    @dateEdit = Qt::DateEdit.new(form)
    @dateEdit.objectName = "dateEdit"
    @dateEdit.geometry = Qt::Rect.new(420, 520, 110, 22)
    @label_2 = Qt::Label.new(form)
    @label_2.objectName = "label_2"
    @label_2.geometry = Qt::Rect.new(20, 10, 181, 20)
    @label_2.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @label_5 = Qt::Label.new(form)
    @label_5.objectName = "label_5"
    @label_5.geometry = Qt::Rect.new(20, 490, 151, 20)
    @label_5.layoutDirection = Qt::RightToLeft
    @label_5.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @label_7 = Qt::Label.new(form)
    @label_7.objectName = "label_7"
    @label_7.geometry = Qt::Rect.new(330, 520, 81, 20)
    @label_7.layoutDirection = Qt::RightToLeft
    @label_7.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @dateTimeEdit = Qt::DateTimeEdit.new(form)
    @dateTimeEdit.objectName = "dateTimeEdit"
    @dateTimeEdit.geometry = Qt::Rect.new(190, 550, 194, 22)
    @label_8 = Qt::Label.new(form)
    @label_8.objectName = "label_8"
    @label_8.geometry = Qt::Rect.new(30, 550, 141, 20)
    @label_8.layoutDirection = Qt::RightToLeft
    @label_8.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @doubleSpinBox = Qt::DoubleSpinBox.new(form)
    @doubleSpinBox.objectName = "doubleSpinBox"
    @doubleSpinBox.geometry = Qt::Rect.new(220, 40, 311, 20)
    @frame = Qt::Frame.new(form)
    @frame.objectName = "frame"
    @frame.geometry = Qt::Rect.new(110, 70, 421, 161)
    @frame.frameShape = Qt::Frame::StyledPanel
    @frame.frameShadow = Qt::Frame::Raised
    @dial = Qt::Dial.new(@frame)
    @dial.objectName = "dial"
    @dial.geometry = Qt::Rect.new(10, 10, 100, 100)
    @horizontalSlider = Qt::Slider.new(@frame)
    @horizontalSlider.objectName = "horizontalSlider"
    @horizontalSlider.geometry = Qt::Rect.new(116, 69, 161, 22)
    @horizontalSlider.orientation = Qt::Horizontal
    @verticalSlider = Qt::Slider.new(@frame)
    @verticalSlider.objectName = "verticalSlider"
    @verticalSlider.geometry = Qt::Rect.new(330, 20, 22, 131)
    @verticalSlider.orientation = Qt::Vertical
    @label_4 = Qt::Label.new(form)
    @label_4.objectName = "label_4"
    @label_4.geometry = Qt::Rect.new(20, 460, 151, 20)
    @label_4.layoutDirection = Qt::RightToLeft
    @label_4.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter
    @groupBox = Qt::GroupBox.new(form)
    @groupBox.objectName = "groupBox"
    @groupBox.geometry = Qt::Rect.new(90, 630, 451, 80)
    @pushButton = Qt::PushButton.new(@groupBox)
    @pushButton.objectName = "pushButton"
    @pushButton.geometry = Qt::Rect.new(30, 30, 111, 31)
    @checkBox = Qt::CheckBox.new(@groupBox)
    @checkBox.objectName = "checkBox"
    @checkBox.geometry = Qt::Rect.new(170, 30, 91, 31)
    @lineEdit = Qt::LineEdit.new(@groupBox)
    @lineEdit.objectName = "lineEdit"
    @lineEdit.geometry = Qt::Rect.new(280, 30, 113, 20)

    retranslateUi(form)

    @tabWidget.setCurrentIndex(0)


    Qt::MetaObject.connectSlotsByName(form)
    end # setupUi

    def setup_ui(form)
        setupUi(form)
    end

    def retranslateUi(form)
    form.windowTitle = Qt::Application.translate("Form", "Form", nil, Qt::Application::UnicodeUTF8)
    @groupBox_4.title = Qt::Application.translate("Form", "Radio Buttons", nil, Qt::Application::UnicodeUTF8)
    @d1F.text = Qt::Application.translate("Form", "B1", nil, Qt::Application::UnicodeUTF8)
    @d2F.text = Qt::Application.translate("Form", "B2", nil, Qt::Application::UnicodeUTF8)
    @d3F.text = Qt::Application.translate("Form", "B3", nil, Qt::Application::UnicodeUTF8)
    @d4F.text = Qt::Application.translate("Form", "B4", nil, Qt::Application::UnicodeUTF8)
    @d5F.text = Qt::Application.translate("Form", "B5", nil, Qt::Application::UnicodeUTF8)
    @d6F.text = Qt::Application.translate("Form", "B6", nil, Qt::Application::UnicodeUTF8)
    @groupBox_6.title = Qt::Application.translate("Form", "Values", nil, Qt::Application::UnicodeUTF8)
    @check3.text = Qt::Application.translate("Form", "Check 3", nil, Qt::Application::UnicodeUTF8)
    @check1.text = Qt::Application.translate("Form", "Check 1", nil, Qt::Application::UnicodeUTF8)
    @check2.text = Qt::Application.translate("Form", "Check 2", nil, Qt::Application::UnicodeUTF8)
    @tabWidget.setTabText(@tabWidget.indexOf(@tab), Qt::Application.translate("Form", "Tab Widget", nil, Qt::Application::UnicodeUTF8))
    @label.text = Qt::Application.translate("Form", "LABEL", nil, Qt::Application::UnicodeUTF8)
    @label_6.text = Qt::Application.translate("Form", "TIME EDIT", nil, Qt::Application::UnicodeUTF8)
    @label_9.text = Qt::Application.translate("Form", "KEY SEQUENCE EDIT NOT SUPPORTED", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("Form", "DOUBLE SPINBOX", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("Form", "SPINBOX", nil, Qt::Application::UnicodeUTF8)
    @label_5.text = Qt::Application.translate("Form", "PLAIN TEXT EDIT", nil, Qt::Application::UnicodeUTF8)
    @label_7.text = Qt::Application.translate("Form", "DATE EDIT", nil, Qt::Application::UnicodeUTF8)
    @label_8.text = Qt::Application.translate("Form", "DATE/TIME EDIT", nil, Qt::Application::UnicodeUTF8)
    @label_4.text = Qt::Application.translate("Form", "COMBO BOX", nil, Qt::Application::UnicodeUTF8)
    @groupBox.title = Qt::Application.translate("Form", "GroupBox", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("Form", "PushButton", nil, Qt::Application::UnicodeUTF8)
    @checkBox.text = Qt::Application.translate("Form", "CheckBox", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(form)
        retranslateUi(form)
    end

end

module Ui
    class Form < Ui_Form
    end
end  # module Ui

