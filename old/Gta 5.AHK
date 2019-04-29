;DON TAČ PREKIDAČ
SetTitleMatchMode, 2
#IfWinActive Grand Theft Auto V
cordx := 411
cordy := 114
ColorCeo := 0xB96E2D
ColorNoCeo := 0x834E20
ColorMission := 0x000000

; CEOMenu
Headhunter =	{down}{down}{enter}{down}{down}{down}{down}{down}{down}{down}{down}{enter}{enter}m
Heli =			{down}{down}{down}{down}{down}{enter}{down}{down}{down}{down}{enter}m
Health =		{down}{down}{enter}{enter}
Armor =			{down}{enter}{down}{down}{down}{down}{enter}m
Car =			{enter}{enter}m
Smoke =			{down}{down}{enter}{up}{enter}m
Ammo = 			{down}{down}{down}{enter}{down}{down}{down}{enter}{right}{down}{down}{down}{enter}{right}{down}{down}{down}{enter}{right}{down}{down}{down}{enter}m

; PhoneMenu
Contacts = {down}{down}{right}{enter}
Lester = {left}{left}{up}{enter}
Mechanic = {left}{up}{enter}
Taxi = {left}{left}{left}{up}{up}{enter}
Marryweather = {left}{up}{enter}

; Hotkey, Numpad0,		HELI
; Hotkey, Numpad1,		HEALTH
; Hotkey, Numpad2,		ARMOR
; Hotkey, Numpad3,		CAR
; Hotkey, Numpad4,		LESTER
; Hotkey, Numpad5,		TAXI
; Hotkey, Numpad6,		MECHANIC
; Hotkey, Numpad7,		AUTOAFK
; Hotkey, Numpad8,		MERRYWEATHER
; Hotkey, NumpadDot,	HEADHUNTER
; Hotkey, NumpadDiv,	DOLE ENTER
; Hotkey, NumpadMult,	CARMOD
; Hotkey, NumpadSub,	SOLOPUBLIC
; Hotkey, NumpadAdd,	CONFIGURATION

Numpad0::GTA.CEOMenu("SecuroServ", Heli, "ceoonly")

Numpad1::GTA.CEOMenu("Inventory", Health, "ceotest")

Numpad2::GTA.CEOMenu("Inventory", Armor, "ceotest")

Numpad3::GTA.CEOMenu("Vehicles", Car, "ceotest")

Numpad4::GTA.CEOPhone(Contacts, Lester)

Numpad5::GTA.CEOPhone(Contacts, Taxi)

Numpad6::GTA.CEOPhone(Contacts, Mechanic)

Numpad7::GTA.CEOMenu("Inventory", Ammo, "ceotest")

Numpad8::GTA.CEOPhone(Contacts, Marryweather)

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
SetKeyDelay, 15, 15
sleep 300
Send, {enter}{enter}
sleep 50
Send, {enter}{down}{enter}{bs}{enter}
sleep 50
Send, {enter}{enter}
sleep 50
Send, {enter}{enter}{enter}{enter}{bs}{bs}{bs}{enter}
sleep 50
Send, {enter}{enter}
sleep 50
Send, {enter}{up}{enter}{up}{enter}{bs}{bs}{enter}
sleep 50
Send, {enter}{enter}{enter}{down}{enter}{enter}{down}{down}{down}{down}{enter}{enter}{enter}{bs}{bs}{bs}{bs}{enter}
return

Numpadsub::
WinMinimize, A
run gta5solopublic.exe GTA5.exe
GTA.Message("Creating Solo Public Session, Please Wait...", 9)
run gta5solopublic.exe -r GTA5.exe
sleep 1000
WinRestore, Grand Theft Auto V
return

Numpadadd::
MouseMove, cordx, cordy
PixelGetColor, ColorVar, cordx, cordy
GTA.Message(ColorVar, 10)
return

NumpadDot::GTA.CEOMenu("SecuroServ", Headhunter, "ceoonly")


Class GTA
{
	CEOMenu(NextMenu, script, ceotype)
	{
		global cordx
		global cordy
		global ColorCeo
		global ColorNoCeo
		global ColorMission
		SetCapsLockState off
		SetKeyDelay, 50, 50
		Send, {bs}{bs}m
		Sleep 200
		PixelGetColor, ColorVar, cordx, cordy

		;CEO
		Sleep 10
		if (ColorVar = ColorCeo)
			{
				continue = 0
				If NextMenu = SecuroServ
				{
				Menu = {enter}
				continue = 1
				}
				If NextMenu = Inventory
				{
				Menu = {down}{down}{enter}
				continue = 1
				}
				If NextMenu = Vehicles
				{
				Menu = {down}{down}{down}{down}{enter}
				continue = 1
				} 
				if continue = 1
				{
				SetKeyDelay, 10, 10
				Send, %Menu%
				Send, %script%
				}
			}
		;NOCEO
		if (ColorVar = ColorNoCeo)
			{
				continue = 0
				If NextMenu = SecuroServ
				{
				GTA.Cancel()
				GTA.Message("You need to be CEO", 1)
				}
				If NextMenu = Inventory
				{
				Menu = {down}{enter}
				continue = 1
				}
				If NextMenu = Vehicles
				{
				Menu = {down}{down}{down}{enter}
				continue = 1
				} 
				if continue = 1
				{
				SetKeyDelay, 10, 10
				Send, %Menu%
				Send, %script%
				}
			}
		;MISSION
		if (ColorVar = ColorMission)
			{
				continue = 0
				If NextMenu = SecuroServ
				{
				GTA.Cancel()
				GTA.Message("You can't do that in mission.", 1)
				}
				If NextMenu = Inventory
				{
				Menu = {down}{enter}
				continue = 1
				}
				If NextMenu = Vehicles
				{
				Menu = {down}{down}{down}{enter}
				continue = 1
				} 
				if continue = 1
				{
				SetKeyDelay, 10, 10
				Send, %Menu%
				Send, %script%
				}
			}
		if (ColorVar != ColorCeo && ColorVar != ColorNoCeo && ColorVar != ColorMission)
			{
				if ceotype = ceotest
				{
					GTA.Message("Can't Do That Right Now.", 1)
					GTA.Cancel()
				}
				if ceotype = ceoonly
				{
					GTA.Cancel()
				}
			}
		if (%ceotype% != ceotest && %ceotype% != ceoonly)
		{
			GTA.Message("Define CEO Type!", 2)
		}	
	}
	
	CEOPhone(PhoneMenu, PhoneMenuSelect)
	{
		SetCapsLockState off
		SetKeyDelay, 10, 10
		Send, {bs}{bs}{up}
		Sleep 750
		SetKeyDelay, 50, 50
		Send %PhoneMenu%
		Sleep 175
		SetKeyDelay, 90, 90
		Send, %PhoneMenuSelect%
			
	}
	
	Message(text, timeout)
	{
		Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
		Gui, Color, ffffff
		Gui +LastFound  
		WinSet, TransColor, ffffff
		Gui, Font, ffffff s20 wbold, Verdana ;changes font color, size and font
		Gui, Add, Text, x20 y15, %text%
		Gui, Show, NoActivate, Xn: 0, Yn: 0 
		WinWait [0,0,%timeout%,0,0]
		Gui, Destroy
	}
	
	Cancel()
	{
		continue = 0
		SetKeyDelay, 10, 10
		Send, {bs}{bs}{bs}{bs}
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