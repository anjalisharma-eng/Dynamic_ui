QT += core gui qml quick charts xml
CONFIG += c++17 console
CONFIG -= app_bundle

# ------------------------------------------------------
# Include paths for all your C++ folders
# ------------------------------------------------------
INCLUDEPATH += \
    Dynamic_Dashboard/Core \
    Dynamic_Dashboard/Models \
    Dynamic_Dashboard/Plugins

# ------------------------------------------------------
# Source (.cpp) files
# ------------------------------------------------------
SOURCES += \
    Dynamic_Dashboard/Core/main.cpp \
    Dynamic_Dashboard/Models/CompassData.cpp \
    Dynamic_Dashboard/Models/ConfigLoader.cpp \
    Dynamic_Dashboard/Models/ForecastData.cpp \
    Dynamic_Dashboard/Models/InfoData.cpp \
    Dynamic_Dashboard/Models/Powerdata.cpp \
    Dynamic_Dashboard/Models/ThrusterData.cpp

# ------------------------------------------------------
# Header (.h) files
# ------------------------------------------------------
HEADERS += \
    Dynamic_Dashboard/Models/CompassData.h \
    Dynamic_Dashboard/Models/ConfigLoader.h \
    Dynamic_Dashboard/Models/ForecastData.h \
    Dynamic_Dashboard/Models/InfoData.h \
    Dynamic_Dashboard/Models/PowerData.h \
    Dynamic_Dashboard/Models/ThrusterData.h

# ------------------------------------------------------
# Resource file (.qrc)
# ------------------------------------------------------
RESOURCES += resources.qrc

# ------------------------------------------------------
# QML import paths (keep empty unless needed)
# ------------------------------------------------------
QML_DESIGNER_IMPORT_PATH =
QML_IMPORT_PATH += $$[QT_INSTALL_QML]

# ------------------------------------------------------
# Deployment rules
# ------------------------------------------------------
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Dynamic_Dashboard/Config/Ui_Config.xml \
    Dynamic_Dashboard/UI/StatusPanel.qml
