
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

/**
 * Adding Text to video
 */
function inputText() {
    // Select the text icon
    tap(1, 735, 500)
    usleep(500000)
    // TODO - Insert a string 

    // Select Done
    tap(1, 735, 100)
    // move text to 325,100
    moveText()
}


function tap(no, x, y) {
    for (i = 0; i < no; i++) {
        touchDown(0, x, y);
        usleep(500000);
        touchUp(0, x, y);
    }
}
function tikTokUpload() {
    //tap bottom upload button 
    tap(1, 325, 1300)
    usleep(2000000)
    // tap media button
    tap(1, 625, 1100)
    usleep(2000000)
    //select the latest media
    latestMedia(625, 1100);
    usleep(16000)
    // Adding text
    // inputText();
    usleep(500000)
    //Select the "NEXT" button
    tap(1, 650, 1300)
    // Select text field
    usleep(500000)
    tap(1, 300, 300)


}
let tiktok = "com.zhiliaoapp.musically";
appKill(tiktok);
usleep(1000000);
appRun(tiktok);
usleep(3000000);
swipeVertically(1);
usleep(500000);
toast("uploading");
tikTokUpload();


const tikTokState = appState(tiktok);

usleep(1000000);
