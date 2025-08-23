import requests

BASE_URL = "https://www.themealdb.com/api/json/v1/1"

"""Filter für Flutter"""
# Essen über nur ein Inhalt filtern
def get_meals_by_ingredient(ingredient):
    url = f"{BASE_URL}/filter.php?i={ingredient}"
    try:
        response = requests.get(url)
        data = response.json()
        if data["meals"]:
            return set(meal["idMeal"] for meal in data["meals"])
    except Exception as e:
        print(f"Error fetching meals for ingredient '{ingredient}': {e}")
    return set()

# filtern von menüs das zu allen ingeredients passt
def find_common_meals(ingredients):
    print(f"Searching for meals with: {', '.join(ingredients)}")
    meal_sets = []

    for ing in ingredients:
        ids = get_meals_by_ingredient(ing)
        if not ids:
            print(f"No meals found for ingredient: {ing}")
            return []
        meal_sets.append(ids)

    common_ids = set.intersection(*meal_sets)
    print(f"\n✅ Found {len(common_ids)} meals that match all ingredients.\n")
    return [get_meal_details(meal_id) for meal_id in common_ids]

# beim (menü) namen suchen
def search_meal_by_name(name):
    """Search for a meal by its name."""
    url = f"{BASE_URL}/search.php?s={name}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.json().get("meals", []) or []
    except Exception as e:
        print(f"Error searching for meal '{name}': {e}")
    return []

# filtern und transformieren über kategorie
def fetch_and_transform_meals_by_category(category_name):
    """Fetch all meals in a category and transform them into clean dictionaries."""
    raw_meals = get_meals_by_category(category_name)
    transformed_meals = []

    for meal in raw_meals:
        meal_id = meal.get("idMeal")
        full_details = get_meal_details(meal_id)
        clean_meal = transform_meal_details(full_details)
        if clean_meal:
            transformed_meals.append(clean_meal)

    return transformed_meals

# kategorie
def get_meals_by_category(category_name):
    """Fetch meals by category name."""
    url = f"{BASE_URL}/filter.php?c={category_name}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.json().get("meals", []) or []
    except Exception as e:
        print(f"Error fetching category '{category_name}': {e}")
    return []



"""Daten für Flutter"""
# filtern über ID
def get_meal_details(meal_id):
    """Fetch full details of a meal by its ID."""
    url = f"{BASE_URL}/lookup.php?i={meal_id}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            meals = response.json().get("meals", [])
            return meals[0] if meals else None
    except Exception as e:
        print(f"Error fetching details for meal ID {meal_id}: {e}")
    return None

# bild vom essen
def get_meal_picture_by_id(meal_id):
    """Return the image URL of a meal given its ID."""
    details = get_meal_details(meal_id)
    if details:
        return details.get("strMealThumb")
    return None



"""Transformation der Suchergebnisse in Dictionary"""
# umwandeln in Dictionary
def transform_meal_details(meal):
    if not meal:
        return None

    ingredients = []
    for i in range(1, 21):
        ing = meal.get(f"strIngredient{i}")
        meas = meal.get(f"strMeasure{i}")
        if ing and ing.strip():
            ingredients.append({
                "ingredient": ing.strip(),
                "measure": meas.strip() if meas else ""
            })

    return {
        "id": meal.get("idMeal"),
        "name": meal.get("strMeal"),
        "category": meal.get("strCategory"),
        "instructions": meal.get("strInstructions"),
        "image": meal.get("strMealThumb"),
        "tags": meal.get("strTags"),
        "ingredients": ingredients
    }


"""Tests"""
#von Chatgpt kein plan ob funktioniert
if __name__ == "__main__":
    # Test multi-ingredient filter
    ingredients = ["chicken", "garlic", "onion"]
    matching_meals = find_common_meals(ingredients)

    for meal in matching_meals:
        print(f"- {meal['strMeal']} ({meal['strArea']})")
        print(f"  Category: {meal['strCategory']}")
        print(f"  Instructions: {meal['strInstructions'][:100]}...")
        print(f"  Image: {meal['strMealThumb']}")
        print()

    # Test category transformation
    print("🔍 Testing meal fetch and transformation for category: Vegetarian\n")
    category = "Vegetarian"
    meals = fetch_and_transform_meals_by_category(category)

    if not meals:
        print("❌ No meals found or transformation failed.")
    else:
        print(f"✅ Found {len(meals)} meals in category '{category}'\n")
        for i, meal in enumerate(meals, start=1):
            print(f"🍽️ Meal {i}: {meal['name']}")
            print(f"📸 Image: {meal['image']}")
            print(f"🧂 Ingredients: {len(meal['ingredients'])}")
            print(f"📖 Instructions (preview): {meal['instructions'][:150]}...\n")