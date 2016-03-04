import QtQuick 2.3
import QtQuick.Controls 1.0
import QtQuick.Window 2.2
import QtSensors 5.0

ApplicationWindow
{
    title: "Accelerate wing"
    id: mainWindow
    width: 320
    height: 480
    visible: true

    Accelerometer
    {
        id: accel
        dataRate: 100
        active:true

        onReadingChanged:
        {
            var roll = (calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .001)
            var newY = (wing.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
            var radius = 100

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

            ball1.t = ball1.t + roll
            ball1.x = wing.centerX + radius * Math.cos(ball1.t)
            ball1.y = wing.centerY + radius * Math.sin(ball1.t)

            ball2.t = ball2.t + roll
            ball2.x = wing.centerX + radius * Math.cos(ball2.t)
            ball2.y = wing.centerY + radius * Math.sin(ball2.t)

            ball3.t = ball3.t + roll
            ball3.x = wing.centerX + radius * Math.cos(ball3.t)
            ball3.y = wing.centerY + radius * Math.sin(ball3.t)

            ball4.t = ball4.t + roll
            ball4.x = wing.centerX + radius * Math.cos(ball4.t)
            ball4.y = wing.centerY + radius * Math.sin(ball4.t)
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
    Image
    {
        id: wing
        source: "resources/Wing.png"
        width: 150
        height: 300
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real wingCenter: wing.width / 2
        x: centerX - wingCenter
        y: centerY - wingCenter

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
        id: ball1
        source: "resources/ball.png"
        width: 30
        height: 30
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real radius: 100
        property real t: 0
        x: centerX + radius * Math.cos(t)
        y: centerY + radius * Math.sin(t)

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
        width: 30
        height: 30
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real radius: 100
        property real t: Math.PI/2
        x: centerX + radius * Math.cos(t)
        y: centerY + radius * Math.sin(t)

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
        width: 30
        height: 30
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real radius: 100
        property real t: Math.PI
        x: centerX + radius * Math.cos(t)
        y: centerY + radius * Math.sin(t)

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
        width: 30
        height: 30
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real ballCenter: ball1.width / 2
        property real radius: 100
        property real t: 3*(Math.PI)/2
        x: centerX + radius * Math.cos(t)
        y: centerY + radius * Math.sin(t)

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
}
