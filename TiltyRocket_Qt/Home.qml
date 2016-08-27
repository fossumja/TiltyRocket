import QtQuick 2.0
import QtQuick.Controls 1.4

import "content"
import "databaseManager.js" as TestManager
ApplicationWindow
{
    id: home
    visible: true
    width: 720
    height: 1280

//    property int highScoreOne: 1000

//    property var highNames : ["","","","","","","","","",""]
//    property var highScores: [ 200, 0, 0, 0, 0, 0, 0, 0, 0, 0]
//    property alias scoreText: scoreCol.text
//    property int score : 100
//    property alias aboutBottom: aboutButton.bottom

    Rectangle
    {
        id: homeWindow
        anchors.centerIn: parent
        anchors.fill: parent

        property real aspectRatio: 3/4
        anchors.rightMargin: if(parent.width > aspectRatio * parent.height){(parent.width - aspectRatio * parent.height)/2} else {0}
        anchors.leftMargin: if(parent.width > aspectRatio * parent.height){(parent.width - aspectRatio * parent.height)/2} else {0}

        visible: true

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

        // This rectangle contains the menu
        Rectangle
        {
            id: menuWindow
            width: parent.width * 0.75
            height: parent.height - 50
            radius: 10
            anchors.centerIn: parent

            property real buttonHeight: menuWindow.height * 0.05;
            property real buttonWidth: menuWindow.width * 0.6;

            Rectangle
            {
                id: titleBox
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50

                width: parent.width - 200
                height: parent.height/8
                Image
                {
                    anchors.fill:parent
                    source: "images/resources/title.jpg"
                }
            }
            Button
            {
                id: arcadeModeButton
                width: menuWindow.buttonWidth
                height: menuWindow.buttonHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: titleBox.bottom
                anchors.topMargin: arcadeModeButton.height
                text: qsTr("Arcade Mode")
                visible: true

                onClicked:
                {
                    Qt.createComponent("content/ArcadeMode.qml").createObject(home, {});
                    homeWindow.visible = false;
                }
            }

            Button
            {
                id: settingsButton
                width: menuWindow.buttonWidth
                height: menuWindow.buttonHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: arcadeModeButton.bottom
                anchors.topMargin: settingsButton.height
                text: qsTr("Settings")
                visible: true

                onClicked:
                {

                }
            }
            Button
            {
                id: aboutButton
                width: menuWindow.buttonWidth
                height: menuWindow.buttonHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: settingsButton.bottom
                anchors.topMargin: aboutButton.height
                text: qsTr("About")
                visible: true

                onClicked:
                {
                    TestManager.saveHighScore("Max");
                    highScores[1] = 10;
                }
            }
        } /*menuWindow*/
    }/*homeWindow*/
} /*home*/

/*Testing */
//Rectangle
//{
//    id: leaderBoard
//    anchors.verticalCenter: parent.verticalCenter
//    anchors.top: aboutBottom
//    width: parent.width

//    Text
//    {
//        id: playerCol
//        horizontalAlignment: Text.AlignLeft
//        anchors.left: parent.left
//        anchors.top: parent.top
//        /*for some reason, I cannot set this or any monospaced font*/
//        //font.family: "FixedSys"
//        text: " 1. " + highNames[ 0] + "\n" +
//              " 2. " + highNames[ 1] + "\n" +
//              " 3. " + highNames[ 2] + "\n" +
//              " 4. " + highNames[ 3] + "\n" +
//              " 5. " + highNames[ 4] + "\n" +
//              " 6. " + highNames[ 5] + "\n" +
//              " 7. " + highNames[ 6] + "\n" +
//              " 8. " + highNames[ 7] + "\n" +
//              " 9. " + highNames[ 8] + "\n" +
//              "10. " + highNames[ 9] + "\n"
//    }
//    Text
//    {
//        id: scoreCol
//        horizontalAlignment: Text.AlignRight
//        anchors.right: parent.right
//        anchors.top: parent.top
//        /*for some reason, I cannot set this or any monospaced font*/
//        //font.family: "FixedSys"
////            text: highScores[ 0] + "\n" +
////                  highScores[ 1] + "\n" +
////                  highScores[ 2] + "\n" +
////                  highScores[ 3] + "\n" +
////                  highScores[ 4] + "\n" +
////                  highScores[ 5] + "\n" +
////                  highScores[ 6] + "\n" +
////                  highScores[ 7] + "\n" +
////                  highScores[ 8] + "\n" +
////                  highScores[ 9] + "\n"
//    }
//}

//        Dialog
//        {
//            id: nameInputDialog
//            anchors.centerIn: parent
//            z: 100

//            onClosed:
//            {
//                TestMode.saveHighScore(nameInputDialog.inputText);
//            }
//        }
//        Text
//        {
//            id: leaderboard
//            anchors.top: aboutButton.bottom
//            anchors.right: parent.horizontalCenter
//            verticalAlignment: Text.AlignVCenter
//            horizontalAlignment: Text.AlignRight
//        }
/*Testing */
