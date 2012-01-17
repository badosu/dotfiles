import XMonad
import XMonad.Layout.NoBorders
import XMonad.Config.Gnome
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

startup :: X ()
startup = do
          spawn "xcompmgr -c" -- Enables compositing
 
main = xmonad $ gnomeConfig
         { modMask = mod4Mask
         , terminal = "urxvt"
				 , layoutHook = noBorders $ layoutHook defaultConfig
         , startupHook = startup
         }
				 `additionalKeysP` myKeys

myKeys = [  ("M-f", spawn "firefox"),
					  ("M-g", spawn "urxvt -e vim"),
					  ("M-m", spawn "urxvt -e mocp -T transparent-background"),
					  ("M-s", spawn "mocp -s"),
					  ("M-S-.", spawn "amixer -c 0 set Master 2dB+"),
					  ("M-S-,", spawn "amixer -c 0 set Master 2dB-"),
						("M-<Return>", spawn "urxvt"),
					  ("C-M1-r", spawn "mocp -r"), 		-- previous
					  ("C-M1-f", spawn "mocp -f"), 		-- next
					  ("C-M1-S-p", spawn "mocp -P"),  -- pause
					  ("C-M1-p", spawn "mocp -p"), 		-- play
					  ("C-M1-x", spawn "mocp -x")  		-- kill
					]
