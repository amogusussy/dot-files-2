from libqtile.lazy import lazy


@lazy.function
def minimize_monitors(qtile, all=False, other=False):
    groups = qtile.groups if all else [qtile.current_group]
    if other:
        groups = [g for g in qtile.groups if g is not qtile.current_group]
    for group in groups:
        for win in group.windows:
            if "Red Dead" in win.info()['name']:
                break
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()
