#include "IPanelPlugin.h"
#include <QObject>
#include <QtQml/qqml.h>
#include <QQmlEngine>
#include <QUrl>

class CompassPanelPlugin : public QObject, public IPanelPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID IPanelPlugin_iid FILE "plugin.json")
    Q_INTERFACES(IPanelPlugin)

public:
    QString pluginName() const override
    {
        return "CompassPanel";
    }

    QUrl qmlSource() const override
    {
        // Load the QML file embedded via resources.qrc
        return QUrl("qrc:/CompassPanelPlugin/CompassPanel.qml");
    }
};

#include "plugin.moc"
