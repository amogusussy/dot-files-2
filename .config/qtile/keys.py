from libqtile.config import EzKey as Key
from libqtile.config import Click, Drag
from libqtile.lazy import lazy
import global_variables as G

alacritty_bin = f"alacritty --config-file {G.HOME_DIR}/.config/alacritty/{G.THEME_NAME}.toml"
rofi_bin = f"rofi -show drun -theme-str '@theme \"{G.THEME_NAME}\"'"

keys = [
    # Focus windows. Cycle through both tiling and floating windows.
    Key("M-j", lazy.group.next_window(), desc="Cycle to next window"),
    Key("M-k", lazy.group.prev_window(), desc="Cycle to previous window"),

    # Move windows
    Key("M-S-h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key("M-S-l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key("M-S-j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key("M-S-k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows
    Key("M-h", lazy.layout.grow_left(), desc="Increase windows size to the left"),
    Key("M-l", lazy.layout.grow_right(), desc="Increase windows size to the right"),
    Key("M-C-j", lazy.layout.grow_down(), desc="Increase windows size downward"),
    Key("M-C-k", lazy.layout.grow_up(), desc="Increase widnows size upward"),
    Key("M-S-n", lazy.layout.normalize(), desc="Return all windows to default width"),

    # Misc
    Key("M-q", lazy.window.kill(), desc="Kill active window"),
    Key("M-f", lazy.window.toggle_fullscreen(), desc="Enter fullscreen"),
    Key("M-S-<space>", lazy.window.toggle_floating(), desc="Toggle floating window"),
    Key("M-C-r", lazy.reload_config(), desc="Reload config"),
    Key("M-C-l", lazy.spawn("pkill librewolf"), desc="Close all librewolf instances"),

    # Hide bar
    Key("M-b", lazy.hide_show_bar("top"), desc="Toggle bar"),

    # App launch
    Key("M-<Return>", lazy.spawn(alacritty_bin), desc="Open terminal"),
    Key("M-e", lazy.spawn(f"{alacritty_bin} -e env EDITOR=nvim ranger"), desc="Open file manager"),
    Key("M-<space>", lazy.spawn("rofi -show drun"), desc="Launch rofi"),
    Key("M-a", lazy.spawn(f"{alacritty_bin} -e pulsemixer"), desc="Open pulsemixer"),

    # Audio
    Key("<XF86AudioPlay>", lazy.spawn("audio play-pause"), desc="Toggle audio stream (play/pause)"),
    Key("<XF86AudioNext>", lazy.spawn("audio next"), desc="Next in playlist"),
    Key("<XF86AudioPrev>", lazy.spawn("audio prev"), desc="Last in playlist"),
]

# Drag floating layouts.
mouse = [
    Drag([G.MOD], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([G.MOD], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([G.MOD], "Button2",
          lazy.window.bring_to_front()),
]
