from flask import Flask, jsonify, request
from vision_labels import detect_labels_from_bytes

from filter_function import (
    fetch_and_transform_meals_by_category,
    search_meal_by_name,
    transform_meal_details,
    get_meal_details
)

app = Flask(__name__)

@app.route("/meals/category/<category_name>", methods=["GET"])
def get_meals_by_category(category_name):
    meals = fetch_and_transform_meals_by_category(category_name)
    return jsonify(meals)

@app.route("/meals/search", methods=["GET"])
def search_meal():
    name = request.args.get("name")
    raw_meals = search_meal_by_name(name)
    transformed = [transform_meal_details(meal) for meal in raw_meals if meal]
    return jsonify(transformed)

@app.route("/meals/details/<meal_id>", methods=["GET"])
def meal_details(meal_id):
    details = get_meal_details(meal_id)
    return jsonify(transform_meal_details(details) or {})

@app.route("/meals/all", methods=["GET"])
def get_all_meals():
    # Optional: hardcoded categories or fetch dynamically
    categories = ["Vegetarian", "Chicken", "Seafood", "Dessert"]
    all_meals = []

    for category in categories:
        meals = fetch_and_transform_meals_by_category(category)
        all_meals.extend(meals)

    return jsonify(all_meals)

if __name__ == "__main__":
    app.run(debug=True)

# Flutter CLoud Vision
app = Flask(__name__)

# Set your service account key path here
KEY_PATH = "C:\\Users\\nick\\Programmieren\\bern_hackt\\hackathon_bern\\API_on_Rpi5\\service-account.json"

@app.route('/analyze', methods=['POST'])
def analyze_image():
    if 'image' not in request.files:
        return jsonify({"error": "No image uploaded"}), 400

    image_file = request.files['image']
    image_bytes = image_file.read()

    try:
        labels = detect_labels_from_bytes(image_bytes, KEY_PATH)
        return jsonify({"labels": labels})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
