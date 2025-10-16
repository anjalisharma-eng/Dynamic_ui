QT += qml quick

TEMPLATE = lib
CONFIG += plugin c++17
TARGET = SummaryPanelPlugin

# ✅ Output DLL to main bin/plugins folder
DESTDIR = $$PWD/../../bin/plugins


INCLUDEPATH += $$PWD/../../Core \
               $$PWD/../../Models \
               $$PWD/../../Plugins

HEADERS += \
    SummaryPlugin.h

SOURCES += \
    SummaryPlugin.cpp

RESOURCES += \
    Summary_resources.qrc

DISTFILES += \
    plugin.json \
    SummaryPanel.qml
