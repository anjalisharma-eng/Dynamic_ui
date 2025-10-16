#pragma once

#include <QObject>
#include <QtPlugin>
#include <QUrl>
#include "IPanelPlugin.h"

class InfoPanelPlugin : public QObject, public IPanelPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "com.anjali.DynamicDashboard.IPanelPlugin/1.0" FILE "plugin.json")
    Q_INTERFACES(IPanelPlugin)

public:
    QString pluginName() const override { return "Info Panel"; }
    QUrl qmlSource() const override { return QUrl("qrc:/InfoPanelPlugin/InfoPanel.qml"); }
};
