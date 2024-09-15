from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from settings.keys import keys, mouse
from libqtile import layout, hook, bar, widget
from groupbox_2 import GroupBox2
import global_variables as G
import subprocess
import theme

BORDER_WIDTH = 2
MARGIN_DEFAULT = 4
DESKTOPS = 6
COLORS = theme.Theme()

BAR_PAD = widget.TextBox()
screens = [Screen(
    wallpaper=COLORS.wallpaper_file,
    wallpaper_mode='stretch',
    top=bar.Bar(
        [
            BAR_PAD,
            GroupBox2(
                normal_style={"text_color": COLORS.workspace_norm},
                has_windows_style={"text_color": COLORS.workspace_active},
                active_any_screen_style={"line": 1},
                disable_drag=True,
            ),
            widget.Spacer(),
            widget.Clock(format=f"󱑆 %H:%M |  %G %-e %b"),
            widget.Spacer(),
            widget.CPU(format="{load_percent}%"),
            widget.Memory(format="{MemUsed:.01f} GB", measure_mem="G"),
            BAR_PAD,
        ],
        28,
        border_color=COLORS.border,
        border_width=[0] * 4,
        background=COLORS.bar_bg,
        foreground=COLORS.bar_fg,
        margin=[2, 4, 0, 4]
    )
)]

# Run ~/.config/qtile/autostart.sh on startup
hook.subscribe.startup_once(lambda: subprocess.run(
    G.HOME_DIR +  "/.config/qtile/autostart.sh"
))

groups = [Group(str(i)) for i in range(1, DESKTOPS + 1)]
for i in groups:
    keys.extend([
        Key([G.MOD], i.name, lazy.group[i.name].toscreen()),
        Key([G.MOD, "shift"], i.name, lazy.window.togroup(i.name))
    ])

layouts = [layout.Columns(
    border_focus=COLORS.focused,
    border_normal=COLORS.unfocused,
    border_width=BORDER_WIDTH,
    border_on_single=True,
    margin=[MARGIN_DEFAULT] * 4
)]

widget_defaults = {
    "font": "monospace sans-serif",
    "fontsize": 12,
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
    ]
)

# Fix broken Java applications
wmname = "LG3D"
