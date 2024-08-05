import json
import requests


weather_session = requests.Session()


def weather(location=""):
    result_format = "{temp}°C"
    url = f"https://wttr.in/{location}?format=j1"
    re = weather_session.get(url)
    if re.status_code != 200:
        return "Err;"

    current_conditions = json.loads(re.content).get("current_condition")
    if current_conditions is None:
        return "Err;"

    return result_format.format(
        temp=current_conditions[0]["FeelsLikeC"]
    )
