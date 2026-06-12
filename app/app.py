from flask import Flask
from datetime import datetime

app = Flask(__name__)

APP_VERSION = "1.0.0"
ENVIROMENT = "Production"

@app.route("/")
def home():
    return {
            "message": "Cloud Status Dashboard",
            "status": "running",
            "enviroment": ENVIROMENT,
            "server_time": datetime.utcnow().isoformat() + "Z"
    }

@app.route("/version")
def version():
        return {
            "version": APP_VERSION
}

@app.route("/health")
def health():
        return {
            "status": "healthy",
            "message": "Application is running successfully"
}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
