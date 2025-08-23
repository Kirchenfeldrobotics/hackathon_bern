from flask import Flask, jsonify, request
from meal_api import (
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
