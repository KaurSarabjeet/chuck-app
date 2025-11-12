# Unit tests for the Chuck Norris application.
# Imports: external and stdlib dependencies
import pytest
# Imports: external and stdlib dependencies
from app import create_app

@pytest.fixture()
# Function: client
def client(monkeypatch):
    app = create_app()
    app.testing = True

# Function: fake_categories
    def fake_categories():
        return ["dev"]
# Function: fake_joke
    def fake_joke(category=None):
        return {"value": "test joke", "url": "http://x"}

# Imports: external and stdlib dependencies
    from app import service
    monkeypatch.setattr(service.ChuckClient, "get_categories", lambda self: fake_categories())
    monkeypatch.setattr(service.ChuckClient, "get_random_joke", lambda self, category=None: fake_joke(category))

    return app.test_client()

# Function: test_index
def test_index(client):
    r = client.get("/")
    assert r.status_code == 200
    assert b"Chuck Norris" in r.data

# Function: test_random
def test_random(client):
    r = client.get("/random")
    assert r.is_json
    assert "value" in r.get_json()