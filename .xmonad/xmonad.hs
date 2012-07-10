import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import System.IO
import XMonad.Layout.PerWorkspace
import qualified XMonad.StackSet as W

main = do
      xmproc <- spawnPipe "xmobar"
      xmonad $ desktopConfig {
        normalBorderColor = "#000",
        focusedBorderColor = "#68e862",
        borderWidth = 1,
        terminal = "urxvt",
        modMask = mod4Mask,
        manageHook = manageDocks <+> myManageHook <+> manageHook desktopConfig,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        logHook = myLogHook xmproc,
        workspaces = myWorkspaces
      } `additionalKeysP` myKeys

myWorkspaces = ["1:main","2:alt","3:web","4:email","5:chat","6:music","7","8","9"]

myLayoutHook = avoidStruts $
               spacing 3 $
               smartBorders $
               layoutHook desktopConfig

myLogHook h = dynamicLogWithPP $ xmobarPP {
                ppTitle = xmobarColor "green" "" . shorten 50,
                ppOutput = hPutStrLn h,
                ppLayout = const ""
              }

myStartupHook :: X ()
myStartupHook = do
          spawn "unclutter" -- Hide mouse when unnecessary
          spawn "xcompmgr -c" -- Enables compositing
          spawn "xsetroot -cursor_name left_ptr" -- Use decent cursor
          spawn "killall trayer; \
                \trayer --edge top --align right --expand true --width 5 \
                \--transparent true --alpha 0 --tint 0x000000 --height 18"

myManageHook = composeAll [
                 className =? "File Operation Progress" --> doFloat,
                 appName   =? "Skype"                   --> doFloat,
                 appName   =? "alsamixer"               --> doFloat,
                 resource  =? "desktop_window"          --> doIgnore,
                 className =? "Do"                      --> doIgnore,
                 className =? "xmobar"                  --> doIgnore,
                 className =? "trayer"                  --> doIgnore
               ]

myKeys = [
           ("M-u", spawn "firefox"),
           ("M-f", spawn "uzbl-tabbed"),
           ("M-S-q", spawn "gnome-session-quit"),
           ("M-S-r", spawn "xmonad --recompile && xmonad --restart"),
           ("M-v", spawn "urxvt -e vim"),
           ("M-t", spawn "thunderbird"),
           ("M-n", spawn "nautilus"),
           ("M-s", spawn "urxvt -e ncmpcpp"),
           ("M-a", spawn "urxvt -name alsamixer -geometry 80x24 -e alsamixer" ),
           ("M-v", spawn "urxvt -e vim"),
           ("M-i", spawn "urxvt -name IRC -e ./.irc-script/irssi-connect.sh"),
           ("M-g", spawn "gvim"),
           ("M-p", spawn "gnome-do"),
           ("M-<Return>", spawn "urxvt -name Terminal"),
           ("M-b", sendMessage ToggleStruts),
           ("M-S-t", withFocused $ windows . W.sink),
           ("M-m", spawn "urxvt -e mutt"),
           ("M-S-m", spawn "urxvt -e mutt -e \"source ~/.mutt/codeminer.account\""),
           ("C-M1-f", spawn "mpc next"),
           ("C-M1-r", spawn "mpc prev"),
           ("C-M1-p", spawn "mpc pause"),
           ("C-M1-S-p", spawn "mpc play")
         ]
