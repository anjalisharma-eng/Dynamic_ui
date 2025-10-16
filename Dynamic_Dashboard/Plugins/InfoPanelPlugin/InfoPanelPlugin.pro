QT += qml quick

TEMPLATE = lib
CONFIG += plugin c++17
TARGET = InfoPanelPlugin

INCLUDEPATH += $$PWD/../ \
               $$PWD/../../Core \
               $$PWD/../../Models

HEADERS += \
    plugin.h

RESOURCES += \
    info_resources.qrc

DISTFILES += \
    plugin.json \
    InfoPanel.qml

# Optional output directory for plugin binaries (keeps them organized)
DESTDIR = $$PWD/../../bin/plugins
