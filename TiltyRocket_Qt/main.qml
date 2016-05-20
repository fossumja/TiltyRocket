import QtQuick 2.3
import QtQuick.Controls 1.0
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
    property int startingAsteroids: 10
    property int totalAsteroids: startingAsteroids + additionalAsteroids

    property int  score: 0
    property double additionalAsteroids: gameOver ? 0 : Math.floor(score/100)

    property bool debugMode: false
    property bool gameOver: false

    property alias rocketX: redRocket.x
    property alias rocketY: redRocket.y
    property alias rocketWidth: redRocket.width
    property alias rocketHeight: redRocket.height
    property alias rocketMargin: redRocket.rocketMargin

    onGameOverChanged:
    {
        if(!gameOver)
        {

            var i
            for(i=0;i<startingAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
    }

    onAdditionalAsteroidsChanged:
    {
        if(!gameOver)
        {
            var i
            for(i=activeAsteroids;i<totalAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
        //console.log("Active Asteroids: " + activeAsteroids +"    Total Asteroids: "+totalAsteroids + additionalAsteroids)
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

        onRotationChanged: console.log(activeAsteroids)
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

                var roll = (calcRoll(rocketAccel.reading.x, rocketAccel.reading.y, rocketAccel.reading.z)* 0.2)

                if(roll < 0)
                {
                    redRocket.rotation = redRocket.rotation < 45 ? redRocket.rotation - (roll ) : redRocket.rotation
                }
                else
                {
                    redRocket.rotation = redRocket.rotation > -45 ? redRocket.rotation - (roll ) : redRocket.rotation
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
            else score = 0
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
            for(i=0;i<startingAsteroids;i++)
            {
                Creator.startDrop();
            }
        }
    }

    Button {
        id: retry
        x: mainWindow.width * 0.25
        y: mainWindow.height * 0.5
        text: qsTr("Retry")
        visible: gameOver ? true: false

        onClicked:
        {
            gameOver = false
        }
    }

    Button {
        id: exit
        x: mainWindow.width * 0.75
        y: mainWindow.height * 0.5
        text: qsTr("Exit")
        visible: gameOver ? true: false

        onClicked: Qt.quit()
    }
}

//Image
//{
//    id: ball1
//    source: "Images/resources/Bluebubble.svg"
//    width: 60
//    height: 60
//    smooth: true
//    property real centerX: mainWindow.width / 2
//    property real centerY: mainWindow.height / 2
//    property real ballCenter: ball1.width / 2
//    property real t: 0


//    function modX(myX, randomX)
//    {
//        ball1.x = myX;
//    }

////        x: {if(y < mainWindow.height + ball1.height) {return (Math.random() * mainWindow.width)}
////        else {/*return (x + 2)*/}}
//    y: -ball1.height

//    SequentialAnimation on y
//    {
//        running: true
//        loops: Animation.Infinite
//        NumberAnimation {duration: Math.random()*500}
//        NumberAnimation {to: (mainWindow.height + ball1.height * 2); duration: 5000 }
//    }
////        SequentialAnimation {
////            running: true
////            loops: Animation.Infinite
////            NumberAnimation { target: ball1; property: "x"; to: 0; duration: 1000 }
//////            NumberAnimation { target: ball1; property: "y"; to: 50; duration: 1000 }
////            NumberAnimation { target: ball1; property: "x"; to: 500; duration: 1000 }
//////            NumberAnimation { target: ball1; property: "y"; to: 500; duration: 1000 }
////        }


//    Behavior on y{SmoothedAnimation{easing.type: Easing.Linear; duration: 100}}
//    Behavior on x{SmoothedAnimation{easing.type: Easing.Linear; duration: 100}}

//    onYChanged: {
//       if (y < mainWindow.height + ball1.height) {ball1.x = Qt.binding( function() {return Math.random() * mainWindow.width})}
//    }
//    Text
//    {
//        anchors.centerIn: ball1
//        text: Math.round(ball1.x)

//    }
//}

//Accelerometer
//{
//    id: accel
//    dataRate: 100
//    active: true

//    function calcPitch(x,y,z)
//    {
//        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
//    }
//    function calcRoll(x,y,z)
//    {
//         return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
//    }
//    onReadingChanged:
//    {

//        var roll = (calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
//        textBox1.text = roll;
//          //ball1.x = ball1.x + roll; event.accepted = false;

//        //if((ball1.y > 0) && (ball1.y < mainWindow.height)) {
//        //    ball1.modX(ball1.x + roll)
//        // console.log(ball1.y)
//        //}
//          //asteroid0.x = Qt.binding ( function() {return asteroid0.x + roll})
//          ball3.x = ball3.x + roll
//          ball4.x = ball4.x + roll

//        if(checkCollission(ball1.x, ball1.y) ||
//           //checkCollission(asteroid1.x, asteroid1.y) ||
//           checkCollission(ball3.x, ball3.y) ||
//           checkCollission(ball4.x, ball4.y)   )
//        {
//            retry.visible = true;
//            exit.visible = true;
//            //Qt.quit()
//        }
//    }
//}
//Image
//{
//    id: ball3
//    source: "Images/resources/ball.png"
//    width: 60
//    height: 60
//    smooth: true
//    property real centerX: mainWindow.width / 2
//    property real centerY: mainWindow.height / 2
//    property real ballCenter: ball1.width / 2
//    property real t: Math.PI

//    x: Math.random() * mainWindow.width
//    y: -ball3.height

//    SequentialAnimation on y
//    {
//        running: true
//        loops: Animation.Infinite
//        NumberAnimation { duration:Math.random() * 5000 }
//        NumberAnimation {to: (mainWindow.height + ball3.height * 2); duration: 5000 }
//    }

//    Behavior on y
//    {
//        SmoothedAnimation
//        {
//            easing.type: Easing.Linear
//            duration: 100
//        }
//    }
//    Behavior on x
//    {
//        SmoothedAnimation
//        {
//            easing.type: Easing.Linear
//            duration: 100
//        }
//    }
//    Text
//    {
//        anchors.centerIn: parent
//        text: Math.round(parent.x)
//    }
//}

//Image
//{
//    id: ball4
//    source: "Images/resources/ball.png"
//    width: 60
//    height: 60
//    smooth: true
//    property real centerX: mainWindow.width / 2
//    property real centerY: mainWindow.height / 2
//    property real ballCenter: ball1.width / 2
//    property real t: 3*(Math.PI)/2

//    x: Math.random() * mainWindow.width
//    y: -ball4.height

//    SequentialAnimation on y
//    {
//        running: true
//        loops: Animation.Infinite
//        NumberAnimation { duration:Math.random() * 5000 }
//        NumberAnimation {to: (mainWindow.height + ball4.height * 2); duration: 5000 }
//    }

//    Behavior on y
//    {
//        SmoothedAnimation
//        {
//            easing.type: Easing.Linear
//            duration: 100
//        }
//    }
//    Behavior on x
//    {
//        SmoothedAnimation
//        {
//            easing.type: Easing.Linear
//            duration: 100
//        }
//    }
//    Text
//    {
//        anchors.centerIn: parent
//        text: Math.round(parent.x)
//    }
//}
