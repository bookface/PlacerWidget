#--------------------------------------------------------------------------
project(project)
cmake_minimum_required(VERSION 3.0)
set(CMAKE_DEBUG_POSTFIX  "d")
set(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS TRUE)

#--------------------------------------------------------------------------
set(exec main)

#--------------------------------------------------------------------------
set (CMAKE_AUTOMOC ON)
set (CMAKE_AUTOUIC ON)
set (uis
    ${CMAKE_CURRENT_SOURCE_DIR}/../ui/widgets.ui
    )
set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/../ui)

find_package(Qt5 COMPONENTS Core Gui Widgets)
execute_process(COMMAND ${QMAKE_EXECUTABLE} -query QT_VERSION OUTPUT_VARIABLE QT_VERSION)
message(STATUS "Qt Version: ${QT_VERSION}Location: ${Qt5_DIR}")

set(QT_LIBRARIES
    Qt5::Core
    Qt5::Gui
    Qt5::Widgets
    imm32
    winmm
    ws2_32
    Mincore
    )

#--------------------------------------------------------------------------
set(sources
    ./main.cpp
    ./placerWidget.h
    ${uis}
    )

#--------------------------------------------------------------------------
add_executable(${exec} ${sources})

#--------------------------------------------------------------------------
target_link_libraries(${exec} ${QT_LIBRARIES})

#--------------------------------------------------------------------------
install(TARGETS ${exec}
    RUNTIME DESTINATION bin
)

