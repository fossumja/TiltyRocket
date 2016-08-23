#ifndef SCOREKEEPER_H
#define SCOREKEEPER_H

#include <qobject.h>
#include <QtQuick>
#include <Qvector>

class ScoreKeeper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(int highScore READ highScore WRITE sethighScore NOTIFY highScoreChanged)

signals:
    void highScoreChanged();

public:
    ScoreKeeper(QQuickItem *parent = 0);

    QString name() const;
    void setName(const QString &name);

    int highScore() const;
    void sethighScore(const int &newScore);

private:
    QString m_name;
    int m_highScore;
    QVector<int> m_highScores;

    void sortHighScore();
};

#endif // SCOREKEEPER_H
