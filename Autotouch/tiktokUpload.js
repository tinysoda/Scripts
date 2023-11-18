
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
* @param {Number} num1
* @param {Number} um
* @return {Number} sum
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

function tap(no, x, y) {
    for (i = 0; i < no; i++) {
        touchDown(0, x, y);
        usleep(16000);
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
