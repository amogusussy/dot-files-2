from libqtile.config import Group, Match, Screen
from libqtile.config import EzKey as Key
from libqtile.lazy import lazy
from libqtile import layout, hook, bar, widget
import subprocess

from groupbox_2 import GroupBox2
import keys
import global_variables as G
import theme
from widgets import weather, volume

cursor_wrap = True
BORDER_WIDTH = 2
MARGIN_DEFAULT = 4
DESKTOPS = 9
BAR_SIZE = 24
COLORS = theme.Theme()
BAR_PAD = widget.TextBox()

mouse = keys.MOUSE
keys = keys.KEYS


def BAR():
    return bar.Bar([
        widget.TextBox(
            " ◉",
            fontsize=BAR_SIZE - 2,
            mouse_callbacks={
                "Button1": lazy.spawn("rofi -show drun"),
            }
        ),
        GroupBox2(
            normal_style={"text_color": COLORS.workspace_norm},
            has_windows_style={"text_color": COLORS.workspace_active},
            active_any_screen_style={
                "line": 1,
            },
            disable_drag=True,
            fontsize=13,
        ),
        widget.Spacer(),
        widget.Clock(format="󱑆 %H:%M |  %G %-e %b"),
        widget.Spacer(),
        weather.weather_widget,
        BAR_PAD,
        volume.volume_widget,
        BAR_PAD,
        widget.CPU(
            format="CPU {load_percent}%",
        ),
        BAR_PAD,
        widget.Memory(
            format=" {MemUsed:.01f} GB",
            measure_mem="G",
        ),
        widget.TextBox(),
    ],
        BAR_SIZE,
        border_color=COLORS.border,
        border_width=[0, 0, 0, 0],
        background=COLORS.bar_bg,
        foreground=COLORS.bar_fg,
        margin=[2, 4, 0, 4]
    )


screens = [
    Screen(
        wallpaper=COLORS.wallpaper_file,
        wallpaper_mode='stretch',
        top=BAR(),
    ),
    Screen(
        wallpaper=COLORS.wallpaper_file,
        wallpaper_mode='stretch',
        top=BAR(),
    )
]

# Run ~/.config/qtile/autostart.sh on startup
hook.subscribe.startup_once(lambda: subprocess.run(
    G.HOME_DIR + "/.config/qtile/autostart.sh"
))


# groups = [Group(str(i), label="") for i in range(1, DESKTOPS + 1)]
groups = [Group(str(i)) for i in range(1, DESKTOPS + 1)]
for i in groups:
    keys.extend([
        Key(f"M-{i.name}", lazy.group[i.name].toscreen()),
        Key(f"M-S-{i.name}", lazy.window.togroup(i.name)),
    ])

layouts = [layout.Columns(
    border_focus=COLORS.focused,
    border_normal=COLORS.unfocused,
    border_width=BORDER_WIDTH,
    border_on_single=True,
    margin=[MARGIN_DEFAULT] * 4
)]

widget_defaults = {
    "font": "JetBrains Mono",
    "fontsize": BAR_SIZE >> 1,
    "padding": 3,
    "foreground": COLORS.bar_fg
}
extension_defaults = widget_defaults.copy()

floating_layout = layout.Floating(
    border_focus=COLORS.focused,
    border_normal=COLORS.unfocused,
    border_width=BORDER_WIDTH,
    float_rules=[
        Match(wm_class='V Picture-in-Picture'),
        Match(wm_class='Godot'),
        Match(wm_class='Godot_Engine'),
    ]
)

cursor_wrap = True
# Fix broken Java applications
wmname = "LG3D"
