/* This script file handles the database logic */
.import QtQuick.LocalStorage 2.0 as Sql
.import QtQuick 2.0 as Quick

var scoresURL = "";

function getHighScores()
{
    saveHighScore("");
}

function saveHighScore(name) {
    if (scoresURL != "" && name !== "")
        sendHighScore(name);

    var db = Sql.LocalStorage.openDatabaseSync("TiltyRocketScores", "1.0", "Local TiltyRocket High Scores", 100);
    var dataStr = "INSERT INTO Scores VALUES(?, ?)";
    var data = [name, score];
    db.transaction(function(tx)
    {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER)');
        if(name !== "")
        {
            tx.executeSql(dataStr, data);
        }

        var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score desc LIMIT 10');

       // var n = "Test";
        for (var i = 0; i < rs.rows.length; i++) {
            highNames[i] = rs.rows.item(i).name;
            highScores[i] = rs.rows.item(i).score;
        }

        playerText =
                " 1. " + highNames[ 0] + "\n" +
                " 2. " + highNames[ 1] + "\n" +
                " 3. " + highNames[ 2] + "\n" +
                " 4. " + highNames[ 3] + "\n" +
                " 5. " + highNames[ 4] + "\n" +
                " 6. " + highNames[ 5] + "\n" +
                " 7. " + highNames[ 6] + "\n" +
                " 8. " + highNames[ 7] + "\n" +
                " 9. " + highNames[ 8] + "\n" +
                "10. " + highNames[ 9] + "\n"  ;

        scoreText =
                highScores[ 0] + "\n" +
                highScores[ 1] + "\n" +
                highScores[ 2] + "\n" +
                highScores[ 3] + "\n" +
                highScores[ 4] + "\n" +
                highScores[ 5] + "\n" +
                highScores[ 6] + "\n" +
                highScores[ 7] + "\n" +
                highScores[ 8] + "\n" +
                highScores[ 9] + "\n"  ;
        //leaderBoard = n;
    });
}


function sendHighScore(name) {
    var postman = new XMLHttpRequest()
    var postData = "name=" + name + "&score=" + score;
    postman.open("POST", scoresURL, true);
    postman.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    postman.onreadystatechange = function() {
        if (postman.readyState == postman.DONE) {
            dialog.show("Your score has been uploaded.");
        }
    }
    postman.send(postData);
}

