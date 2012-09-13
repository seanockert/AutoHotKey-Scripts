;ColourCursor
;Author: Sean Ockert 2011
;Add auto-insert an HTML skeleton for starting a new web project

#HotkeyInterval 1000

#MaxHotkeysPerInterval 100
SendMode Input
#NoEnv

#Hotstring r EndChars `n

:oc:skel::<{!}doctype html>{Enter}<{!}--[if lt IE 7 ]><html class="no-js ie6" lang="en"><{!}[endif]-->{Enter}<{!}--[if IE 7 ]><html class="no-js ie7" lang="en"><{!}[endif]-->{Enter}<{!}--[if IE 8 ]><html class="no-js ie8" lang="en"><{!}[endif]-->{Enter}<{!}--[if (gte IE 9)|{!}(IE)]><{!}--> <html class="no-js " lang="en"><{!}--<{!}[endif]-->{Enter}<head>{Enter}<meta charset="utf-8">{Enter}<meta name="viewport" content="width=device-width, initial-scale=1" />{Enter}<meta name="HandheldFriendly" content="true">{Enter}<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">{Enter}<title></title>{Enter}<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />{Enter}<link rel="stylesheet" href="style.css" type="text/css" media="all" />{Enter}</head>{Enter}<body>{Enter}{Enter}<header>{Enter}</header>{Enter}{Enter}<section>{Enter}</section>{Enter}{Enter}<footer>{Enter}</footer>{Enter}{Enter}<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>{Enter}<script>window.jQuery || document.write('<script src="js/jquery-1.7.1.min.js"><\/script>')</script>{Enter}<script src="js/scripts.js"></script>{Enter}</body>{Enter}</html>