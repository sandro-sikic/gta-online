Run, bin\update.exe

; CEOMenu
Headhunter =		{down}{down}{enter}{down}{down}{down}{down}{down}{down}{down}{down}{enter}{enter}m
Helicopter =		{down}{down}{down}{down}{down}{enter}{down}{down}{down}{down}{enter}m

Hire = 			{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}{down}{enter}{right}m

Snacks =			{down}{down}{enter}{enter}
Armor =				{down}{enter}{up}{up}{up}{enter}m
PersonalVehicle =	{enter}{enter}m
Smoke =				{down}{down}{enter}{up}{enter}m

; PhoneMenu
Contacts = 			{down}{down}{right}{enter}
Lester = 			{left}{left}{up}{up}{enter}
Mechanic = 			{left}{up}{up}{up}{enter}
Taxi = 				{left}{left}{left}{up}{up}{up}{enter}
Marryweather = 		{left}{up}{up}{enter}

;DON TAČ PREKIDAČ
#Persistent

I_Icon = bin\images\icon.png
ICON [I_Icon]                        ;Changes a compiled script's icon (.exe)
if I_Icon <>
IfExist, %I_Icon%
	Menu, Tray, Icon, %I_Icon%   ;Changes menu tray icon 

SetTitleMatchMode, 2

if !WinExist("Grand Theft Auto V") {
MsgBox, Grand Theft Auto V Is Not Running.
ExitApp
}

#IfWinActive Grand Theft Auto V
SetTimer, ExitWithGta, 1000
ExitWithGta() {
    if !WinExist("Grand Theft Auto V") {
    ExitApp
    }
}

cordx := 411
cordy := 114
ColorCeo := 0xB96E2D
ColorNoCeo := 0x1F1308
ColorMission := 0x000000
MenuItem := 1
MenuItems := 14
working = false
execute = false

Gui +LastFound +AlwaysOnTop -Caption +ToolWindow -SysMenu -theme ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Font, ffffff s20 wbold, Verdana ;changes font color, size and font
Gui, Add, Text, vTitle, Select Shortcut:	
Gui, Add, ListBox,  w350 Choose1 r%MenuItems% vMenuSelect, Snacks|Helicopter/Motorcycle|Personal Vehicle|Lester|Terrorbyte|Headhunter|Hire People|Mechanic|Car Modification|Taxi|Buy Ammo|Switch Faction|Merryweather|Solo Public Session
;WinSet, TransColor, ffffff ; Make all pixels of this color transparent and make the text itself translucent (150):
Return

;hold
*Numpad0::MenuShow()
*Numpad0 Up::MenuHide()
Numpad5::MenuUp()
Numpad2::MenuDown()

Numpad1::InteractionMenu("Inventory", Snacks)
Numpad4::InteractionMenu("Inventory", Armor)


MenuShow() {
	global
	if ( %working% = false) {
		GuiControl, Text, Title , Select Shortcut:	
		GuiControl, Show, MenuSelect
		Gui, Show, x0 y0 w500 AutoSize NoActivate
		execute = true
		return	
	} 
	return
}

MenuHide() {
    global
	if ( %working% = false && %execute% = true) {
		working = true
		GuiControl, Text, Title , Working...
		GuiControl, Hide, MenuSelect
		Gui, Show, AutoSize NoActivate
		Gui, Submit, NoHide
		MenuItem = 1
		GuiControl, Choose, MenuSelect, %MenuItem%
		Redirect(MenuSelect)
		Gui, Cancel
		sleep 250
		working = false
		execute = false
		return
	}
	return
}

MenuDown() {
    global MenuItem
    global MenuItems 
    if (MenuItem = MenuItems) {
        MenuItem := 1
        GuiControl, Choose, MenuSelect, %MenuItem%
		Return
    }
    if (MenuItem < MenuItems) {
        MenuItem := MenuItem + 1
        GuiControl, Choose, MenuSelect, %MenuItem%
		Return    
	}
}

MenuUp() {
    global MenuItem 
    global MenuItems
	if (MenuItem = 1) {
        MenuItem := MenuItems
        GuiControl, Choose, MenuSelect, %MenuItem%
		Return
    }
    if (MenuItem > 1) {
        MenuItem := MenuItem - 1
        GuiControl, Choose, MenuSelect, %MenuItem%
		Return    
	}
}

Redirect(selection) {
	global

    if (selection = "Snacks") {
		InteractionMenu("Inventory", Snacks)
    }

    if (selection = "Helicopter/Motorcycle") {
		InteractionMenu("CEO Vehicles")
    }

    if (selection = "Personal Vehicle") {
		InteractionMenu("Vehicles", PersonalVehicle)
    }

    if (selection = "Lester") {
        Phone(Contacts, Lester)
    }

    if (selection = "Terrorbyte") {
		InteractionMenu("Terrorbyte")
    }

    if (selection = "Headhunter") {
		InteractionMenu("Abilities", Headhunter)
    }

    if (selection = "Mechanic") {
        Phone(Contacts, Mechanic)
    }

    if (selection = "Merryweather") {
        Phone(Contacts, Marryweather)
    }

    if (selection = "Taxi") {
        Phone(Contacts, Taxi)
    }

    if (selection = "Buy Ammo") {
		InteractionMenu("Ammo")
    }

    if (selection = "Car Modification") {
        CarMod()
    }

    if (selection = "Switch Faction") {
		InteractionMenu("Switch Faction")
    }

    if (selection = "Hire People") {
		InteractionMenu("Hire", Hire)
    }
    
    if (selection = "Solo Public Session") {
        SoloPublic()
    }
}

; Hotkey, NumpadDiv,	DOLE ENTER

Numpad3::
	while (GetKeyState("Numpad3", "P"))
	{
		Send, {down}
		Sleep 1
		Send, {enter}
	}
return

Numpad3 up::
return

CarMod(){
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
}

Ammo() {
	Send, {down}{down}{down}{enter}
	SetKeyDelay, 10, 10
	Loop, 6 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 2 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 5 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 2 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 3 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 3 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 1 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 5 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Send, {right}
	Loop, 4 {
		Send, {down}{right}{down}{down}{enter}{down}
	}
	Cancel()
}

SoloPublic() {
	WinMinimize, A
	run bin\gta5solopublic.exe GTA5.exe
	;GTA.Message("Creating Solo Public Session, Please Wait...", 9)
	sleep 9000
	run bin\gta5solopublic.exe -r GTA5.exe
	sleep 1000
	WinRestore, Grand Theft Auto V
}

InteractionMenu(nextMenu, script = "") {
	global
	SetCapsLockState off
	SetKeyDelay, 50, 50
	Cancel()
	Send, m
	sleep 100

	;CEO
	ImageSearch, OutputVarX, OutputVarY, 0, 100, 500, 200, *150 bin\images\ceo.PNG
	if !ErrorLevel
	{
		SetKeyDelay, 10, 10
		if (nextMenu = "Hire") {
			Send, {enter}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Work") {
			Send, {enter}{down}{down}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Challenges") {
			Send, {enter}{down}{down}{down}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Abilities") {
			Send, {enter}{up}{up}{up}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "CEO Vehicles") {
			Send, {enter}{up}{up}{enter}{down}{down}{down}{down}{enter}
			return
		}
		if (nextMenu = "Switch Faction") {
			Send, {enter}{up}{enter}
			sleep 100
			Send, m
			sleep 100
			Send, {down}{down}{down}{down}{down}{down}{down}{down}{enter}{enter}
			return
		}
		if (nextMenu = "Inventory") {
			Send, {up 16}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Ammo") {
			Cancel()
			Send 1,m
			Send, {up 16}{enter}
			Ammo()
			return
		}
		if (nextMenu = "Vehicles") {
			Send, {up 14}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Terrorbyte") {
			Send, {down}{down}{down}{down}{down}{enter}{enter}
			Send, %script%
			return
		}
	}

	;President
	ImageSearch, OutputVarX, OutputVarY, 0, 100, 500, 200, *150 bin\images\president.PNG
	if !ErrorLevel
	{
		SetKeyDelay, 10, 10
		if (nextMenu = "CEO Vehicles") {
			Send, {enter}{enter}{enter}
			return
		}
		if (nextMenu = "Hire") {
			Send, {enter}{down}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Switch Faction") {
			Send, {enter}{up}{enter}
			sleep 100
			Send, m
			sleep 100
			Send, {down}{down}{down}{down}{down}{down}{down}{enter}{enter}
			return
		}
		if (nextMenu = "Inventory") {
			Send, {up 16}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Ammo") {
			Cancel()
			Send 1,m
			Send, 1{up 16}{enter}
			Ammo()
			return
		}
		if (nextMenu = "Vehicles") {
			Send, {up 14}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Terrorbyte") {
			Send, {down}{down}{down}{down}{down}{enter}{enter}
			Send, %script%
			return
		}
	}

	if ErrorLevel {
		if (nextMenu = "Inventory") {
			Send, {down}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Ammo") {
			Cancel()
			Send 1,m
			Send, {down}{enter}
			Ammo()
			return
		}
		if (nextMenu = "Vehicles") {
			Send, {down}{down}{down}{enter}
			Send, %script%
			return
		}
		if (nextMenu = "Terrorbyte") {
			Send, {down}{down}{down}{enter}{enter}
			Send, %script%
			return
		}
		Cancel()
	}
}

Cancel()
{
	SetKeyDelay, 10, 10
	Send, {bs}{bs}{bs}{bs}{bs}{bs}{bs}{bs}
}

Phone(PhoneMenu, PhoneMenuSelect) {
		SetCapsLockState off
		SetKeyDelay, 10, 10
		Cancel()
		Sleep 750
		SetKeyDelay, 50, 50
		Send %PhoneMenu%
		Sleep 175
		SetKeyDelay, 90, 90
		Send, %PhoneMenuSelect%
}
