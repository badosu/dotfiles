import XMonad
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.CycleWS
import System.IO
import qualified XMonad.StackSet as W

startup :: X ()
startup = do
          spawn "xcompmgr -c" -- Enables compositing

insistentQuery name = appName =? name <||> title =? name <||> className =? name

myManageHook = composeAll [
                            appName =? "Skype" --> doFloat,
                            className =? "xmobar" --> doIgnore,
                            isFullscreen --> doFullFloat,
                            className =? "Do" --> doIgnore
                            -- className =? "Unity-2d-launcher" --> doFloat,
                            -- insistentQuery "xfce4-notifyd" --> doIgnore,
                            -- appName =? "Synapse" --> doFloat,
                            -- className =? "Gnome-panel" --> doIgnore,
                            -- className =? "Unity-2d-panel" --> doIgnore,
                          ]

myLayoutHook = avoidStruts $
               mkToggle (single REFLECTX) $
               mkToggle (single REFLECTY) $
               noBorders $
               layoutHook desktopConfig

myKeys = [ ("M-f", spawn "firefox"),
           ("M-S-q", spawn "gnome-session-quit"),
           ("M-S-r", spawn "xmonad --recompile && xmonad --restart"),
           ("M-v", spawn "urxvt -e vim"),
           ("M-S-h", moveTo Prev EmptyWS),
           ("M-S-l", moveTo Next EmptyWS),
           ("M-S-j", moveTo Prev NonEmptyWS),
           ("M-S-k", moveTo Next NonEmptyWS),
           ("M-t", spawn "thunderbird"),
           ("M-h", spawn "nautilus"),
           ("M-v", spawn "urxvt -e vim"),
           ("M-i", spawn "urxvt -name IRC -e ./.irc-script/irssi-connect.sh"),
           ("M-g", spawn "gvim"),
           ("M-p", spawn "gnome-do"),
           ("M-m", spawn "urxvt -name Mocp -e mocp -T transparent-background"),
           ("M-S-.", spawn "amixer -c 0 set Master 2dB+"), -- raise volume
           ("M-S-,", spawn "amixer -c 0 set Master 2dB-"), -- lower volume
           ("C-M1-p", spawn "mocp -p"),     -- play
           ("C-M1-s", spawn "mocp -s"),     -- stop
           ("C-M1-f", spawn "mocp -f"),     -- next
           ("C-M1-r", spawn "mocp -r"),     -- previous
           ("C-M1-S-p", spawn "mocp -P"),   -- pause
           ("C-M1-S-u", spawn "mocp -U"),   -- unpause
           ("C-M1-x", spawn "mocp -x"),      -- kill
           ("M-<Return>", spawn "urxvt -name Terminal"),
           ("M-b", sendMessage ToggleStruts),
           ("M-S-t", withFocused $ windows . W.sink)
          ]

myLogHook h = dynamicLogWithPP $ xmobarPP
              {
                ppTitle = xmobarColor "green" "" . shorten 50,
                ppOutput = hPutStrLn h
              }

main = do
      xmproc <- spawnPipe "~/.cabal/bin/xmobar"
      xmonad $ desktopConfig {
        manageHook = manageDocks <+> myManageHook <+> manageHook desktopConfig,
        layoutHook = myLayoutHook,
        logHook = myLogHook xmproc,
        startupHook = startup,
        terminal = "urxvt",
        modMask = mod4Mask
      } `additionalKeysP` myKeys
