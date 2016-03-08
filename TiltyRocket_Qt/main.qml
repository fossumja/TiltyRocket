import QtQuick 2.3
import QtQuick.Controls 1.0
import QtQuick.Window 2.2
import QtSensors 5.0

ApplicationWindow
{
    title: "Accelerate ship"
    id: mainWindow
    width: 720
    height: 1280
    visible: true

    property real pathRadius: 200
    Accelerometer
    {
        id: accel
        dataRate: 100
        active:true

        onReadingChanged:
        {
            var roll = (calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
            var newY = (redRocket.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1)

            if (isNaN(roll) || isNaN(newY))
                return;

//            if (newX < 0)
//                newX = 0

//            if (newX > mainWindow.width - ball1.width)
//                newX = mainWindow.width - ball1.width

            if (newY < 18)
                newY = 18

            if (newY > mainWindow.height - ball1.height)
                newY = mainWindow.height - ball1.height

//            ball1.t = ball1.t + roll
            ball1.x = ball1.x + roll
//            ball1.y = redRocket.centerY + mainWindow.pathRadius  * Math.sin(ball1.t)

//            ball2.t = ball2.t + roll
              ball2.x = ball2.x + roll
//            ball2.y = redRocket.centerY + mainWindow.pathRadius * Math.sin(ball2.t)

//            ball3.t = ball3.t + roll
              ball3.x = ball3.x + roll
//            ball3.y = redRocket.centerY + mainWindow.pathRadius * Math.sin(ball3.t)

//            ball4.t = ball4.t + roll
              ball4.x = ball4.x + roll
//            ball4.y = redRocket.centerY + mainWindow.pathRadius * Math.sin(ball4.t)
            if(checkCollission(ball1.x, ball1.y) ||
               checkCollission(ball2.x, ball2.y) ||
               checkCollission(ball3.x, ball3.y) ||
               checkCollission(ball4.x, ball4.y)   )
            {
                retry.visible = true;
                exit.visible = true;
                //Qt.quit()
            }
        }
    }

    function calcPitch(x,y,z)
    {
        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
    }
    function calcRoll(x,y,z)
    {
         return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
    }

    function checkCollission(x,y)
    {
        return (x > redRocket.x && x < (redRocket.x + redRocket.width)) && ((y > redRocket.y) && (y < redRocket.y + redRocket.height));
    }

    Image
    {
        id: redRocket
        source: "resources/JunkRocket_1.png"
        width: mainWindow.width/6
        height: redRocket.width * 2
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real redRocketCenter: redRocket.width / 2
        x: centerX - redRocketCenter
        y: mainWindow.height - (redRocket.height + redRocket.width/4)

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
        MouseArea
        {
            width: parent.width
            height: parent.height
            onClicked: Qt.quit()
        }
    }

    Image
    {
        id: ball1
        source: "resources/Bluebubble.svg"
        width: 60
        height: 60
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real t: 0

        x: mainWindow.width/2
        y: mainWindow.height/2//-ball1.height

        SequentialAnimation on y
        {
            running: true
            loops: Animation.Infinite
            NumberAnimation {duration: Math.random()*1000}
            //NumberAnimation {to: (mainWindow.height + ball1.height * 2); duration: 5000 }
            PropertyAction {property: "x"; value: Math.random()* mainWindow.width }
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
    Image
    {
        id: ball2
        source: "resources/ball.png"
        width: 60
        height: 60
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real t: Math.PI/2

        x: Math.random() * mainWindow.width
        y: -ball2.height

        SequentialAnimation on y
        {
            running: true
            loops: Animation.Infinite
            NumberAnimation { duration:Math.random() * 5000 }
            NumberAnimation { to: (mainWindow.height + ball2.height * 2); duration: 5000 }
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

    Image
    {
        id: ball3
        source: "resources/ball.png"
        width: 60
        height: 60
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real t: Math.PI

        x: Math.random() * mainWindow.width
        y: -ball3.height

        SequentialAnimation on y
        {
            running: true
            loops: Animation.Infinite
            NumberAnimation { duration:Math.random() * 5000 }
            NumberAnimation {to: (mainWindow.height + ball3.height * 2); duration: 5000 }
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

    Image
    {
        id: ball4
        source: "resources/ball.png"
        width: 60
        height: 60
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real t: 3*(Math.PI)/2

        x: Math.random() * mainWindow.width
        y: -ball4.height

        SequentialAnimation on y
        {
            running: true
            loops: Animation.Infinite
            NumberAnimation { duration:Math.random() * 5000 }
            NumberAnimation {to: (mainWindow.height + ball4.height * 2); duration: 5000 }
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

    Button {
        id: retry
        x: mainWindow.width * 0.25
        y: mainWindow.height * 0.5
        text: qsTr("Retry")
        visible: false

        onClicked:
        {

            retry.visible = false;
            exit.visible = false;
        }
    }

    Button {
        id: exit
        x: mainWindow.width * 0.75
        y: mainWindow.height * 0.5
        text: qsTr("Exit")
        visible: false

        onClicked: Qt.quit()
    }
}
