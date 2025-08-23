# import libraries
from flask import Flask, jsonify, request
from vision_labels import detect_labels_from_bytes

# import functions from other files
from filter_function import (
    fetch_and_transform_meals_by_category,
    search_meal_by_name,
    transform_meal_details,
    get_meal_details,
    get_meals_by_ingredient,
    find_common_meals,
    get_meal_picture_by_id
)

# initializing Flask application
app = Flask(__name__)

# Path to where the Key is stored
KEY_PATH = "C:\\Users\\nick\\Programmieren\\bern_hackt\\hackathon_bern\\API_on_Rpi5\\service-account.json"

""" picture analysisation """
# analysing
@app.route('/analyze', methods=['POST'])
def analyze_image():
    image_file = request.files.get('image')
    if not image_file:
        return jsonify({"error": "No image uploaded"}), 400

    image_bytes = image_file.read()

    try:
        labels = detect_labels_from_bytes(image_bytes, KEY_PATH)
        return jsonify({"labels": labels})
    except Exception as e:
        return jsonify({"error": str(e)}), 500



"""getting specific meal categories"""

# get meal from category
@app.route("/meals/category/<category_name>", methods=["GET"])
def get_meals_by_category(category_name):
    meals = fetch_and_transform_meals_by_category(category_name)
    return jsonify(meals or [])

# get meal from search term
@app.route("/meals/search/<name>", methods=["GET"])
def search_meal(name):
    raw_meals = search_meal_by_name(name)
    transformed = [transform_meal_details(meal) for meal in raw_meals if meal]
    return jsonify(transformed or [])

# get meal from meal ID
@app.route("/meals/details/<meal_id>", methods=["GET"])
def meal_details(meal_id):
    details = get_meal_details(meal_id)
    if not details:
        return jsonify({"error": f"No meal found with ID {meal_id}"}), 404
    return jsonify(transform_meal_details(details))

# get image from meal ID
@app.route("/meals/image/<meal_id>", methods=["GET"])
def meal_image(meal_id):
    image_url = get_meal_picture_by_id(meal_id)
    if not image_url:
        return jsonify({"error": f"No image found for meal ID {meal_id}"}), 404
    return jsonify({"image": image_url})

# get meals by one ingredient
@app.route("/meals/ingredient/<ingredient>", methods=["GET"])
def meals_by_ingredient(ingredient):
    meal_ids = get_meals_by_ingredient(ingredient)
    meals = []
    for mid in meal_ids:
        details = get_meal_details(mid)
        if details:
            meals.append(transform_meal_details(details))
    return jsonify(meals or [])



"""getting meals by multiple ingredients(Google AI)"""
# get meals by multiple ingredients
@app.route("/meals/ingredients", methods=["POST"])
def meals_by_multiple_ingredients():
    data = request.get_json()
    ingredients = data.get("ingredients")
    if not ingredients:
        return jsonify({"error": "No ingredients provided"}), 400

    meals = find_common_meals(ingredients)
    return jsonify(meals or [])

# run the app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)