import XMonad
import XMonad.Layout.NoBorders
import XMonad.Config.Gnome
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
 
main = xmonad $ gnomeConfig
         { modMask = mod4Mask
         , terminal = "urxvt"
				 , layoutHook = noBorders $ layoutHook defaultConfig
         }
				 `additionalKeysP`
					[ ("M-f", spawn "firefox"),
					  ("M-g", spawn "urxvt -e vim"),
					  ("M-m", spawn "urxvt -e mocp -T transparent-background"),
						("M-<Return>", spawn "urxvt")
					]
