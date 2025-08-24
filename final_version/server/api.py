# import libraries
from flask import Flask, jsonify, request
from vision_labels import detect_labels_from_bytes

# import functions from other files
from filter_function import (
    fetch_and_transform_meals_by_category,
    search_meal_by_name,
    transform_meal_details,
    get_meals_by_ingredient,
    find_common_meals,
    get_meal_picture_by_id
)
from blacklisted_lables import get_blacklisted_labels

# initializing Flask application
app = Flask(__name__)

KEY_PATH = "/home/user1/Desktop/API_on_Rpi5/service-account.json" 

""" picture analysisation """
# analysing
@app.route('/analyze', methods=['POST'])
def analyze_image():
    if 'image' not in request.files:
        return jsonify({"error": "No image uploaded"}), 400

    image_file = request.files['image']
    image_bytes = image_file.read()

    try:
        labels = detect_labels_from_bytes(image_bytes, KEY_PATH)
        final_labels = []
        blacklisted_labels = get_blacklisted_labels()
        for i, label in enumerate(labels) : 
            if label not in blacklisted_labels :
                final_labels.append(label)
        print(final_labels)
        return jsonify({"labels": final_labels[0]})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

"""getting specific meal categories"""

# get meal from category
@app.route("/meals/category/<category_name>", methods=["GET"])
def get_meals_by_category_route(category_name):
    print(f"📌 Requested category: {category_name}")   # <---- add this
    meals = fetch_and_transform_meals_by_category(category_name)
    print(f"📌 Meals found: {len(meals)}")            # <---- and this
    return jsonify(meals or [])


# get meal from search term
@app.route("/meals/search/<name>", methods=["GET"])
def search_meal_route(name):
    transformed = search_meal_by_name(name)
    return jsonify(transformed or [])

# get meal from meal ID
def get_meal_details(meal_id):
    url = f"{BASE_URL}/lookup.php?i={meal_id}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            meals = data.get("meals", [])
            # Ensure it's actually a list of dicts
            if isinstance(meals, list) and meals and isinstance(meals[0], dict):
                return meals[0]
            else:
                print(f"Unexpected response for meal ID {meal_id}: {data}")
    except Exception as e:
        print(f"Error fetching details for meal ID {meal_id}: {e}")
    return None

# get image from meal ID
@app.route("/meals/image/<meal_id>", methods=["GET"])
def meal_image(meal_id):
    image_url = get_meal_picture_by_id(meal_id)
    if not image_url:
        return jsonify({"error": f"No image found for meal ID {meal_id}"}), 404
    return jsonify({"image": image_url})

# run the app
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
