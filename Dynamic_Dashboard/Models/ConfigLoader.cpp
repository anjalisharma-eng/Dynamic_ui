//#include "ConfigLoader.h"
//#include <QFile>
//#include <QXmlStreamReader>
//#include <QVariantMap>
//#include <QDebug>

//ConfigLoader::ConfigLoader(QObject *parent)
//    : QObject(parent)
//{
//}

//void ConfigLoader::loadConfig(const QString &filePath)
//{
//    m_components.clear();

//    QFile file(filePath);
//    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
//        qWarning() << "Unable to open config file:" << filePath;
//        return;
//    }

//    QXmlStreamReader xml(&file);

//    while (!xml.atEnd() && !xml.hasError()) {
//        xml.readNext();
//        if (xml.name().toString() == "Component") {
//            QVariantMap comp;
//            comp["source"] = xml.attributes().value("source").toString();
//            comp["x"] = xml.attributes().value("x").toInt();
//            comp["y"] = xml.attributes().value("y").toInt();
//            comp["width"] = xml.attributes().value("width").toInt();
//            comp["height"] = xml.attributes().value("height").toInt();
//            comp["params"] = xml.attributes().value("params").toString();
//            m_components.append(comp);
//        }
//    }

//    file.close();

//    if (xml.hasError()) {
//        qWarning() << "XML parse error:" << xml.errorString();
//    }

//    emit componentsChanged();
//}

//QList<QVariant> ConfigLoader::components() const
//{
//    return m_components;
//}

#include "ConfigLoader.h"
#include <QFile>
#include <QXmlStreamReader>
#include <QDebug>

ConfigLoader::ConfigLoader(QObject *parent)
    : QObject(parent)
{
}

bool ConfigLoader::loadConfig(const QString &filePath)
{
    m_components.clear();

    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Unable to open config file:" << filePath;
        return false;
    }

    QXmlStreamReader xml(&file);

    while (!xml.atEnd() && !xml.hasError()) {
        xml.readNext();
        if (xml.isStartElement() && xml.name() == QLatin1String("Component")) {
            QVariantMap comp;
            auto a = xml.attributes();

            comp["source"] = a.value("source").toString();
            comp["params"] = a.value("params").toString();

            if (a.hasAttribute("relativeX")) {
                comp["relativeX"] = a.value("relativeX").toDouble();
                comp["relativeY"] = a.value("relativeY").toDouble();
                comp["relativeWidth"] = a.value("relativeWidth").toDouble();
                comp["relativeHeight"] = a.value("relativeHeight").toDouble();
            } else {
                comp["x"] = a.value("x").toInt();
                comp["y"] = a.value("y").toInt();
                comp["width"] = a.value("width").toInt();
                comp["height"] = a.value("height").toInt();
            }

            m_components.append(comp);
        }
    }

    file.close();

    if (xml.hasError()) {
        qWarning() << "XML parse error:" << xml.errorString();
        return false;
    }

    emit componentsChanged();
    return true;
}

QVariantList ConfigLoader::components() const
{
    return m_components;
}
