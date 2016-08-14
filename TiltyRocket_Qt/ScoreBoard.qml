import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: scoreBoardPopup
    anchors.fill: parent
    // Add a simple animation to fade in the popup
    // let the opacity go from 0 to 1 in 400ms
    PropertyAnimation { target: scoreBoardPopup; property: "opacity";
                                  duration: 400; from: 0; to: 1;
                                  easing.type: Easing.InOutQuad ; running: true }

    // This rectange is the a overlay to partially show the parent through it
    // and clicking outside of the 'dialog' popup will do 'nothing'
    Rectangle {
        anchors.fill: parent
        id: overlay
        color: "#000000"
        opacity: 0.6
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea {
            anchors.fill: parent
        }
    }

    // This rectangle is the actual popup
    Rectangle {
        id: scoreBoardWindow
        width: 100
        height: 62
        radius: 10
        anchors.centerIn: parent

        Text {
            anchors.centerIn: parent
            text: "This is the popup"
        }
            Button {
                id: retry
                x: parent.width * 0.25
                y: parent.height * 0.5
                text: qsTr("Retry")
                visible: mainWindow.gameOver ? true: false

                onClicked:
                {
                    gameOver = false
                }
            }

            Button {
                id: exit
                x: parent.width * 0.75
                y: parent.height * 0.5
                text: qsTr("Exit")
                visible: mainWindow.gameOver ? true: false

                onClicked: Qt.quit()
            }

        // For demo I do not put any buttons, or other fancy stuff on the popup
        // clicking the whole dialogWindow will dismiss it
        MouseArea{
            anchors.fill: parent
            onClicked: {
                // destroy object is needed when you dynamically create it
                scoreBoardPopup.destroy()
            }
        }
    }
}
