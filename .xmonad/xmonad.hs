import XMonad
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.CycleWS
import System.IO
import XMonad.Layout.PerWorkspace
import qualified XMonad.StackSet as W

startup :: X ()
startup = do
          spawn "unclutter" -- Hide mouse when unnecessary
          spawn "xcompmgr -c" -- Enables compositing
          spawn "xsetroot -cursor_name left_ptr" -- Use decent cursor
          spawn "killall trayer; trayer --edge top --align right --expand true --width 5 --transparent true --alpha 0 --tint 0x000000 --height 18"

insistentQuery name = appName =? name <||> title =? name <||> className =? name

myWorkspaces = ["1:main","2:alt","3:web","4:email","5:chat","6:music","7","8","9"]

myManageHook = composeAll [
                            className =? "File Operation Progress" --> doFloat,
                            resource =? "desktop_window" --> doIgnore,
                            appName =? "Skype" --> doFloat,
                            className =? "Do" --> doIgnore,
                            className =? "xmobar" --> doIgnore,
                            className =? "trayer" --> doIgnore
                          ]


myLayoutHook = avoidStruts $
               spacing 3 $
               smartBorders $
               layoutHook desktopConfig
                 where
                   noBordersLayout = noBorders $ spacing 0 $ layoutHook desktopConfig
               --onWorkspace "5:chat" noBordersLayout $

myKeys = [ ("M-u", spawn "firefox"),
           ("M-f", spawn "uzbl-tabbed"),
           ("M-S-q", spawn "gnome-session-quit"),
           ("M-S-r", spawn "xmonad --recompile && xmonad --restart"),
           ("M-v", spawn "urxvt -e vim"),
           ("M-t", spawn "thunderbird"),
           ("M-n", spawn "nautilus"),
           ("M-S-m", spawn "urxvt -e ncmpcpp"),
           ("M-a", spawn "urxvt -e alsamixer"),
           ("M-v", spawn "urxvt -e vim"),
           ("M-i", spawn "urxvt -name IRC -e ./.irc-script/irssi-connect.sh"),
           ("M-g", spawn "gvim"),
           ("M-p", spawn "gnome-do"),
           ("M-<Return>", spawn "urxvt -name Terminal"),
           ("M-b", sendMessage ToggleStruts),
           ("M-S-t", withFocused $ windows . W.sink),
           ("C-M1-f", spawn "mpc next"),
           ("C-M1-r", spawn "mpc prev"),
           ("C-M1-p", spawn "mpc pause"),
           ("C-M1-S-p", spawn "mpc play")
          ]

myLogHook h = dynamicLogWithPP $ xmobarPP
              {
                ppTitle = xmobarColor "green" "" . shorten 50,
                ppOutput = hPutStrLn h,
                ppLayout = const ""
              }

main = do
      xmproc <- spawnPipe "xmobar"
      xmonad $ desktopConfig {
        normalBorderColor = "#000",
        focusedBorderColor = "#68e862",
        borderWidth = 1,
        manageHook = manageDocks <+> myManageHook <+> manageHook desktopConfig,
        terminal = "urxvt",
        modMask = mod4Mask,
        startupHook = startup,
        layoutHook = myLayoutHook,
        logHook = myLogHook xmproc,
        workspaces = myWorkspaces
      } `additionalKeysP` myKeys

-- STORED myKeys
  --("M-S-h", moveTo Prev NonEmptyWS),
  --("M-S-l", moveTo Next NonEmptyWS),
  --("M-S-j", moveTo Prev EmptyWS),
  --("M-S-k", moveTo Next EmptyWS),
-- STORED myManageHook
  -- insistentQuery "xfce4-notifyd" --> doIgnore,
  -- appName =? "Synapse" --> doFloat,
  -- className =? "Gnome-panel" --> doIgnore,
  -- className =? "Unity-2d-panel" --> doIgnore,
  -- className =? "Unity-2d-launcher" --> doFloat,
  -- appName =? "unity-2d-shell" --> doIgnore
