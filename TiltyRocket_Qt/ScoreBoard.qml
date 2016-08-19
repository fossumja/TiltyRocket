import QtQuick 2.0
import QtQuick.Controls 1.4

Item
{
    id: scoreBoardPopup
    anchors.fill: parent
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
        id: scoreBoard
        width: parent.width * 0.75
        height: parent.height * 0.4
        radius: 10
        anchors.centerIn: parent

        Text
        {
            id: leaderboardTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Leaderboard"

        }
        Text
        {
            id: playerOne
            anchors.top: leaderboardTitle.bottom
            anchors.right: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight

            text: "Player One:"
            Text
            {
                id: scoreOne
                anchors.left: parent.right
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                width: 100

                text: home.highScoreOne
            }
        }
        Text
        {
            id: playerTwo
            anchors.top: playerOne.bottom
            anchors.right: parent.horizontalCenter

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight

            text: "Player Two:"
            Text
            {
                id: scoreTwo
                anchors.left: parent.right
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                width: 100
                text: " " + 3
            }
        }
        Text
        {
            id: playerThree
            anchors.top: playerTwo.bottom
            anchors.right: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight

            text: "Player Three:"
            Text
            {
                id: scoreThree
                anchors.left: parent.right
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                width: 100
                text: " " + 3
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
                // destroy object is needed when you dynamically create it
                scoreBoardPopup.destroy()
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
