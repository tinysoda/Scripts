; Only run this script when Stardew Valley is the active window
#IfWinActive ahk_exe Stardew Valley.exe

~LButton::
    while GetKeyState("LButton", "P")
    {
        ; Wait a tiny bit for the swing to actually start
        Sleep, 100 
        
        ; Send the animation cancel keys
        Send, {RShift Down}{Delete Down}{R Down}
        
        ; Short delay to ensure the game registers the press
        Sleep, 20
        
        ; Release the keys
        Send, {RShift Up}{Delete Up}{R Up}
        
        ; Small buffer before the next swing starts
        Sleep, 150
    }
return

#IfWinActive