# Supporting Python module for the Chuck Norris application.
# Imports: external and stdlib dependencies
import requests

API_URL = "https://api.chucknorris.io/jokes/random"

# Function: get_random_joke
def get_random_joke():
    try:
        res = requests.get(API_URL, timeout=5)
        res.raise_for_status()
        return res.json()
    except Exception:
        return {"value": "Chuck Norris broke the API"}