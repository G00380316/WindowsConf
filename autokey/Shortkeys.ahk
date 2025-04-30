#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Variables ////////////////////////////////////////////////////////////////////////////////////

Number =

;At Startup /////////////////////////////////////////////////////////////////////////////////////////////

;To run Neovim automatically
;Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/Terminal
;return

;To disable Windows Shortkeys/////////////////////////////////////////////////////////////////////////////////////////////

;#s::Return

; /////////////////////////////////////////////////////////////////////////////////////////////

;To pause the Script
#!p::Pause

; /////////////////////////////////////////////////////////////////////////////////////////////

;Maximise current window
#!f::WinMaximize, A
return

;Close current window
#!c::WinClose, A
return

;minimise window
#!m::WinMinimize, A
return

;Close current window
#!q::WinKill, A
return

;Change Sound device
^!1::

if Number =
{
	Run, nircmd.exe setdefaultsounddevice "ARZOPA"
	Number = 1
}
else if Number = 1
{
	Run, nircmd.exe setdefaultsounddevice "JBL Speakers"
	++Number
	return
}
else if Number = 2
{
	Run, nircmd.exe setdefaultsounddevice "Headphones"
	++Number
	return
}
else if Number = 3
{
	Run, nircmd.exe setdefaultsounddevice "Speakers"
	++Number=
	return
}
else if Number = 4
{
	Run, nircmd.exe setdefaultsounddevice "Airpods"
	Number=
	return
}
return

;To Hide/Show Taskbar
$F12:: HideShowTaskbar(hide := !hide)
   
HideShowTaskbar(action)
{
   if action
      WinHide, ahk_class Shell_TrayWnd
   else
      WinShow, ahk_class Shell_TrayWnd
}

; /////////////////////////////////////////////////////////////////////////////////////////////

; To Shutdown Computer
#!s::
shutdown, 1
return

; To SleepComputer
#!h::
DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 1, "Int", 0)
return

; Pick Wallpaper
#!w::
Run, PowerShell.exe -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"C:\Users\Enoch\.config\scripts\pick-wallpapers.ps1"' -Verb RunAs
return

; To Reboot Computer
#!r::
shutdown, 6
return

; /////////////////////////////////////////////////////////////////////////////////////////////

; To open Windows Desktop Coding folder
^!d::
Run, C:\Users\enoch\Projects
return

; To run Microsoft Edge
^!e::
Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/Microsoft Edge
return

; To run Youtube
;^!y::
;Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/Youtube
;return

; To run Vscode
^!v::
Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/Code
return

;To run Dolby Access
^!3::
Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/Dolby Access
return

; To run Youtube Music
;^!2::
;Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/Youtube Music
;return

; To run Powershell
^!z::
Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/powershell
return

; To run Github
;^!g::
;Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/Github
;return

;To run Deskpins
;^!p::
;Run, C:\Users\enoch\Documents\AutoKey Run Shortcuts/deskpins
;return

; /////////////////////////////////////////////////////////////////////////////////////////////

; Auto completes

;:*:btw::by the way
;:*:gnight::good night
;:*:nvm::never mind
;:*:gtg::got to go