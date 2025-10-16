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
#include "IPanelPlugin.h"

int main(int argc, char *argv[])
{
    // --------------------------------------------------
    // Basic Application Setup
    // --------------------------------------------------
    QQuickWindow::setSceneGraphBackend("software");
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL, true);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qputenv("QML_DISABLE_DISK_CACHE", "1");
    qputenv("QT_QUICK_BACKEND", "software");
    qputenv("QT_CHARTS_USE_OPENGL", "0");

    qDebug() << "Scene Graph Backend:" << QQuickWindow::sceneGraphBackend();

    engine.addImportPath("C:/Qt/6.5.3/mingw_64/qml");
    qmlRegisterModule("QtCharts", 2, 15);

    // --------------------------------------------------
    // Context setup (data providers)
    // --------------------------------------------------
    auto configLoader  = new ConfigLoader(&app);
    auto compassData   = new CompassData(&app);
    auto thrusterData  = new ThrusterData(&app);
    auto infoData      = new InfoData(&app);
    auto powerData     = new PowerData(&app);

    engine.rootContext()->setContextProperty("configLoader", configLoader);
    engine.rootContext()->setContextProperty("compassData", compassData);
    engine.rootContext()->setContextProperty("thrusterData", thrusterData);
    engine.rootContext()->setContextProperty("infoData", infoData);
    engine.rootContext()->setContextProperty("powerData", powerData);

    // --------------------------------------------------
    // Verify QRC resources
    // --------------------------------------------------
    qDebug() << "Checking QRC roots:" << QDir(":/").entryList(QDir::Dirs | QDir::NoDotAndDotDot);
    qDebug() << "Main QML exists:" << QFile(":/Dynamic_Dashboard/UI/main.qml").exists();
    qDebug() << "Config file exists:" << QFile(":/Dynamic_Dashboard/Config/Ui_Config.xml").exists();
    qDebug() << "CompassPanel QML exists:" << QFile(":/CompassPanelPlugin/CompassPanel.qml").exists();
    qDebug() << "InfoPanel QML exists:" << QFile(":/InfoPanelPlugin/InfoPanel.qml").exists();
    qDebug() << "PowerPanel QML exists:" << QFile(":/PowerPanelPlugin/PowerPanel.qml").exists();

    if (!configLoader->loadConfig(":/Dynamic_Dashboard/Config/Ui_Config.xml")) {
        qCritical() << "❌ Failed to load UI configuration!";
        return -1;
    }

    // --------------------------------------------------
    // Dynamic Plugin Loader
    // --------------------------------------------------
    // 🔧 Fixed plugin directory path
    QString pluginDirPath =
        QCoreApplication::applicationDirPath() + "/../../Dynamic_Dashboard_Project/Dynamic_Dashboard/bin/plugins";

    QDir pluginsDir(pluginDirPath);
    qDebug() << "Resolved plugin path:" << pluginsDir.absolutePath();

    if (!pluginsDir.exists()) {
        qWarning() << "⚠️ Plugin directory not found:" << pluginsDir.absolutePath();
    } else {
        qDebug() << "🔍 Searching for plugins in:" << pluginsDir.absolutePath();

        const QStringList filters = { "*.dll", "*.so", "*.dylib" };
        const QStringList pluginFiles = pluginsDir.entryList(filters, QDir::Files);

        if (pluginFiles.isEmpty()) {
            qWarning() << "⚠️ No plugin libraries found in" << pluginsDir.absolutePath();
        }

        for (const QString &fileName : pluginFiles) {
            QString absPath = pluginsDir.absoluteFilePath(fileName);
            qDebug() << "🧩 Trying to load plugin:" << absPath;

            QPluginLoader loader(absPath);
            QObject *pluginInstance = loader.instance();

            if (!pluginInstance) {
                qWarning() << "❌ Failed to load:" << fileName
                           << "Error:" << loader.errorString();
                continue;
            }

            auto *panel = qobject_cast<IPanelPlugin *>(pluginInstance);
            if (!panel) {
                qWarning() << "⚠️ Invalid interface in plugin:" << fileName
                           << "IID mismatch? Error:" << loader.errorString();
                continue;
            }

            qDebug() << "✅ Loaded plugin:" << panel->pluginName()
                     << "→ QML:" << panel->qmlSource();

            QString qmlPath = panel->qmlSource().toString();
            QString cleanPath = qmlPath;
            cleanPath.remove("qrc:/");
            qDebug() << "QML exists in resources:" << QFile(":" + cleanPath).exists();

            // Load QML from plugin
            engine.load(panel->qmlSource());
        }
    }

    // --------------------------------------------------
    // Load Main Dashboard QML
    // --------------------------------------------------
    const QUrl mainQmlUrl(u"qrc:/Dynamic_Dashboard/UI/main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [mainQmlUrl](QObject *obj, const QUrl &objUrl) {
            if (!obj && mainQmlUrl == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    qDebug() << "🚀 Loading main QML:" << mainQmlUrl.toString();
    engine.load(mainQmlUrl);

    if (engine.rootObjects().isEmpty()) {
        qCritical() << "❌ Failed to load main.qml!";
        return -1;
    }

    // --------------------------------------------------
    // Backend Simulation
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
        } catch (...) {
            qCritical() << "❌ Exception during backend startup!";
        }
    });

    QObject::connect(&app, &QCoreApplication::aboutToQuit, []() {
        qDebug() << "👋 Application exiting.";
    });

    return app.exec();
}
