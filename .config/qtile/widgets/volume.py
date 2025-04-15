import subprocess
from libqtile import widget

command = ["pamixer", "--get-volume"]

def get_volume():
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, _ = process.communicate()
    out = int(out.decode("utf-8").strip())
    icon = ""
    # if out < 20:
    #     icon = "🔈"
    # elif 20 <= out <= 60:
    #     icon = "🔉"
    # else:
    #     icon = "🔊"
    return f"{icon}{out}%"


volume_widget = widget.GenPollText(
    func=get_volume,
    update_interval=5,
)


if __name__ == "__main__":
    print(get_volume())
