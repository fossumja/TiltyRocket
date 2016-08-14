import QtQuick 2.3
import QtQuick.Controls 1.0
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.2
import QtSensors 5.0
import "itemCreation.js" as Creator

ApplicationWindow
{
    title: "Arcade Mode"
    id: mainWindow
    width: 720
    height: 1280
    visible: true

    property int activeAsteroids: 0
    property int totalAsteroids: 10

    property int  score: 0
    property double additionalAsteroids: Math.floor(score/100)
    property bool gameOver: false

    property alias rocketX: redRocket.x
    property alias rocketY: redRocket.y
    property alias rocketWidth: redRocket.width
    property alias rocketHeight: redRocket.height
    property alias rocketMargin: redRocket.rocketMargin

    onGameOverChanged:
    {
        if(!gameOver) /* Create more asteroids */
        {

            var i
            for(i=0;i<totalAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
        else /* Display the score board */
        {
            Qt.createComponent("ScoreBoard.qml").createObject(mainWindow, {});
        }
    }

    onAdditionalAsteroidsChanged:
    {
        if(!gameOver)
        {
            var i
            for(i=activeAsteroids;i<totalAsteroids + additionalAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
        console.log("Active Asteroids: " + activeAsteroids +"    Total Asteroids: "+totalAsteroids + additionalAsteroids)
    }

    Rectangle
    {
        id: redRocket
        width: mainWindow.width/6
        height: redRocket.width * 2
        smooth: true

        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real redRocketCenter: redRocket.width / 2
        property real rocketMargin: redRocket.width /3
        x: centerX - redRocketCenter
        y: mainWindow.height - (redRocket.height + redRocket.width/4)

        /**** Debuging ****/
        Rectangle
        {
            anchors.fill: redRocket
            anchors.leftMargin: rocketMargin
            anchors.rightMargin: rocketMargin

            anchors.onFillChanged: anchors.fill = redRocket
            border.width: 5
            border.color: "magenta"
        }
        /**** Debuging ****/

        Accelerometer
        {
            id: rocketAccel
            dataRate: 100
            active: true

            function calcRoll(x,y,z)
            {
                return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
            }
            onReadingChanged:
            {

                var roll = (calcRoll(rocketAccel.reading.x, rocketAccel.reading.y, rocketAccel.reading.z) * .1)

                if(true)
                {

                    redRocket.rotation -= roll
                }
            }
        }
        Image
        {
            anchors.fill: redRocket
            source: "Images/resources/JunkRocket_1.png"
        }

        MouseArea
        {
            width: parent.width
            height: parent.height
            onClicked:
            {
                Creator.startDrop();
            }
        }

        Behavior on y
        {
            SmoothedAnimation
            {
                easing.type: Easing.Linear
                duration: 100
            }
        }
        Behavior on x
        {
            SmoothedAnimation
            {
                easing.type: Easing.Linear
                duration: 100
            }
        }
    }
    onActiveAsteroidsChanged:
    {
        if(!gameOver)
        {
            if(activeAsteroids < totalAsteroids)
            {
                Creator.startDrop();
            }
        }
    }

    Text
    {
        id: textBox1
        color: "#431cf1"
        text: mainWindow.score;
    }

    Timer
    {
        id: timer
        interval: 100;
        running: true;
        repeat: true;
        onTriggered:
        {
            if(!mainWindow.gameOver && !blastOffButton.visible) score = score + (1);
        }
    }

    Button {
        id: blastOffButton
        anchors.top: redRocket.top
        anchors.left: redRocket.left
        text: qsTr("Blast Off!")
        visible: true

        onClicked:
        {
            var i = 0;
            blastOffButton.visible = false
            for(i=0;i<totalAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
    }
}
