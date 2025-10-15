#include <QCoreApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QDebug>
#include <QFile>
#include <QQuickWindow>
#include <QSGRendererInterface>
#include <QPluginLoader>
#include <QDir>

#include <QtCharts/QChartView>
#include <QtCharts/QBarSeries>
#include <QtCharts/QLineSeries>
#include <QtCharts/QValueAxis>
#include <QtCharts/QCategoryAxis>
QT_USE_NAMESPACE

#include "ConfigLoader.h"
#include "CompassData.h"
#include "ThrusterData.h"
#include "InfoData.h"
#include "PowerData.h"
#include "ForecastData.h"
#include "IPanelPlugin.h"  // ✅ Plugin interface

int main(int argc, char *argv[])
{
    // --------------------------------------------------
    // Basic app setup
    // --------------------------------------------------
    QQuickWindow::setSceneGraphBackend("software");
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL, true);

    QGuiApplication app(argc, argv);

    // Disable disk caching and enforce software rendering
    qputenv("QML_DISABLE_DISK_CACHE", "1");
    qputenv("QT_QUICK_BACKEND", "software");
    qputenv("QT_CHARTS_USE_OPENGL", "0");

    QQmlApplicationEngine engine;

    qDebug() << "Scene Graph Backend:" << QQuickWindow::sceneGraphBackend();

    // Add import paths for Qt modules
    engine.addImportPath("C:/Qt/6.5.3/mingw_64/qml");
    qmlRegisterModule("QtCharts", 2, 15);

    // --------------------------------------------------
    // Context setup
    // --------------------------------------------------
    auto configLoader  = new ConfigLoader(&app);
    auto compassData   = new CompassData(&app);
    auto thrusterData  = new ThrusterData(&app);
    auto infoData      = new InfoData(&app);
    auto powerData     = new PowerData(&app);
    auto forecastData  = new ForecastData(&app);

    engine.rootContext()->setContextProperty("configLoader", configLoader);
    engine.rootContext()->setContextProperty("compassData", compassData);
    engine.rootContext()->setContextProperty("thrusterData", thrusterData);
    engine.rootContext()->setContextProperty("infoData", infoData);
    engine.rootContext()->setContextProperty("powerData", powerData);
    engine.rootContext()->setContextProperty("forecastData", forecastData);

    // --------------------------------------------------
    // Verify QRC resources
    // --------------------------------------------------
    qDebug() << "Checking QRC paths:" << QDir(":/").entryList(QDir::Dirs | QDir::NoDotAndDotDot);
    qDebug() << "Checking Config file exists:" << QFile(":/Dynamic_Dashboard/Config/Ui_Config.xml").exists();
    qDebug() << "Checking main QML exists:"  << QFile(":/Dynamic_Dashboard/UI/main.qml").exists();

    if (!configLoader->loadConfig(":/Dynamic_Dashboard/Config/Ui_Config.xml")) {
        qCritical() << "❌ Failed to load UI configuration file!";
        return -1;
    }

    // --------------------------------------------------
    // Plugin Loading (optional)
    // --------------------------------------------------
    QString pluginDirPath = QCoreApplication::applicationDirPath() + "/plugins";
    QDir pluginsDir(pluginDirPath);

    if (!pluginsDir.exists()) {
        qWarning() << "⚠️ Plugin directory not found:" << pluginsDir.absolutePath();
    } else {
        qDebug() << "🔍 Searching for plugins in:" << pluginsDir.absolutePath();
        for (const QString &fileName : pluginsDir.entryList(QDir::Files)) {
            if (!fileName.endsWith(".dll") && !fileName.endsWith(".so"))
                continue;

            QString absPath = pluginsDir.absoluteFilePath(fileName);
            QPluginLoader loader(absPath);
            QObject *pluginInstance = loader.instance();

            if (pluginInstance) {
                IPanelPlugin *panel = qobject_cast<IPanelPlugin *>(pluginInstance);
                if (panel) {
                    qDebug() << "✅ Loaded plugin:" << panel->pluginName()
                             << " → QML:" << panel->qmlSource().toString();
                    engine.load(panel->qmlSource());
                } else {
                    qWarning() << "⚠️ Invalid plugin interface in:" << fileName;
                }
            } else {
                qWarning() << "⚠️ Failed to load plugin:" << absPath
                           << loader.errorString();
            }
        }
    }

    // --------------------------------------------------
    // Load main dashboard QML
    // --------------------------------------------------
    const QUrl mainQmlUrl(u"qrc:/Dynamic_Dashboard/UI/main.qml"_qs);

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [mainQmlUrl](QObject *obj, const QUrl &objUrl) {
            if (!obj && mainQmlUrl == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
    );

    qDebug() << "🚀 Loading main QML:" << mainQmlUrl.toString();
    engine.load(mainQmlUrl);

    if (engine.rootObjects().isEmpty()) {
        qCritical() << "❌ Failed to load main.qml!";
        return -1;
    }

    // --------------------------------------------------
    // Backend Simulation (Data update timers)
    // --------------------------------------------------
    QTimer compassTimer;
    QObject::connect(&compassTimer, &QTimer::timeout, compassData, &CompassData::updateAngle);
    compassTimer.start(100);

    QTimer::singleShot(2000, &app, [=]() {
        qDebug() << "🟢 Starting backend updates...";
        try {
            thrusterData->startUpdates();
            infoData->startUpdates();
            powerData->startUpdates();
            forecastData->startUpdates();
        } catch (...) {
            qCritical() << "❌ Exception during backend startup!";
        }
    });

    QObject::connect(&app, &QCoreApplication::aboutToQuit, []() {
        qDebug() << "👋 Application exiting.";
    });

    // --------------------------------------------------
    // Run the application
    // --------------------------------------------------
    return app.exec();
}
