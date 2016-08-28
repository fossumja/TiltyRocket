import QtQuick 2.3
import QtQuick.Controls 1.0
import QtSensors 5.0
import "itemCreation.js" as Creator

Image
{
    id: rootAsteroid
    source: "images/resources/ball.png"
    width: arcadeWindow.width/20
    height: arcadeWindow.width/20
    smooth: true
    property string componentFile: "Asteroid.qml"
    property bool created: false
    property real windowWidth
    property real windowHeight
    property real h: arcadeWindow.rocketHeight
    property real w: arcadeWindow.rocketWidth
    property real m: arcadeWindow.rocketMargin
    property real a: ((contMouse.mouseAngleCalc * 3.14) /180)
    property double calcRocketX: 0
    property double calcRocketY: 0

    property bool leftCheck: false
    property bool rightCheck: false
    property bool topCheck: false
    property bool bottomCheck: false

    property bool collision: false
    property double rocketMargin: 10
    Rectangle
    {
        id: rootAsteroidBorder
        opacity: 0.5
        anchors.fill: rootAsteroid
        border.width: 5
        //border.color: checkCollission(rootAsteroid.x, rootAsteroid.y) ? "red" : "green"
    }

    function checkCollission(x,y)
    {//ball y wrong, rocket x wrong
        calcRocketX = (arcadeWindow.width/2) + ((y - h*Math.sin(a))*Math.cos(a)) +h*Math.cos(a)
        calcRocketY = h*Math.sin(a)+ ((Math.cos(a))*(x-h*Math.cos(a)))
        leftCheck = ((x + width) > (calcRocketX + m));
        rightCheck = (x < (calcRocketX + w - m));
        topCheck = (y > calcRocketY);
        bottomCheck = (y < (calcRocketY + h));

        return(false)
        //return(leftCheck && rightCheck && topCheck && bottomCheck)

        //return (   ((x + width > (arcadeWindow.rocketX   + arcadeWindow.rocketMargin  )) && (x < (arcadeWindow.rocketX + arcadeWindow.rocketWidth    - arcadeWindow.rocketMargin  )))
        //        && ((y > (arcadeWindow.rocketY /*+ arcadeWindow.rocketMargin*/)) && (y < (arcadeWindow.rocketY + arcadeWindow.rocketHeight /*- arcadeWindow.rocketMargin*/))))
    }

    y: -rootAsteroid.height
//    x: arcadeWindow.mouseModeRate + rootAsteroid.x

    onXChanged:
    {
        rootAsteroid.collision = checkCollission(rootAsteroid.x, (arcadeWindow.height-rootAsteroid.y))
        console.log(x + ", " + calcRocketX + ", " + y + ", " + calcRocketY)
        //console.log(h + ", " + a + ", " + m + ", " + Math.sin(a))
        //console.log(leftCheck + ", " + rightCheck + ", " + topCheck + ", " + bottomCheck)
        /* Should probably put an animation here so they don't just disappear */
    }

    onYChanged:
    {
        rootAsteroid.x -= (arcadeWindow.height * contMouse.mouseVelXCalc)/200;  //200 = 5000/25 (speed of y fall)
        rootAsteroid.collision = checkCollission(rootAsteroid.x, (arcadeWindow.height-rootAsteroid.y))
        /* Should probably put an animation here so they don't just disappear */
    }

    onCollisionChanged:
    {
        if(collision)
        {
            contMouse.enabled = false
            if(!arcadeWindow.debugMode)
            arcadeWindow.gameOver = true;
        }
    }

    onCreatedChanged:
    {
        if (created)
        {
            rootAsteroid.z = 1;    // above the sky but below the ground layer
            arcadeWindow.activeAsteroids++;
            // once item is created, start moving offscreen
            dropYAnim.duration = 5000; //(arcadeWindow.height) * 16;
            dropAnim.running = true;
        }
        else
        {
            arcadeWindow.activeAsteroids--;
        }
    }

    SequentialAnimation on y
    {
        id: dropAnim
        running: false

        NumberAnimation { duration:Math.random() * 10000 }
        NumberAnimation
        {
            id: dropYAnim
            to: (arcadeWindow.height + rootAsteroid.height * 2)
        }
        ScriptAction
        {
            script: { rootAsteroid.created = false; rootAsteroid.destroy() }
        }
    }

    //turned this off cause the accel code was pissing me off. we need to restructure this crap
    /*Accelerometer
    {
        id: asteroidAccel
        dataRate: 100
        active: true

        function calcRoll(x,y,z)
        {
            //console.log(x + ", " + y + ", " + z)
            return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
        }
        onReadingChanged:
        {

            var roll = (calcRoll(asteroidAccel.reading.x, asteroidAccel.reading.y, asteroidAccel.reading.z) * .5)

            if(created)
            {
                rootAsteroid.x += roll
                if(arcadeWindow.gameOver)
                {
                    rootAsteroid.created = false;
                    rootAsteroid.destroy()
                }
            }
        }
    }*/
}


