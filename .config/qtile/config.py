from libqtile import layout, hook, bar, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from settings.keys import keys
import groupbox_2
import subprocess
import os
import json
import random


home_dir = os.path.expanduser('~')
with open(f"{home_dir}/.config/qtile/theme_name.txt", "r") as file:
    theme = file.read().strip()

with open(f"{home_dir}/.config/qtile/themes/{theme}.json", "r") as f:
    colors = json.loads(f.read())

wall_dir = f"{home_dir}/Pictures/Wallpapers/{theme}/"
wallpaper = wall_dir + random.choice(os.listdir(wall_dir))

BORDER_WIDTH = 2
MARGIN_DEFAULT = 4

screens = [Screen(
    wallpaper=wallpaper,
    wallpaper_mode='stretch',
    top=bar.Bar(
        [
            widget.TextBox(
                fmt=""
            ),
            groupbox_2.GroupBox2(
                disable_drag=True,
                normal_style={"text_color": colors['workspace_norm']},
                has_windows_style={"text_color": colors['workspace_active']},
                active_any_screen_style={"line": 1},
            ),
            widget.Spacer(),
            widget.Clock(
                format="󱑆 %H:%M |   %G %e %b",
            ),
            widget.Spacer(),
            widget.CPU(format="{load_percent}%"),
            widget.Memory(format="{MemUsed:.01f} GB", measure_mem="G"),
            widget.TextBox(
                fmt=""
            ),
        ],
        28,
        border_color=colors['border'],
        border_width=[0] * 4,

        background=colors['bar_bg'],
        foreground=colors['bar_fg'],
        margin=[2, 4, 0, 4]
    )
)]


@hook.subscribe.startup_once
def autostart_once():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])


mod = "mod4"

groups = [Group(i) for i in "123456"]
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    ])

layouts = [layout.Columns(
    border_focus=colors['focused'],
    border_normal=colors['unfocused'],
    border_width=BORDER_WIDTH,
    border_on_single=True,
    margin=[
        MARGIN_DEFAULT,
        MARGIN_DEFAULT,
        MARGIN_DEFAULT,
        MARGIN_DEFAULT,
    ],
)]

widget_defaults = dict(
    font="monospace",
    fontsize=12,
    padding=3,
    foreground=colors['bar_fg']
)
extension_defaults = widget_defaults.copy()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2",
          lazy.window.bring_to_front()),
]

floating_layout = layout.Floating(
    border_focus=colors['focused'],
    border_normal=colors['unfocused'],
    border_width=BORDER_WIDTH,
    float_rules=[
        Match(wm_class='V Picture-in-Picture'),
    ]
)

# Fix broken Java applications
wmname = "LG3D"
