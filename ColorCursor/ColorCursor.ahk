;ColourCursor
;Author: Sean Ockert 2008
;Show the RRGGBB colour under the cursor.

#SingleInstance,Force
;Win+C displays the hex color below the cursor
#C::
Loop
 {
  Sleep,100
  MouseGetPos,x,y
  PixelGetColor,rgb,x,y,RGB
  StringTrimLeft,rgb,rgb,2
  ToolTip,%rgb%
  GetKeyState, state, esc
  if state = D
      break
  ;Sleep,5000
  ;ToolTip
 }
 ToolTip
 return

;hide the tooltip when pressing the escape key
;esc::
;ToolTip