from placerWidget import *
from ui_widgets import Ui_Form

import sys
app = QtWidgets.QApplication(sys.argv)
pw = PlacerWidget()
pw.setFontSize(12)
ui = Ui_Form()
ui.setupUi(pw)
pw.show()
sys.exit(app.exec_())
