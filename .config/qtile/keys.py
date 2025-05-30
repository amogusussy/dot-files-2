from libqtile.config import EzKey as Key
from libqtile.config import Click, Drag
from libqtile.lazy import lazy
import global_variables as G
import custom_functions as funcs

term = f"alacritty --config-file {G.HOME_DIR}/.config/alacritty/{G.THEME_NAME}.toml"
term_run = term + " -e {command}"
# term = f"kitty --single-instance"
# term_run = "kitty --single-instance --hold sh -c {command}"
rofi_bin = f"rofi -show drun -theme-str '@theme \"{G.THEME_NAME}\"'"

KEYS = [
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
    # Key("M-S-n", lazy.layout.normalize(), desc="Return all windows to default width"),

    # Misc
    Key("M-q", lazy.window.kill(), desc="Kill active window"),
    Key("M-f", lazy.window.toggle_fullscreen(), desc="Enter fullscreen"),
    Key("M-S-<space>", lazy.window.toggle_floating(), desc="Toggle floating window"),
    Key("M-C-r", lazy.reload_config(), desc="Reload config"),
    Key("M-C-l", lazy.spawn("pkill librewolf"), desc="Close all librewolf instances"),

    # Hide bar
    Key("M-b", lazy.hide_show_bar("top"), desc="Toggle bar"),

    # App launch
    Key("M-<Return>", lazy.spawn(term), desc="Open terminal"),
    Key("M-e", lazy.spawn(term_run.format(command="env EDITOR=nvim ranger")), desc="Open file manager"),
    Key("M-<space>", lazy.spawn("rofi -show drun"), desc="Launch rofi"),
    Key("M-a", lazy.spawn(term_run.format(command="pulsemixer")), desc="Open pulsemixer"),
    Key("M-<F12>", lazy.spawn(f"flameshot gui"), desc="Screenshot"),

    # Audio
    Key("<XF86AudioPlay>", lazy.spawn("audio play-pause"), desc="Toggle audio stream (play/pause)"),
    Key("<XF86AudioNext>", lazy.spawn("audio next"), desc="Next in playlist"),
    Key("<XF86AudioPrev>", lazy.spawn("audio prev"), desc="Last in playlist"),

    # Minimize windows on a given monitor
    Key("M-S-n", funcs.minimize_monitors(all=True), desc="Toggle minimize on all monitors"),
    Key("M-n", funcs.minimize_monitors(), desc="Toggle minimize on all windows on current monitor"),
    Key("M-C-n", funcs.minimize_monitors(all=True, other=True), desc="Toggle minimize on other active monitor"),
    Key("M-C-t", lazy.next_screen(), desc="Move mouse to other screen"),
]

# Drag floating layouts.
MOUSE = [
    Drag([G.MOD], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([G.MOD], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([G.MOD], "Button2",
          lazy.window.bring_to_front()),
]
