from libqtile.lazy import lazy


@lazy.function
def minimize_all_monitors(qtile):
    for group in qtile.groups:
        # if group not on any monitors
        if not group.screen:
            continue
        for win in group.windows:
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()

@lazy.function
def minimize_curr_monitor(qtile):
    for win in qtile.current_group.windows:
        if hasattr(win, "toggle_minimize"):
            win.toggle_minimize()
