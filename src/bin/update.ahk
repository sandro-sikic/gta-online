Process, Close, Gta_V.exe

UrlDownloadToFile, https://github.com/Sikilee/gta-online-helper/blob/master/build/Gta_V.exe?raw=true, ../Gta_V.exe
if ErrorLevel {
	Gui +LastFound +AlwaysOnTop -Caption +ToolWindow -SysMenu -theme ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
	Gui, Font, ffffff s20 wbold, Verdana ;changes font color, size and font
	Gui, Add, Text, vTitle1, Failed to update GTA V Helper Script.	
	Gui, Add, Text, vTitle2, Check your network connection.	
	Gui, Show, AutoSize NoActivate
	sleep 3000
	Gui, Destroy
}

Run, ../Gta_V.exe

Exit 
