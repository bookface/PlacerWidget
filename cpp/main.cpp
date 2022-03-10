#include <QApplication>
#include "placerWidget.h"
#include "ui_widgets.h"

int main(int argc, char * argv[])
{
    QApplication *app = new QApplication(argc,argv);
    PlacerWidget *w = new PlacerWidget;
    w->setFontSize(12);
    Ui_Form *form   = new Ui_Form;
    form->setupUi(w);
    w->show();
    app->exec();
}

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
//
// You can include this even for a console app.  It won't get called
// for console apps, but it's required for Windows apps
//
//
int WINAPI WinMain( HINSTANCE hInstance, 
                    HINSTANCE hPrevInstance,
                    LPSTR     lpCmdLine, 
                    int       nCmdShow)
{
    return main(__argc, __argv);
}
        
#endif
