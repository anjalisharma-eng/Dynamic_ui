QT += core qml quick

TEMPLATE = lib
CONFIG += plugin c++17
TARGET = CompassPanelPlugin

INCLUDEPATH += ../../Models

SOURCES += plugin.cpp
HEADERS += IPanelPlugin.h

RESOURCES += compass_resources.qrc
DISTFILES += plugin.json

# Optional output directory for plugin binaries (keeps them organized)
DESTDIR = $$PWD/../../bin/plugins
