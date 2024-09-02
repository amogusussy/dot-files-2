import json
import requests

weather_session = requests.Session()


def weather(location=""):
    url = f"https://wttr.in/{location}?format=j1"
    re = weather_session.get(url)
    current_conditions = json.loads(re.content).get("current_condition", [])
    if len(current_conditions) == 0 or re.status_code != 200:
        raise Exception("No results")

    return current_conditions[0]["FeelsLikeC"] + "°C"

if __name__ == "__main__":
    print(weather())
