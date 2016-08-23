#include <scorekeeper.h>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <Qdir>

#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc,argv);

    qmlRegisterType<ScoreKeeper>("TiltyRocket", 1, 0, "ScoreKeeper");

    QQmlApplicationEngine engine(QUrl("qrc:/Home.qml"));
    //qDebug() << "Default path >> "+engine.offlineStoragePath();

    QDir dir;
    QString customPath = dir.currentPath()+"/OffLineStorage";

    qDebug() << customPath;
    if(dir.mkpath(QString(customPath))){
        qDebug() << "Default path >> "+engine.offlineStoragePath();
        engine.setOfflineStoragePath(QString(customPath));
        qDebug() << "New path >> "+engine.offlineStoragePath();
    }
    else
    {
        qDebug() << "It didn't work...";
    }

    return app.exec();
}
