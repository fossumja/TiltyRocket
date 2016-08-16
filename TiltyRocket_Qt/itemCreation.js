var itemComponent = null;
var draggedItem = null;
var startingMouse;
var startPos;

function startDrop()
{
    startPos = Math.random() * mainWindow.width;
    loadComponent();
    checkGameOver();
}

//Creation is split into two functions due to an asynchronous wait while
//possible external files are loaded.

function loadComponent() {
    if (itemComponent != null) { // component has been previously loaded
        createItem();
        return;
    }

    itemComponent = Qt.createComponent("Asteroid.qml");
    if (itemComponent.status === Component.Loading)  //Depending on the content, it can be ready or error immediately
        component.statusChanged.connect(createItem);
    else
        createItem();
}

function createItem() {
    if (itemComponent.status === Component.Ready && draggedItem == null) {
        draggedItem = itemComponent.createObject(mainWindow, {"image": "images/resources/ball.png", "x": startPos, "y": -60, "z": 3});
    }
    else if (itemComponent.status === Component.Error)
    {
        draggedItem = null;
        console.log("error creating component");
        console.log(itemComponent.errorString());
    }
    return draggedItem;
}

function checkGameOver()
{
    if (draggedItem == null)
        return;

    if (mainWindow.gameOver) {
        draggedItem.created = true;
        //draggedItem.destroy();
        draggedItem = null;
    } else {
        draggedItem.created = true;
        draggedItem = null;
    }
}

