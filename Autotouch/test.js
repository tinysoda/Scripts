
const { usleep, appRun, appKill, appState, appInfo, touchDown, touchMove, touchUp, toast, getColor } = at


function swipeVertically(times) {
    for (let i = 0; i < times; i++) {
        touchDown(1, 200, 300);
        for (let y = 300; y <= 900; y += 50) {
            usleep(12000);
            touchMove(1, 200, y);
        }
        touchUp(1, 200, 900);
        usleep(500000);
    }
}
/**
* Select the latest Media
* @param {Number} x
* @param {Number} y
* @return {void} 
*/
function latestMedia(x, y) {
    let [color, error] = getColor(x, y)
    if (error == null) {
        if (color != "16777215") {
            tap(1, x, y)
        } else {
            // alert(color);
            latestMedia(x - 100, y)
        }
    }
}

/**
 * Adding Text to video
 */
function inputText() {
    tap(1, 735, 500)
    usleep(500000)
    // Insert a string 

    tap(1, 735, 100)

}

function moveText() {
    touchDown(0, 325, 680)
    usleep(16000)
    for (let y = 680; y >= 100; y -= 50) {
        usleep(12000);
        touchMove(0, 325, y);
    }
    touchUp(0, 325, 100)
    usleep(500000)

}

function moveText() {
    // for (let i = 0; i < 5; i++) {
    touchDown(1, 350, 680);
    for (let y = 680; y >= 100; y -= 50) {
        usleep(12000);
        touchMove(1, 325, y);
    }
    touchUp(1, 325, 100);
    usleep(500000);
    // }
}

function tap(no, x, y) {
    for (i = 0; i < no; i++) {
        touchDown(0, x, y);
        usleep(500000);
        touchUp(0, x, y);
    }
}

// inputText()
swipeVertically()
// moveText()