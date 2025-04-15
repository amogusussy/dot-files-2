import requests
from libqtile import widget
import json


def get_weather(city: str) -> str:
    weather_url = "https://wttr.in/{city}?format=j1".format(
        city=city
    )
    re = requests.get(weather_url)
    if re.status_code != 200:
        return "None"
    weather_data = json.loads(re.text)
    current = weather_data.get('current_condition')
    if current is None:
        return "None"
    temp_c = current[0]['FeelsLikeC']
    icon = current[0]['weatherIconUrl'][0]['value']
    return f"{icon} {temp_c}°C"


weather_widget = widget.GenPollText(
    func=lambda: get_weather("London"),
    update_interval=5,
)


if __name__ == "__main__":
    print(get_weather("London"))
