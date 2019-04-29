;DON TAČ PREKIDAČ
SetTitleMatchMode, 2
#IfWinActive Grand Theft Auto V
ceoonly = 1
ceotest = 2
cordx := 411
cordy := 114

; CEOMenu
Headhunter =	{enter}{down}{down}{enter}{down}{down}{down}{down}{down}{down}{down}{down}{enter}{enter}m
Heli =			{enter}{down}{down}{down}{down}{down}{enter}{down}{down}{down}{down}{enter}m
Health =		{down}{enter}{down}{down}{enter}{down}{enter}m
Armor =			{down}{enter}{down}{enter}{down}{down}{down}{down}{enter}m
Car =			{down}{down}{down}{enter}{enter}m
Smoke =			{down}{enter}{down}{down}{enter}{up}{enter}m
Ammo = 			{down}{enter}{down}{down}{down}{enter}{down}{down}{down}{enter}{right}{down}{down}{down}{enter}{right}{down}{down}{down}{enter}{right}{down}{down}{down}{enter}m

; PhoneMenu
Contacts = {down}{down}{right}{enter}
Lester = {left}{left}{enter}
Mechanic = {left}{up}{enter}

; Hotkey, Numpad0,		HELI
; Hotkey, Numpad1,		HEALTH
; Hotkey, Numpad2,		ARMOR
; Hotkey, Numpad3,		CAR
; Hotkey, Numpad4,		LESTER
; Hotkey, Numpad5,		AUTOFORWARD
; Hotkey, Numpad6,		MECHANIC
; Hotkey, Numpad7,		AUTOAFK
; Hotkey, NumpadDot,	HEADHUNTER
; Hotkey, NumpadDiv,	DOLE ENTER
; Hotkey, NumpadMult,	CARMOD
; Hotkey, NumpadSub,	SOLOPUBLIC
; Hotkey, NumpadAdd,	CONFIGURATION

Numpad0::GTA.CEOMenu(ceoonly, Heli)

Numpad1::GTA.CEOMenu(ceotest, Health)

Numpad2::GTA.CEOMenu(ceotest, Armor)

Numpad3::GTA.CEOMenu(ceotest, Car)

Numpad4::GTA.CEOPhone(Contacts, Lester)

Numpad5::GTA.CEOMenu()

Numpad6::GTA.CEOPhone(Contacts, Mechanic)

Numpad7::GTA.CEOMenu(ceotest, Ammo)

Numpaddiv::
while (GetKeyState("Numpaddiv", "P"))
{
Send, {down}
Sleep 1
Send, {enter}
}
return
Numpaddiv up::
return

Numpadmult::
SetKeyDelay, 10, 10
Send, {enter}{enter}
Send, {enter}{down}{enter}{bs}{enter}
Send, {enter}{enter}
Send, {enter}{enter}{enter}{enter}{bs}{bs}{bs}{enter}
Send, {enter}{enter}
Send, {enter}{up}{enter}{up}{enter}{bs}{bs}{enter}
Send, {enter}{enter}{down}{enter}{down}{down}{down}{down}{enter}{enter}{bs}{bs}{bs}{bs}{enter}
return

Numpadsub::
run C:\GTA5\gta5solopublic.exe GTA5.exe
text = Creating Solo Public Session, Please Wait...
Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
Gui, Color, ffffff
Gui +LastFound  
WinSet, TransColor, ffffff
Gui, Font, ffffff s20 wbold, Verdana ;changes font color, size and font
Gui, Add, Text, x20 y15, %text%
Gui, Show, NoActivate, Xn: 0, Yn: 0
sleep 8500
Gui, Destroy
run C:\GTA5\gta5solopublic.exe -r GTA5.exe
return

Numpadadd::
PixelGetColor, ColorVartest, %cordx%, %cordy%
MouseMove, %cordx%, %cordy%
MsgBox, Pixel Color Position.`nColor is = %ColorVartest%
return

NumpadDot::GTA.CEOMenu(ceoonly, Headhunter)


Class GTA
{
	CEOMenu(ceotype, script)
	{
		cordx := 411
		cordy := 114
		ColorCeo := 0x000000
		ColorNoCeo := 0xB96E2D
		ColorMission := 0x814D1F
		SetCapsLockState off
		SetKeyDelay, 50, 50
		Send, {bs}{bs}m
		Sleep 40
		PixelGetColor, ColorVar, %cordx%, %cordy%
		if ceotype = 1
		{
			if ColorVar = %ColorCeo%
			{
				SetKeyDelay, 1, 1
				Send, {down}%script%
			}
			else
			{
				SetKeyDelay, 1, 1
				Send, {bs}{bs}{bs}{bs}
			}
		}
		if ceotype = 2
		{
			if ColorVar = %ColorCeo%
			{
				SetKeyDelay, 1, 1
				Send, {down}%script%
			}
			else if ColorVar = %ColorNoCeo%
			{
				SetKeyDelay, 1, 1
				Send, %noscript%
			}
			else if ColorVar = %ColorMission%
			{
				SetKeyDelay, 1, 1
				Send, %noscript%
			}
			else if (ColorVar != ColorCeo && ColorVar != ColorNoCeo && ColorVar != ColorMission)
			{
				SetKeyDelay, 1, 1
				Send, {bs}{bs}{bs}{bs} 
				GTA.Message("Can't Do That Right Now.")
			}
		}
		if (ceotype != 1 && ceotype != 2)
		{
			GTA.Message("Define CEO Type!")
		}
	}
	
	CEOPhone(PhoneMenu, PhoneMenuSelect)
	{
		SetKeyDelay, 25, 25
		Send, {bs}{bs}{up}
		Sleep 500
		Send %PhoneMenu%
		Sleep 125
		SetKeyDelay, 70, 70
		Send, %PhoneMenuSelect%
			
	}
	
	Message(text)
	{
		Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
		Gui, Color, ffffff
		Gui +LastFound  
		WinSet, TransColor, ffffff
		Gui, Font, ffffff s20 wbold, Verdana ;changes font color, size and font
		Gui, Add, Text, x20 y15, %text%
		Gui, Show, NoActivate, Xn: 0, Yn: 0 
		WinWait [0,0,2,0,0]
		Gui, Destroy
	}
}
;            //////AUTOFORWARD//////
;Numpad5::
;toggle := !toggle
;if (toggle) {
;SendInput {w Down}{Numpad8 Down}
;} else {
;SendInput {w Up}{Numpad8 Up}
;}
;return