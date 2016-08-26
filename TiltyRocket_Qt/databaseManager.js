/* This script file handles the database logic */
.import QtQuick.LocalStorage 2.0 as Sql
.import QtQuick 2.0 as Quick

var scoresURL = "";

//![2]
function saveHighScore(name) {
    if (scoresURL != "" && name !== "")
        sendHighScore(name);

    var db = Sql.LocalStorage.openDatabaseSync("TiltyRocketScores", "1.0", "Local TiltyRocket High Scores", 100);
    var dataStr = "INSERT INTO Scores VALUES(?, ?)";
    var data = [name, score];
    db.transaction(function(tx)
    {
        if(name !== "")
        {
            tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER)');
            tx.executeSql(dataStr, data);
        }

        var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score desc LIMIT 10');
        var n = "\n\n"
        var s = "\n\n"
        for (var i = 0; i < rs.rows.length; i++) {
            n += (i + 1) + ": " + rs.rows.item(i).name + '      ' + rs.rows.item(i).score + '\n';
        }
        leaderBoard = n;
    });
}
//![2]

//![1]
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
//![1]
