@echo off

:: Check if the user provided a URL as an argument
if "%~1"=="" (
    echo Usage: download_video.bat video_url
    exit /b 1
)

:: Set the video URL with double quotes
set "VIDEO_URL="%~1""

:: Download the video using yt-dlp
yt-dlp -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" --merge-output-format mp4 %VIDEO_URL%

:: Check if the command was successful
if errorlevel 1 (
    echo Failed to download video
    exit /b 1
)

echo Download and merge completed successfully.
