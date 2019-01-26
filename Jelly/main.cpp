#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QtQml>
#include "client.h"

int main(int argc, char *argv[])
{
    /*
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    */



#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    qmlRegisterType<Client>("com.company.client", 1, 0, "Client");
    QQmlApplicationEngine engine;
    QQmlComponent component(&engine, QUrl(QStringLiteral("qrc:/main.qml")));
    QObject *object = component.create();
    Client *client = new Client(object);


    return app.exec();
}
