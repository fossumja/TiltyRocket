#include "scorekeeper.h"

#include <QtAlgorithms>

ScoreKeeper::ScoreKeeper(QQuickItem *parent)
    : QObject(parent)
{

}

QString ScoreKeeper::name() const
{
    return m_name;
}

void ScoreKeeper::setName(const QString &name)
{
    m_name = name;
}

int ScoreKeeper::highScore() const
{
    return m_highScore;
}

void ScoreKeeper::sethighScore(const int &newScore)
{
    m_highScores.push_front(newScore);
    this->sortHighScore();
    m_highScore = newScore;
}

void ScoreKeeper::sortHighScore()
{
    qSort(m_highScores.begin(), m_highScores.end(), qGreater<int>());
}
