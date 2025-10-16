QT += qml quick

TEMPLATE = lib
CONFIG += plugin c++17
TARGET = PowerPanelPlugin

INCLUDEPATH += $$PWD/../ \
               $$PWD/../../Core \
               $$PWD/../../Models

HEADERS += \
    PowerPlugin.h

RESOURCES += \
    power_resources.qrc


# Optional (not required for now)
DISTFILES += plugin.json\
             PowerPanel.qml

# Optional output directory for plugin binaries (keeps them organized)
DESTDIR = $$PWD/../../bin/plugins
