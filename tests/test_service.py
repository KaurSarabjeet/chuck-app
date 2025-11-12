# Unit tests for the Chuck Norris application.
# Imports: external and stdlib dependencies
import pytest
# Imports: external and stdlib dependencies
from app.service import ChuckClient

# Class definition
class DummyResp:
# Function: __init__
    def __init__(self, payload, status=200):
        self._payload = payload
        self.status_code = status
# Function: raise_for_status
    def raise_for_status(self):
        if self.status_code >= 400:
            raise Exception("HTTP error")
# Function: json
    def json(self):
        return self._payload

# Function: test_categories
def test_categories(monkeypatch):
# Function: fake_get
    def fake_get(url, timeout=5):
        return DummyResp(["dev", "movie", "sport"])
    monkeypatch.setattr("requests.get", fake_get)
    c = ChuckClient("https://api.chucknorris.io")
    assert "dev" in c.get_categories()

# Function: test_random_joke
def test_random_joke(monkeypatch):
# Function: fake_get
    def fake_get(url, params=None, timeout=5):
        return DummyResp({"value": "Chuck Norris tested this app", "url": "http://x"})
    monkeypatch.setattr("requests.get", fake_get)
    c = ChuckClient("https://api.chucknorris.io")
    joke = c.get_random_joke()
    assert "Chuck" in joke["value"]