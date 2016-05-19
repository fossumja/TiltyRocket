import QtQuick 2.3
import QtQuick.Controls 1.0
import QtSensors 5.0
import "itemCreation.js" as Creator

Image
{
    id: rootAsteroid
    source: "Images/resources/ball.png"
    width: mainWindow.width/20
    height: mainWindow.width/20
    smooth: true
    property string componentFile: "Asteroid.qml"
    property bool created: false
    property real windowWidth
    property real windowHeight

    property bool collision: false
    property double rocketMargin: 10
    Rectangle
    {
        id: rootAsteroidBorder
        opacity: 0.5
        anchors.fill: rootAsteroid
        border.width: 5
        border.color: checkCollission(rootAsteroid.x, rootAsteroid.y) ? "red" : "green"
    }

    function checkCollission(x,y)
    {
        return (   ((x + width > (mainWindow.rocketX   + mainWindow.rocketMargin  )) && (x < (mainWindow.rocketX + mainWindow.rocketWidth    - mainWindow.rocketMargin  )))
                && ((y > (mainWindow.rocketY /*+ mainWindow.rocketMargin*/)) && (y < (mainWindow.rocketY + mainWindow.rocketHeight /*- mainWindow.rocketMargin*/))))
    }

    y: -rootAsteroid.height

    onCollisionChanged:
    {
        if(collision)
        {
            mainWindow.gameOver = true;
        }
    }

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

        NumberAnimation { duration:Math.random() * 5000 }
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
                rootAsteroid.collision = checkCollission(rootAsteroid.x, rootAsteroid.y)
                /* Should probably put an animation here so they don't just disappear */
                if(mainWindow.gameOver)
                {
                    rootAsteroid.created = false;
                    rootAsteroid.destroy()
                }
            }
        }
    }
}


