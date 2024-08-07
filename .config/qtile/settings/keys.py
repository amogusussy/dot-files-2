from libqtile.config import EzKey as Key
from libqtile.lazy import lazy
import os

home_dir = os.path.expanduser('~')
with open(f"{home_dir}/.config/qtile/theme_name.txt", "r") as file:
    theme = file.read().strip()


alacritty_bin = (
        f"alacritty --config-file {home_dir}/.config/alacritty/{theme}.toml"
)
rofi_bin = f"rofi -show drun -theme-str '@theme \"{theme}\"'"

keys = [
    # Focus windows. Cycle through both tiling and floating windows.
    Key("M-j", lazy.group.next_window()),
    Key("M-k", lazy.group.prev_window()),

    # Move windows
    Key("M-S-h", lazy.layout.shuffle_left()),
    Key("M-S-l", lazy.layout.shuffle_right()),
    Key("M-S-j", lazy.layout.shuffle_down()),
    Key("M-S-k", lazy.layout.shuffle_up()),

    # Resize windows
    Key("M-h", lazy.layout.grow_left()),
    Key("M-l", lazy.layout.grow_right()),
    Key("M-C-j", lazy.layout.grow_down()),
    Key("M-C-k", lazy.layout.grow_up()),
    Key("M-n", lazy.layout.normalize()),

    # Misc
    Key("M-q", lazy.window.kill()),
    Key("M-f", lazy.window.toggle_fullscreen()),
    Key("M-S-<space>", lazy.window.toggle_floating()),
    Key("M-C-r", lazy.reload_config()),
    Key("M-C-k", lazy.spawn("pkill librewolf")),

    # Hide bar
    Key("M-b", lazy.hide_show_bar("top")),

    # App launch
    Key("M-<Return>", lazy.spawn(alacritty_bin)),
    Key("M-e", lazy.spawn(f"{alacritty_bin} -e env EDITOR=nvim ranger")),
    Key("M-<space>", lazy.spawn("rofi -show drun")),
    Key("M-a", lazy.spawn(f"{alacritty_bin} -e pulsemixer")),

    # Audio
    Key("<XF86AudioPlay>", lazy.spawn("audio play-pause")),
    Key("<XF86AudioNext>", lazy.spawn("audio next")),
    Key("<XF86AudioPrev>", lazy.spawn("audio prev")),
]
