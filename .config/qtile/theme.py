from dataclasses import dataclass
import os
import random
import global_variables as G


@dataclass
class Theme():
    def __init__(self):
        self.theme = G.THEME_NAME
        self.home_dir = G.HOME_DIR

        filename = f"{self.home_dir}/.config/qtile/themes/{self.theme}.theme"

        with open(filename, "r") as file:
            for line in file.read().split("\n"):
                line = line.strip().replace(" ", "")
                if ":" not in line or line.startswith("#"):
                    continue
                splitted = line.split(":")
                setattr(self, splitted[0], splitted[1])

    def get_wallpaper(self):
        wall_dir = f"{self.home_dir}/Pictures/Wallpapers/{self.theme}/"
        wallpaper = wall_dir + random.choice(os.listdir(wall_dir))
        return wallpaper
