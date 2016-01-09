import QtQuick 2.3
import QtQuick.Window 2.2
import QtSensors 5.5

Window {
    property alias ball: ball
    width: 200
    height: 200
    visible: true

    // ---- Here's the crap I added for the accelerometer
    /*Accelerometer {
        id: accel
        dataRate: 100
        active:true
        onReadingChanged: {
            var newX = (ball.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
            var newY = (ball.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1)

            if (isNaN(newX) || isNaN(newY))
                return;

            if (newX < 0)
                newX = 0

            if (newX > mainWindow.width - ball.width)
                newX = mainWindow.width - ball.width

            if (newY < 18)
                newY = 18

            if (newY > mainWindow.height - ball.height)
                newY = mainWindow.height - ball.height

            ball.x = newX
            ball.y = newY
        } //onReadingChanged
    } //Accelerometer

    function calcPitch(x,y,z) {
        return -(Math.atan(y / Math.sqrt(x * x + z * z)) * 57.2957795);
    }
    function calcRoll(x,y,z) {
         return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
    }
    // ---- END crap I added for the accelerometer*/

    Image {
        id: ball
        x: 60
        y: 106
        width: 17
        height: 17
        fillMode: Image.PreserveAspectCrop
        source: "/ball.png"
    } //Image

    Text {
        id: text1
        x: 6
        y: 9
        text: qsTr("X")
        font.pixelSize: 12
    }

    Text {
        id: text2
        x: 6
        y: 27
        text: qsTr("Y")
        font.pixelSize: 12
    }

    Text {
        id: text3
        x: 6
        y: 45
        text: qsTr("Z")
        font.pixelSize: 12
    }

    TextEdit {
        id: txtX
        x: 19
        y: 9
        width: 47
        height: 14
        text: qsTr("Text Edit")
        font.pixelSize: 12
    }

    TextEdit {
        id: txtY
        x: 19
        y: 27
        width: 47
        height: 14
        text: qsTr("Text Edit")
        font.pixelSize: 12
    }

    TextEdit {
        id: txtZ
        x: 19
        y: 45
        width: 47
        height: 14
        text: qsTr("Text Edit")
        font.pixelSize: 12
    }

    Text {
        id: text4
        x: 82
        y: 9
        text: qsTr("Velocity")
        font.pixelSize: 12
    }

    TextEdit {
        id: txtVelocity
        x: 129
        y: 9
        width: 42
        height: 14
        text: qsTr("Text Edit")
        font.pixelSize: 12
    }

    MouseArea {
        id: mouseArea1
        x: 100
        y: 100
        width: 100
        height: 100
    }
}
