# from libqtile import bar, widget
# import groupbox_2
# import os
# import json
#
# home_dir = os.path.expanduser('~')
# with open(f"{home_dir}/.config/qtile/theme_name.txt", "r") as file:
#     theme = file.read().strip()
#
# with open(f"{home_dir}/.config/qtile/themes/{theme}.json", "r") as f:
#     colors = json.loads(f.read())
#
#
# def make_top_bar(margin=[2, 4, 0, 4], border=1):
#     widgets = [
#         groupbox_2.GroupBox2(
#             disable_drag=True,
#             normal_style={"text_color": colors['grey']},
#             has_windows_style={"text_color": colors['green']},
#             active_any_screen_style={"line": 1},
#         ),
#         widget.WindowName(),
#         widget.CPU(format="{load_percent}%"),
#         widget.Memory(format="{MemUsed:.01f} GB", measure_mem="G"),
#         widget.Clock(format="%H:%M"),
#     ]
#
#     return bar.Bar(
#         widgets,
#         28,
#         border_width=border,
#         border_color=colors['border'],
#         background=colors['bar_background'],
#         foreground=colors['bar_foreground'],
#         margin=margin,
#     )
