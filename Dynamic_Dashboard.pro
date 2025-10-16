QT += core gui qml quick quickcontrols2 charts xml
CONFIG += c++17 console
CONFIG -= app_bundle

TEMPLATE = app
TARGET = Dynamic_Dashboard

# ------------------------------------------------------
# Plugin Projects (Compass + Info)
# ------------------------------------------------------
SUBDIRS += \
    Dynamic_Dashboard/Plugins/CompassPanelPlugin \
    Dynamic_Dashboard/Plugins/InfoPanelPlugin \
    Dynamic_Dashboard/Plugins/PowerPanelPlugin \
    Dynamic_Dashboard/Plugins/ThrusterPanelPlugin \
    Dynamic_Dashboard/Plugins/SummaryPanelPlugin

# ------------------------------------------------------
# Include paths
# ------------------------------------------------------
INCLUDEPATH += \
    Dynamic_Dashboard/Core \
    Dynamic_Dashboard/Models \
    Dynamic_Dashboard/Config \
    Dynamic_Dashboard/UI \
    Dynamic_Dashboard/Plugins \
    Dynamic_Dashboard/Plugins/CompassPanelPlugin \
    Dynamic_Dashboard/Plugins/InfoPanelPlugin   \
    Dynamic_Dashboard/Plugins/PowerPanelPlugin  \
    Dynamic_Dashboard/Plugins/ThrusterPanelPlugin \
    Dynamic_Dashboard/Plugins/SummaryPanelPlugin

# ------------------------------------------------------
# Source files
# ------------------------------------------------------
SOURCES += \
    Dynamic_Dashboard/Core/main.cpp \
    Dynamic_Dashboard/Models/CompassData.cpp \
    Dynamic_Dashboard/Models/ConfigLoader.cpp \
    Dynamic_Dashboard/Models/InfoData.cpp \
    Dynamic_Dashboard/Models/PowerData.cpp \
    Dynamic_Dashboard/Models/ThrusterData.cpp

# ------------------------------------------------------
# Header files
# ------------------------------------------------------
HEADERS += \
    Dynamic_Dashboard/Models/CompassData.h \
    Dynamic_Dashboard/Models/ConfigLoader.h \
    Dynamic_Dashboard/Models/InfoData.h \
    Dynamic_Dashboard/Models/PowerData.h \
    Dynamic_Dashboard/Models/ThrusterData.h \
    Dynamic_Dashboard/Plugins/IPanelPlugin.h

# ------------------------------------------------------
# Resource files
# ------------------------------------------------------
# Each resource file gets a unique compiled name
RESOURCES += \
    Dynamic_Dashboard/resources.qrc \
    Dynamic_Dashboard/Plugins/CompassPanelPlugin/compass_resources.qrc \
    Dynamic_Dashboard/Plugins/InfoPanelPlugin/info_resources.qrc \
    Dynamic_Dashboard/Plugins/PowerPanelPlugin/power_resources.qrc \
    Dynamic_Dashboard/Plugins/ThrusterPanelPlugin/thruster_resources.qrc \
    Dynamic_Dashboard/Plugins/SummaryPanelPlugin/summary_resources.qrc

# Custom resource names to prevent "overriding recipe" warnings
QMAKE_RESOURCE_NAME += dashboard_resources
QMAKE_RESOURCE_NAME += compass_plugin_resources
QMAKE_RESOURCE_NAME += info_plugin_resources
QMAKE_RESOURCE_NAME += thruster_plugin_resources
QMAKE_RESOURCE_NAME += summary_plugin_resources


# ------------------------------------------------------
# Distribution and configuration files
# ------------------------------------------------------
DISTFILES += \
    Dynamic_Dashboard/Plugins/CompassPanelPlugin/plugin.json \
    Dynamic_Dashboard/Plugins/InfoPanelPlugin/plugin.json \
    Dynamic_Dashboard/Config/Ui_Config.xml \
    Dynamic_Dashboard/UI/main.qml \
    Dynamic_Dashboard/UI/StatusPanel.qml

# ------------------------------------------------------
# QML import paths (ensure QtCharts works)
# ------------------------------------------------------
QML_IMPORT_PATH += $$[QT_INSTALL_QML]
QML_DESIGNER_IMPORT_PATH += $$[QT_INSTALL_QML]
QML_IMPORT_PATH += $$[QT_INSTALL_PREFIX]/qml/QtCharts

# ------------------------------------------------------
# Deployment paths
# ------------------------------------------------------
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
