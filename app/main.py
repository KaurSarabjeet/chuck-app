# Main Python web application serving Chuck Norris jokes.
# Imports: external and stdlib dependencies
from flask import Flask, render_template, jsonify
# Imports: external and stdlib dependencies
from service import get_random_joke

app = Flask(__name__)

@app.route("/")
# Function: index
def index():
    joke = get_random_joke()
    return render_template("index.html", joke=joke)

@app.route("/random")
# Function: random_joke
def random_joke():
    return jsonify(get_random_joke())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)