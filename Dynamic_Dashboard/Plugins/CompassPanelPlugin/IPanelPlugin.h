#pragma once

#include <QtPlugin>
#include <QString>
#include <QUrl>

class IPanelPlugin
{
public:
    virtual ~IPanelPlugin() = default;

    // Returns the display name of the plugin
    virtual QString pluginName() const = 0;

    // Returns the QML file URL that should be loaded by the application
    virtual QUrl qmlSource() const = 0;
};

#define IPanelPlugin_iid "com.anjali.DynamicDashboard.IPanelPlugin/1.0"
Q_DECLARE_INTERFACE(IPanelPlugin, IPanelPlugin_iid)
