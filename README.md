# PlacerWidget
A Qt Widget that re-sizes all the child Widgets that are
placed within the PlacerWidget.
Source code for Python, Ruby, and C++ is provided.

The PlacerWidget class allows you to create a dialog, placing
the widgets wherever you want.  The Widgets will automatically
resize when the dialog is resized.

1. Do NOT add Layout widgets to your design. The whole
   point of this is to avoid them.

2. For fonts to resize, you must call placerWidget->setFontSize(),
   Otherwise they keep the same font attributes as set
   in the .ui file.

3. All objects must have a name. YOU MUST CALL setObjectName()
   for widgets that are added without using the designer. Designer
   automatically creates an object name.

  See the main.<> examples.
 
  Qt Fonts will resize if their size is set via
  setPixelSize() but not setPointSize() (which is the default).
  Calling placerWidget->setFontSize() will change all fonts to
  use setPixelSize() and ignore all other font size attributes.

