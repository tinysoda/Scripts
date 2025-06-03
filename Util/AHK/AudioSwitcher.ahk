#Requires AutoHotkey v2.0

audioDevices := [
    "Speakers ([AV] MX-T40)",
    "Speakers (2- Logitech G733 Gaming Headset)"
]

currentIndex := 0

#F2:: {
    global currentIndex, audioDevices
    currentIndex := Mod(currentIndex, audioDevices.Length) + 1
    SoundOutput(audioDevices[currentIndex])
    ToolTip("Switched to: " audioDevices[currentIndex])
    SetTimer(() => ToolTip(), -1500)
}


SoundOutput(DeviceName?) {
    list := _DeviceList()
    deviceId := _GetDeviceID(DeviceName, list)
    if (!IsSet(DeviceName)) {
        return LTrim(list, "`n")
    }
    if (deviceId = "") {
        MsgBox('Device "' DeviceName '" not found.`n`nCurrent devices:`n' list, "Error", 0x40010)
        return
    }
    try {
        IPolicyConfig := ComObject("{870AF99C-171D-4F9E-AF0D-E63DF40C2BC9}", "{F8679F50-850A-41CF-9C72-430F290290C8}")
        ComCall(13, IPolicyConfig, "Str", deviceId, "UInt", 0)
    } catch {
        MsgBox("SoundOutput() failed for device " DeviceName, "Error", 0x40010)
    }
}

_DeviceList() {
    static eRender := 0, STGM_READ := 0, DEVICE_STATE_ACTIVE := 1
    devices := Map()
    IMMDeviceEnumerator := ComObject("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
    
    IMMDeviceCollection := 0
    if ComCall(3, IMMDeviceEnumerator, "UInt", eRender, "UInt", DEVICE_STATE_ACTIVE, "Ptr*", &IMMDeviceCollection) != 0 {
        MsgBox("Failed to get audio device collection", "Error", 0x40010)
        return devices
    }

    count := 0
    if ComCall(3, IMMDeviceCollection, "UInt*", &count) != 0 {
        MsgBox("Failed to get device count", "Error", 0x40010)
        return devices
    }

    pk := Buffer(20, 0)
    pv := Buffer(A_PtrSize = 8 ? 24 : 16, 0)

    loop count {
        IMMDevice := 0
        ComCall(4, IMMDeviceCollection, "UInt", A_Index - 1, "Ptr*", &IMMDevice)
        ComCall(5, IMMDevice, "Str*", &devId)
        IPropertyStore := 0
        ComCall(4, IMMDevice, "UInt", STGM_READ, "Ptr*", &IPropertyStore)
        ObjRelease(IMMDevice)

        DllCall("ole32\CLSIDFromString", "Str", "{A45C254E-DF1C-4EFD-8020-67D146A850E0}", "Ptr", pk.Ptr)
        NumPut("UInt", 14, pk.Ptr, 16)
        ComCall(5, IPropertyStore, "Ptr", pk.Ptr, "Ptr", pv.Ptr)
        ObjRelease(IPropertyStore)

        pwszVal := NumGet(pv.Ptr, 8, "Ptr")
        devName := StrGet(pwszVal)
        devices[devName] := devId
    }

    ObjRelease(IMMDeviceCollection)
    return devices
}

_GetDeviceID(DeviceName, list) {
    clone := list.Clone()
    listText := ""
    found := ""
    for name, id in clone {
        if (InStr(name, DeviceName)) {
            found := id
        }
        listText .= "`n- " name
    }
    return found
}
