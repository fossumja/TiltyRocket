import QtQuick 2.3
import QtQuick.Controls 1.0
import QtSensors 5.0
import "itemCreation.js" as Creator

Image
{
    id: rootAsteroid
    source: "Images/resources/ball.png"
    width: 60
    height: 60
    smooth: true
    property string componentFile: "Asteroid.qml"
    property bool created: false
    property real windowWidth
    property real windowHeight

    function checkCollission(x,y)
    {
        var collision = ((x > mainWindow.rocketX) && x < (mainWindow.rocketX + mainWindow.rocketWidth))
            && ((y > mainWindow.rocketY) && (y < mainWindow.rocketY + mainWindow.rocketHeight))
        if(collision){mainWindow.gameOver = true}
        return (collision);
    }

    y: -rootAsteroid.height
    onCreatedChanged:
    {
        if (created)
        {
            rootAsteroid.z = 1;    // above the sky but below the ground layer
            mainWindow.activeAsteroids++;
            // once item is created, start moving offscreen
            dropYAnim.duration = 5000; //(mainWindow.height) * 16;
            dropAnim.running = true;
        }
        else
        {
            mainWindow.activeAsteroids--;
        }
    }

    SequentialAnimation on y
    {
        id: dropAnim
        running: false
        NumberAnimation
        {
            id: dropYAnim
            to: (mainWindow.height + rootAsteroid.height * 2)
        }
        ScriptAction
        {
            script: { rootAsteroid.created = false; rootAsteroid.destroy() }
        }
    }

    Accelerometer
    {
        id: asteroidAccel
        dataRate: 100
        active: true

        function calcRoll(x,y,z)
        {
            return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
        }
        onReadingChanged:
        {

            var roll = (calcRoll(asteroidAccel.reading.x, asteroidAccel.reading.y, asteroidAccel.reading.z) * .1)

            if(created)
            {

                rootAsteroid.x += roll
                checkCollission(rootAsteroid.x, rootAsteroid.y)
            }
        }
    }
}

