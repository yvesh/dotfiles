# Simple qTile config
# v0.5.0 (2023-10-22)

import os
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Screen, DropDown, ScratchPad, Key, Match
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
    Key([mod], "h", lazy.layout.next(), desc="Switch window focus to other pane(s) of stack"),
    Key([mod], "l", lazy.layout.prev(), desc="Switch to previous"),
    Key([mod], "k", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(), desc="Move focus up in stack pane"),

    # Program launcher
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Launch Rofi"),
    # Key([mod, "shift"], "e", lazy.spawn("emacsclient -c -a emacs"), desc="Launch Emacs"),

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
    Key([mod], "h", lazy.layout.next(), desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(), desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),

    # Scratchpad
    Key([mod], "s", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "v", lazy.group["scratchpad"].dropdown_toggle("vivaldi")),
    Key([mod], "b", lazy.group["scratchpad"].dropdown_toggle("firefox")),
    Key([mod, "shift"], "n", lazy.group["scratchpad"].dropdown_toggle("notion")),

    # Kill Window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    # Restart / Logout
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),

    # Lock window
    Key([mod, "shift"], "l", lazy.spawn("i3lock-fancy-rapid 5 3"), desc="Lock screen"),

    # Screenshot
    Key([], "Print", lazy.spawn(f"'{scripts_path}/screenshot'"), desc="Screenshot"),
    Key([mod], "Print", lazy.spawn(f"'{scripts_path}/area'"), desc="Select area for Screenshot"),

    # Audio Keys
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")),

    # Other media
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
]

# Workspaces
groups = [
   Group("dash", layout="columns"),
   Group("dev1", layout='monadthreecol'),
   Group("dev2", layout='monadthreecol'),
   Group("dev3", layout='monadthreecol'),
   Group("vm", layout='columns'),
   Group("www1", layout='stack'),
   Group("www2", layout='stack'),
   Group("misc", layout='monadtall'),
   Group("spot"),
   Group("trash"),
   ScratchPad("scratchpad", [
       DropDown("term", "alacritty", width=0.4, x=0.3),
       DropDown("vivaldi", "vivaldi", width=0.35, height=0.8, opacity=1, x=0.52, y=0.1, on_focus_lost_hide=False),
       DropDown("firefox", "firefox", width=0.35, height=0.8, opacity=1, x=0.52, y=0.1, on_focus_lost_hide=False),
       DropDown("notion", "notion-snap-reborn", width=0.3, height=0.6, opacity=1, x=0.2, y=0.1, on_focus_lost_hide=False),
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
        Key([mod, "shift"], group_key, lazy.window.togroup(group.name, switch_group=False),
            desc="Switch to & move focused window to group {}".format(group.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])


layouts = [
    layout.Max(),
    layout.Stack(num_stacks=4, margin=6),
    layout.MonadTall(border_width=2, margin=6),
    layout.TreeTab(),
    layout.Columns(margin=4, num_columns=4),
    layout.MonadThreeCol(),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=15,
    padding=8,
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
                       interface = "enp16s0",
                       format = '{down} ↓↑ {up}',
                       padding = 5
                ),
                widget.Sep(linewidth=0, padding=15),
                widget.CPU(),
                widget.Sep(linewidth=0, padding=15),
                widget.ThermalSensor(tag_sensor="Tctl"),
                widget.Sep(linewidth=0, padding=15),
                widget.Memory(),
                widget.Sep(linewidth=0, padding=15),
                widget.TextBox(Text="Vol.", foreground='#ffffff'),
                widget.Volume(),
                widget.Sep(linewidth=0, padding=15),
                widget.Systray(),
                widget.Sep(linewidth=0, padding=15),
                widget.Clock(format='%a, %d-%m %H:%M'),
            ],
            24,
        ),
    ),
#    Screen(
#        top=bar.Bar(
#            [
#                widget.CurrentLayout(),
#                widget.GroupBox(),
#                widget.WindowName(),
#                widget.Clock(format='%a, %d-%m %H:%M'),
#           ],
#           24,
#        ),
#    ),
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
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmset'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='file_progress'),
    Match(wm_class='ssh-askpass'),
    Match(wm_class='notification'),
    Match(wm_class='maketag'),
    Match(wm_class='makebranch'),
    Match(title='branchdialog'),
    Match(title='pinentry'),
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

