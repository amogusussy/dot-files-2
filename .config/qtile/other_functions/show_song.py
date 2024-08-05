import gi
gi.require_version("Playerctl", "2.0")
from gi.repository import Playerctl


def show_song():
    pctl = Playerctl.Player()

    name = pctl.get_title()
    artist = pctl.get_artist()

    return f"{artist} - {name}"


if __name__ == "__main__":
    print(show_song())
