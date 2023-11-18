const { screenshot, getColor } = at
let shadowrocket = "com.liguangming.Shadowrocket";
function tap(no, x, y) {
    for (i = 0; i < no; i++) {
        at.touchDown(0, x, y);
        at.usleep(16000);
        at.touchUp(0, x, y);
    }
}



// const [result, error] = at.getColor(650, 200)
// if (error) {
//     alert('Failed to get color, error: %s', error)
// } else {
//     alert('Got result by getColor', result)
// }
// let color=getPixelColor(650,200);
// let offColor="15263978";
let onColor = "16777215";
at.appKill(shadowrocket);
at.usleep(1500000);
at.appRun(shadowrocket);
at.usleep(2000000);
let [color, error] = getColor(650, 200)
at.usleep(500000);
// alert(color);
if (color != onColor) {
    at.usleep(500000);
    tap(1, 650, 200);
}
at.usleep(500000);
// at.appKill(shadowrocket);


