import System.IO
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W

main = do
      xmproc <- spawnPipe "xmobar"
      xmonad $ defaultConfig {
        normalBorderColor = "#000",
        focusedBorderColor = "#111",--"#68e862",
        terminal = "urxvt",
        modMask = mod4Mask,
        manageHook = manageDocks <+> myManageHook <+> manageHook desktopConfig,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        logHook = myLogHook xmproc,
        workspaces = myWorkspaces
      } `additionalKeysP` myKeys

myLayoutHook = avoidStruts $
               noBorders $
               layoutHook desktopConfig

myLogHook h = dynamicLogWithPP $ xmobarPP {
  ppTitle = xmobarColor "green" "" . shorten 50,
  ppOutput = hPutStrLn h,
  ppLayout = const ""
}

myStartupHook :: X ()
myStartupHook = do
  spawn "killall stalonetray; stalonetray -bg '#555'"
  sendMessage ToggleStruts

myManageHook = composeAll [
      className =? "File Operation Progress" --> doCenterFloat,
      className =? "Sxiv"                    --> doCenterFloat,
      className =? "Gvim"                    --> doFloat,
      className =? "plugin-container"        --> doCenterFloat,
      appName   =? "alsamixer"               --> doCenterFloat,
      appName   =? "QuickTerminal"           --> doCenterFloat,
      appName   =? "Uzbl WebInspector"       --> doCenterFloat,
      resource  =? "desktop_window"          --> doIgnore,
      appName   =? "Synapse"                 --> doIgnore
    ]

myKeys = [
    (         "M-a", spawn "urxvt -name alsamixer -geometry 70x30 -e alsamixer" ),
    (         "M-b", sendMessage ToggleStruts),
    (         "M-f", withFocused $ windows . W.sink),
    (         "M-g", spawn "gvim -geom 100+50+50"),
    (       "M-S-g", spawn "urxvt -name QuickTerminal -e vim"),
    (         "M-m", spawn "urxvt -e mutt"),
    (         "M-n", spawn "thunar"),
    (         "M-p", spawn "exec $(yeganesh -x -- -fn Inconsolata-10 -z)"),
    (       "M-S-r", spawn "xmonad --recompile && xmonad --restart"),
    (         "M-u", spawn "firefox" ),
    (         "M-v", spawn "urxvt -e vim"),
    (       "M-S-v", spawn "urxvt -name QuickTerminal -e vim"),
    (  "M-<Return>", spawn "urxvt -name Terminal"),
    ("M-S-<Return>", spawn "urxvt -name QuickTerminal")
  ]

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
