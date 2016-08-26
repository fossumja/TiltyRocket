import QtQuick 2.0
import QtQuick.Controls 1.4

Item
{
    id: scoreBoardPopup
    anchors.fill: parent

    property alias leaderBoard: leaderboard.text
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
        Text
        {
            id: leaderboard
            anchors.top: leaderBoardTitle.bottom
            anchors.right: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
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
