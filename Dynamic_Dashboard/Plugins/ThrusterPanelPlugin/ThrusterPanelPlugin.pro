QT += qml quick

TEMPLATE = lib
CONFIG += plugin c++17
TARGET = ThrusterPanelPlugin

# ✅ Output DLL to main bin/plugins folder
DESTDIR = $$PWD/../../bin/plugins


INCLUDEPATH += $$PWD/../../Core \
               $$PWD/../../Models \
               $$PWD/../../Plugins

HEADERS += \
    ThrusterPlugin.h

SOURCES += \
    ThrusterPlugin.cpp

RESOURCES += \
    thruster_resources.qrc

DISTFILES += \
    plugin.json \
    ThrusterPanel.qml
