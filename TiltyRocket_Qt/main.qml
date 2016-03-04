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
            var newX = (wing.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
            var newY = (wing.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1)

            if (isNaN(newX) || isNaN(newY))
                return;

            if (newX < 0)
                newX = 0

            if (newX > mainWindow.width - wing.width)
                newX = mainWindow.width - wing.width

            if (newY < 18)
                newY = 18

            if (newY > mainWindow.height - wing.height)
                newY = mainWindow.height - wing.height

            if(mainWindow.width < mainWindow.height)
            {
                wing.x = newX
                wing.y = newY
            }
            else
            {
                wing.y = newX
                wing.x = newY
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
    Image
    {
        id: wing
        source: "resources/ICOrisV2.jpg"
        width: 150
        height: 150
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
}
