# mealdb_client.py
import requests

main_URL = "https://www.themealdb.com/api/json/v1/1"

def get_meals_by_ingredients(ingredients):
    """Fetch meals that include all specified ingredients."""
    if isinstance(ingredients, list):
        ingredient_query = ",".join(ingredients)
    else:
        ingredient_query = ingredients  # fallback if already a string

    url = f"{BASE_URL}/filter.php?i={ingredient_query}"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json().get("meals", [])
    return []

def get_meal_details(meal_id):
    """Fetch full details of a meal by its ID."""
    url = f"{BASE_URL}/lookup.php?i={meal_id}"
    response = requests.get(url)
    if response.status_code == 200:
        meals = response.json().get("meals", [])
        return meals[0] if meals else None
    return None

def search_meal_by_name(name):
    """Search for a meal by its name."""
    url = f"{BASE_URL}/search.php?s={name}"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json().get("meals", [])
    return []

def get_meals_by_category(category_name):
    """Fetch meals by category name (e.g., 'Chicken', 'Vegetarian')."""
    url = f"{BASE_URL}/filter.php?c={category_name}"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json().get("meals", [])
    return []