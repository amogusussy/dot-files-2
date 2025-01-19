from libqtile.lazy import lazy


@lazy.function
def minimize_monitors(qtile, all=False):
    groups = qtile.groups if all else [qtile.current_group]
    for group in groups:
        for win in group.windows:
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()


@lazy.function
def minimize_other_monitor(qtile):
    groups = [g for g in qtile.groups if g is not qtile.current_group]
    for group in groups:
        for win in group.windows:
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()
