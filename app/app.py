from flask import Flask, render_template
from datetime import datetime
import os

app = Flask(__name__)

APP_VERSION = "1.0.0"
ENVIRONMENT = os.getenv("APP_ENV", "Production")

@app.route("/")
def home():
    return render_template(
        "index.html",
        app_version=APP_VERSION,
        environment=ENVIRONMENT,
        server_time=datetime.utcnow().isoformat() + "Z"
    )

@app.route("/version")
def version():
    return {
        "version": APP_VERSION
    }

@app.route("/health")
def health():
    return {
        "status": "healthy",
        "message": "Application is running successfully",
        "environment": ENVIRONMENT
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
