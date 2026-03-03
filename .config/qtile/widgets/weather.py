import requests
from libqtile import widget
import json


def get_weather(city: str) -> str:
    return ""
    weather_url = "https://wttr.in/{city}?format=j1".format(
        city=city
    )
    re = requests.get(weather_url, timeout=10)
    if re.status_code != 200:
        return "None"
    weather_data = json.loads(re.text)
    current = weather_data.get('current_condition')
    if current is None:
        return ""
    temp_c = round(current[0]['FeelsLikeC'])
    return f"{temp_c}°C"


weather_widget = widget.GenPollText(
    func=lambda: "{:>4}".format(get_weather("London")),
    update_interval=5 * 60,
)


if __name__ == "__main__":
    print(get_weather("London"))
