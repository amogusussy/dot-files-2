from dataclasses import dataclass
from os import listdir
from random import choice as randchoice
import global_variables as G


@dataclass
class Theme():
    theme: str
    home_dir: str
    filename: str
    wallpaper_file: str

    bar_bg: str
    bar_fg: str
    border: str
    workspace_norm: str
    workspace_active: str
    focused: str
    unfocused: str
    pink: str


    def __init__(self):
        self.theme = G.THEME_NAME
        self.home_dir = G.HOME_DIR

        self.filename = f"{self.home_dir}/.config/qtile/themes/{self.theme}.theme"
        wall_dir = f"{self.home_dir}/Pictures/Wallpapers/{self.theme}/"
        self.wallpaper_file = wall_dir + randchoice(listdir(wall_dir))

        with open(self.filename, "r") as file:
            for line in file.read().split("\n"):
                line = line.strip().replace(" ", "")
                if ":" not in line or line.startswith("#"):
                    continue
                splitted = line.split(":")
                setattr(self, splitted[0], splitted[1])
