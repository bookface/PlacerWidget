
require 'Qt'

$: << '.'
require 'placerWidget'
require 'widgets'

Qt::Application.new(ARGV) do

    pw = PlacerWidget.new
    pw.setFontSize 12
    @ui = Ui_Form.new
    @ui.setupUi pw
    pw.show
 
    exec
    exit
end
