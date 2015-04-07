import System.Exit
import System.IO
import Graphics.X11.Xlib
import Graphics.X11.ExtraTypes.XF86

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.LayoutHints
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile

import Control.Monad (liftM2)

import qualified Data.Map as M
import qualified XMonad.StackSet as W


main = xmonad =<< statusBar "/usr/bin/xmobar ~/.xmobarrc" myPP toggleBarKey defaultConfig
		{ manageHook = myManageHook <+> manageHook defaultConfig
		, layoutHook = myLayoutHook
		, modMask = mod4Mask     -- Rebind Mod to the Super key
		, workspaces = myWorkspaces
		, keys = myKeys
		, terminal = "xterm"
		, focusFollowsMouse = False
		, normalBorderColor = "#444444"
		, focusedBorderColor = "#00ff00"
		}

toggleBarKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myWorkspaces = ["|:mon",	"1:xmonad",	"2:chat",	"3",		"4",
		"q:wm",		"w:web",	"e:ide",	"r:rterm",	"t:term",
				"a:audio",	"s:video",	"d:pdf",	"f:file"]
myManageHook = composeAll
		[ className =? "Thunderbird"      --> doShift "1:xmonad"

		, className =? "Skype"            --> doShift "2:chat"

		, className =? "Firefox"          --> doShift "w:web"
		, className =? "Chromium-browser" --> doShift "w:web" -- ubuntu
		, className =? "Chromium"         --> doShift "w:web" -- arch

		, className =? "Eclipse"          --> doShift "e:ide"

		, className =? "Spotify"          --> doShift "a:audio"
		, className =? "Pavucontrol"      --> doShift "a:audio"

		, className =? "Evince"           --> viewShift "d:pdf"

		, className =? "Thunar"           --> doShift "f:file"

		, className =? "Nautilus"         --> doShift "f:file"
		]
	where viewShift = doF . liftM2 (.) W.greedyView W.shift

myLayoutHook = avoidStruts
	$ onWorkspace "|:mon" (rtall 0.5 ||| wide ||| full)
	$ onWorkspace "2:chat" (rtall 0.25 ||| wide ||| full)
	$ onWorkspace "r:rterm" (tall ||| vwide ||| full)
	$ onWorkspace "t:term" (tall ||| vwide ||| full)
	$ onWorkspace "w:web" (full ||| wide ||| tall)
	$ onWorkspace "s:video" (full ||| vwide ||| tall)
	$ onWorkspace "a:audio" (rtall 0.25 ||| wide ||| full)
	$ onWorkspace "d:pdf" (full ||| wide ||| tall)
	$ onWorkspace "f:file" (wide ||| tall ||| full)
	$ (tall ||| wide ||| full)
	where
		nmaster = 1
		delta = 0.01
		gr = toRational (2/(1+sqrt(5)::Double)) -- golden ratio
		vwr = 0.915 -- usefull very wide ratio, giving approx 5 lines (12px) terminal below large window on WIDTH*1200
		rtall r = smartBorders
			$ Tall nmaster delta r
		rwide r = Mirror $ rtall r
		tall = rtall gr
		wide = rwide gr
		vwide = rwide vwr
		full = noBorders
			$ Full

myPP = xmobarPP
	{ ppSep = " "
	, ppCurrent = xmobarColor "#cccc00" "" . wrap "[" "]"
	, ppTitle = xmobarColor "#00cc00" "" . trim
	, ppLayout = xmobarColor "#cc00cc" "" . (\x -> case x of --- compact layout indicator
		"Full" -> "^"
		"Mirror Tall" -> "-"
		"Tall" -> "|")
	, ppExtras = [logWindowCount ]
	, ppOrder = \(ws:l:t:e:_) -> [ws,l,e,t]
	}

logWindowCount = withWindowSet $
	return . Just . xmobarColor "#cc00cc" "" . show . length . W.index

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
altMask = mod1Mask
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

	[ ((modm .|. shiftMask,   xK_Return), spawn $ XMonad.terminal conf) -- launch a terminal
	, ((modm,                 xK_p     ), spawn "LANG='' dmenu_run") -- launch dmenu
	, ((modm .|. shiftMask,   xK_p     ), spawn "gmrun") -- launch gmrun

	, ((modm,                 xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
	, ((modm .|. shiftMask,   xK_space ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default

	, ((modm .|. shiftMask,   xK_c     ), kill) -- close focused window
	, ((modm,                 xK_n     ), refresh) -- Resize viewed windows to the correct size
	, ((modm .|. altMask,     xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling

	, ((modm,                 xK_m     ), windows W.focusMaster) -- Move focus to the master window
	, ((modm,                 xK_Return), windows W.swapMaster) -- Swap the focused window and the master window

	, ((modm,                 xK_Tab   ), windows W.focusDown) -- Move focus to the next window
	, ((modm,                 xK_j     ), windows W.focusDown) -- Move focus to the next window
	, ((modm,                 xK_k     ), windows W.focusUp  ) -- Move focus to the previous window
	, ((modm .|. shiftMask,   xK_Tab   ), windows W.focusUp  ) -- Move focus to the previous window
	, ((modm .|. shiftMask,   xK_j     ), windows W.swapDown  ) -- Swap the focused window with the next window
	, ((modm .|. shiftMask,   xK_k     ), windows W.swapUp    ) -- Swap the focused window with the previous window

	, ((modm,                 xK_h     ), sendMessage Shrink) -- Shrink the master area
	, ((modm,                 xK_l     ), sendMessage Expand) -- Expand the master area
	, ((modm .|. shiftMask,   xK_h     ), sendMessage MirrorShrink)
	, ((modm .|. shiftMask,   xK_l     ), sendMessage MirrorExpand)

	, ((modm,                 xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
	, ((modm,                 xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

	, ((modm,                 xK_b     ), sendMessage ToggleStruts) -- Toggle the status bar gap

	, ((modm .|. controlMask, xK_Tab   ), nextWS) -- shift to next workspace
	, ((modm .|. controlMask .|. shiftMask, xK_Tab   ), prevWS) -- shift to previous workspace

--	, ((modm .|. altMask .|. controlMask,   xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad
	, ((modm .|. altMask,                 xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Restart xmonad

	, ((modm,                 xK_Print ), spawn "scrot") -- screenshot
	, ((modm .|. shiftMask,   xK_Print ), spawn "sleep 0.2; scrot -s") -- screenshot for window clicked on

	, ((modm .|. shiftMask,   xK_z     ), spawn "xscreensaver-command -lock") -- lock screen
	, ((modm .|. shiftMask,   xK_plus  ), spawn "amixer -c 0 -- sset Master playback 1+ > /dev/null")
    , ((modm .|. shiftMask,   xK_backslash  ), spawn "amixer -c 0 -- sset Master playback 1- > /dev/null")

	, ((modm .|. controlMask, xK_p     ), spawn "mpc toggle") -- mpd play/pause
	, ((modm .|. controlMask, xK_h     ), spawn "mpc prev") -- mpd previous song
	, ((modm .|. controlMask, xK_j     ), spawn "mpc seek -2%") -- mpd seek backward
	, ((modm .|. controlMask, xK_k     ), spawn "mpc seek +2%") -- mpd seek forward
	, ((modm .|. controlMask, xK_l     ), spawn "mpc next") -- mpd next song
	, ((modm .|. controlMask, xK_minus ), spawn "mpc volume -4") -- volume decrease
	, ((modm .|. controlMask, xK_plus  ), spawn "mpc volume +4") -- volume increase
	, ((modm .|. controlMask, xK_r     ), spawn "mpc repeat") -- mpd toggle repeat mode
	, ((modm .|. controlMask, xK_z     ), spawn "mpc random") -- mpd toggle random mode
	, ((modm .|. controlMask, xK_y     ), spawn "mpc single") -- mpd toggle single repeat mode
	, ((modm .|. controlMask .|. shiftMask, xK_r), spawn "mpc consume") -- mpd toggle consume mode, remove song from playlist after completion
	, ((0, 0x1008FF12), spawn "~/common/bin/mute_toggle.sh &> /dev/null"          ) -- XF86XK_AudioMute
	, ((0, 0x1008FF11), spawn "amixer -q -c 0 -- sset Master playback 1- > /dev/null"         ) -- XF86XK_AudioLowerVolume
	, ((0, 0x1008FF13), spawn "amixer -q -c 0 -- sset Master playback 1+ > /dev/null"          ) -- XF86XK_AudioRaiseVolume
	, ((0, 0x1008ff02), spawn "xbacklight -inc 10 -time 1 -steps 1") -- Turn backlight up
	, ((0, 0x1008ff03), spawn "xbacklight -dec 10 -time 1 -steps 1") -- Turn backlight down
	, ((0, 0x1008ff05), spawn "sudo kbdBacklightControl up"     ) -- XF86KbdBrightnessUp
	, ((0, 0x1008ff06), spawn "sudo kbdBacklightControl down"     ) -- XF86KbdBrightnessDown
	, ((0, 0x1008ff59), spawn "xrandr --auto"     ) -- XF86Display
	]
	++

	-- mod-KEY, Switch to workspace N
	-- mod-shift-KEY, Move client to workspace N
	-- mod-shift-alt-KEY, Move client to workspace N and switch to workspace N
	[((m .|. modm, k), windows $ f i)
		| (i, k) <- zip (XMonad.workspaces conf) ([xK_bar]++[xK_1     ..    xK_4]++
															[xK_q,xK_w,xK_e,xK_r,xK_t]++
															[xK_a,xK_s,xK_d,xK_f])
		, (f, m) <- [	 (W.greedyView, 0)
						,(W.shift, shiftMask)
						,(\i -> W.greedyView i . W.shift i, shiftMask .|. altMask)]]

