; Virtual Desktop

; Original Author: Christian Schüler 2005
; Modified By: Sean Ockert 2008

; ***** Initialization *****

SetBatchLines, -1   ; maximize script speed!
SetWinDelay, -1
#NoTrayIcon
OnExit, CleanUp      ; clean up in case of error (otherwise some windows will get lost)

numDesktops := 2   ; maximum number of desktops
curDesktop := 1      ; index number of current desktop

WinGet, windows1, List   ; get list of all currently visible windows

ChangeGUI(curDesktop)
;Gosub, DetectMouse

; ***** Hotkeys *****

#Left::SwitchToDesktop(1)
#Right::SwitchToDesktop(2)
;#Up::Gosub, ToggleDesktop
#Down::Gosub, ToggleSendActive

#0::ExitApp


; ***** Functions *****

; Toggle between the 2 desktops
ToggleDesktop:
{
   if (curDesktop == 1)
   {
   SwitchToDesktop(2)
   return
   } else {
   SwitchToDesktop(1)
   return
   }
 }
 
; Send the active window to the other desktop
ToggleSendActive:
{
   if (curDesktop == 1)
   {
   SendActiveToDesktop(2)
   return
   } else {
   SendActiveToDesktop(1)
   return
   }
 }

; Switch to the desktop with the given index number
SwitchToDesktop(newDesktop)
{
   global

   if (curDesktop <> newDesktop)
   {
      GetCurrentWindows(curDesktop)

      ;WinGet, windows%curDesktop%, List,,, Program Manager   ; get list of all visible windows

      ShowHideWindows(curDesktop, false)
      ShowHideWindows(newDesktop, true)
	  ChangeGUI(newDesktop) ; Change screen number label
      curDesktop := newDesktop
	  WinClose, ahk_class SysShadow ;Get rid of persistent shadow problem from tooltips
      Send, {ALT DOWN}{TAB}{ALT UP}   ; activate the right window
   }
   return
}

; Sends the currently active window to the given desktop
SendActiveToDesktop(newDesktop)
{
   global
   if (curDesktop <> newDesktop)
   {
   WinGet, id, ID, A
   SendToDesktop(id, newDesktop)
   }
}

; Sends the given window from the current desktop to the given desktop
SendToDesktop(windowID, newDesktop)
{
   global
   RemoveWindowID(curDesktop, windowID)

   ; add window to destination desktop
   windows%newDesktop% += 1
   i := windows%newDesktop%

   windows%newDesktop%%i% := windowID
   
   WinHide, ahk_id %windowID%

   Send, {ALT DOWN}{TAB}{ALT UP}   ; activate the right window
}

; Removes the given window id from the desktop <desktopIdx>
RemoveWindowID(desktopIdx, ID)
{
   global   
   Loop, % windows%desktopIdx%
   {
      if (windows%desktopIdx%%A_Index% = ID)
      {
         RemoveWindowID_byIndex(desktopIdx, A_Index)
         Break
      }
   }
}

; This removes the window id at index <ID_idx> from desktop number <desktopIdx>
RemoveWindowID_byIndex(desktopIdx, ID_idx)
{
   global
   Loop, % windows%desktopIdx% - ID_idx
   {
      idx1 := % A_Index + ID_idx - 1
      idx2 := % A_Index + ID_idx
      windows%desktopIdx%%idx1% := windows%desktopIdx%%idx2%
   }
   windows%desktopIdx% -= 1
}

; this builds a list of all currently visible windows in stores it in desktop <index>
GetCurrentWindows(index)
{
   global
   WinGet, windows%index%, List,,, Program Manager      ; get list of all visible windows

   ; now remove task bar "window" (is there a simpler way?)
   Loop, % windows%index%
   {
      id := % windows%index%%A_Index%

      WinGetClass, windowClass, ahk_id %id%
      if windowClass = Shell_TrayWnd      ; remove task bar window id
      {
         RemoveWindowID_byIndex(index, A_Index)
         Break
      }
   }
}

; if show=true then shows windows of desktop %index%, otherwise hides them
ShowHideWindows(index, show)
{
   global

   Loop, % windows%index%
   {
      id := % windows%index%%A_Index%

      if show
         WinShow, ahk_id %id%
      else
         WinHide, ahk_id %id%
   }
}

; Add a clickable number to the desktop to toggle 
ChangeGUI(newDesktop)
{
DChange := gScreen%newDesktop%

Gui Destroy
Gui, Margin, 0, 0
Gui, Font, CFFFFFF. s20, Verdana  
Gui, Color, 000000
Gui, +Lastfound +AlwaysOnTop +Toolwindow +Owner

Gui, Add, Text, x10 y0 w30 h35 gToggleDesktop, %newDesktop%
WinSet, Transparent, 100
Gui, -Caption
Xp:= 0 
;Xp:= A_ScreenWidth - 40 for top right position
Yp:= 0
Gui, Show, x%XP% y%Yp%, VirtualDesk
return
}

DetectMouse:
{
;Use GuiDropFiles eg 
;Loop, parse, A_GuiEvent, `n
;{FirstFile = %A_LoopField% Break}

;Xx:= A_ScreenWidth - 50
Loop
{
  MouseGetPos,mx,my
  If (mx == 0) {
	Gosub, ToggleSendActive
  }
}
}

; Show all windows from all desktops on exit
CleanUp:
WinClose, ahk_class SysShadow
Loop, %numDesktops%
   ShowHideWindows(A_Index, true)
ExitApp