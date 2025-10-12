QT += core gui qml quick quickcontrols2 charts xml

CONFIG += c++17 console
CONFIG -= app_bundle

# ------------------------------------------------------
# Include paths for your headers
# ------------------------------------------------------
INCLUDEPATH += \
    Dynamic_Dashboard/Core \
    Dynamic_Dashboard/Models \
    Dynamic_Dashboard/Plugins

# ------------------------------------------------------
# Source files
# ------------------------------------------------------
SOURCES += \
    Dynamic_Dashboard/Core/main.cpp \
    Dynamic_Dashboard/Models/CompassData.cpp \
    Dynamic_Dashboard/Models/ConfigLoader.cpp \
    Dynamic_Dashboard/Models/ForecastData.cpp \
    Dynamic_Dashboard/Models/InfoData.cpp \
    Dynamic_Dashboard/Models/PowerData.cpp \
    Dynamic_Dashboard/Models/ThrusterData.cpp

# ------------------------------------------------------
# Header files
# ------------------------------------------------------
HEADERS += \
    Dynamic_Dashboard/Models/CompassData.h \
    Dynamic_Dashboard/Models/ConfigLoader.h \
    Dynamic_Dashboard/Models/ForecastData.h \
    Dynamic_Dashboard/Models/InfoData.h \
    Dynamic_Dashboard/Models/PowerData.h \
    Dynamic_Dashboard/Models/ThrusterData.h

# ------------------------------------------------------
# Resource files
# ------------------------------------------------------
RESOURCES += resources.qrc

# ------------------------------------------------------
# QML import paths (ensures QtCharts plugin loads)
# ------------------------------------------------------
QML_IMPORT_PATH += $$[QT_INSTALL_QML]
QML_DESIGNER_IMPORT_PATH += $$[QT_INSTALL_QML]

# ------------------------------------------------------
# Explicitly include QtCharts plugin for deployment
# ------------------------------------------------------
QML_IMPORT_PATH += $$[QT_INSTALL_PREFIX]/qml/QtCharts

# ------------------------------------------------------
# Deployment rules
# ------------------------------------------------------
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# ------------------------------------------------------
# Extra files to include (non-QML configs)
# ------------------------------------------------------
DISTFILES += \
    Dynamic_Dashboard/Config/Ui_Config.xml \
    Dynamic_Dashboard/UI/StatusPanel.qml
