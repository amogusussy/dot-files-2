import subprocess


def next_in_playlist():
    subprocess.Popen(["audio", "next"])


def prev_in_playlist():
    subprocess.Popen(["audio", "prev"])


def pause():
    subprocess.Popen(["audio", "play-pause"])
