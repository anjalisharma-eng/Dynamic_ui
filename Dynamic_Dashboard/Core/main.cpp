#include <QCoreApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QDebug>
#include <QFile>
#include <QQuickWindow>
#include <QSGRendererInterface>

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

int main(int argc, char *argv[])
{
    QQuickWindow::setSceneGraphBackend("software");
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL, true);

    QGuiApplication app(argc, argv);

    qputenv("QML_DISABLE_DISK_CACHE", "1");
    qputenv("QT_QUICK_BACKEND", "software");
    qputenv("QT_CHARTS_USE_OPENGL", "0");

    QQmlApplicationEngine engine;

    QString backend = QQuickWindow::sceneGraphBackend();
    qDebug() << "Scene Graph Backend:" << backend;

    engine.addImportPath("C:/Qt/6.5.3/mingw_64/qml");
    qmlRegisterModule("QtCharts", 2, 15);

    auto configLoader = new ConfigLoader(&app);
    auto compassData = new CompassData(&app);
    auto thrusterData = new ThrusterData(&app);
    auto infoData = new InfoData(&app);
    auto powerData = new PowerData(&app);
    auto forecastData = new ForecastData(&app);

    engine.rootContext()->setContextProperty("configLoader", configLoader);
    engine.rootContext()->setContextProperty("compassData", compassData);
    engine.rootContext()->setContextProperty("thrusterData", thrusterData);
    engine.rootContext()->setContextProperty("infoData", infoData);
    engine.rootContext()->setContextProperty("powerData", powerData);
    engine.rootContext()->setContextProperty("forecastData", forecastData);

    if (!configLoader->loadConfig(":/Dynamic_Dashboard/Config/Ui_Config.xml")) {
        qCritical() << "Failed to load UI configuration!";
        return -1;
    }

    const QUrl mainQmlUrl(u"qrc:/Dynamic_Dashboard/UI/main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [mainQmlUrl](QObject *obj, const QUrl &objUrl) {
            if (!obj && mainQmlUrl == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
    );

    qDebug() << "Loading main QML:" << mainQmlUrl.toString();
    engine.load(mainQmlUrl);

    if (engine.rootObjects().isEmpty()) {
        qCritical() << "Failed to load main.qml!";
        return -1;
    }

    QTimer compassTimer;
    QObject::connect(&compassTimer, &QTimer::timeout, compassData, &CompassData::updateAngle);
    compassTimer.start(100);

    QTimer::singleShot(2000, &app, [=]() {
        qDebug() << "Starting backend updates...";
        try {
            thrusterData->startUpdates();
            infoData->startUpdates();
            powerData->startUpdates();
            forecastData->startUpdates();
        } catch (...) {
            qCritical() << "Exception during backend startup!";
        }
    });

    QObject::connect(&app, &QCoreApplication::aboutToQuit, []() {
        qDebug() << "Application exiting.";
    });

    return app.exec();
}
