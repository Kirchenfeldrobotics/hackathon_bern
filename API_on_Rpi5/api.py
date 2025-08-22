from flask import Flask, request, jsonify
from google.cloud import vision
import os

app = Flask(__name__)

# Google Vision credentials
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "service-account.json"
client = vision.ImageAnnotatorClient()

@app.route("/analyze", methods=["POST"])
def analyze_image():
    if "image" not in request.files:
        return jsonify({"error": "No image uploaded"}), 400

    file = request.files["image"]
    content = file.read()
    image = vision.Image(content=content)

    response = client.label_detection(image=image)
    labels = response.label_annotations

    results = [{"description": l.description, "score": l.score} for l in labels]

    return jsonify({"labels": results})

if __name__ == "__main__":
    app.run(debug=True)
