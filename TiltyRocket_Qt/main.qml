import QtQuick 2.3
import QtQuick.Controls 1.0
import QtQuick.Window 2.2
import QtSensors 5.0

ApplicationWindow
{
    title: "Accelerate rocket"
    id: mainWindow
    width: 1440
    height: 2560
    visible: true
    Accelerometer
    {
        id: accel
        dataRate: 100
        active:true

        onReadingChanged:
        {
            var oldX = rocket.x
            var oldY = rocket.y
            var newX = (rocket.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * 1)
            var newY = (rocket.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * 1)

            if (isNaN(newX) || isNaN(newY))
                return;

            if (newX < 0)
                newX = 0

            if (newX > mainWindow.width - rocket.width)
                newX = mainWindow.width - rocket.width

            if (newY < 18)
                newY = 18

            if (newY > mainWindow.height - rocket.height)
                newY = mainWindow.height - rocket.height

            if(mainWindow.width < mainWindow.height)
            {
                rocket.x = newX
                rocket.y = newY
            }
            else
            {
                rocket.y = newX
                rocket.x = newY
            }

            if(newY > oldY)
            {
                rocket.angle = Math.atan((newY - oldY) / (newX - oldX))*100
            }
            else
            {
                rocket.angle = Math.atan((newY - oldY) / (newX - oldX))*100 + 180
            }

            if (isNaN(rocket.angle))
                rocket.angle = 0

            console.log(oldX, " , ", newX, " , ", rocket.angle)

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
        id: rocket
        source: "resources/JunkRocket_1.png"
        width: 350
        height: 350
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real rocketCenter: rocket.width / 2
        x: centerX - rocketCenter
        y: centerY - rocketCenter
        property real angle: 0
        transform: Rotation { origin.x: 175; origin.y: 275; angle: rocket.angle }

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

        Behavior on transform
        {
            SmoothedAnimation
            {
                easing.type: Easing.Linear
                duration: 100
            }
        }

    }
}
