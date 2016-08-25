/* This script file handles the database logic */
.import QtQuick.LocalStorage 2.0 as Sql
.import QtQuick 2.0 as Quick

var maxColumn = 10;
var maxRow = 15;
var maxIndex = maxColumn * maxRow;
var board = new Array(maxIndex);
var component;
var scoresURL = "";
var gameDuration = 1000000;

//![2]
function saveHighScore(name) {
    if (scoresURL != "")
        sendHighScore(name);

    var db = Sql.LocalStorage.openDatabaseSync("SameGameScores", "1.0", "Local SameGame High Scores", 100);
    var dataStr = "INSERT INTO Scores VALUES(?, ?, ?, ?)";
    var data = [name, 444, maxColumn + "x" + maxRow, Math.floor(gameDuration / 1000)];
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER, gridSize TEXT, time NUMBER)');
        tx.executeSql(dataStr, data);

        var rs = tx.executeSql('SELECT * FROM Scores WHERE gridSize = "10x15" ORDER BY score desc LIMIT 10');
        var r = "\nHIGH SCORES for a standard sized grid\n\n"
        for (var i = 0; i < rs.rows.length; i++) {
            r += (i + 1) + ". " + rs.rows.item(i).name + ' got ' + rs.rows.item(i).score + ' points in ' + rs.rows.item(i).time + ' seconds.\n';
        }
        leaderboard.text = r;
    });
}
//![2]

//![1]
function sendHighScore(name) {
    var postman = new XMLHttpRequest()
        var postData = "name=" + name + "&score=" + 555 + "&gridSize=" + maxColumn + "x" + maxRow + "&time=" + Math.floor(gameDuration / 1000);
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
