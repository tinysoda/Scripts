
const { usleep, appRun, appKill, appState, appInfo, touchDown, touchMove, touchUp, toast } = at


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

function tap(no, x, y) {
    for (i = 0; i < no; i++) {
        touchDown(0, x, y);
        usleep(16000);
        touchUp(0, x, y);
    }
}
function tikTokUpload() {
    tap(1, 325, 1300)
    usleep(2000000)
    tap(1, 625, 1100)
    usleep(2000000)
    tap(1, 625, 1100)
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
