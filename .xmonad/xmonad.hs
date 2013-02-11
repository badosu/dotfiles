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
      xmonad $ desktopConfig {
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
  spawn "xcompmgr -c" -- Enables compositing
  spawn "xsetroot -cursor_name left_ptr" -- Use decent cursor
  spawn "killall trayer; \
        \trayer --edge top --align right --expand true --width 5 \
        \--transparent true --alpha 0 --tint 0x000000 --height 18"

myManageHook = composeAll [
      className =? "File Operation Progress" --> doCenterFloat,
      appName   =? "alsamixer"               --> doCenterFloat,
      appName   =? "QuickTerminal"           --> doCenterFloat,
      appName   =? "Uzbl WebInspector"       --> doCenterFloat,
      resource  =? "desktop_window"          --> doIgnore,
      className =? "Do"                      --> doIgnore,
      appName   =? "Synapse"                 --> doIgnore,
      className =? "xmobar"                  --> doIgnore,
      className =? "trayer"                  --> doIgnore
    ]

myKeys = [
    (         "M-a", spawn "urxvt -name alsamixer -geometry 70x30 -e alsamixer" ),
    (         "M-b", sendMessage ToggleStruts),
    (         "M-c", spawn "chromium-browser"),
    (         "M-d", kill),
    (         "M-f", withFocused $ windows . W.sink),
    (      "C-M1-f", spawn "mpc next"),
    (         "M-g", spawn "gvim"),
    (       "M-S-g", spawn "urxvt -name QuickTerminal -e vim"),
    (         "M-i", spawn "urxvt -fn \"xft:Anonymous Pro:pixelsize=20\" -name IRC -e bin/irssi-connect.sh"),
    (         "M-m", spawn "urxvt -e mutt"),
    (       "M-S-m", spawn "urxvt -e mutt -e \"source ~/.mutt/codeminer.account\""),
    (         "M-n", spawn "urxvt -name QuickTerminal -e vifm"),
    (       "M-S-n", spawn "nautilus"),
    (         "M-p", spawn "synapse"),
    (      "C-M1-p", spawn "mpc pause"),
    (    "C-M1-S-p", spawn "mpc play"),
    (       "M-S-q", spawn "gnome-session-quit"),
    (       "M-S-r", spawn "xmonad --recompile && xmonad --restart"),
    (      "C-M1-r", spawn "mpc prev"),
    (         "M-s", spawn "urxvt -fn \"xft:Anonymous Pro:pixelsize=18\" -e ncmpcpp"),
    (         "M-t", spawn "thunderbird"),
    (         "M-u", spawn "uzbl-tabbed"),
    (       "M-S-u", spawn "firefox"),
    (         "M-v", spawn "urxvt -e vim"),
    (       "M-S-v", spawn "urxvt -name QuickTerminal -e vim"),
    (         "M-x", spawn "gnome-control-center"),
    (  "M-<Return>", spawn "urxvt -name Terminal"),
    ("M-S-<Return>", spawn "urxvt -name QuickTerminal")
  ]

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
