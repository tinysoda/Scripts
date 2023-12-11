
const { usleep, appRun, appKill, appState, appInfo, touchDown, touchMove, touchUp, toast, getColor, inputText, findText, findImage, rootDir, openURL } = at
const axios = require('axios');
var dataObjectVideo = null;

function InitDataVideo() {
    try {

        let pathFile = rootDir() + '/ObjVideo/objvideo.txt'
        const [data, error] = fs.readFile(pathFile)
        let dataObjectVideo = JSON.parse(data)
        return dataObjectVideo;
    }
    catch (error) {
        alert(error);
    }
    return null;
}

function funSwipeUp() {
    touchDown(2, 432.11, 844.48);
    usleep(34581.50);
    touchMove(2, 422.87, 808.84);
    usleep(16885.88);
    touchMove(2, 424.92, 763.04);
    usleep(16630.17);
    touchMove(2, 438.26, 678.52);
    usleep(16531.96);
    touchMove(2, 482.40, 596.06);
    usleep(16693.04);
    touchMove(2, 550.14, 527.83);
    usleep(15606.75);
    touchUp(2, 554.25, 523.76);
}

function funSwipeDown() {

    touchDown(6, 553.22, 677.50);
    usleep(33382.83);
    touchMove(6, 553.22, 696.84);
    usleep(16435.46);
    touchMove(6, 553.22, 713.15);
    usleep(16633.88);
    touchMove(6, 553.22, 732.48);
    usleep(16683.00);
    touchMove(6, 553.22, 755.89);
    usleep(16605.29);
    touchMove(6, 553.22, 784.41);
    usleep(16674.71);
    touchMove(6, 553.22, 817.00);
    usleep(16716.42);
    touchMove(6, 553.22, 848.55);
    usleep(16548.33);
    touchMove(6, 553.22, 872.99);
    usleep(16737.58);
    touchMove(6, 553.22, 893.35);
    usleep(16659.92);
    touchMove(6, 553.22, 908.62);
    usleep(16659.88);
    touchMove(6, 553.22, 920.83);
    usleep(16736.17);
    touchMove(6, 553.22, 928.99);
    usleep(16658.29);
    touchMove(6, 554.25, 935.10);
    usleep(16559.12);
    touchMove(6, 555.28, 941.21);
    usleep(16694.71);
    touchMove(6, 556.31, 946.29);
    usleep(16690.83);
    touchMove(6, 557.33, 950.37);
    usleep(16649.17);
    touchMove(6, 557.33, 951.38);
    usleep(16755.54);
    touchMove(6, 557.33, 952.40);
    usleep(16712.46);
    touchMove(6, 558.36, 953.42);
    usleep(33191.96);
    touchMove(6, 558.36, 954.44);
    usleep(16806.25);
    touchUp(6, 557.33, 965.63);

}

function funTap(no, x, y) {
    for (let i = 0; i < no; i++) {
        touchDown(0, x, y);
        usleep(16000);
        touchUp(0, x, y);
        usleep(500000);
    }
}

function funFindVideoByThumnail(capturedPart) {
    const targetImagePath = rootDir() + "/ThumnailNeedFind/" + capturedPart;
    var index = { x: 0, y: 0 }
    for (let y = 1; y <= 5; y++) {
        try {
            const options = {
                targetImagePath: targetImagePath,
                count: 3,
                threshold: 0.95,
                region: null,
                debug: false,
                method: 1,
            };
            const [result, error] = at.findImage(options);
            if (result.length > 0) {
                index = result[0];
                return index;
                break;
            }
            else {
                funSwipeDown()
                usleep(3000000)
            }
        }
        catch (error) {
            alert(error);
        }
        usleep(1000000)
    }
}

function funTapButton(textToFind) {
    for (let i = 0; i < 5; i++) {
        try {
            const [result, error] = at.findText({}, text => text.toLowerCase() == textToFind.toLowerCase())
            if (result.length > 0) {
                let index = result[0].bottomRight
                funTap(1, index.x, index.y)
                break;
            } else {
                usleep(1000000)
            }
        } catch (error) {
            toast(error)
        }
        usleep(1000000)
    }
}

function funCheckUpload() {
    const targetImagePath = "image/shareIcon.png"
    for (let y = 1; y <= 120; y++) {
        try {
            const options = {
                targetImagePath: targetImagePath,
                count: 3,
                threshold: 0.95,
                debug: true,
                method: 1,
            };
            const [result, error] = findImage(options);
            if (result.length > 0) {
                toast("Upload thanh cong")
                return true;
            }
            else {
                usleep(3000000)
                funTap(1, 226, 1273)
                toast("checking upload: " + y);
            }
        }
        catch (error) {
        }
    }
    return false
}

function funCaption(videoCaption) {
    funTap(1, 697, 430)
    usleep(2000000)

    inputText(videoCaption)
    usleep(500000)
    funTap(1, 684, 88)
    usleep(2000000)

    // Move text to the North
    touchDown(1, 350, 680);
    for (let y = 680; y >= 150; y -= 50) {
        usleep(12000);
        touchMove(1, 325, y);
    }
    touchUp(1, 325, 150);
    usleep(500000);
    usleep(16000);
    //Select the "NEXT" button
    funTap(1, 650, 1300)
}

function funTitleFinish(Caption) {
    funTap(1, 37, 178)
    usleep(2000000)
    // edit Video Title
    inputText(Caption)
    usleep(10000000)
    // Tap the text field 2 times
    funTap(1, 36, 175)
    usleep(500000)
    funTap(1, 36, 175)
    usleep(500000)
    // Tap the location 2 times
    funTap(1, 93, 646)
    usleep(500000)
    funTap(1, 93, 646)
    // choosing location
    const location = 'Washington D.C'
    usleep(1000000)
    inputText(location)
    // usleep(3000000)
    funTapButton(location)
}

function funOpenApp(app) {
    appKill(app)
    usleep(500000)
    appRun(app)
    usleep(5000000)
}

function funResultUpload(urlResultUpload) {
    axios.get(urlResultUpload)
        .then(function (response) {
            console.log(response);
        })
        .catch(function (error) {
            alert(error)
        })
}

function FunMain() {
    try {


        //Step 1: quét lấy data video
        toast("Init Data Video")
        dataObjectVideo = InitDataVideo();
        toast("Init Data Video Done")


        //Step 2: Download video
        if (dataObjectVideo.LinkDownloadVideo != null && dataObjectVideo.LinkDownloadVideo != "") {
            toast("Downloading video")
            openURL(dataObjectVideo.LinkDownloadVideo);
            usleep(10000000);

            //Step 3: Mở app TikTok
            toast("Open App Tiktok")
            const tiktok = "com.zhiliaoapp.musically";
            funOpenApp(tiktok)

            // UPLOAD VIDEO
            toast("Upload Video")
            funSwipeUp()
            usleep(16000)
            // Tap upload button
            funTap(1, 375, 1280)
            usleep(2000000)
            // Tap media button
            funTap(1, 625, 1100)
            usleep(2000000)

            //Step 4: Chọn video dựa vào thumnail
            // Getting thumbnail, name
            try {
                const thumbnailUrl = dataObjectVideo.ImageThumnail;
                const fileNameMatch = thumbnailUrl.match(/\/([^\/]+\.png)$/);
                // Extracting the captured part from the match result
                let capturedPart = fileNameMatch ? fileNameMatch[1] : null;
                const index = funFindVideoByThumnail(capturedPart)
                funTap(1, index.x, index.y)
            } catch (error) {
                alert(error)
            }

            usleep(2000000)
            //Step 5: Điền các thông tin về video

            // ĐIỀN CAPTION
            const videoCaption = dataObjectVideo.Caption.replace(/#.+/g, '');
            funCaption(videoCaption)
            usleep(500000)

            // ĐIỀN TITLE
            funTitleFinish(dataObjectVideo.Caption)

            // posting video
            usleep(500000)
            funTap(1, 541, 1258)
            usleep(10000000)




            //Step 6: Check upload xong.
            const uploadThanhCong = funCheckUpload()

            //Step 7: 
            //Lấy trạng thái upload ở bước 6. Trong thư mục ResultUpload tạo file dạng videoId_sucess hoặc videoId_error tương ứng theo trạng thái.

            const idVideo = dataObjectVideo.IdVideo
            // const resultUploadPathFile = rootDir() + '/ResultUpload/' + idVideo + '.txt'
            // const [resultData, error] = fs.readFile(resultUploadPathFile)
            // const videoUploadResult = JSON.parse(resultData)

            let urlResultUpload = null

            if (!uploadThanhCong) {
                urlResultUpload = 'http://' + dataObjectVideo.IpLocalDevice + ':8080/file/new?path=/ResultUpload/' + idVideo + '_ERROR.txt';
                // const pathFileErrorResultUpload = rootDir() + '/ResultUpload/' + idVideo + '_ERROR.txt';
            } else {
                urlResultUpload = 'http://' + dataObjectVideo.IpLocalDevice + ':8080/file/new?path=/ResultUpload/' + idVideo + '_SUCCESS.txt';
            }
            funResultUpload(urlResultUpload)
        }
    }
    catch (error) {
        alert(error)
    }

}
FunMain()