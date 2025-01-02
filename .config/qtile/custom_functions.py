from libqtile.lazy import lazy


@lazy.function
def minimize_monitors(qtile, all=False):
    groups = qtile.groups if all else [qtile.current_group]
    for group in groups:
        if not group.screen:
            continue
        for win in group.windows:
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()
