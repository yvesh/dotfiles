# Simple qTile config
# v0.3.3 (2021-07-30)

import os
import subprocess

from datetime import datetime

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Screen, DropDown, ScratchPad, Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "alacritty"
reconfigure_screens = True
auto_fullscreen = True
focus_on_window_activation = "smart"
scripts_path = '/home/bytee/.config/qtile'

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Program launcher
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Launch Rofi"),
    Key([mod, "shift"], "e", lazy.spawn("emacsclient -c -a emacs"), desc="Launch Emacs"),

    # Switch Monitor (same as xmonad)
    Key([mod], "w", lazy.to_screen(0), desc="Focus first monitor"),
    Key([mod], "e", lazy.to_screen(1), desc="Focus second monitor"),

    # Fullscreen and Float
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Fullscreen"),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Float"),

    # Move windows up or down in current stack
    # monad layout
    Key([mod, "shift"], "k", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "shift"], "j", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    Key([mod, "shift"], "h", lazy.layout.grow()),
    Key([mod, "shift"], "l", lazy.layout.shrink()),

    # Complex shrinks (for some layouts, like column)
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod], "n", lazy.layout.normalize()),

    # Flip layout (depending on layout)
    Key([mod], "period", lazy.layout.flip()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(), desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(), desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Scratchpad
    Key([mod], "s", lazy.group["scratchpad"].dropdown_toggle("term")),

    # Kill Window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    # Restart / Logout
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "l", lazy.spawn("i3lock-fancy-rapid 5 3"), desc="Lock screen"),

    # Screenshot
    Key([], "Print", lazy.spawn(f"'{scripts_path}/screenshot'"), desc="Screenshot"),
    Key([mod], "Print", lazy.spawn(f"'{scripts_path}/area'"), desc="Select area for Screenshot"),

    # Audio Keys
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 1+ unmute")),

    # Other media
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set -10%")),
]

# Workspaces
groups = [
   Group("dash", {'layout': 'monadtall'}),
   Group("dev1", {'layout': 'max'}),
   Group("dev2", {'layout': 'max'}),
   Group("dev3", {'layout': 'max'}),
   Group("vm", {'layout': 'monadtall'}),
   Group("www1", {'layout': 'stack'}),
   Group("www2", {'layout': 'stack'}),
   Group("misc", {'layout': 'monadtall'}),
   Group("spot"),
   Group("trash"),
   ScratchPad("scratchpad", dropdowns=[
       DropDown("term", "alacritty"),
   ]),
]


for i, group in enumerate(groups):
    # Scratchpad etc
    if i > 9:
        break

    group_key = str(i + 1)

    # Trash is mod + 0
    if group_key == "10":
        group_key = "0"

    keys.extend([
        # mod1 + letter of group = switch to group
       Key([mod], group_key, lazy.group[group.name].toscreen(),
            desc="Switch to group {}".format(group.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], group_key, lazy.window.togroup(group.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(group.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])


layouts = [
    layout.Max(),
    layout.Stack(num_stacks=3, margin=6),
    layout.MonadTall(border_width=2, margin=6),
    layout.TreeTab(),
    layout.Columns(margin=4, num_columns=3),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.Sep(linewidth=0, padding=15),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Sep(linewidth=0, padding=60),
                widget.Net(
                       interface = "enp36s0f0",
                       format = '{down} ↓↑ {up}',
                       padding = 5
                ),
                widget.Systray(),
                widget.Sep(linewidth=0, padding=15),
                # widget.ThermalSensor(),
                widget.Sep(linewidth=0, padding=15),
                widget.Memory(),
                widget.Sep(linewidth=0, padding=15),
                widget.TextBox(Text="Vol.", foreground='#ffffff'),
                widget.Volume(),
                widget.Sep(linewidth=0, padding=15),
                widget.Clock(format='%a, %d-%m %H:%M'),
            ],
            24,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.WindowName(),
                widget.Clock(format='%a, %d-%m %H:%M'),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
