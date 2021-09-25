-- Simple xmonad config, mostly based on DT's one with some customizations and removed features
-- use xmonad --recompile to recompile it

-- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W 

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.MouseResize

-- Data
import qualified Data.Map as M
import Data.Maybe (isJust, fromJust)
import Data.Monoid

-- Hooks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))

-- Layout Modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Spacing
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders
import XMonad.Layout.Simplest
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.ShowWName
import XMonad.Layout.SubLayouts
import XMonad.Layout.Magnifier
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))

-- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

-- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W 

-- Data
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=10:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "vivaldi"

myEditor :: String
myEditor = "vim"

myLock :: String
myLock = "i3lock-fancy-rapid 5 3"

myBorderWidth :: Dimension
myBorderWidth = 2

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Startup
myStartupHook :: X ()
myStartupHook = do
-- Starting picom, gnome-keyring etc. through nixos configuration
    spawnOnce "picom &"
    spawnOnce "emacs --daemon &"
--   spawnOnce "polybar bytee &" -- Using xmobar instead
--   spawnOnce "polybar bytee2 &"
    spawnOnce "~/.fehbg &" -- last background
    spawnOnce "copyq &" -- Clipboard manager
    spawnOnce "numlockx on &" -- Clipboard manager
    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34  --height 22 &" -- simple tray
    spawnOnce "xss-lock i3lock-fancy-rapid 3 5 &"
    setWMName "LG3D" -- compat for things like Jetbrains IDE and others

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "firefox" spawnFirefox findFirefox manageFirefox
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnFirefox = "firefox"
    findFirefox = className =? "Firefox"
    manageFirefox = customFloating $ W.RationalRect l t w h
                where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

-- Workspaces
myWorkspaces = [" dash ", " dev ", " dev2 ", " dev 3 ", " vm ", " www ", " www2 ", " misc ", " spot", " trash "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "pinentry-gnome"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , isFullscreen -->  doFullFloat
     ] <+> namedScratchpadManageHook myScratchPads

-- Layouts
-- Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

tall     = renamed [Replace "tall"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 3
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 3
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
threeCol = renamed [Replace "threeCol"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 3
           $ limitWindows 7
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
               where
                 myDefaultLayout =     withBorder myBorderWidth tall
                                   ||| noBorders monocle
                                   ||| floats
                                   ||| noBorders tabs
                                   ||| grid
                                   ||| threeCol

-- Keybinds
myKeys :: [(String, X ())]
myKeys = 
    -- M -> Modifier, C -> Control, S -> Shift
    [ ("M-C-r", spawn "xmonad --recompile")
    , ("M-S-r", spawn "xmonad --restart")
    , ("M-C-q", io exitSuccess)

    , ("M-<Return>", spawn (myTerminal))
    , ("M-d", spawn "rofi -show drun" )
    , ("M-g", spawn (myBrowser ++ "google.com"))

    , ("M-q", kill1)

    , ("M-S-f", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)

    -- Floating windows
    , ("M-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
    , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
    , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    -- Scratchpad
    , ("C-s t", namedScratchpadAction myScratchPads "terminal")
    , ("M-s", namedScratchpadAction myScratchPads "terminal")
    , ("M-b", namedScratchpadAction myScratchPads "firefox")

    -- Screenshots
    , ("<Print>", spawn "maim /mnt/fast/onedrive/screenshots/screen-$(date +%Y-%m-%d_%H-%m-%s).png")
    , ("M-<Print>", spawn "maim -s /mnt/fast/onedrive/screenshots/area-$(date +%Y-%m-%d_%H-%m-%s).png")

    -- Lock
    , ("M-S-l", spawn (myLock))

    -- Audio / Function Keys
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set -10%")
    , ("<XF86Lock>", spawn (myLock))
    ]

    -- The following lines are needed for named scratchpads.
        where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
              nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

-- Main
main :: IO ()

main = do
    -- Launch xmobar
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc0"
    xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/xmobarrc1"
    xmonad $ ewmh def
        { modMask = myModMask
        , manageHook = myManageHook <+> manageDocks
        , handleEventHook = fullscreenEventHook <+> docksEventHook
        , terminal = myTerminal
        , startupHook = myStartupHook
        , layoutHook = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces = myWorkspaces
        , borderWidth = myBorderWidth
        , logHook = dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP
               -- the following variables beginning with 'pp' are settings for xmobar.
               { ppOutput = \x -> hPutStrLn xmproc0 x                          -- xmobar on monitor 1
--                             >> hPutStrLn xmproc1 x                          -- xmobar on monitor 2
               , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]"           -- Current workspace
               , ppVisible = xmobarColor "#98be65" "" . clickable              -- Visible but not current workspace
               , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" "" . clickable -- Hidden workspaces
               , ppHiddenNoWindows = xmobarColor "#c792ea" ""  . clickable     -- Hidden workspaces (no windows)
               , ppTitle = xmobarColor "#b3afc2" "" . shorten 60               -- Title of active window 
               , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
               , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace 
               , ppExtras  = [windowCount]                                     -- # of windows current workspace
               , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar 
              }
        } `additionalKeysP` myKeys
