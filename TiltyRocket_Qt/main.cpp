
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <Qdir>

#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc,argv);

    //qmlRegisterType<ScoreKeeper>("TiltyRocket", 1, 0, "ScoreKeeper");

    QQmlApplicationEngine engine(QUrl("qrc:/TiltyRocket.qml"));
    //qDebug() << "Default path >> "+engine.offlineStoragePath();

    QDir dir;
    QString customPath = dir.currentPath()+"/OffLineStorage";

    qDebug() << "Default path >> "+engine.offlineStoragePath();
    qDebug() << "Desired path >> "+ customPath;
    if(dir.mkpath(QString(customPath))){

        engine.setOfflineStoragePath(QString(customPath));
        qDebug() << "New path >> "+engine.offlineStoragePath();
    }
    else
    {
        qDebug() << "Local file storage location was unable to be altered.";
    }

    return app.exec();
}
