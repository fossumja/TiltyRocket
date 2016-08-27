import QtQuick 2.0
import QtQuick.Controls 1.4

Item
{
    id: scoreBoardPopup
    anchors.fill: parent

    property var highNames : ["","","","","","","","","",""]
    property var highScores: [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    property alias scoreText: scoreCol.text
    property alias playerText: playerCol.text
//    property alias leaderBoard: leaderboard.text
    // Add a simple animation to fade in the popup
    // let the opacity go from 0 to 1 in 400ms
    PropertyAnimation { target: scoreBoardPopup; property: "opacity";
        duration: 400; from: 0; to: 1;
        easing.type: Easing.InOutQuad ; running: true }

    // This rectange is the a overlay to partially show the parent through it
    // and clicking outside of the 'dialog' popup will do 'nothing'

    Rectangle
    {
        anchors.fill: parent
        id: overlay
        color: "#000000"
        opacity: 0.6
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea
        {
            anchors.fill: parent
        }
    }

    // This rectangle is the actual popup
    Rectangle
    {
        id: leaderBoardContainer
        width: parent.width * 0.75
        height: parent.height * 0.4
        radius: 10
        anchors.centerIn: parent

        Text
        {
            id: leaderBoardTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Leaderboard"
        }
//        Text
//        {
//            id: leaderboard
//            anchors.top: leaderBoardTitle.bottom
//            anchors.right: parent.horizontalCenter
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignRight
//        }
        Rectangle
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: leaderBoardTitle.bottom

            width: parent.width * 0.6

            border.color: "black"

            Text
            {
                id: playerCol
                horizontalAlignment: Text.AlignLeft
                anchors.left: parent.left
                anchors.top: parent.top
                text: " 1. " + highNames[ 0] + "\n" +
                      " 2. " + highNames[ 1] + "\n" +
                      " 3. " + highNames[ 2] + "\n" +
                      " 4. " + highNames[ 3] + "\n" +
                      " 5. " + highNames[ 4] + "\n" +
                      " 6. " + highNames[ 5] + "\n" +
                      " 7. " + highNames[ 6] + "\n" +
                      " 8. " + highNames[ 7] + "\n" +
                      " 9. " + highNames[ 8] + "\n" +
                      "10. " + highNames[ 9] + "\n"
            }
            Text
            {
                id: scoreCol
                horizontalAlignment: Text.AlignRight
                anchors.right: parent.right
                anchors.top: parent.top
                text: highScores[ 0] + "\n" +
                      highScores[ 1] + "\n" +
                      highScores[ 2] + "\n" +
                      highScores[ 3] + "\n" +
                      highScores[ 4] + "\n" +
                      highScores[ 5] + "\n" +
                      highScores[ 6] + "\n" +
                      highScores[ 7] + "\n" +
                      highScores[ 8] + "\n" +
                      highScores[ 9] + "\n"
            }
        }

        Button
        {
            id: retry
            y: 21
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5

            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.01

            text: qsTr("Retry")

            onClicked:
            {
                gameOver = false
                score = 0
                scoreBoardPopup.visible = false
            }
        }

        Button
        {
            id: exit

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5

            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.01
            text: qsTr("Exit")


            onClicked:
            {
                scoreBoardPopup.destroy()
                mainWindow.destroy()
                homeWindow.visible = true;
            }
        }
    }
}
