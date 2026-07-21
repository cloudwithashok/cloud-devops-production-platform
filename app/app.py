from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Cloud & Devops production Platfrom Docker Deployment"

if __name__ == "__main":
    app.run(host="0.0.0.0", port=5000)