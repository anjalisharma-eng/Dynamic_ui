#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QDebug>

#include "ConfigLoader.h"
#include "CompassData.h"
#include "ThrusterData.h"
#include "InfoData.h"
#include "PowerData.h"
#include "ForecastData.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // =========================
    // 1. Instantiate Backends
    // =========================
    ConfigLoader configLoader;
    CompassData compassData;
    ThrusterData thrusterData;
    InfoData infoData;
    PowerData powerData;
    ForecastData forecastData;

    // =========================
    // 2. Expose C++ objects to QML
    // =========================
    engine.rootContext()->setContextProperty("configLoader", &configLoader);
    engine.rootContext()->setContextProperty("compassData", &compassData);
    engine.rootContext()->setContextProperty("thrusterData", &thrusterData);
    engine.rootContext()->setContextProperty("infoData", &infoData);
    engine.rootContext()->setContextProperty("powerData", &powerData);
    engine.rootContext()->setContextProperty("forecastData", &forecastData);

    // =========================
    // 3. Load XML configuration (Layout)
    // =========================
    if (!configLoader.loadConfig(":/Dynamic_Dashboard/Config/Ui_Config.xml")) {
        qCritical() << "Failed to load UI configuration!";
        return -1;
    }

    // =========================
    // 4. Load QML UI after all data sources are ready
    // =========================
    const QUrl mainQmlUrl(u"qrc:/Dynamic_Dashboard/UI/main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [mainQmlUrl](QObject *obj, const QUrl &objUrl) {
            if (!obj && mainQmlUrl == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
    );
    engine.load(mainQmlUrl);

    if (engine.rootObjects().isEmpty()) {
        qCritical() << "Failed to load main.qml!";
        return -1;
    }

    // =========================
    // 5. Start periodic backend updates (C++-only simulation)
    // =========================

    // --- Compass rotation ---
    QTimer compassTimer;
    QObject::connect(&compassTimer, &QTimer::timeout, &compassData, &CompassData::updateAngle);
    compassTimer.start(100); // updates every 100 ms

    // --- Other subsystem data updates ---
    QTimer::singleShot(1000, [&]() {
        qDebug() << "Starting backend updates...";
        thrusterData.startUpdates();
        infoData.startUpdates();
        powerData.startUpdates();
        forecastData.startUpdates();
    });

    // =========================
    // 6. Run application
    // =========================
    return app.exec();
}
